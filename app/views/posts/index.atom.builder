atom_feed do |feed|
feed.title "Woji Posts "
feed.updated(@posts[0].created_at) if @posts.length > 0
@posts.each do |post|
      feed.entry(post) do |entry|
        entry.title(post.title)
        entry.content(post.content, :type => 'html')
        entry.tags(post.tag_list) if post.tag_list.length > 0
        entry.author do |author|
          author.name(post.author)
          author.email(post.user.try(:email))
        end
      end
    end 
end
