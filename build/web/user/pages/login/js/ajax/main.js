


$("#loginForm").submit(function (e) {


    e.preventDefault();

    var form = $(this);
    var url = form.attr('action');
    console.log(url);
    $('#in_massage').html("");
    document.getElementById("loading").classList.remove("hide");
    $.ajax({
        url: url,
        type: 'POST',
        data: form.serialize(),
        success: function (data) {

            console.log(data);

            if (data === 'Success') {
                setTimeout(function(){
                    window.location = document.referrer;
                },1000);
//               window.location.href =$("#loginForm").attr('url');
                
            }else{
                
                setTimeout(function(){
                    document.getElementById("loading").classList.add("hide");
                    $('#in_massage').html(data);
                },600);
                
            }
        },
        error: function (data) {

            alert("Error occured");
        }
    });
    e.preventDefault();





});