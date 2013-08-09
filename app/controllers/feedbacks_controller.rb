class FeedbacksController < ApplicationController
 before_filter :signed_in_user,:only =>[:index]
  
  def new
  end

	def create
		@feedback = Feedback.new(params[:feedback])
		respond_to do |format|
      if @feedback.save
        format.html { redirect_to root_path, notice: 'Thank your message!' }
        format.json { render json: @feedback, status: :created, location: @feedback }
      else
        format.html { render action: "new" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end

	end

end
