

function fileChosen(file_id, file_name){


  $('#file_list').append("<li>" + file_name + "</li>" );
  $('#file_list').append("<input name='file_ids[]' type='hidden' value='" + file_id + "'>" );


  $('#filePickerModal').modal('hide')

}

function folderChosen(folder_id){

  //TODO:
  //Reload picker w/ folder contents via API using YQL
  //http://developers.blog.box.com/2011/09/28/using-the-box-api-with-javascript/

}



function showUpload(){
  $('.modal-upload').css("display", "inline")

}


var files;

$('input[type=file]').on('change', prepareUpload);

// Grab the files and set them to our variable
function prepareUpload(event)
{
  files = event.target.files;
}



$("#upload_file_form").submit(function(e){
  e.preventDefault();
  console.log("Submit pressed")

  $('.modal-upload').css("display", "hidden")

  $("#upload_link").html("Uploading...")

  var data = new FormData();
      $.each(files, function(key, value)
      {
          data.append(key, value);
          console.log(key+" value= "+value.fullPath)
      });

      $.ajax({
          url: 'apply/upload',
          type: 'POST',
          data: data,
          cache: false,
          dataType: 'json',
          processData: false, // Don't process the files
          contentType: false, // Set content type to false as jQuery will tell the server its a query string request
          success: function(data, textStatus, jqXHR)
          {



          },
          error: function(jqXHR, textStatus, errorThrown)
          {
              // Handle errors here
              console.log('ERRORS: ' + textStatus);
              // STOP LOADING SPINNER
          }
      });



});





function uploadFile(path){



}
