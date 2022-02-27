
function plusSlides(a) {

    if (a === -1) {

        var element = document.getElementsByClassName("next");

        element[0].classList.remove("hide");
        element = document.getElementsByClassName("prev");

        element[0].classList.add("hide");
        $('.parent-box').toggleClass('move-right');
    }
    if (a === 1) {

        var element = document.getElementsByClassName("prev");

        element[0].classList.remove("hide");
        element = document.getElementsByClassName("next");


        element[0].classList.add("hide");
        $('.parent-box').toggleClass('move-right');
    }

}

