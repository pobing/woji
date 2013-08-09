class Admin::FeedbacksController < ApplicationController
 before_filter :signed_in_user,:only =>[:index]
 before_filter :admin_required?
 layout "admin"
	def index
		@feedbacks = Feedback.paginate(page: params[:page])
	end

end
