<%-- 
    Document   : UpdateProduct
    Created on : Oct 6, 2021, 1:32:19 PM
    Author     : DELL
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% // DAOProduct dao = new DAOProduct();
            ResultSet rs = (ResultSet) request.getAttribute("rs");
            ResultSet rscate = (ResultSet) request.getAttribute("rscate");
            String urlJSP = (String) request.getAttribute("url");
        %>
        <% if (rs.next() && rscate != null) {%>
        <form action="ControllerProduct?action=update&&url=<%=urlJSP%>" method="POST">
            <div class="form-group">
                <label for="exampleFormControlSelect1">Category Name</label>




                <select class="form-control" id="exampleFormControlSelect1" name="cateid" >
                    <%while (rscate.next()) {%>
                    <option value ="<%=rscate.getInt("cateid")%>" <%if(rs.getInt("cateid")==rscate.getInt("cateid")){%>selected="selected"<%}%>><%=rscate.getString("catename")%></option>
                    <%}%></select>

                </select>
            </div>
            <div class="form-group row">
                <!--<label for="inputEmail3" class="col-sm-2 col-form-label">Product ID</label>-->
                <!--<div class="col-sm-10">-->
                    <input type="hidden" class="form-control" id="inputEmail3" name="pid" placeholder="Product ID" value="<%=rs.getString("pid")%>">
                <!--</div>-->
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Product Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" name="pname" placeholder="Product Name" value="<%=rs.getString("pname")%>"/>
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Quantity</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" name="quantity" placeholder="Quantity" value="<%=rs.getInt("quantity")%>">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Price</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" name="price" placeholder="Price" value="<%=rs.getDouble("price")%>">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Image Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" name="image" placeholder="Image Name" value="<%=rs.getString("image")%>">
                </div>
            </div>
            <div class="form-group row">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Description</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="inputPassword3" name="description" placeholder="Description" value="<%=rs.getString("description")%>">
                </div>
            </div>
            <fieldset class="form-group">
                <div class="row">
                    <legend class="col-form-label col-sm-2 pt-0">Status</legend>
                    <div class="col-sm-10">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="gridRadios1" value="1" <%=rs.getInt("status")==1? "checked":""%>>
                            <label class="form-check-label" for="gridRadios1">
                                Enable
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="gridRadios2" value="0" <%=rs.getInt("status")==0? "checked":""%>>
                            <label class="form-check-label" for="gridRadios2">
                                Disable
                            </label>
                        </div>
                    </div>
                </div>
            </fieldset>
            <div class="form-group row">
                <div class="col-sm-10">
                    <button type="submit" value="submit" name="submit" class="btn btn-primary">Submit</button>
                </div>
            </div>
        </form>
        <%}%>
    </body>
</html>
