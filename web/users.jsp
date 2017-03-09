<%-- 
    Document   : users
    Created on : Feb 3, 2017, 1:48:25 PM
    Author     : Miriam
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="iici_db.css" rel="stylesheet" type="text/css">
        <title>Users</title>
        <script>
            window.onerror=function(a,b,c){
                alert('javascript error:\n'+a+'\nPath:'+b+'\nLine: ' + c);
                return true;
            }
        </script>
        <script>
            'use strict';
            window.onload = init;
            function init() {
                document.getElementById('pplbody').onclick = frmbtnclk;
                document.getElementById('btnNewPpl').onclick = newBtnClk;
                document.getElementById('btnSrchPpl').onclick = srchBtnClk;
            }//End function init()
            function frmbtnclk(evt) {
                alert('Form Button Click..');
                if (evt.target.tagName == 'INPUT' && evt.target.className == 'edbtn'){
                    var btn = evt.target;
                    var tr = btn.parentNode.parentNode;
                    var tdlist = tr.getElementsByTagName('TD');
                    var td1 = tdlist[0].innerHTML;
                    var td2 = tdlist[1].innerHTML;
                    var td3 = tdlist[2].innerHTML;
                    var td4 = tdlist[3].innerHTML;
                    if (btn.value === 'Edit') {
                        document.getElementById('editpplttl').innerHTML = 'Edit User';
                        document.getElementById('pplmask').style.display = 'block';
                        document.getElementById('editppldiv').style.display = 'block';
                        document.getElementById('ppl_id').value = td1;
                        document.getElementById('fnm').value = td2;
                        document.getElementById('mi').value = td3;
                        document.getElementById('lnm').value = td4;
                        document.getElementById('btnPplCan').onclick = function() {
                            document.getElementById('pplmask').style.display = 'none';
                            document.getElementById('editppldiv').style.display = 'none';
                        };//End cancel function
                    } else if(btn.value==='Delete'){
                        var pplnum = evt.target.parentNode.parentNode.getElementsByTagName('TD')[0].innerHTML;
                        var r = window.confirm('You are about to permanently delete user number ' 
                                + pplnum + '\n Are you sure?');
                        if(r==true){
                        document.getElementById('ppl_id').value = pplnum;
                        document.getElementById('fnm').value = '';
                        document.getElementById('mi').value = '';
                        document.getElementById('lnm').value = '';
                        document.getElementById('hdnPplDel').value = 'DELETE';
                        //alert('submitting...');
                        document.getElementById('hdnpplfrm').submit();
                        }
                    }
                }
            }//End frmbtnclk
            function newBtnClk() {
                alert('New Button Clicked...');
                clearFields();
                document.getElementById('pplmask').style.display = 'block';
                document.getElementById('editppldiv').style.display = 'block';
                document.getElementById('editpplttl').innerHTML = 'Add New User';
                document.getElementById('ppl_id').disabled = 'true';
                document.getElementById('fnm').focus();
                document.getElementById('btnPplCan').onclick = function() {
                    document.getElementById('pplmask').style.display = 'none';
                    document.getElementById('editppldiv').style.display = 'none';
                };
            }
            function srchBtnClk() {
                alert('Searching...');
                clearFields();
                document.getElementById('hdnPplSearch').value = 'SEARCH';
                document.getElementById('editpplttl').innerHTML = 'Find User';
                document.getElementById('pplmask').style.display = 'block';
                document.getElementById('editppldiv').style.display = 'block';
                document.getElementById('btnPplCan').onclick = function() {
                    document.getElementById('pplmask').style.display = 'none';
                    document.getElementById('editppldiv').style.display = 'none';
                };
            }
            function clearFields() {
                document.getElementById('hdnPplDel').value = '';
                document.getElementById('hdnPplSearch').value = '';
                document.getElementById('ppl_id').value = '';
                document.getElementById('fnm').value = '';
                document.getElementById('mi').value = '';
                document.getElementById('lnm').value = '';
            }
        </script>
    </head>
    <body>
        <h1>IICI Database Users</h1>
        <div id="ppltblwrap" class="tblwrap">
            <table id="ppltblhd" class="tblhd">
                <tr>
                    <th>User ID</th>
                    <th>First Name</th>
                    <th>Middle Initial</th>
                    <th>Last Name</th>
                    <th></th>
                </tr>
            </table>
            <div id="pplbodywrap">
                <table id="pplbody">
                    <c:forEach var="prsn" items="${people}">
                        <tr>
                            <td>${prsn.ppl_num}</td>
                            <td>${prsn.fname}</td>
                            <td>${prsn.minit}</td>
                            <td>${prsn.lname}</td>
                            <td>
                                <input type="button" class="edbtn" value="Edit">
                                <input type="button" class="edbtn" value="Delete">
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <input type="button" value="New" id="btnNewPpl" name="btnNewPpl">
                <input type="button" value="Search" id="btnSrchPpl">
            </div>
        </div>
        <form id="hdnpplfrm" action="People" method="post">
            <div id="pplmask" class="mask">
                <div id="editppldiv">
                    <h2 id="editpplttl">Edit User</h2>
                    <table id="editppltbl">
                        <tr>
                            <td>User Number:</td>
                            <td>First Name:</td>
                            <td>Middle Initial:</td>
                            <td>Last Name:</td>
                        </tr>
                        <tr>
                            <td><input id="ppl_id" name="ppl_id" type="text" /></td>
                            <td><input id="fnm" name="fnm" type="text" /></td>
                            <td><input id="mi" name="mi" type="text" /></td>
                            <td><input id="lnm" name="lnm" type="text" /></td>
                        </tr>
                    </table>
                    <input type="submit" value="Submit" id="btnPplSub" name="btnPplSub">
                    <input type="button" value="Cancel" id="btnPplCan">
                    <input type="hidden" value="" id="hdnPplDel" name="hdnPplDel">
                    <input type="hidden" value="" id="hdnPplSearch" name="hdnPplSearch">
                </div>
            </div>
        </form>
        
        <h4 class="msgctr" id="btnmsg">${msg} ${btnmsg}</h4><br>
        <p class="msgctr">${cntmsg}</p>
        
        <div id="nav">
            <a class="button"  href="page1.jsp">Home</a>
            <a class="button"  href="logon.jsp">Logon</a>
            <a class="button"  href="Plasmid">Plasmids</a>
            <a class="button"  href="Primer">Primers</a>
            <a class="button"  href="Sequence">Sequence</a>
            <a class="button"  href="Protocol">Protocols</a>
            <a class="button"  href="Chores">Chores</a>
            <a class="button"  href="People">IICI Database Users</a>
        </div>
    </body>
</html>
