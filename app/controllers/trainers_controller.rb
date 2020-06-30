class TrainersController < ApplicationController
  def index
    @trainers = Trainer.buffer(params[:number].to_i, params[:tname])
    @last_group = Trainer.filtered(params[:tname]) == @trainers.last
  end
end
