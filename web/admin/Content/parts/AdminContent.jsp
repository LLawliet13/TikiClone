<%-- 
    Document   : AdminContent
    Created on : Oct 24, 2021, 8:13:55 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
        Boolean isDispatched = (Boolean) request.getAttribute("isDispatched");
        if(isDispatched==null){
            isDispatched = false;
        }
        
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="<%=(isDispatched==true? "":"../")%>css/admincontentstyle.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body>
        
        <%  String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            // option : 3 - list các thành phần , 2 - tạo form để điền , 1 - hiển thị chi tiết các tùy chọn trong từng manager(nhận từ link ở menu)
            String option = (String) request.getAttribute("option");
            // managertype :  chỉ ra option trong phần nào
            String managerType = (String) request.getAttribute("managertype");

        %>
        <%if (option!=null){%>
        <!--list các tùy chọn trong manager-->
        <%if (option.equals("showoption")) {%>
        <%if (managerType.equals("productmanager")) {%>
        <ul class="list-group">
            <li class="list-group-item  "><h4>product Manager</h4></li>
            <li class="list-group-item list-group-item-action "><a href="<%=(isDispatched==true? "":"../")%>ControllerProduct?action=insert&&option=openform&&formtype=insert&&managertype=productmanager">Insert product</a></li>
            <li class="list-group-item list-group-item-action "><a href="<%=(isDispatched==true? "":"../")%>ControllerProject?action=selectproductpage&&managertype=productmanager&&option=listattribute">View product</a></li>
        </ul>
        <%}%>
        <%if (managerType.equals("customermanager")) {%>
        <ul class="list-group">
            <li class="list-group-item  "><h4>Customer Manager</h4></li>
            <li class="list-group-item list-group-item-action "><a href="<%=(isDispatched==true? "":"../")%>ControllerCustomer?action=insert&&option=openform&&formtype=insert&&managertype=customermanager">Insert Customer</a></li>
            <li class="list-group-item list-group-item-action "><a href="<%=(isDispatched==true? "":"../")%>ControllerProject?action=selectcustomerpage&&managertype=customermanager&&option=listattribute">View Customer</a></li>
        </ul>
        <%}%>
        <%if (managerType.equals("billmanager")) {%>
        <ul class="list-group">
            <li class="list-group-item  "><h4>Bill Manager</h4></li>
            <li class="list-group-item list-group-item-action "><a href="<%=(isDispatched==true? "":"../")%>ControllerProject?action=selectbillpage&&managertype=billmanager&&option=listattribute">View Bill</a></li>
        </ul>

        <%}%>
        <%}%>
        <!--hiện thị form-->
        <%if (option.equals("openform")) {%>
        <!--có 2 loại form là update và insert-->
        <% String formType = (String) request.getAttribute("formtype");%>

        <%if (managerType.equals("productmanager")) {%>
        
        

        <%if (formType.equals("insert")) {%>
        <div class="col-sm-9 ">
            <jsp:include page="parts/Product/InsertProduct.jsp"/>
        </div>
        <%}%>

        <%if (formType.equals("update")) {%>
        <div class="col-sm-9 ">
            <jsp:include page="parts/Product/UpdateProduct.jsp"/>
        </div>
        <%}%>

        <%}%>

        <%if (managerType.equals("customermanager")) {%>
        
        <%if (formType.equals("insert")) {%>
        <div class="col-sm-9 ">
            <jsp:include page="parts/Customer/InsertCustomer.jsp"/>
        </div>
        <%}%>

        <%if (formType.equals("update")) {%>
        <div class="col-sm-9 ">
            <jsp:include page="parts/Customer/UpdateCustomer.jsp"/>
        </div>
        <%}%>

        <%}%>

        <%if (managerType.equals("billmanager")) {%>

        <%}%>

        <%}%>
        <%if (option.equals("listattribute")) {%>
        



        <%
//            chứa toàn bộ thông tin của page hiện tại
            String message = (String) request.getAttribute("message");
//            số lượng của thành phần đc in ra
            Integer numberofentries = (Integer) request.getAttribute("numberofentries");
//            quyết định list thuộc manager nào
            String action = (String)request.getAttribute("action");

        %>
        <!--thanh search-->
        <div class="col-sm-3 ">
            <% if (managerType.equals("billmanager")) {%>
            <jsp:include page="SearchBill.jsp"/>
            <%}%>
            <% if (managerType.equals("customermanager")) {%>
            <jsp:include page="SearchCustomer.jsp"/>
            <%}%>
            <% if (managerType.equals("productmanager")) {%>
            <jsp:include page="SearchProductForAdmin.jsp"/>
            <%}%>
        </div>
        <!--thanh số lượng thành phần hiển thị ra trang-->
        <!--không nhập gì mà submit thì coi như số lương mặc định trong servlet-->
        <div class="col-sm-9 ">
            <form class="form-inline md-form entries" action="<%=(isDispatched==true? "":"../")%>ControllerProject?action=<%=action%>&&option=listattribute&&url=<%=pageName%>&&message=<%=message%>&&managertype=<%=managerType%>" method="POST">
                <input class="form-control mr-sm-2" type="text" name="numberofentries" value="" type="text" placeholder="number of entries" aria-label="Search">
                <button class="btn aqua-gradient btn-rounded btn-sm my-0" type="submit">Submit</button>
            </form>

            <!--bảng hiện thị các thành phần-->
            <% if (managerType.equals("billmanager")) {%>   
            <jsp:include page="ViewBillProject.jsp"/>
            <%}%>
            <% if (managerType.equals("productmanager")) {%>   
            <jsp:include page="ViewProduct.jsp"/>
            <%}%><% if (managerType.equals("customermanager")) {%>   
            <jsp:include page="ViewCustomer.jsp"/>
            <%}%>

            <!--thanh chọn trang-->
            <%
                Integer NumbOfPage = (Integer) request.getAttribute("numbofpage");//number of page
                String currentpage = (String) request.getAttribute("currentpage");// current page
                if (NumbOfPage != null && NumbOfPage != 0) {
                    int num = NumbOfPage;
            %>

            <nav aria-label="Search results pages" class="pages">
                <ul class="pagination flex-wrap">

                    <%  int i = 1;

                        while (i <= num) {%>
                    <%
                        if (Integer.parseInt(currentpage) == i) {%>
                    <li class="page-item active">
                        <a class="page-link" href="#"> <%=i%> <span class="sr-only">(current)</span></a>
                    </li>

                    <%} else {%>
                    <li class="page-item"><a class="page-link" href="<%=(isDispatched==true? "":"../")%>ControllerProject?action=<%=action%>&&option=listattribute&&currentpage=<%=i%>&&url=<%=pageName%>&&message=<%=message%>&&numberofentries=<%=numberofentries%>&&managertype=<%=managerType%>"><%=i%></a></li>

                    <%}
                            i++;
                        }%>

                </ul>
            </nav>
            <%}%>
        </div>








        <%}%>
        
        <%}%>
        <%if (option == null) {%>
        <h3>--select some manager--</h3>
        <%}%>


    </body>
</html>
