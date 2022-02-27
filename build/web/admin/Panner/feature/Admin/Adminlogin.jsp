<%-- 
    Document   : Adminlogin
    Created on : Oct 29, 2021, 1:30:16 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin login</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <style>

            body {
                background: #007bff;
                background: linear-gradient(to right, #0062E6, #33AEFF);
            }

            .btn-login {
                font-size: 0.9rem;
                letter-spacing: 0.05rem;
                padding: 0.75rem 1rem;
            }

            .btn-google {
                color: white !important;
                background-color: #ea4335;
            }

            .btn-facebook {
                color: white !important;
                background-color: #3b5998;
            }

        </style>

    </style>
</head>
<body>

    <%
        String massage = (String) request.getAttribute("massage");
        String isLogin = (String) session.getAttribute("admin");

        Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
        if (isDispatched == null) {
            isDispatched = false;
        }
        String action = ""; //ảnh hưởng bởi vị trí của response , action tính theo vị trí của response trả về lần trước ?
    %>

    <%if (isLogin == null) {%>

<body>
    <% if (isDispatched == true) {
            action = "ControllerAdmin?action=login";
        } else {
            action = "../../../../ControllerAdmin?action=login";
        }%>
    <form id = "loginForm" action="<%=action%>" method="POST">
        <div class="container">
            <div class="row">
                <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
                    <div class="card border-0 shadow rounded-3 my-5">
                        <div class="card-body p-4 p-sm-5">
                            <h5 class="card-title text-center mb-5 fw-light fs-5">Login</h5>
                            <form>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" name="username" id="floatingInput" placeholder="Admin Name">

                                </div>
                                <div class="form-floating mb-3">
                                    <input type="password" class="form-control" name="password" id="floatingPassword" placeholder="Password">

                                </div>


                                <div class="d-grid">
                                    <button class="btn btn-primary btn-login text-uppercase fw-bold" name="submit" value="submit" type="submit">Sign
                                        in</button>
                                </div>
                                <%if (massage != null) {%>
                                <div class="form-floating mb-3">
                                    <span id="massage"><%=massage%></span>
                                </div>
                                <%}%>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>



    <%} else {
            String url = "";
            if (isDispatched == true) {
                url = "admin/AdminSettings.jsp";
//            response có vị trí giống với vị trí file servlet về

            } else {
//            response bắt đầu từ file Adminlogin.jsp
                url = "../../../AdminSettings.jsp";
            }
            response.sendRedirect(url);

        }%>

</body>
</html>
