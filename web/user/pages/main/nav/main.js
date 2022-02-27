function recommendFunction(a) {
    var search = a.value;
    console.log(search);

    if (search != "") {
        $.ajax({
            url: 'ControllerProject?action=searchNavBar',
            type: 'GET',
            data: {
                'content':search 
            },

            success: function (data) {
                document.getElementById('recommendNav').innerHTML = data;
               
            },
            error: function (request, error)
            {
                alert("Request: " + JSON.stringify(request));
            }
        });
    }

    return false;
}
function endRecommendFunction() {



    document.getElementById('recommendNav').innerHTML = "";


    return false;
}
$(function () {
    
   $.ajax({
            url: 'ControllerProject?action=cart',
            type: 'GET',
            data: {
                
            },

            success: function (data) {
                console.log("cart: "+data);
                document.getElementById('cartTB').innerHTML = data;
            },
            error: function (request, error)
            {
                alert("Request: " + JSON.stringify(request));
            }
        });
});