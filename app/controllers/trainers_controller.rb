class TrainersController < ApplicationController
  def index
    @trainers = Trainer.buffer(params[:number].to_i)
  end
end
