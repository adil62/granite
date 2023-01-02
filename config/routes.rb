# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "*path", to: "home#index", via: :all

  resources :tasks, except: %i[new edit destroy], param: :slug
end
