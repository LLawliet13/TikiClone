function opencard(a,content) {
        document.getElementById("content_tag").innerHTML= content;
        var active = document.getElementsByClassName("active-card")[0];
        if(active.getAttribute('name')!==a.getAttribute('name')){
        active.classList.remove("active-card");
        a.classList.add("active-card");
    $.ajax({
        url: a.getAttribute("src"),
        type: 'GET',
        data: {

        },

        success: function (data) {
            history.replaceState('', 'jsp page', a.getAttribute("originalLink"));
//            history.pushState('', 'new jsp page', );
            console.log(data);
            document.getElementsByClassName('content')[0].innerHTML = data;

        },
        error: function (request, error)
        {
            alert("Request: " + JSON.stringify(request));
        }
    });}
}
