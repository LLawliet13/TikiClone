//$(".view_product").click(function(){
//
////$(".product_colors span").removeClass("active");
////$(this).addClass("active");
////$("body").css("background",$(this).attr("data-color"));
////$(".product_price").css("background",$(this).attr("data-color"));
////$(".product_button").css("background",$(this).attr("data-color"));
////$(".product_pic").css("background-image",$(this).attr("data-pic"));
//var xmlHttp = new XMLHttpRequest();
////xmlHttp.open("POST", $(this).attr("request"));
////xmlHttp.send();
//console.log("trigger");
//
//
//});
//
// $('a.product_button').click(function(){
// 
// alert(".someclass was clicked");
// 
// });
// 
// $('.product_button').click(function(){
// 
// alert(".someclass was clicked")
// 
// });
//document.getElementById("theid").onfocus=function fone(){
//    document.onkeypress = function(myEvent) {
//
//        var code = myEvent.which;
//        if ((code === 13) || (code === 32)) {
//
//           $('.someclass').click();
//        }
//    }
//}
function openDetail(a) {
    console.log(a.getAttribute('request'));
    window.location.href = a.getAttribute('request');

}
function showMore() {
    var boxName = document.getElementsByClassName("active_hot_list_nav");
    var detail = boxName[0].getElementsByClassName("detail");
    var topic = detail[0].getAttribute("topic");
    console.log(detail[0].getAttribute("topic"));
    var ProductCard = document.getElementsByClassName("product_card");
    var amountOfProductCard = ProductCard.length;
    console.log(amountOfProductCard + " ," + topic);
    var hot_item_list = document.getElementsByClassName("hot_item_list");

    $.ajax({

        'url': 'ControllerProject?action=selectCategory_hotDeal&&topic=' + topic + '&&numberOfBox=' + amountOfProductCard,
        'type': 'GET',
        'data': {

        },
        'success': function (data) {
            console.log('Data: ' + data);
            hot_item_list[0].innerHTML += data;
            $.ajax({

                'url': 'ControllerProject?action=canShowMore&&topic=' + topic + '&&numberOfBox=' + amountOfProductCard,
                'type': 'GET',
                'data': {

                },
                'success': function (data) {

                    document.getElementsByClassName("viewmore")[0].innerHTML = data;
                },
                'error': function (request, error)
                {
                    alert("Request: " + JSON.stringify(request));
                }
            });



        },
        'error': function (request, error)
        {
            alert("Request: " + JSON.stringify(request));
        }
    });
    return false;

}
function selectCategory(a) {
    var boxName = document.getElementsByClassName("active_hot_list_nav");
    var curTopic = boxName[0].getElementsByClassName("detail")[0].getAttribute("topic");
    console.log();
    boxName[0].classList.remove("active_hot_list_nav");
    a.classList.add("active_hot_list_nav");
    var detail = a.getElementsByClassName("detail");
    var topic = detail[0].getAttribute("topic");
    if (curTopic != topic) {

        console.log(detail[0].getAttribute("topic"));
        var hot_item_list = document.getElementsByClassName("hot_item_list");
//    window.scrollTo(0, boxName.scrollHeight);
//    boxName.scrollIntoView({behavior: "smooth"});
//    location.href = "#topHL";
        document.getElementById("topHL").scrollIntoView();
        $.ajax({

            'url': 'ControllerProject?action=selectCategory_hotDeal&&topic=' + topic,
            'type': 'GET',
            'data': {

            },
            'success': function (data) {

                hot_item_list[0].innerHTML = data;
                $.ajax({

                    'url': 'ControllerProject?action=canShowMore&&topic=' + topic + '&&numberOfBox=' + 0,
                    'type': 'GET',
                    'data': {

                    },
                    'success': function (data) {

                        document.getElementsByClassName("viewmore")[0].innerHTML = data;
                    },
                    'error': function (request, error)
                    {
                        alert("Request: " + JSON.stringify(request));
                    }
                });

            },
            'error': function (request, error)
            {
                alert("Request: " + JSON.stringify(request));
            }
        });
    }
    return false;
}

