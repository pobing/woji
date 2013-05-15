# encoding:utf-8
class FilesController < ApplicationController
	def create
		Rails.logger.debug "debug #{params}"
		uploader = Uploader.new
		uploader.store!(params[:file]) if params[:file]
		disk_file = DiskFile.new
		upload = params[:file]
		if upload
			  disk_file.file_name = upload.original_filename
		    disk_file.file_size = upload.size
		    disk_file.mime_type = upload.content_type
		   # disk_file.container_type = upload.content_type
		#    disk_file.container_id = params[:container_id].to_i
		 #   disk_file.user_id  = User.current.id
		    # disk_file.store!(upload)
		   #disk_file.retrieve_from_store!('my_file.png')
		    disk_file.save
  	end
    render :json=> { retCode: 1,url: disk_file.file_name} 
	end

	def index
	end
end