<%-- 
    Document   : page1
    Created on : Jan 5, 2016, 12:11:59 PM
    Author     : Miriam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>IICIdb_Page1</title>
        <style>
            #btndiv {
                width: 30%;
                min-width: 300px;
                margin: 0 auto;
                overflow: hidden;
            }
            .btn1 {
                display: block;
                height: 70px;
                width: 150px;
                border: 2px solid;
                border-color: white #006600 #006600 white;
                margin-bottom: 20px;
                background-color: #99de66;
                font-family: Arial;
                font-size: small;
                font-weight: bolder;
                color: #006600;
                float: left;
                border-radius: 5px 25px;
                text-align: center;
                text-decoration: none;
                line-height: 70px;
                
            }
            .btn2 {
                display: block;
                height: 70px;
                width: 150px;
                border: 2px solid;
                border-color: white #006600 #006600 white;
                margin-bottom: 20px;
                background-color: #99de66;
                font-family: Arial;
                font-size: small;
                font-weight: bolder;
                color: #006600;
                float: right;
                border-radius: 5px 25px;
                text-align: center;
                text-decoration: none;
                line-height: 70px;
                
            }
            #btnPrimer, #btnSeq, #btnQPCR {
                height: 75px;
                width: 150px;
                margin-bottom: 20px;
                background-color: #99de66;
                font-weight: bold;
                color: #006600;
                float: left;
                border-radius: 5px 25px;
            }
            #btnPlsmid, #btnProtocol, #btnBlot {
                height: 75px;
                width: 150px;
                margin-bottom: 20px;
                background-color: #99de66;
                font-weight: bold;
                color: #006600;
                float: right;
                border-radius: 5px 25px;
            }
            body{
                background-color: #d2b48c;
            }
            h1{
                text-align:center;
            }
            div.d1{
                margin: 0 auto; 
                width: auto; 
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>IICI Database</h1>
        
       <!-- <form id='f' action="Primer" method="post"> -->
            <div id="btndiv" class="d1">
              <!--  <input type="submit" value="Primers" name="pbtn" id="btnPrimer"> -->
                <a href="Primer" class="btn1">Primers</a> 
                <!-- <input type="button" value="Plasmids" id="btnPlsmid" -->
                <a href="Plasmid" class="btn2">Plasmids</a>
                <!--<input type="button" value="Sequences" id="btnSeq"> -->
                <a href="chores.jsp" class="btn1">Lab Chores</a>
                <input type="button" value="Protocols" id="btnBlot">
                <input type="button" value="qPCR" id="btnQPCR" disabled>
                <input type="button" value="Blots" id="btnProtocol" disabled>
            </div>
       <!-- </form> -->
    </body>
</html>
