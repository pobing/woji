(function(){
  $('#update_pwd_form').on('submit', function(event){
     event.preventDefault();
      $.ajax({
          url : $(this).prop('action'),
          dataType:'json',
          type:'POST',
          data: $('#update_pwd_form').serializeArray(),
          success: function(data){
             $(":password").val("");
               if (data.retCode == 1)
                notify("success",data.msg) ;
              else
             return notify("failure",data.errors) ;
          },
          error: function(message){
              var error_message = $.parseJOSN(message);
              notify("failure",error_message) ;
          }
      })
  });
  
  /*
  $(".del_user").last().click(function(event){
    // event.preventDefault();
    $.ajax({
    type: "DELETE",
    dataType:'json',
    url: $(this).attr("href"),
    success: function(data){
      $(this).parents("tr").remove();
      if (data.retCode == 1)
        notify("success",data.msg) ;
      else
        return notify("failure",data.errors) ;
          }
    });
    });
*/

  // $('#update_avatar_form').on('submit', function(event){
  //    event.preventDefault();
  //     $.ajax({
  //         url : $(this).prop('action'),
  //         dataType:'json',
  //         type:'POST',
  //         data: {
  //         "avatar": $('#avatar').serialize
  //         // $('#update_avatar_form').serializeArray()
  //         },
  //         // data: $('#update_avatar_form').serializeArray(),
  //         success: function(data){
  //            // $(":password").val("");
  //            // console.log(data);
  //              if (data.retCode == 1){
  //               $('#img_thumb').attr('src',data.item.avatar.thumb.url);
  //               return notify("success",data.msg) ;
  //              }
  //            return notify("failure",data.errors) ;
  //         }
  //     })
  // });

})();
