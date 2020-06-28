class TrainersController < ApplicationController
  def index
    @trainers = Trainer.buffer(params[:number].to_i)
    @last_group = Trainer.last == @trainers.last
  end
end
