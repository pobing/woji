# encoding:utf-8
class FilesController < ApplicationController
	def create
		uploader = Uploader.new
		uploader.store!(params[:file]) if params[:file]
		disk_file = DiskFile.new
		upload = params[:file]
		if upload
			  disk_file.file_name = upload.original_filename
		    disk_file.file_size = upload.size
		    disk_file.mime_type = upload.content_type
		    disk_file.container_type = params[:container_type]
		#    disk_file.container_id = params[:container_id].to_i
		    disk_file.user_id  = current_user.id
		    disk_file.save
		    if disk_file.container_user?
            current_user.avatar_id=disk_file.id
            current_user.save(:validate=>false)
		    end
  	end
    render :json=> { retCode: 1,url: disk_file.file_name} 
	end

	def index
	end
end