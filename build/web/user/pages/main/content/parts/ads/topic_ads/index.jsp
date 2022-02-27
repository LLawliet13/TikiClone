<%-- 
    Document   : index
    Created on : Dec 1, 2021, 1:09:34 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%

            Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if (isDispatched == null) {
                isDispatched = false;
            }
            String uri = request.getRequestURI();
            String pageName = uri.substring((uri.substring(uri.indexOf("/") + 1)).indexOf("/") + 2);
            String[] parts = uri.split("/");
            int numberofSlash = parts.length - 3;
            String backPrefixLink = "";
            while (numberofSlash > 0) {
                backPrefixLink += "../";
                numberofSlash--;
            }

        %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/ads/topic_ads/style.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    </head>
    <body>
           <div class="slider_ads">

        <section class="section">
            <div class="slider">
                <div class="slide">
                    <input type="radio" name="radio-btn" id="radio1">
                    <input type="radio" name="radio-btn" id="radio2">
                    <input type="radio" name="radio-btn" id="radio3">
                    <div class="st first">
                        <img src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/ads/topic_ads/image/slide1.img" alt="">
                    </div>
                    <div class="st">
                        <img src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/ads/topic_ads/image/slide2.img" alt="">
                    </div>
                    <div class="st">
                        <img src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/ads/topic_ads/image/slide3.img" alt="">
                    </div>

                    <div class="nav-auto">
                        <div class="a-b1 one"></div>
                        <div class="a-b2 two"></div>
                        <div class="a-b3 three"></div>
    
                    </div>
                </div>
               
                <div class="nav-m">
                    <label for="radio1" class="m-btn "></label>
                    <label for="radio2" class="m-btn "></label>
                    <label for="radio3" class="m-btn "></label>
                </div>
            </div>
        </section>
        <div class="hot_topic_ads">
            <img src="<%=(isDispatched == true ? "" : backPrefixLink)%>user/pages/main/content/parts/ads/topic_ads/image/hot_topic_ads.img" alt="">
        </div>
    </div>
        <script type="text/javascript">
            var counter = 1;
            setInterval(function () {
                document.getElementById('radio' + counter).checked = true;
                counter++;
                if (counter > 3) {
                    counter = 1;
                }
            }, 5000);


        </script>
    </body>
</html>
