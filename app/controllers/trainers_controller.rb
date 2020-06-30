class TrainersController < ApplicationController
  def index
    @trainers = Trainer.buffer(
      params[:number].to_i,
      params[:tname],
      params[:texpert],
      params[:tintermediate]
    )

    @last_group = Trainer.filtered(
      params[:tname],
      params[:texpert],
      params[:tintermediate]
    ).last == @trainers.last

    byebug
  end
end
