<%-- 
    Document   : logon
    Created on : Jan 31, 2017, 4:10:41 PM
    Author     : Miriam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LogonPage</title>
        <link href="iici_db.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <form id="logonform" action="DBLogon">
            <h1>Welcome to the IICI Database</h1>
            <input type="text" id="username" name="username" required>
            <label for="username">Username</label><br>
            <input type="text" id="pwd" name="pwd" required>
            <label for="username">Password</label><br>
            <input type="submit" value="Logon">
        </form>
    </body>
</html>
