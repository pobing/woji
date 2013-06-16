$(function(){
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
          ' | <a href="/posts/'+_data.id,
          '",class="post_del">删除</a> ',
          ' | 评论 '+_data.comments_count,
          ' | 阅读 '+ _data.visited_count,
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
              $(".span7").prepend(post_html(data.item)).hide().fadeIn('slow');
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
              $(".span7").prepend(post_html(data.item)).hide().fadeIn('slow');;
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
                $(".span7").prepend(post_html(data.item)).hide().fadeIn('slow');;
              }
              else
               return notify("failure",data.errors) ;
            }
        })
  });

  $('#new_post_form').on('submit', function(event){
       event.preventDefault();
       var values = $("#new_post_form").serializeArray();
       var content_val = UE.getEditor('post_content').getContent();
        values.push({
            name: "content",
            value: content_val
        });

        values = jQuery.param(values);

        $.ajax({
            url : $(this).prop('action'),
            dataType:'json',
            type:'POST',
            // data: $('#new_post_form').serializeArray(),
            data:values,
            success: function(data){
              if (data.retCode == 1){
                $('#new_post_form')[0].reset();
                return notify("success",data.msg) ;
              }
              else
               return notify("failure",data.errors) ;
            }
        })
  });

$(".post_del").click(function(e){
  e.preventDefault();
  var url = $(this).attr("href");
  var postContainer = $(this).parents('div.post');
  if (confirm('Are you sure?')){
    $.ajax({
            url : url,
            dataType:'json',
            type:'DELETE',
            success: function(data){
              if (data.retCode){
                postContainer.slideUp('slow', function() {$(this).remove();});
              }
              else
               return notify("failure","caozuo shibai ") ;
            }
        })
  }
});

$(".site_del").click(function(e){
  e.preventDefault();
  var url = $(this).attr("href");
  var siteItem = $(this).parents('tr');
  if (confirm('Are you sure?')){
    $.ajax({
            url : url,
            dataType:'json',
            type:'DELETE',
            success: function(data){
              if (data.retCode){
                siteItem.remove();
              }
              else
               return notify("failure","caozuo shibai ") ;
            }
        })
  }
});

$(".user_del").click(function(e){
  e.preventDefault();
  var url = $(this).attr("href");
  var userItem = $(this).parents('tr');
  if (confirm('Are you sure?')){
    $.ajax({
            url : url,
            dataType:'json',
            type:'DELETE',
            success: function(data){
              if (data.retCode){
                userItem.remove();
              }
              else
               return notify("failure","caozuo shibai ");
            }
        })
  }
});

$(".cate_del").click(function(e){
  e.preventDefault();
  var url = $(this).attr("href");
  var cateItem = $(this).parents('tr');
  if (confirm('Are you sure?')){
    $.ajax({
            url : url,
            dataType:'json',
            type:'DELETE',
            success: function(data){
              if (data.retCode){
                cateItem.remove();
              }
              else
               return notify("failure","caozuo shibai ");
            }
        })
  }
});
// $("#site_link").click(function(){
//   $(this).hide();
//   $("#site_form").replaceWith(sitePl());
// });

// var sitePl = function(){
//  return ['<p><a id="site_link" href="#">普通模式发布</a></p>',
//  '<form method="post" id="new_site_form" action="/sites/add_by_md" accept-charset="UTF-8">',
//  '<input type="text" placeholder="Markdown 格式发布：[name](link)" name="sites" id="sites" class="input-xxlarge">', 
// '<input type="text" size="30" placeholder="Please input cateory!" name="site[name]" id="site_name">',
// '<input type="text" size="30" placeholder="Please input cateory!" name="site[url]" id="site_url">',
// '<p><input type="submit" value="Add Site" name="commit" class="btn">',
//   '</p>',
// '</form>'
//  ].join("");
// };
 //  $(".post_del").click(function() {
 //    // $('#load').fadeIn();
 //    var commentContainer = $(this).parent();
 //    var id = $(this).attr("id");
 //    var string = 'id='+ id ;
      
 //    $.ajax({
 //       type: "POST",
 //       url: "delete.php",
 //       data: string,
 //       cache: false,
 //       success: function(){
 //      commentContainer.slideUp('slow', function() {$(this).remove();});
 //      $('#load').fadeOut();
 //      }
 //   }
 // });
});

