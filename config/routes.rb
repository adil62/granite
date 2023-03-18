# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "*path", to: "home#index", via: :all

  constraints(lambda { |req| req.format == :json }) do
    resources :tasks, except: %i[new edit], param: :slug
    resources :users, only: :index
    resources :users, only: %i[index create]
  end
end
