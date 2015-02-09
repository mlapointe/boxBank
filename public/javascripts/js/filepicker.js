

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


// AJAX FILE UPLOAD

var files_to_upload = [];


$("input[type=file]").change(function(event) {
  $.each(event.target.files, function(index, file) {
    var reader = new FileReader();
    reader.onload = function(event) {
      object = {};
      object.filename = file.name;
      object.data = event.target.result;
      console.log("file ="+object.filename)
      console.log("file ="+object.data)

      files_to_upload.push(object);
    };
    reader.readAsDataURL(file);
  });
});

$("#upload_file_form").submit(function(e){
  e.preventDefault();
  console.log("Submit pressed")

  $('.modal-upload').css("display", "hidden")

  $("#upload_link").html("Uploading...")


  $.each(files_to_upload, function(index, file) {
    console.log(file)
    console.log(file.filename)
    console.log(file.data)
    $.ajax({url: "apply/upload",
          type: 'POST',
          data: {filename: file.filename, data: file.data},
          success: function(data, status, xhr) {



          }
        });
  });
  files = [];

  $('#filePickerModal').modal('hide')



});



$("form").submit(function(form) {
  $.each(files, function(index, file) {
    $.ajax({url: "/ajax-upload",
          type: 'POST',
          data: {filename: file.filename, data: file.data},
          success: function(data, status, xhr) {}
    });
  });
  files = [];
  form.preventDefault();
});





function uploadFile(path){



}
