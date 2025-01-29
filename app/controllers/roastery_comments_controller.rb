class RoasteryCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @roastery = Roastery.find(params[:roastery_id])
    @roastery_comment = @roastery.roastery_comments.build(comment_params)
    @roastery_comment.user = current_user

    if @roastery_comment.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "roastery_#{@roastery.id}_comments", # Matches the div ID
            partial: "roastery_comments/roastery_comment",
            locals: { roastery_comment: @roastery_comment }
          )
        end
        format.html { redirect_to @roastery, notice: "Comment added!" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("comment_form", partial: "roastery_comments/form", locals: { roastery_comment: @roastery_comment }) }
        format.html { redirect_to @roastery, alert: "Failed to add comment." }
      end
    end
  end

  private

  def comment_params
    params.require(:roastery_comment).permit(:comment)
  end
end
