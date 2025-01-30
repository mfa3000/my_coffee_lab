class BeanCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bean_comment, only: [:destroy]

  def create
    @bean = Bean.find(params[:bean_id])
    @bean_comment = @bean.bean_comments.build(comment_params)
    @bean_comment.user = current_user

    if @bean_comment.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "bean_#{@bean.id}_comments",
            partial: "bean_comments/bean_comment",
            locals: { bean_comment: @bean_comment }
          )
        end
        format.html { redirect_to @bean, notice: "Comment added!" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("comment_form", partial: "bean_comments/form", locals: { bean_comment: @bean_comment }) }
        format.html { redirect_to @bean, alert: "Failed to add comment." }
      end
    end
  end

  def destroy
    @bean_comment.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @bean_comment.bean, notice: "Comment deleted!" }
    end
  end

  private

  def comment_params
    params.require(:bean_comment).permit(:comment)
  end

  def set_bean_comment
    @bean_comment = BeanComment.find(params[:id])
    redirect_to @bean_comment.bean, alert: "Not authorized!" unless @bean_comment.user == current_user
  end
end
