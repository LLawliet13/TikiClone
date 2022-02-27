<%-- 
    Document   : InsertCustomer
    Created on : Oct 11, 2021, 9:29:41 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .body{font-size: 10px;}
        </style>
    </head>
    <body>


        <%Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
            if (isDispatched == null) {
                isDispatched = false;
            }

        %>



        <form action="<%=(isDispatched == true ? "" : "../")%>ControllerCustomer?action=insert" method="POST" class="">

            <div class="form-group row ">
                <label for="inputEmail3" class="col-sm-4 col-form-label">Customer Name</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="inputEmail3" name="cname" placeholder="Customer Name">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-4 col-form-label">Phone Number</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="inputPassword3" name="cphone" placeholder="Customer Phone Number">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-4 col-form-label">Address</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="inputPassword3" name="caddress" placeholder="Customer Address">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-4 col-form-label">Username</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="inputPassword3" name="username" placeholder="User Name">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-4 col-form-label">Password</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="inputPassword3" name="password" placeholder="Password">
                </div>
            </div>

            <fieldset class="form-group">
                <div class="row">
                    <legend class="col-form-label col-sm-4 pt-0">Status</legend>
                    <div class="col-sm-8">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="gridRadios1" value="1" checked>
                            <label class="form-check-label" for="gridRadios1">
                                Enable
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="gridRadios2" value="0">
                            <label class="form-check-label" for="gridRadios2">
                                Disable
                            </label>
                        </div>
                    </div>
                </div>
            </fieldset>

            <div class="form-group row ">
                <div class="col-sm-12  d-flex justify-content-center">
                    <button type="submit" value="submit" name="submit" class="btn btn-primary">Submit</button>
                </div>
            </div>
        </form>





    </body>
</html>
