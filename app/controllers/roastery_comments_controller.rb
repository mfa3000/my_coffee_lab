class RoasteryCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @roastery = Roastery.find(params[:roastery_id])
    @roastery_comment = @roastery.roastery_comments.build(comment_params)
    @roastery_comment.user = current_user

    if @roastery_comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @roastery, notice: "Comment added!" }
      end
    else
      redirect_to @roastery, alert: "Failed to add comment."
    end
  end

  private

  def comment_params
    params.require(:roastery_comment).permit(:comment)
  end
end
