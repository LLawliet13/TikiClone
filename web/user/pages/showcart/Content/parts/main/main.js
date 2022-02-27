function removeProduct(a, cid) {
    var canRemove = false;
    if (a == 'all') {
        var pidArr = document.getElementsByClassName("pid");
        var pidc = [];
        var j = 0;
        for (var i = 0; i < pidArr.length; i++) {
            if (pidArr[i].checked) {
                pidc[j++] = pidArr[i].value;
            }

        }
        if (pidc.length == 0) {
            swal({
                title: '',
                text: "Vui lòng chọn sản phẩm cần xóa",
                type: 'warning',
                showCancelButton: false,
                confirmButtonText: 'Đồng ý'
            });

        } else {
            canRemove = true;
        }

    } else {
        canRemove = true;
    }
    if (canRemove === true) {
        swal({
            title: '',
            text: "Đồng ý xóa sản phẩm không?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#DD6B55',
            confirmButtonText: 'Đồng ý',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.value) {
                if (a != "all") {
                    var pid = [a];

                } else {

                    var pidArr = document.getElementsByClassName("pid");
                    var pid = [];
                    var j = 0;
                    for (var i = 0; i < pidArr.length; i++) {
                        if (pidArr[i].checked) {
                            pid[j++] = pidArr[i].value;
                        }

                    }


                }

                console.log("pid" + pid);
                $.ajax({

                    url: "ControllerProject?action=removecart&&cid=" + cid,
                    type: "GET",
//            dataType: 'json',
                    data: {pid: pid},

                    success: function (data) {
                        var checkboxes = document.getElementsByClassName("pid");
                        var length = pid.length;
                        for (var i = length - 1; i >= 0; i--) {
                            console.log(i);
                            $('#' + pid[i]).remove();
                        }
                        estimateTotal(cid);

                        var checkboxes = document.getElementsByClassName("pid");
                        if (checkboxes.length == 0)
                            document.getElementsByClassName("cart_page")[0].innerHTML =
                                    "<div class=\"empty\"><img src=\"https://salt.tikicdn.com/desktop/img/mascot@2x.png\" alt=\"\" class=\"empty__img\"><p class=\"empty__note\">Không có sản phẩm nào trong giỏ hàng của bạn.</p><a data-view-id=\"cart_empty_continue.shopping\" href=\"index.jsp\" class=\"empty__btn\">Tiếp tục mua sắm</a></div>";
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
                        });


                    }
                });

            } else {
                // result.dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
            }
        });


    }





}


function buy(a) {
    console.log(a.getAttribute("src"));
    $.ajax({

        url: a.getAttribute("src"),
        type: "GET",

        data: {},

        success: function (data) {
            console.log(data==1);
            if (data==1) {
                window.location = "user/pages/checkout/index.jsp";

            } else {
                swal({
                    title: '',
                    text: "Vui lòng chọn sản phẩm cần mua",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonText: 'Đồng ý'
                });
            }
        }
    });

}
function checkAll(a, cid) {
    var name = a.value;
    if (name == "all") {
        var checkboxes = document.getElementsByClassName("pid");
        if (a.checked) {

            for (var i = 0; i < checkboxes.length; i++) {
                if (!checkboxes[i].checked)
                    checkboxes[i].checked = true;
            }
        } else {
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked)
                    checkboxes[i].checked = false;
            }
        }

    } else {
        var checkboxes = document.getElementsByClassName("pid");

        var indexChecked = 0;
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked)
                indexChecked++;
        }

        if (indexChecked == checkboxes.length) {
            document.getElementById("all").checked = true;
        } else {

            document.getElementById("all").checked = false;

        }


    }
    var pidc = [];
    var j = 0;
    var pidArr = document.getElementsByClassName("pid");
    for (var i = 0; i < pidArr.length; i++) {
        if (pidArr[i].checked) {
            pidc[j++] = pidArr[i].value;
        }

    }
    $.ajax({

        url: "ControllerProject?action=changeInChooseCart&&cid=" + cid,
        type: "GET",

        data: {pid: pidc},

        success: function (data) {
            estimateTotal(cid);
        }
    });
    //calculate total






}
function openlink(a){
    window.location= a.getAttribute("src");
}
function estimateTotal(cid) {
    checkboxes = document.getElementsByClassName("pid");
    var pid = [];
    var j = 0;
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            pid[j++] = checkboxes[i].value;
        }
    }
    if (j != 0) {
        $.ajax({

            url: "ControllerProject?action=estimateTotal&&cid=" + cid + "&&require=estimatedTotal",
            type: "GET",
//            dataType: 'json',
            data: {pid: pid},

            success: function (data) {
                document.getElementsByClassName("estimated_total")[0].getElementsByClassName("right")[0].innerHTML = data + "đ";
                $.ajax({

                    url: "ControllerProject?action=estimateTotal&&cid=" + cid + "&&require=discount",
                    type: "GET",
//            dataType: 'json',
                    data: {pid: pid},

                    success: function (data) {
                        document.getElementsByClassName("discount")[0].getElementsByClassName("right")[0].innerHTML = data + "đ";
                        $.ajax({

                            url: "ControllerProject?action=estimateTotal&&cid=" + cid + "&&require=total",
                            type: "GET",
//            dataType: 'json',
                            data: {pid: pid},

                            success: function (data) {
                                document.getElementsByClassName("real_total")[0].getElementsByClassName("right")[0].innerHTML = data + "đ";

                            }
                        });
                    }
                });
            }
        });
    } else {
        document.getElementsByClassName("estimated_total")[0].getElementsByClassName("right")[0].innerHTML = "0đ";
        document.getElementsByClassName("discount")[0].getElementsByClassName("right")[0].innerHTML = "0đ";
        document.getElementsByClassName("real_total")[0].getElementsByClassName("right")[0].innerHTML = "Vui lòng chọn sản phẩm";
    }
    console.log("j=" + j);
}
function addQuantity(pid, cid) {
    var quantityVar = document.getElementById("quantity" + pid);


    var maxQuantity = quantityVar.getAttribute("maxQuantity");
//    console.log(parseInt(quantityVar.value) > parseInt(maxQuantity));
    if (parseInt(quantityVar.value) + 1 > parseInt(maxQuantity)) {
        swal({
            title: '',
            text: "Số Lượng lớn nhất là " + maxQuantity,
            timer: 1000,
            showCancelButton: false,
            showConfirmButton: false
        });
    } else {
        quantityVar.value = parseInt(quantityVar.value) + 1;
    }
    updateQuantityCartSQL(pid, quantityVar.value, cid);

}
function subtractQuantity(pid, cid) {
    console.log("quantity" + pid);
    var quantity = document.getElementById("quantity" + pid);
    var curQuantity = quantity.value;

    if (parseInt(curQuantity) > 1) {
        quantity.value = parseInt(curQuantity) - 1;
        curQuantity = quantity.value;
        console.log();
        updateQuantityCartSQL(pid, curQuantity, cid);

    } else {
        removeProduct(pid, cid);






    }


}
function updateQuantityCartSQL(pid, quantity, cid) {


    $.ajax({
        url: "ControllerProject?action=changeNumberOfProductCart&&pid=" + pid + "&&quantity=" + quantity + "&&cid=" + cid,
        type: 'GET',
        data: "",
        success: function (data) {

            console.log(data);

            $.ajax({
                url: 'ControllerProject?action=cart',
                type: 'GET',
                data: {

                },

                success: function (data) {
                    var price = document.getElementsByClassName("price" + pid)[0].getAttribute("price");
                    var discount = document.getElementsByClassName("price" + pid)[0].getAttribute("discount");
                    document.getElementsByClassName('raw_total' + pid)[0].innerHTML = parseInt((parseInt(quantity) * parseInt(price) * (1 - parseInt(discount) / 100))) + "đ";
                    console.log("cart: " + data);
                    document.getElementById('cartTB').innerHTML = data;
                    estimateTotal(cid);
                },
                error: function (request, error)
                {
                    alert("Request: " + JSON.stringify(request));
                }
            });



        },
        error: function (data) {

            alert("Error occured");
        }
    });



}

function Blur(pid, cid) {
    var quantity = document.getElementById("quantity" + pid);
    const parsed = parseInt(quantity.value);
    if (isNaN(parsed)) {
        quantity.value = 1;

    } else {


        var maxQuantity = quantity.getAttribute("maxQuantity");

        if (parseInt(quantity.value) > parseInt(maxQuantity)) {
            swal({
                title: '',
                text: "Số Lượng lớn nhất là " + maxQuantity,
                timer: 1000,
                showCancelButton: false,
                showConfirmButton: false
            });
            quantity.value = maxQuantity;
        } else if (quantity.value <= 0) {
            swal({
                title: '',
                text: "Số Lượng nhỏ nhất là 1",
                timer: 1000,
                showCancelButton: false,
                showConfirmButton: false
            });
            quantity.value = 1;
        }
    }
    updateQuantityCartSQL(pid, quantity.value, cid);
}