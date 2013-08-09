class TagsController < ApplicationController
 def show
 	name = CGI::unescapeHTML(params[:id])
 	@tag = Tag.find_by_name(name)
 	@posts = @tag.posts
 end
end