class TrainersController < ApplicationController
  def index
    @trainers = Trainer.buffer(
      params[:number].to_i,
      params[:tname],
      params[:texpert],
      params[:tintermediate],
      params[:tamateur]
    )

    @last_group = Trainer.filtered(
      params[:tname],
      params[:texpert],
      params[:tintermediate],
      params[:tamateur]
    ).last == @trainers.last
  end
end
