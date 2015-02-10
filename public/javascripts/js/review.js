


//Load file from viewer --> implement later
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
