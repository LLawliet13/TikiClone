function opendetail() {
    var product_detail = document.getElementsByClassName("active");
    console.log(typeof product_detail[0] + "," + product_detail[0]);
    if (product_detail[0] == undefined) {
        product_detail = document.getElementsByClassName("product_list_2");
        product_detail[0].classList.add("active");
    } else {
        product_detail[0].classList.remove("active");
    }
}
function buy(cid) {
    var radioGroup1 = document.getElementsByClassName("option_1");
    var isRadio1Checked = false;
    for (var i = 0; i < radioGroup1.length; i++) {
        if (radioGroup1[i].getElementsByTagName('input')[0].checked == true) {
            isRadio1Checked = true;
            break;
        }
    }
    var radioGroup2 = document.getElementsByClassName("option_2");
    var isRadio2Checked = false;
    for (var i = 0; i < radioGroup2.length; i++) {
        if (radioGroup2[i].getElementsByTagName('input')[0].checked == true) {
            isRadio2Checked = true;
            break;
        }
    }
    var confirmGroup = document.getElementsByClassName("confirm");
    var isConfirm = true;
    for (var i = 0; i < confirmGroup.length; i++) {
        if (confirmGroup[0].getElementsByTagName('input')[0].checked == false) {
            isConfirm = false;
            break;
        }
    }
    if (isRadio1Checked == true && isRadio2Checked == true && isConfirm == true) {
        swal({
            title: '',
            text: "Đã xử lý đơn hàng",
            type: 'warning',
            showCancelButton: false,
            showConfirmButton: false
        });
        setTimeout(function (){window.location = "ControllerProject?action=buycart&&cid=" + cid;
        }, 2000);

    } else {
        swal({
            title: '',
            text: "Vui lòng chọn đầy đủ các phương thức và xác nhận",
            type: 'warning',
            showCancelButton: false,
            confirmButtonText: 'Đồng ý'
        });
    }

}