# frozen_string_literal: true

Rails.application.routes.draw do
  resources :bank_accounts, only: %i[show]
end
