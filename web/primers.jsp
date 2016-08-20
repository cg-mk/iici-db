<%-- 
    Document   : primers
    Created on : Jan 5, 2016, 5:29:05 PM
    Author     : Miriam
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Primers</title>
        <style>
            /*[type=button],[type=submit]{
                height: 75px;
                width: 150px;
                margin:1em 5em 1em;
                display:table-column;
                background-color: #99de66;
                font-weight: bold;
                color: #006600;
            
            }*/
            *{
                margin:0;
                padding:0;
            }
            body{
                background-color:#d2b48c;
            }
            h1{
                text-align:center;
                margin:5px;
            }
            #wraptable{
                background-color: #ffffcc;
                /*position: fixed;*/
                width: 95%;
                padding: 0;
                margin: 0 auto;
            }
            #thead{
                width: 100%;
                border-collapse: collapse;
                border: 2px solid #555;
                border-bottom: none;
                /*float: left;*/
            }
            tr:nth-child(odd) {background: #ffffcc}
            tr:nth-child(even) {background: #ccff66}
            
            th{
                /*border-left: 2px solid #555;*/
            }
            th:nth-child(1){
                width: 5%;
                min-width:100px;
            }
            th:nth-child(2){
                width: 20%;
            }
            th:nth-child(3){
                /*width: 55%;*/
            }
            th:nth-child(4){
                width: 120px;
            }
            #wraptbody{
                height: 200px;
                overflow-y: auto;
                border: 1px solid #000;
            }
            #tbody{
                width: 100%;
                border-collapse: collapse;
                border-bottom: 1px solid #555;
            }
            td{
                border: 1px solid #bbb;
                border-top: none;
                border-bottom: none;
            }
            td:first-child{
                width: 5%;
                min-width:100px;
                border-right: none;
                text-align: center;
            }
            td:nth-child(2){
                width: 20%;
            }
            #tbody td:nth-child(3){
                /*width: 55%;*/
            }
            #tbody td:nth-child(4){
                width: 120px;
                /*border-right: none;*/
            }
            #tbody td{
                padding: 0 5px 0 5px;
            }
            /*#editbtn, #delbtn{
                height: 25px;
                width: 50px;
                background-color: #999966;
                border-radius: 5px;
            }*/
            #editprdiv{
                display:none;
                z-index:1;
                position:fixed;
                top:100px;
                left:10px;
                right:10px;
                border:1px solid #fff;
                border-radius: 10px;
                /*height: 110px;*/
                margin: 0 auto;
                /*overflow: hidden;*/
            }
            #prmask{
                display:none;
                z-index:0;
                position:fixed;
                top:10px;
                left:2px;
                right:2px;
                height:400px;
                opacity:0.96;
                background-color:#020;
                border-radius:10px;
            }
            #prtitle{
                color:#fff;
                text-align:center;
                background-color:#797;
                border-radius:10px 10px 0 0;
            }
            #prid,#seq,#prdesc{
                background-color:#FAFAD2;
                width: 99%;
                padding: 0 2px 0 2px;
            }
            #prid{text-align: center;}
            #btnSubmit{height: 30px; background-color: oldlace; margin: 0 10px 0 70%; float: right;}
            #btnCancel{height: 30px; background-color: oldlace; margin: 0 0 0 0; float: right;}
            #predit{width:100%;}
            #predit td:first-child{
                width: 5%;
                min-width:100px;
            }
            #predit td:nth-child(2){
                width: 20%;
                min-width: 100px;
            }
            #predit td:nth-child(3){
                width: 75%;
                min-width: 100px;
            }
            #btnSrch{margin-top: 10px; margin-right: 10px; margin-bottom: 2px; float: right;}
            #btnNew{margin-top: 10px; float: right;}
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
            #btnmsg{
                border:1px solid #555;
                position:fixed;
                bottom:0;
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
            window.onload=init;
            function init() {
                document.getElementById('tbody').onclick = frmbtnclk;
                document.getElementById('hiddenform').onsubmit = validate;
                document.getElementById('btnSrch').onclick = searchBtnClk;
                document.getElementById('btnNew').onclick = newBtnClk;
            }//end function init

            function frmbtnclk(evt) {
                if (evt.target.tagName == 'INPUT' && evt.target.className == 'edbtn'){
                    var btn = evt.target;
                    var tr = btn.parentNode.parentNode;
                    var tdlist = tr.getElementsByTagName('TD');
                    var td1 = tdlist[0].innerHTML;
                    var td2 = tdlist[1].innerHTML;
                    var td3 = tdlist[2].innerHTML;
                    //alert('btn clicked: '+btn.value+'\ncol1: '+td1+'\ncol2: '+td2+'\ncol3: '+td3);
                    if(btn.value=='Edit'){
                        document.getElementById('prtitle').innerHTML = 'Edit Primer';
                        document.getElementById('editprdiv').style.display = 'block';
                        document.getElementById('prmask').style.display = 'block';
                        document.getElementById('prid').value = td1;
                        document.getElementById('seq').value = td2;
                        document.getElementById('prdesc').value = td3;
                        document.getElementById('btnSubmit').onclick = function(){
                            //alert('submit');
                        }
                        document.getElementById('btnCancel').onclick = function(){
                            //alert('cancel');
                            document.getElementById('editprdiv').style.display = 'none';
                            document.getElementById('prmask').style.display = 'none';
                        }
                    }else if(btn.value=='Delete'){
                        var prnum = evt.target.parentNode.parentNode.getElementsByTagName('TD')[0].innerHTML;
                        var r = window.confirm('You are about to permanently delete primer number ' 
                                + prnum+ '\n Are you sure?');
                        if(r==true){
                        document.getElementById('prid').value = prnum;
                        document.getElementById('seq').value = '';
                        document.getElementById('prdesc').value = '';
                        document.getElementById('hdnDel').value = 'DELETE';
                        //alert('submitting...');
                        document.getElementById('hiddenform').submit();
                        }
                    }
                }
            }//end frmbtnclk
            function validate(evt){
                //alert('validate function');
                var fail = false;
                if (document.getElementById('hdnSearch').value == "") {// if this is not a search...
                var prid = document.getElementById('prid').value.trim();
                if(prid.length > 0) {
                    var pridi=parseInt(prid);
                    if(isNaN(pridi)) {
                        alert('Error: primer id must be an integer');
                        fail = true;
                        document.getElementById('prid').focus();
                    }
                    if(pridi <= 0) {
                        alert('Error: primer id must be greater than zero');
                        fail = true;
                        document.getElementById('prid').focus();
                    }
                }
                var seq = document.getElementById('seq').value;
                if(seq == null) {
                    alert('Error: seq missing');
                    fail = true;
                    document.getElementById('seq').focus();
                }else if(seq.trim().length == 0){
                    alert('Error: seq missing');
                    fail = true;
                    document.getElementById('seq').focus();
                }else{
                    seq = seq.trim().toUpperCase();
                    document.getElementById('seq').value = seq;
                }
                
                var pat = /[^acgtu]/gi;
                if(seq.match(pat)) {
                    alert('Error: seq pattern failure');
                    fail = true;
                    document.getElementById('seq').focus();
                }
                
                var prdesc = document.getElementById('prdesc').value.trim();
                if(prdesc.length == 0) {
                    alert('Error: missing description');
                    fail = true;
                    document.getElementById('prdesc').focus();
                }
            }
                //var prdesc = document.getElementById('prdesc').value.trim();
                
                //alert('prid = ' + prid + '\n' + 'seq = ' + seq + '\n' + 'prdesc = ' + prdesc);
                
                if(fail == true) {
                    evt.preventDefault();
                    //alert('submit was aborted');
                }else{
                    //alert('submitting form...');
                }
            }//end function validate               
        
            function newBtnClk() { // new button click event
                //alert('newBtnClk');
                clearFields();
                document.getElementById('hdnDel').value = ''; // clear hidden field
                document.getElementById('hdnSearch').value = ''; // clear hidden field
                document.getElementById('editprdiv').style.display = 'block';
                document.getElementById('prtitle').innerHTML = 'New Primer';
                document.getElementById('prmask').style.display = 'block';
                document.getElementById('prid').disabled='true';
                document.getElementById('seq').focus();
                //document.getElementById('prdesc').value = td3;
                document.getElementById('btnCancel').onclick = function(){
                    //alert('cancel');
                    document.getElementById('editprdiv').style.display = 'none';
                    document.getElementById('prmask').style.display = 'none';
                }
            }
             function searchBtnClk() { // new button click event
                clearFields();
                document.getElementById('hdnDel').value = ''; // clear hidden field
                document.getElementById('hdnSearch').value = 'SEARCH'; // set hidden field
                document.getElementById('prtitle').innerHTML = 'Search';//set title
                document.getElementById('editprdiv').style.display = 'block';
                document.getElementById('prmask').style.display = 'block';
                document.getElementById('prid').focus();
                //document.getElementById('prdesc').value = td3;
                document.getElementById('btnCancel').onclick = function(){
                    //alert('cancel');
                    document.getElementById('editprdiv').style.display = 'none';
                    document.getElementById('prmask').style.display = 'none';
                }
            }
            function clearFields() {
                document.getElementById('hdnDel').value = '';
                document.getElementById('hdnSearch').value = '';
                document.getElementById('prid').value = '';
                document.getElementById('seq').value = '';
                document.getElementById('prdesc').value = '';
            }
        </script>
    </head>
    
    <body>
        
        <h1>Primers</h1>
        
        <div id="wraptable">
            <table id="thead">
                <tr>
                    <th>Primer Name</th>
                    <th>Sequence</th>
                    <th>Description</th>
                    <th></th>
                </tr>
            </table>
            
            <div id="wraptbody">
                <table id="tbody">
                    <c:forEach var="p" items="${primers}">
                    <tr>
                        <td>${p.primerID}</td>
                        <td>${p.sequence}</td>
                        <td>${p.prDesc}</td>
                        <td>
                            <input type="button" class="edbtn" value="Edit">
                            <input type="button" class="edbtn" value="Delete">
                        </td>
                    </tr>
                    </c:forEach>
                </table>
            </div>
            <a class="button"  href="page1.jsp">Return to Main Menu</a>
            <input type="button" value="New" id="btnNew" name="btnNew">
            <input type="button" value="Search" id="btnSrch">
        </div>
        
        <form id="hiddenform" method="post" action="Primer">
            <div id="prmask">
                <div id="editprdiv">
                    <h2 id="prtitle">Edit Primer</h2>
                    <table id="predit">
                        <tr>
                            <td>Primer Number:</td>
                            <td>Sequence:</td>
                            <td>Description:</td>
                        </tr>
                        <tr>
                            <td><input id="prid" name="prid" type="text" /></td>
                            <td><input id="seq" name="seq" type="text" /></td>
                            <td><input id="prdesc" name="prdesc" type="text" /></td>
                        </tr>
                    </table>
                    <input type="submit" value="Submit" id="btnSubmit" name="btnSubmit">
                    <input type="button" value="Cancel" id="btnCancel">
                    <input type="hidden" value="" id="hdnDel" name="hdnDel">
                    <input type="hidden" value="" id="hdnSearch" name="hdnSearch">
                </div>
            </div>
            
        </form>
            <h4 id="btnmsg">${msg} ${btnmsg}</h4>
            <p style="text-align: center"> ${cntmsg} </p>
    </body>
</html>
