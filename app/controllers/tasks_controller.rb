# frozen_string_literal: true

class TasksController < ApplicationController
  # respond_to :html,:xml,:json

  def index
    @tasks = Task.all
    # respond_with(@tasks)
    respond_to do |format|
        format.html
        format.json { render json: @tasks }
        format.xml { render xml: @tasks }
      end
  end
end
