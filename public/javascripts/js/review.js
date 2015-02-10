
function confirmDownload(){

  return confirm('Final view would reload viewer on this page. \n (see source for example code) \n Would you like to download file instead?')
}

function addComment(){
  return alert('To be implemented after viewer above is live')
}

function acceptApplication(){

  return alert('To be implemented after DB is created')

}


//Load file from viewer --> implement later
//(need DB to store applications w/ Viewer ID -- Cannot expect file to process as soon as it is uploaded to the Box View API)

// function selectFileToView(file){
//
//   console.log(file)
//
//
//   $.ajax({url: "review/ajax-getfile",
//       type: 'POST',
//       data: {file_id: file},
//       success: function(data, status, xhr) {
//         info = JSON.parse(data)
//
//         console.log(info)
//
//         var viewer = Crocodoc.createViewer('.viewer', {
//             url: 'https://view-api.box.com/1/sessions/'+info.id+'/assets/'
//         });
//         viewer.load();
//
//
//       }, error: function(request, textStatus, errorThrown) {
//           console.log("error"+request+textStatus)
//
//       }
//     });
// }
