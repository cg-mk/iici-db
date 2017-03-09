<%-- 
    Document   : chores
    Created on : Jul 29, 2016, 2:55:53 PM
    Author     : Miriam
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lab Duties</title>
        <link href="test.css" rel="stylesheet" type="text/css">
        <style>
            body{
                background-color: #d2b48c;
            }
            h1{
                text-align:center;
            }
            #form1{
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
                width: 10%;
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
            
            .labels {
                margin: 10px;
            }
            #chrDesc {
                margin: 10px;
            }
            #btnEditChrCncl {
                margin-top: 10px;
            }
            #chrLstBdy td,#chrLstHead th{
                border:1px solid black;
            }
            /* form{ border:1px solid red;} */
            table{ border:1px solid green;}
            #chorediv{
                float:left;
                width:50%;
            }
            #peoplediv{
                float:left;
                width:20%;
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
            var action;
            var display = "${display}";
            window.onload = init;
            function init() {
                document.getElementById("form1").style.display = 'none'; // radio buttons
                document.getElementById('form2').style.display = 'none'; // people and chores
                document.getElementById('form3').style.display = 'none'; // assigned tasks
                document.getElementById('form4').style.display = 'none'; 
                document.getElementById("form5").style.display = 'none'; // add/edit chore
                document.getElementById("form6").style.display = 'none'; // search chores
                
                
                if (display==''){
                     document.getElementById("form1").style.display = 'block';
                }else{
                    if (display.indexOf("1") != -1){ // display radio buttons
                        document.getElementById("form1").style.display = 'block';
                    }
                    if (display.indexOf("2") != -1){ // display people and chores
                        document.getElementById('form2').style.display = 'block';
                        //alert('assign btn handler');
                        document.getElementById('chrLstBdy').onclick = frmbtnclk;
                    }
                    if (display.indexOf("3") != -1){ // display assigned chores
                        document.getElementById('form3').style.display = 'block';
                    }
                    /*if (display.indexOf("4") != -1){
                        document.getElementById('form4').style.display = 'block';
                    }*/
                    if (display.indexOf("5") != -1){ // add/edit chores
                        //document.getElementById('form5').style.display = 'block';
                    }
                    if (display.indexOf("6") != -1){ // search chores
                        //document.getElementById('form6').style.display = 'block';
                    }
                    
                }
                document.getElementById('cancel2').onclick = hide2;
                document.getElementById('cancel3').onclick = hide3;
                document.getElementById('cancel5').onclick = hide5;
                document.getElementById('cancel6').onclick = hide6;
                
                document.getElementById('newChr1').onclick = show5;
                document.getElementById('newChr2').onclick = show5;
                document.getElementById('searchbtn1').onclick = show6;
                document.getElementById('searchbtn2').onclick = show6;
            };
            
            function frmbtnclk(evt) {
                if (evt.target.tagName === 'INPUT' && evt.target.className === 'delbtn') {
                    var tr = evt.target.parentNode.parentNode;
                    var chid = tr.getAttribute('data-id');
                    var chtype = tr.getAttribute('data-type');
                    var chdesc = tr.getElementsByTagName('TD')[0].innerHTML;
               
                    var x = confirm('Delete Chore ['+ chdesc +'] ?');
                    if(x){
                        alert('deleting...');
                        document.getElementById('frm4choreid').value = chid;
                        document.getElementById('form4').submit();
                    }
                } else if (evt.target.tagName === 'INPUT' && evt.target.className === 'edbtn') {
                    
                    document.getElementById('addEditTitle').innerHTML = 'Edit Chore';
                    var tr = evt.target.parentNode.parentNode;
                    var chid = tr.getAttribute('data-id');
                    var chtype = tr.getAttribute('data-type');
                    var chdesc = tr.getElementsByTagName('TD')[0].innerHTML;
                    alert('id='+chid+' type=['+chtype+'] desc=['+chdesc+']');
                    document.getElementById('chrId5').value = chid;
                    document.getElementById('chrDesc5').value = chdesc;
                    if (chtype == '1'){
                        
                        document.getElementById('editcleanup5').checked = true;
                        //document.getElementById('editweekly5').checked = false;
                        
                    }else{
                        
                        document.getElementById('editweekly5').checked = true;
                        //document.getElementById('editcleanup5').checked = false;
                        
                    }
                    document.getElementById('form2').style.display = 'none';
                    document.getElementById('form3').style.display = 'none';
                    document.getElementById('form5').style.display = 'block';
                }
            }
            function show5(){
                alert('show5...');
                document.getElementById('addEditTitle').innerHTML = 'Add New Chore';
                document.getElementById('chrDesc5').value = '';
                document.getElementById('chrId5').value = '';
                document.getElementById('form1').style.display = 'none';
                document.getElementById('form2').style.display = 'none';
                document.getElementById('form5').style.display = 'block';
            } 
            function show6(){
                alert('show6...');
                document.getElementById('form1').style.display = 'none';
                document.getElementById('form2').style.display = 'none';
                document.getElementById('form6').style.display = 'block';
            } 
            function hide2(){
                alert('Canceling...hide2');
                document.getElementById('form2').style.display = 'none';
                document.getElementById('form1').style.display = 'none';
                document.getElementById('form2').style.display = 'none';
                document.getElementById('form1').style.display = 'block';
            } 
            function hide3(){
                alert('Canceling...hide3');
                document.getElementById('form2').style.display = 'none';
                document.getElementById('form3').style.display = 'none';
                document.getElementById('form5').style.display = 'none';
                document.getElementById('form1').style.display = 'block';
            } 
            function hide5(){
                alert('Canceling...hide5');
                document.getElementById('form2').style.display = 'none';
                document.getElementById('form3').style.display = 'none';
                document.getElementById('form5').style.display = 'none';
                document.getElementById('form1').style.display = 'block';
            }
            function hide6(){
                alert('Canceling...hide6');
                document.getElementById('form2').style.display = 'none';
                document.getElementById('form3').style.display = 'none';
                document.getElementById('form6').style.display = 'none';
                document.getElementById('form1').style.display = 'block';
            }
        </script>
    </head>
    
    <body>
        
        <h1>Lab Duties</h1>
        <form id="form1" action="Chore" method="post">
            <fieldset id="choice" name="choice">
                <input type="radio" value="weekly" name="choretp" ${(choreMode=="Weekly"||choreMode==null)?'checked="checked"':''}>
                <label for="weekly">Weekly</label><br>
                <input type="radio" value="cleanup" name="choretp" ${(choreMode=="Cleanup")?'checked="checked"':''}>
                <label for="cleanup">Lab Cleanup</label>
            </fieldset>
            <input type="submit" value="View Chore List">
            <input type="button" id="newChr1" value="New Chore">
            <input type="button" id="searchbtn1" value="Search">
            <input type="hidden" name="formname" value="form1">
        </form>
        <div id="form2wrap"> 
        <form id="form2" action="Chore" method="post">
            
            <h2 id="lists">${choreMode} Chores and People</h2>
            <div id="peoplediv">
            <table id="listtblhead">
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th></th>
                </tr>
            </table>
           
            <table id="listtblbdy">
                <c:forEach var="p" items="${people}">
                <tr>
                    <td>${p.fname}</td>
                    <td>${p.lname}</td>
                    <td><input name="${p.ppl_num}" type="checkbox" checked="checked"></td>
                </tr>
                </c:forEach>
            </table>
            </div>
            
            <div id="chorediv">
            <table id="chrLstHead">
                <tr>
                    <th>List of Chores</th>
                </tr>
            </table>
            <table id="chrLstBdy">
                <c:forEach var="ch" items="${chores}">
                    <tr data-id="${ch.taskID}" data-type="${ch.taskType}">
                        <td>${ch.taskDesc}</td>
                        <td>
                            <input type="button" class="edbtn" value="Edit">
                            <input type="button" class="delbtn" value="Delete">
                        </td>
                    </tr>
                </c:forEach>
            </table>
            </div>
            <br style="clear:both">
            <input type="submit" value="Assign Chores">
            <input type="button" id="cancel2" value="Cancel">
            <input type="button" id="newChr2" value="New Chore">
            <input type="button" id="searchbtn2" value="Search">
            <input type="hidden" name="formname" value="form2">
        </form>
        </div>
        <form id="form3" action="Chore" method="post">
            <h2 id="assnChr">Duty Assignments</h2>
            <div id="tblwrap">
                <table id="tblhead">
                    <!--
                    <tr>
                        <th>Person</th>
                        <th>Task</th>
                    </tr>
                    -->
                </table>
                <div id="wraptbdy">
                    <table id="tbdy">
                        <tr>
                        <th>Person</th>
                        <th>Task</th>
                        </tr>
                    
                        <c:forEach var="a" items="${assign}">
                            <tr>
                                <td>${a.fullName}</td>
                                <td>${a.taskDesc}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <input type="submit" name="assignbtn" value="Accept">
            <input type="submit" name="assignbtn" value="Re-Do">
            <input type="button" id="cancel3" value="Cancel">
            <input type="hidden" name="formname" value="form3">
        </form>
            
        <form id="form4" action="Chore" method="post">
            <input type="text" id="frm4choreid" name="choreid">
            <input type="hidden" name="formname" value="form4">
            <!-- this form is submitted by javascript to delete a chore -->
        </form>
        
        <div id="form5mask" class="mask">
            <form id="form5" action="Chore" method="post">
                <h2 id="addEditTitle">Add/Edit Chores</h2>
                <fieldset style="width:250px">
                    <input type="radio" id="editweekly5" value="weekly" name="chrType">
                    <label for="editweekly5">Weekly</label><br>
                    <input type="radio" id="editcleanup5"value="cleanup" name="chrType">
                    <label for="editcleanup5">Lab Cleanup</label>
                </fieldset>
                <label class="labels">Description of Chore:</label>
                <input type="text" id="chrDesc5" name="chrDesc" style="width:350px">
                
                <input type="hidden" id="chrId5" name="chrId" value="">
                <input type="submit" value="Submit Chore">
                <input type="button" id="cancel5" value="Cancel">
                <input type="hidden" name="formname" value="form5">
            </form>
        </div>
        <div id="form6wrap">
            <form id="form6" action="Chore" method="post">
                <h2 id="chrsrch">Find Chores</h2>
                <label class="labels">Enter Chore Description:<input type="text" id="chrDesc6" name="chrDesc"></label>
                <input type="submit" value="Find Chore">
                <input type="button" id="cancel6" value="Cancel">
                <input type="hidden" name="formname" value="form6">
            </form>
        </div>
        <h4 class="msgctr">${msg}</h4>
        <div class="nav">
            <a class="button"  href="page1.jsp">Home</a>
            <a class="button"  href="logon.jsp">Logon</a>
            <a class="button"  href="Plasmid">Plasmids</a>
            <a class="button"  href="Primer">Primers</a>
            <a class="button"  href="Sequence">Sequence</a>
            <a class="button"  href="Protocol">Protocols</a>
            <a class="button"  href="Chore">Chores</a>
            <a class="button"  href="People">IICI Database Users</a>
        </div>
    </body>
</html>
