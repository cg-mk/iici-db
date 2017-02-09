<%-- 
    Document   : protocol
    Created on : Oct 14, 2016, 4:22:57 PM
    Author     : Miriam
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Protocol</title>
        <!--link href="iici_db_.css" rel="stylesheet" type="text/css"-->
    <style>
    body{
        background-color: #d2b48c;
    }
    h1{
        text-align: center;
    }
    #prottblhead {width:100%;
        border-collapse: collapse;
        border: 2px solid #555;
        border-bottom: none;
    }
    #prottblhead tr th:first-child{
        width: 60%;
        min-width:200px;
        border-right: none;
    }
    #prottblhead tr th:nth-child(2){
        width: 20%;
        min-width: 100px;
    }
    #prottbody td:first-child{
        width: 60%;
        min-width:200px;
        border-right: none;
    }
    #prottbody td:nth-child(2){
        width: 20%;
        min-width: 100px;
    }
    #wrapprottbody{
    height: 200px;
    overflow-y: auto;
    border: 1px solid #000;
    }
    #prottbody{
        width: 100%;
        border-collapse: collapse;
        border-bottom: 1px solid #555;
    }
    tr:nth-child(odd) {background: #ffffcc}
    tr:nth-child(even) {background: #ccff66}
    #prottbody td:nth-child(3){
    width: 120px;
    }
    #prottbody td{
        padding: 0 5px 0 5px;
    }
    #protmask, #searchprotmask {
    display:none;
    z-index:0;
    position:fixed;
    top:10px;
    left:2px;
    right:2px;
    height:480px;
    opacity:0.95;
    background-color:#020;
    border-radius:10px;
    overflow: auto;
    }
    #prottxt{
    margin-left: 20px;
    }
    #getProtDiv, #searchprotdiv {
        color:#fff;
        margin:5px 15px;
        overflow: auto;
    }
    #prottitle, #prottitle2 {
        text-align: center;
    }
    
    #btnNew, #btnSearch, #protbtnCancel {
        margin-top: 5px;
    }
    #btnSrch {margin-top: 10px; margin-right: 10px; float: right;}
    #btnNew {margin-top: 10px; float: right;}
    .clrfix{clear:both;}
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
    .hid{display: none;}
    a#hdnFile:link{color:#fff;}
    a#hdnFile:visited{color:#fff;}
    a#hdnFile:hover{color:#ccc;}
    a#hdnFile:active{color:#fff;}
    #btnCancel2 {margin-top: 5px;}
    </style>
    <script>
        window.onerror = function(a,b,c){
            alert('javascript error:\n'+a+'\nPath:'+b+'\nLine: ' + c);
            return true;
        }
    </script>
    <script>
        'use strict';
        var filetext = [];
        var filename = [];
                <c:forEach var="p" items="${prot}">
                    filetext[${p.protID}] = '${p.protData}';
                    filename[${p.protID}] = '${p.protName}';
                </c:forEach>
        window.onload = init;
        function init() {
                document.getElementById('prottbody').onclick = frmbtnclk;
                document.getElementById('btnSrch').onclick = searchBtnClk;
                document.getElementById('btnNew').onclick = newBtnClk;
                document.getElementById('txtprot').onsubmit = validatet;
                document.getElementById('fileprot').onsubmit = validatef;
            }
            function frmbtnclk(evt) {
                if (evt.target.tagName == 'INPUT' && evt.target.className == 'edbtn'){
                    var btn = evt.target;
                    var tr = btn.parentNode.parentNode;
                    var tdlist = tr.getElementsByTagName('TD');
                    var td1 = tdlist[0].innerHTML; // protocol_name
                    var td2 = null;
                    var tr = tdlist[0].parentNode;
                    var protid = tr.getAttribute('data-protid');
                    var protnm = tr.getAttribute('data-protnm');
                    //var protfile = tr.getAttribute('data-file');
                    //var protdata = tr.getAttribute('data-data');
                    alert('td1='+td1+'\ntd2='+td2);
                    alert('protid=['+protid+']\nprotnm=['+protnm+']');
                   // alert('fileprot=['+fileprot+']\nprotdata_len='+protdata.length);
                }
                if(btn.value=='Edit'){
                    alert('Edit Button Clicked');
                    document.getElementById('getProtDiv').style.display = 'block';
                    document.getElementById('protmask').style.display = 'block';
                    document.getElementById('prottitle').innerHTML = 'Edit Protocol';
                    document.getElementById('hdnProtId').value = protid;
                    document.getElementById('hdnActiont').value = 'UPDATE';
                    document.getElementById('fileprot').style.display = 'none';
                    document.getElementById('searchprotdiv').style.display = 'none';
                                        
                    if (filetext[protid] === null || filetext[protid] === '')  {
                        document.getElementById('prot').style.display = 'none';
                        document.getElementById('fileprot').style.display = 'none';
                        document.getElementById('editp').style.display = 'block';
                        var a = document.getElementById('hdnFile');
                        a.setAttribute('href', './flintstones/'+filename[protid]);
                        document.getElementById('hdnFile').style.display = 'block';
                        document.getElementById('hdnFile').onclick = function() {
                            alert('Aha!!');
                            document.getElementById('fileprot').style.display = 'block';
                        };
                        
                    } else {
                        document.getElementById('protName').value = filename[protid];
                        document.getElementById('txtprot').value = filetext[protid];
                        document.getElementById('editp').style.display = 'none';
                       //document.getElementById('hdnFile').style.display = 'none';
                    }
                    
                    document.getElementById('protbtnCancel').onclick = function(){
                        alert('cancel');
                        document.getElementById('getProtDiv').style.display = 'none';
                        document.getElementById('protmask').style.display = 'none';
                    };
                    
                }else if(btn.value=='Delete'){
                    document.getElementById('prottitle').innerHTML = 'Delete Protocol';
                    var protnum = evt.target.parentNode.parentNode.getElementsByTagName('TD')[0].innerHTML;
                    var r = window.confirm('You are about to permanently delete protocol ' 
                            + protnm + '\n Are you sure?');
                    if(r==true){
                    document.getElementById('hdnProtId').value = protid;
                    document.getElementById('protName').value = protnm;
                    document.getElementById('txtprot').value = '';
                    document.getElementById('hdnActiont').value = 'DELETE'; // hidden field
                    //document.getElementById('hdnActionf').value = 'DELETE'; // hidden field
                    alert('submitting...');
                    document.getElementById('prot').submit();
                    //document.getElementById('fileprot').submit();
                    }
                    }
                }//End frmbtnclk
                
                function newBtnClk() { // new button click event
                //alert('New Button Clicked');
                clearFields();
                document.getElementById('prottitle').innerHTML = 'Add a New Protocol';
                document.getElementById('fileprot').style.display = 'block'; // file form
                document.getElementById('txtprot').style.display = 'block'; // text form
                //document.getElementById('hdnFile').style.display = 'none';
                document.getElementById('hdnActiont').value = 'INSERT'; // clear hidden field
                document.getElementById('hdnActionf').value = 'INSERT'; // clear hidden field
                document.getElementById('getProtDiv').style.display = 'block';
                document.getElementById('prottitle').innerHTML = 'Add a Protocol';
                document.getElementById('protmask').style.display = 'block';
                document.getElementById('protName').value = '';
                document.getElementById('txtprot').value = '';
                document.getElementById('protName').focus();
                document.getElementById('searchprotdiv').style.display = 'none';
                document.getElementById('editp').style.display = 'none';
                document.getElementById('hdnFile').style.display = 'none';
                document.getElementById('protbtnCancel').onclick = function(){
                    alert('cancel');
                    document.getElementById('getProtDiv').style.display = 'none';
                    document.getElementById('protmask').style.display = 'none';
                };
            }//end newBtnClk
            
            function searchBtnClk() {
                //alert('Searching... now...');
                document.getElementById('prottitle2').innerHTML = 'Find Protocol';
                document.getElementById('searchprotmask').style.display = 'block';
                document.getElementById('searchprotdiv').style.display = 'block';
                document.getElementById('protdesc').focus();
                document.getElementById('hdnFile').style.display = 'none';
                var ha2 = document.getElementById('hdnAction2');
                ha2.value = 'SEARCH';
                //alert('ha2='+ ha2.value);
                document.getElementById('btnCancel2').onclick = function(){
                    alert('cancel');
                    document.getElementById('searchprotmask').style.display = 'none';
                    document.getElementById('searchprotdiv').style.display = 'none';
                };
                document.getElementById('sprotbtn').onclick = function() {
                    var stitle = document.getElementById('protdesc').value;
                    if(stitle.length === 0) {
                        alert('Missing search title. Please enter a title:');
                        document.getElementById('protdesc').focus();
                    } else {
                        alert('submitting...');            
                        document.getElementById('hdnprot').submit();
                    }
                };
                //alert('That\'s all folks!!!');
            }//end srchBtnClk
                
            function clearFields() {
            document.getElementById('txtprot').value = '';
            document.getElementById('protdesc').value = '';
            }
             function validatet(evt){
                var err = '';
                alert('validate function');
                var len1 = document.getElementById('protName').value.trim().length;
                var len2 = document.getElementById('txtprot').value.trim().length;
                if (len1<1){
                    err += 'Protocol Name is missing.\n';
                }
                if (len2<1){
                    err += 'Protocol is missing.';
                }
                if (err.length>0){
                    evt.preventDefault();
                    alert(err);
                }
            }//End validatet
            
            function validatef(evt){
                alert('validate function');
                var len1 = document.getElementById('uploadfile').value.trim().length;
                 if (len1<1){
                    evt.preventDefault();
                    alert('Protocol File is missing.\n');
                }
            }
    </script>
    </head>
    <body>
    <h1>Protocols</h1>
        
    <div id="tblwrap">
        <table id="prottblhead">
            <tr>
                <th>Protocol</th>
                <th></th>
            </tr>
        </table>

        <div id="wrapprottbody" class="tbdy">
            <table id="prottbody" class="prottbody">
                <c:forEach var="p" items="${prot}">
                    <tr data-protid="${p.protID}" data-protnm="${p.protName}">
                        <td><a>${p.protName}</a></td>
                        <td>
                            <input type="button" class="edbtn" value="Edit">
                            <input type="button" class="edbtn" value="Delete">
                        </td>
                    </tr>
                </c:forEach>
        </table>
    </div>
        <!--a class="button"  href="page1.jsp">Return to Main Menu</a -->
        <input type="button" value="New" id="btnNew" name="btnNew">
        <input type="button" value="Search" id="btnSrch">
        <br class="clrfix">
    </div>
    
    <div id="protmask" class="mask">
        <div id="getProtDiv">
            <h2 id="prottitle">Title</h2>
            <form id="prot" action="Protocol" method="post">
                Name of Protocol:
                <input type="text" id="protName" name="protName">
                <p>Cut and paste Protocol here:</p>
                
                <textarea id="txtprot" name="txtprot" rows="10" maxlength="40000" cols="60" wrap="soft"></textarea>
                <input type="submit" value="Submit" name="btnSubmit">
                <input type="hidden" id="hdnActiont" name="hdnAction" value="">
                <input type="hidden" id="hdnProtId" name="hdnProtId" value="">
            </form>
            <br><br>
            <p id="editp">The current protocol is a file and must be downloaded and edited externally.</p>
            <a href="a" id="hdnFile">Download Current File</a>
            
            <form id="fileprot" action="ProtocolUpload" method="post" enctype="multipart/form-data">
                <p>Or Select Protocol File To Upload... 
                <input type="file" id="uploadfile" name="uploadfile" accept=".txt, .pdf, .doc, .docx" size="50"/>
                </p>
                <!--input type="button" value="Cancel" id="btnCancel"-->
                <input type="submit" value="Upload File" name="btnSubmit">
                <input type="hidden" id="hdnActionf" name="hdnAction" value="">
            </form>
        <br><input type="button" value="Cancel" id="protbtnCancel">
        </div>
    </div>
    <form id="hdnprot" action="Protocol" method="post">
        <div id="searchprotmask" class="searchMask">
            <div id="searchprotdiv" class="searchDiv">
                <h2 id="prottitle2">Search</h2>
                <input type="text" id="protdesc" name="protdesc" placeholder="Title...">
                <input type="button" id="sprotbtn" value="Search Protocols">
                <br><input type="button" value="Cancel" id="btnCancel2" style="margin-left:20px">
                <input type="hidden" value="SEARCH" id="hdnAction2" name="hdnAction">
            </div>
        </div>
    </form>
    <%--
    <p>${msg}</p>
    --%>
    <div id="nav">
            <a class="button"  href="page1.jsp">Home</a>
            <a class="button"  href="logon.jsp">Logon</a>
            <a class="button"  href="Plasmid">Plasmids</a>
            <a class="button"  href="Primer">Primers</a>
            <a class="button"  href="Sequence">Sequence</a>
            <a class="button"  href="Protocol">Protocols</a>
            <a class="button"  href="Chore">Chores</a>
            <a class="button"  href="People">IICI Database Users</a>
        </div>
    <h4 class="msgctr" id="btnmsg">${msg} ${btnmsg}</h4><br>
    <p class="msgctr" style="text-align: center"> ${cntmsg} </p>
    <!--a class="button"  href="page1.jsp">Return to Main Menu</a-->
    </body>
</html>
