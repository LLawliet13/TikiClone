<%-- 
    Document   : InsertAdmin
    Created on : Oct 7, 2021, 12:36:09 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <form action="ControllerAdmin?action=insert" method="POST">
            <table border="0">

                <tbody>
                    <tr>
                        <td>username</td>
                        <td><input type="text" name="username" value="" /></td>
                    </tr>
                    <tr>
                        <td>password</td>
                        <td><input type="password" name="password" value="" /></td>
                    </tr>
<!--                    <tr>
                       <td>confirm password</td>
                        <td><input type="password" name="renewpassword" value="" /></td>
                    </tr>-->
                    
                    <tr>
                        <td><input type="submit" value="submit" name="submit" /></td>
                        <td><input type="reset" value="reset" name="reset" /></td>
                    </tr>
                </tbody>
            </table>

           
            
        </form>
    </body>
</html>
