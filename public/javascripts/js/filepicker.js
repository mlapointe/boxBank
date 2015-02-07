
var chosen_files = []


function fileChosen(file_id, file_name){

  chosen_files.push(file_id)

  $('#file_list').append("<li>" + file_name + "</li>" );
  $('#file_list').append("<input name='file_ids[]' type='hidden' value='" + file_id + "'>" );


  $('#filePickerModal').modal('hide')

}

function folderChosed(folder_id){

  //TODO:
  //Reload picker w/ folder contents via API using YQL
  //http://developers.blog.box.com/2011/09/28/using-the-box-api-with-javascript/

}
