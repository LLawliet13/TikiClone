
function plusSlidesTime(a) {

    if (a === -1) {

        var element = document.getElementsByClassName("nextTime");

        element[0].classList.remove("hideTime");
        element = document.getElementsByClassName("prevTime");

        element[0].classList.add("hideTime");
        console.log("next");
        $('.child_time').toggleClass('move-rightTime');
    }
    if (a === 1) {

        var element = document.getElementsByClassName("prevTime");

        element[0].classList.remove("hideTime");
        element = document.getElementsByClassName("nextTime");

        element[0].classList.add("hideTime");
        console.log("prev");
        $('.child_time').toggleClass('move-rightTime');
    }

}
function openItem(a) {
    window.location.href = "ControllerProject?action=viewdetail&&pid=" + a.getAttribute('src');
}
function selectType(a) {
    var curActive = document.getElementsByClassName('activeTime')[0];
    if (curActive.getAttribute("data") !== a.getAttribute("data")) {
        curActive.classList.remove("activeTime");
        a.classList.add("activeTime");
        var delay = 1000;
        if (document.getElementsByClassName('hideTime')[0].getAttribute("data") === "next")
            plusSlidesTime(-1);

        setTimeout(function () {
            document.getElementsByClassName('child_time')[0].innerHTML = " <div id=\"loading\">\n" +
                    "                            <img id=\"loading-image\" src=\"user/pages/main/content/parts/list_item/hot_item_by_time/image/loading-3.gif\" alt=\"Loading...\" style=\"width: 10%;margin-left:20%;\"/>\n" +
                    "                        </div>";
        }, 100);



        document.getElementsByClassName('nextTime')[0].classList.add("hideTime");

        $.ajax({
            url: 'ControllerProject?action=hotlistTime&&bywhen=' + a.getAttribute("data"),
            type: 'GET',
            data: {

            },

            success: function (data) {
                setTimeout(function () {
                    document.getElementsByClassName('nextTime')[0].classList.remove("hideTime");
                    document.getElementsByClassName('child_time')[0].innerHTML = data;
                }, delay);
//                document.getElementsByClassName('child_time')[0].innerHTML = data;

            },
            error: function (request, error)
            {
                alert("Request: " + JSON.stringify(request));
            }
        });
    }
}
function delaySuccess() {
    console.log("loading");

    document.getElementsByClassName('child_time')[0].innerHTML = " <div id=\"loading\">\n" +
            "                            <img id=\"loading-image\" src=\"user/pages/main/content/parts/list_item/hot_item_by_time/image/loading.gif\" alt=\"Loading...\" />\n" +
            "                        </div>";
}