atom_feed do |feed|
feed.title "title: #{@post.title}"
feed.updated(@post.created_at)
feed.entry(@post) do |entry|
        entry.title(@post.title)
        entry.content(@post.content, :type => 'html')
        # entry.author do |author|
        #   author.name("DHH")
        # end
        entry.author(@post.author)
      end
end