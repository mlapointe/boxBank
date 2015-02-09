
function fileChosen(file_id, file_name){


  $('#file_list').append("<li>" + file_name + "</li>" );
  $('#file_list').append("<input name='file_ids[]' type='hidden' value='" + file_id + "'>" );


  $('#filePickerModal').modal('hide')

}

function folderChosen(id){

    $.ajax({url: "apply/ajax-getfolder",
        type: 'POST',
        data: {folder_id: id},
        success: function(data, status, xhr) {
          info = JSON.parse(data)

          console.log(info)
          $('#modal_file_ul').empty()


          for ( i in info){
            x = info[i]
            if (x.type === 'file'){
              $('#modal_file_ul').append('<button type="button" class="btn file-btn" onclick="fileChosen('+x.id+',\''+x.name+'\')">'+x.name+'</button>');
              console.log("file")
            }else if (x.type === 'folder'){
              $('#modal_file_ul').append('<button type="button" class="btn file-btn" onclick="folderChosen('+x.id+')">['+x.name+']</button>');
              console.log("folder")

            }

          }


        }, error: function(request, textStatus, errorThrown) {
            console.log("error"+request+textStatus)

        }
      });


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

  // $("#upload_link").html("Uploading...")


  $.each(files_to_upload, function(index, file) {
    console.log(file)
    console.log(file.filename)
    console.log(file.data)
    $.ajax({url: "apply/upload",
          type: 'POST',
          data: {filename: file.filename, data: file.data},
          success: function(data, status, xhr) {
            info = JSON.parse(data)

            fileChosen(info.file_id, info.file_name)
            $('.modal-upload').css("display", "hidden")


          }, error: function(request, textStatus, errorThrown) {
              console.log("error"+request+textStatus)
              $('#filePickerModal').modal('hide')
          }
        });
  });
  files = [];





});
