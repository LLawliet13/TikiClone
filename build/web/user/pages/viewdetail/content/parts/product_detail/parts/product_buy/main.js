function addtocart(a, cid) {
    console.log(a.getAttribute("pid"), cid);
    if (cid == null) {
        window.location = 'user/pages/login/index.jsp';
    } else {
        var quantity = document.getElementsByClassName("quantity")[0].value;
        if (parseInt(quantity) > 0) {
            $.ajax({

                'url': 'ControllerProject?action=addtosession&&pid=' + a.getAttribute("pid") + '&&quantity=' + quantity + "&&cid=" + cid,
                'type': 'GET',
                'data': {

                },
                'success': function (data) {
                    console.log('Data: ' + data);
                    if (!data.includes('/')) {
                        swal({
                            title: 'Success!',
                            text: data,
                            timer: 1000,
                            showCancelButton: false,
                            showConfirmButton: false
                        }).then(
//                        function () {},
//                        // handling the promise rejection
//                                function (dismiss) {
//                                    if (dismiss === 'timer') {
//                                        //console.log('I was closed by the timer')
//                                    }
//                                }
                                $.ajax({
                                    url: 'ControllerProject?action=cart',
                                    type: 'GET',
                                    data: {

                                    },

                                    success: function (data) {
                                        console.log("cart: " + data);
                                        document.getElementById('cartTB').innerHTML = data;
                                    },
                                    error: function (request, error)
                                    {
                                        alert("Request: " + JSON.stringify(request));
                                    }
                                })
                                );
                    } else {
                        window.location.href = data;
                    }
//                        window.alert(data);
                },
                'error': function (request, error)
                {
                    alert("Request: " + JSON.stringify(request));
                }
            });

        }
    }
}
function addQuantity() {
    var quantity = document.getElementsByClassName("quantity")[0];
    var curQuantity = document.getElementsByClassName("quantity")[0].value;
    quantity.value = parseInt(curQuantity) + 1;

}
function subtractQuantity() {
    var quantity = document.getElementsByClassName("quantity")[0];
    var curQuantity = document.getElementsByClassName("quantity")[0].value;
    if (parseInt(curQuantity) > 0)
        quantity.value = parseInt(curQuantity) - 1;

}
function roughScale(x) {
    const parsed = parseInt(x);
    if (isNaN(parsed)) {
        return -1;
    }
    return parsed;
}
function validateNumber(a) {
    if (roughScale(a.value) == -1) {
        a.value = '';
    }
}
$(function () {

    $('input.quantity').on('blur', function () {
        console.log($('input.quantity').val());
        const parsed = parseInt($('input.quantity').val());
        if (isNaN(parsed)) {
            $('input.quantity').val(0);

        }
    });
});