(function(){
 var post_html = function(_data){
  var tagEl=[];
  if (_data.tags.length > 0) {
    tagEl = ['| Tagged: '];
    $.each(_data.tags,function(k,v){
     tagEl.push('<a href="/posts/tag_posts?name='+v.name +'">'+v.name+'</a> ');
    });
  }
  return [
  '<div class="post">',
     '<h3><a href="/posts/'+_data.id,
     '">'+_data.title,
     '</a></h3>',
        '<p>Posted on <a href="/posts/date_posts?date='+_data.created_at,
        '">'+_data.date,
        '</a>',
        ' | by <a href="/users/'+_data.author.id,
        '">'+_data.author.full_name,
        '</a>',
        '</p>',
        '<p>'+_data.content,
        '</p>',
        '<p>Post in: <a href="/posts?type='+_data.type,
        '">'+_data.category,
        '</a> ',
        tagEl.join(""),
         ' | <a href="/posts/',+_data.id,
         '/edit">编辑</a>',
          ' | <a rel="nofollow" data-method="delete" data-confirm="Are you sure?" href="/posts/'+_data.id,
          '">删除</a> ',
          ' | 评论 '+_data.comments_count,
           '</p>',
        // '<p>分享</p>',
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
            if (data.retCode == 1){
              $('#tweet_form')[0].reset();
              $(".span7").prepend(post_html(data.item));
            }
            else
             return notify("failure",data.errors) ;
          }
      })
  });
$('#blog_form').on('submit', function(event){
     event.preventDefault();
      $.ajax({
          url : $(this).prop('action'),
          dataType:'json',
          type:'POST',
          data: $('#blog_form').serializeArray(),
          success: function(data){
            if (data.retCode == 1){
              $('#blog_form')[0].reset();
              $(".span7").prepend(post_html(data.item));
            }
            else
             return notify("failure",data.errors) ;
          }
      })
  });

  $('#site_form').on('submit', function(event){
       event.preventDefault();
        $.ajax({
            url : $(this).prop('action'),
            dataType:'json',
            type:'POST',
            data: $('#site_form').serializeArray(),
            success: function(data){
              if (data.retCode == 1){
                $('#site_form')[0].reset();
                $(".span7").prepend(post_html(data.item));
              }
              else
               return notify("failure",data.errors) ;
            }
        })
    });
})();

