class UsersController < ApplicationController
  def index
    users = User.select(:id, :name)
    render status: :ok, json: { users: }
  end
end
