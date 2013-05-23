#require 'flickraw'

#FlickRaw.api_key="112874de58604e65d3c74f8593191a0c"
#FlickRaw.shared_secret="df1fcbc8c1810a54"

#list   = flickr.photos.getContactsPhotos(:include_self => 'include_self')
#getContactsPhotos(:count => 'count',:just_friends => 'just_friends',:single_photo => 'single_photo',:include_self => 'include_self',:extras => 'extras')
# list = flickr.photos
# list = flickr.photos.getContactsPublicPhotos
#puts list[0].inspect
# id     = list[0].id
# secret = list[0].secret
# info = flickr.photos.getInfo :photo_id => id, :secret => secret
# puts list[0].columns
# puts list.first(10).map(&:id)
# puts info.title           # => "PICT986"
# puts info.dates.taken     # => "2006-07-06 15:16:18"

# sizes = flickr.photos.getSizes :photo_id => id

# original = sizes.find {|s| s.label == 'Original' }
# puts original.width    