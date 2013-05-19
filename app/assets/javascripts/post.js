(function(){
 var post_html = function(_data){
return [
'<div class="post">',
   '<h3><a href="/posts/'+_data.id,
   '">'+_data.title,
   '</a></h3>',
      '<p>Posted on '+_data.date,
      ' | by '+_data.author.name,
      '</p>',
      '<p>'+_data.content,
      '</p>',
      '<p>Post in: '+_data.category,
       '| <a href="/posts/',+_data.id,
       '/edit">编辑</a>',
        '| <a rel="nofollow" data-method="delete" data-confirm="Are you sure?" href="/posts/'+_data.id,
        '">删除</a> ',
        '| 评论 '+_data.comments_count,
         '</p>',
      '<p>分享</p>',
      '</div>'
      ].join(""); 
}; 
$('#tweet_form').on('submit', function(event){
     event.preventDefault();
      $.ajax({
          url : $(this).prop('action'),
          dataType:'json',
          type:'POST',
          data: $('#tweet_form').serializeArray(),
          success: function(data){
             // $(":password").val("");
               if (data.retCode == 1)
                // notify("success",data.msg) ;
              $(".span7").prepend(post_html(data.item));
              else
             return notify("failure",data.errors) ;
          }
      })
  });
})();

// <h3><%=link_to post.title,post%></h3>
//       <p>Posted on <%=link_to time_local(post.created_at),"/posts/date_posts?date=#{post.created_at}" %> | by <%=link_to post.author,post.user %>
//       </p>
//          <p><%=raw post.summary %></p>
//          <% if post.summary.length > 200 %>
//           <p><%= link_to "阅读全文",post %></p>
//          <% end %>
//         <p>
//           Post in: <%=link_to post.category_name, posts_path(:type=>post.item_type) %> 
//           <%unless post.tags.empty? %>
//            | Tagged:<% post.tags.each do |t| %>
//               <%=link_to t.name, "/posts/tag_posts?name=#{t.name}"%>
//               <%end%>
//           <%end%>
//           <% if current_user?(post.user)%>
//            | <%=link_to '编辑',edit_post_path(post)%>
//            | <%= link_to '删除', post, confirm: 'Are you sure?', method: :delete %> 
//           <%end%>
//          | 评论 <%= post.comments_count || 0 %> 
//         </p>