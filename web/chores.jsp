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
            form{ border:1px solid red;}
            table{ border:1px solid green;}
            
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
                document.getElementById('form4').style.display = 'none'; //
                document.getElementById("form5").style.display = 'none'; //
                document.getElementById("form6").style.display = 'none'; //
               
                //document.getElementById('chrtblmask').style.display = 'none';
                //document.getElementById('editChrMask').style.display = 'none';
                
                if (display==''){
                    
                }else{
                    if (display.indexOf("1") != -1){
                        document.getElementById("form1").style.display = 'block';
                    }
                    if (display.indexOf("2") != -1){
                        document.getElementById('form2').style.display = 'block';
                    }
                    if (display.indexOf("3") != -1){
                        document.getElementById('form3').style.display = 'block';
                    }
                    if (display.indexOf("4") != -1){
                        document.getElementById('form4').style.display = 'block';
                    }
                    if (display.indexOf("5") != -1){
                        document.getElementById('form5').style.display = 'block';
                    }
                    if (display.indexOf("6") != -1){
                        document.getElementById('form6').style.display = 'block';
                    }
                    
                }
                //document.getElementById('viewChr').onclick = frmbtnclk;
                //document.getElementById('addChr').onclick = frmbtnclk;
                //document.getElementById('btnfrm').onsubmit = unhide1;
            };
            
            function frmbtnclk(evt) {
                if (evt.target.tagName === 'INPUT' && evt.target.className === 'viewChr') {
                    alert('Getting Chore List...');
                    document.getElementById('form1').style.display = 'block';
                    document.getElementById('form2').style.display = 'block';
                    document.getElementById('form3').style.display = 'none';
                    document.getElementById('form4').style.display = 'none';
                    document.getElementById('form5').style.display = 'none';
                    document.getElementById('form6').style.display = 'none';
                    /*if(document.getElementById('weekly').checked) {
                        document.getElementsByName('chores') = 'WEEKLY';
                    } else if(document.getElementById('cleanup').checked) {
                        document.getElementById('choice').value = 'CLEANUP';
                    }*/
                    //document.getElementById('btnfrm').submit();
                    /*document.getElementById('btnCnclChr').onclick = function() {
                        document.getElementById('chrtblmask').style.display = 'none';
                        document.getElementById('hdnChrList').style.display = 'none';
                    };*/
                } else if (evt.target.tagName === 'INPUT' && evt.target.className === 'assn') {
                    alert('Assigning Chores...');
                    document.getElementById('form').style.display = 'block';
                } else if (evt.target.tagName === 'INPUT' && evt.target.className === 'addChr') {
                    alert('Add/Edit Chores');
                    document.getElementById('form').style.display = 'block';
                    //document.getElementById('').style.display = 'block';
                    
                    document.getElementById('btnEditChrCncl').onclick = function() {
                        alert('Canceling...');
                        document.getElementById('form').style.display = 'none';
                    };
                }
            };
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
            <input type="submit" id="viewChr" class="viewChr" name="viewChr" value="View Chore List">
            <input type="hidden" name="formname" value="form1">
        </form>
        <div id="form2wrap"> 
        <form id="form2" action="Chore" method="post">
            <h2 id="lists">${choreMode} Chores and People</h2>
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
            <table id="chrLstHead">
                <tr>
                    <th>List of Chores</th>
                </tr>
            </table>
            <table id="chrLstBdy">
                <c:forEach var="ch" items="${chores}">
                    <tr>
                        <td>${ch.taskDesc}</td>
                        <td>
                            <input type="button" class="edbtn" value="Edit">
                            <input type="button" class="edbtn" value="Delete">
                        </td>
                    </tr>
                </c:forEach>
                    
            </table>
            <input type="submit" class="assn" id="assnsub" value="Assign Chores">
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
            <input name="assignbtn" type="submit" class="assn" value="Accept">
            <input name="assignbtn" type="submit" class="assn" value="Re-Do">
            <input name="assignbtn" type="submit" class="assn" value="Cancel">
            <input type="hidden" name="formname" value="form3">
        </form>
        <form id="form4" action="Chore" method="post">
            <div id="chrtblmask" class="mask">
            <div id="chrhdwrap" class="tblwrap">
                <table id="chrhead" class="chrhd">
                    <tr>
                        <th>Chore</th>
                        <th></th>
                    </tr>
                </table>
                <div id="chrtblbdy" class="chrtblbody">
                    <table id="choretbl" class="chrtbl">
                        <c:forEach var="c" items="${chores}">
                            <tr>
                                <td>${c.taskDesc}</td>
                                <td>
                                    <input type="button" class="edbtn" value="Edit">
                                    <input type="button" class="edbtn" value="Delete">
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
       
            </div>
             <p>this form lacks a submit button?</p>
            <input type="hidden" name="formname" value="form4">
        </form>
        <div id="form5mask" class="mask">
            <form id="form5" action="Chore" method="post">
                <h2 id="chrEdit">Add/Edit Chores</h2>
                <fieldset id="editChrSet" name="choice">
                    <input type="radio" id="editweekly" name="chores">
                    <label for="weekly">Weekly</label><br>
                    <input type="radio" id="editcleanup" name="chores">
                    <label for="cleanup">Lab Cleanup</label>
                </fieldset>
                <label class="labels">Description of Chore:<input type="text" id="chrDesc" name="chrDesc"></label>
                <input type="button" id="addChr" class="addChr" value="Add/Edit Chore">
                <p>this form lacks a submit button?</p>
                <input type="hidden" name="formname" value="form5">
            </form>
        </div>
        <div id="form6wrap">
            <form id="form6" action="Chore" method="post">
                <h2 id="chrsrch">Find Chores</h2>
                <label class="labels">Enter Chore Description:<input type="text" id="chrDesc" name="chrDesc"></label>
                <input type="button" id="srchchrbtn" name="srchchrbtn" value="Find Chore">
                <input type="button" id="btnsrchcncl" value="Cancel">
                <p>this form lacks a submit button?</p>
                <input type="hidden" name="formname" value="form6">
            </form>
        </div>
        <h4 class="msgctr">Msg:${msg}</h4>
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
