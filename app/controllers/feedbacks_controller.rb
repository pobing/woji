class FeedbacksController < ApplicationController
 before_filter :signed_in_user,:only =>[:index]
 before_filter :admin_required?, :only => [:index]
 
	def index
		@feedbacks = Feedback.paginate(page: params[:page])
		render :layout => 'manage'
	end
  
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
