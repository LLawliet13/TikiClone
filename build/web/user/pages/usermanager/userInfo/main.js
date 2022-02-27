

function submitForm(){
$("#changedetail").submit(function (e) {


    e.preventDefault();

    var form = $(this);
    var url = form.attr('action');
    console.log(url);


    $.ajax({
        url: url,
        type: 'GET',
        data: form.serialize(),
        success: function (data) {

            
            console.log(data);
            if (data === 'Success') {
                swal({
                    title: '',
                    text: "Thay đổi thông tin thành công",
                    type: 'info',
                    timer: 1000,
                    showCancelButton: false,
                    showConfirmButton: false
                });
                    setTimeout(function(){location.reload();},1000);
                
            } else {
                swal({
                    title: '',
                    text: "Một vài thông tin sai lệch",
                    type: 'Warning',
                    timer: 1000,
                    showCancelButton: false,
                    showConfirmButton: false
                });

            }
        },
        error: function (data) {

            alert("Error occured");
        }
    });
    e.preventDefault();





});
}

