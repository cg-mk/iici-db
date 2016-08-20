<%-- 
    Document   : chores
    Created on : Jul 29, 2016, 2:55:53 PM
    Author     : Miriam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lab Duties</title>
        
        <style>
            body{
                background-color: #d2b48c;
            }
            h1{
                text-align:center;
            }
            #btnfrm{
                text-align: center;
            }
            #choice{
                border: none;
                display: inline-block;
                padding: 50px;
                text-align: left;
            }
            #label{
                text-align: left;
            }
            a.button{
                display: block;
                width: 175px;
                height: 20px;
                margin: 10px 2px;
                text-align: center;
                text-decoration: none;
                font-family: Arial;
                font-size: small;
                background-color: #f5f5f0;
                border: 1px solid #555;
                border-radius: 3px;
                color: #000;
                float: left;
                line-height: 20px;
            }
        </style>
        
        <script>
            window.onerror=function(a,b,c){
                alert('javascript error:\n'+a+'\nPath:'+b+'\nLine: ' + c);
                return true;
            }
        </script>
        <script>
            'use strict';
            
        </script>
    </head>
    <body>
        <h1>Lab Duties</h1>
        <form id="btnfrm" action="">
        <fieldset id="choice">
            <input type="radio" id="weekly" name="chores">
            <label for="weekly">Weekly</label><br>
            <input type="radio" id="cleanup" name="chores">
            <label for="cleanup">Lab Cleanup</label>
        </fieldset>
        </form>
        <a class="button"  href="page1.jsp">Return to Main Menu</a>
    </body>
</html>
