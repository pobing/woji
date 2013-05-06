module UsersHelper
  def gravatar_for(user,options = { size:50 })
  email = user.try(:email).nil? ? "" : user.email.downcase
	gravatar_id = Digest::MD5::hexdigest(email)
	size = options[:size]
	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
	image_tag(gravatar_url, alt: user.try(:name), class: "gravatar")
  end
end
