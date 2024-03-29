# frozen_string_literal: true

class Task < ApplicationRecord
  include ActionView::Helpers::TranslationHelper

  MAX_TITLE_LENGTH = 125
  validates :title, presence: true, length: { maximum: 125 }
  validates :slug, uniqueness: true
  validate :slug_not_changed # made it immutable

  before_create :set_slug

  belongs_to :assigned_user, foreign_key: "assigned_user_id", class_name: "User"

  # Use this for small querie like orderby, where
  scope :with_juice, -> { where("juice > 0") }

  # use class methods for larger queries
  def self.by_audience(audience)
    if audience == "children"
      where("age < 13")
    else
      where("age >= 13")
    end
  end

  def errors_to_sentence
    errors.full_messages.to_sentence
  end

  private

    def set_slug
      title_slug = title.parameterize
      regex_pattern = "slug #{Constants::DB_REGEX_OPERATOR} ?"
      latest_task_slug = Task.where(
        regex_pattern,
        "#{title_slug}$|#{title_slug}-[0-9]+$"
      ).order("LENGTH(slug) DESC", slug: :desc).first&.slug
      slug_count = 0
      if latest_task_slug.present?
        slug_count = latest_task_slug.split("-").last.to_i
        only_one_slug_exists = slug_count == 0
        slug_count = 1 if only_one_slug_exists
      end
      slug_candidate = slug_count.positive? ? "#{title_slug}-#{slug_count + 1}" : title_slug
      self.slug = slug_candidate
    end

    def slug_not_changed
      if slug_changed? && self.persisted?
        errors.add(:slug, t("task.slug.immutable"))
      end
    end
end
