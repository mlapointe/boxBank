
var chosen_files = []


function fileChosen(file_id){

  chosen_files.push(file_id)

  $('#file_list').append("<li>" + file_id + "</li>" );

  $('#filePickerModal').modal('hide')

}
