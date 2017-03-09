<%-- 
    Document   : sequence
    Created on : Aug 31, 2016, 7:47:09 PM
    Author     : Miriam
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sequence</title>
    <!-- <link href="iici_db.css" rel="stylesheet" type="text/css"> -->
    <style>
    body{
        background-color: #d2b48c;
    }
    h1{
        text-align: center;
    }
    #cntmsg { text-align: center;}
    #tblhead {
        width:100%;
        border-collapse: collapse;
        border: 2px solid #555;
        border-bottom: none;
    }
    #tblhead tr th:first-child{
        width: 60%;
        min-width:200px;
        border-right: none;
    }
    #tblhead tr th:nth-child(2){
        width: 20%;
        text-align: left;
        min-width: 100px;
    }
    #tblhead tr th:nth-child(3){
        width: 20%;
        min-width: 100px;
    }
    td:first-child{
        width: 60%;
        min-width:200px;
        border-right: none;
    }
    td:nth-child(2){
        width: 20%;
        min-width: 100px;
    }
    td:nth-child(3){
        width: 20%;
        min-width: 100px;
    }
    #seqwraptbody {
    height: 220px;
    overflow-y: auto;
    border: 1px solid #000;
    }
    #seqtblwrap {
        overflow: auto;
    }
    #seqtbody{
        width: 100%;
        border-collapse: collapse;
        border-bottom: 1px solid #555;
    }
    tr:nth-child(odd) {background: #ffffcc}
    tr:nth-child(even) {background: #ccff66}
    #tbody td:nth-child(3){
    width: 120px;
    /*border-right: none;*/
    }
    #tbody td{
        padding: 0 5px 0 5px;
    }
    #seqmask {
    display:none;
    z-index:0;
    position:fixed;
    top:10px;
    left:2px;
    right:2px;
    height:490px;
    opacity:0.98;
    background-color:#020;
    border-radius:10px;
    }
    #txtseq{
    margin-left: 20px;
    }
    #getSeqDiv{
        color:#fff;
        margin:5px 15px;
    }
    #seqtitle {
        text-align: center;
    }
    #btnSrch {margin-top: 10px; margin-right: 10px; float: right;}
    #btnNew {margin-top: 10px; float: right;}
    .clrfix{clear:both;}
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
.searchDiv, .searchMask {
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
}
a#hdnFile:link{color:#fff;}
a#hdnFile:visited{color:#fff;}
a#hdnFile:hover{color:#ccc;}
a#hdnFile:active{color:#fff;}
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
                <c:forEach var="s" items="${seq}">
                    filetext[${s.seqID}] = '${s.safeSeqData}';
                    filename[${s.seqID}] = '${s.seqName}';
                </c:forEach>
        
            window.onload = init;
            function init() {
                document.getElementById('seqtbody').onclick = frmbtnclk;
                document.getElementById('btnSrch').onclick = searchBtnClk;
                document.getElementById('btnNew').onclick = newBtnClk;
                document.getElementById('seq').onsubmit = validatet;
                document.getElementById('fileseq').onsubmit = validatef;
                document.getElementById('seqsrchmask').style.display = 'none';
                document.getElementById('seqsrchdiv').style.display = 'none';
            }
            
            function frmbtnclk(evt) {
                if (evt.target.tagName == 'INPUT' && evt.target.className == 'edbtn'){
                    var btn = evt.target;
                    var tr = btn.parentNode.parentNode;
                    var tdlist = tr.getElementsByTagName('TD');
                    var td1 = tdlist[0].innerHTML; // gene_name
                    var td2 = tdlist[1].innerHTML; // seq_date
                    var td3 = null;
                    var tr = tdlist[0].parentNode;
                    var seqid = tr.getAttribute('data-seqid');
                    var seqfile = tr.getAttribute('data-file');
                    var seqdata = tr.getAttribute('data-data');
                    alert('td1='+td1+'\ntd2='+td2+'\ntd3='+td3);
                    alert('seqid='+seqid+'\nseqfile=['+seqfile+']\nseqdata_len='+seqdata.length);
                    
                    if(btn.value=='Edit'){
                        document.getElementById('seqtitle').innerHTML = 'Edit Sequence';
                        document.getElementById('getSeqDiv').style.display = 'block';
                        document.getElementById('seqmask').style.display = 'block';
                        document.getElementById('hdnActiont').value = 'UPDATE'; // hidden field
                        document.getElementById('hdnActionf').value = 'UPDATE'; // hidden field
                
                        if ((seqdata == null || seqdata.length == 0) && (seqfile != null && seqfile.length > 0)){
                            alert('Sequence is currently stored as a file.'+
                                   '\nTo edit you must download the file'+
                                   '\nand then edit the file'+
                                   '\nand then upload the edited file.');
                            document.getElementById('hdnSeqId').value = seqid;
                            document.getElementById('hdnFile').setAttribute('href','./jetsons/' + filename[seqid]);
                            document.getElementById('hdnFile').style.display = 'inline'; // download link
                            document.getElementById('fileseq').style.display = 'block'; // file form
                            document.getElementById('txtseq').style.display = 'none'; // text form
                            document.getElementById('txtseq').value = '';
                        }else if (seqfile == null || seqfile.length == 0){
                            document.getElementById('seqName').value = td1;
                            document.getElementById('hdnSeqDate').value = td2;
                            document.getElementById('txtseq').value = seqdata;
                            document.getElementById('hdnSeqId').value = seqid;
                            document.getElementById('hdnFile').style.display = 'none'; // download link
                            document.getElementById('fileseq').style.display = 'block'; // file form
                            document.getElementById('txtseq').style.display = 'block'; // text form
                        }else{
                            alert('Error: unexpected database error. Both File and textData exist.')
                            
                        }

                        document.getElementById('btnCancel').onclick = function(){
                            alert('cancel');
                            document.getElementById('getSeqDiv').style.display = 'none';
                            document.getElementById('seqmask').style.display = 'none';
                        }
                    }else if(btn.value=='Delete'){
                        var seqnum = evt.target.parentNode.parentNode.getElementsByTagName('TD')[0].innerHTML;
                        var r = window.confirm('You are about to permanently delete sequence ' 
                                + seqnum + '\n Are you sure?');
                        if(r==true){
                        document.getElementById('hdnSeqId').value = seqid;
                        document.getElementById('txtseq').value = '';
                        //document.getElementById('').value = '';
                        document.getElementById('hdnActiont').value = 'DELETE'; // hidden field
                        document.getElementById('hdnActionf').value = 'DELETE'; // hidden field
                        //alert('submitting...');
                        document.getElementById('seq').submit();
                        }
                    }
                }
            }//end frmbtnclk   
            
            function newBtnClk() { // new button click event
                //alert('newbtn');
                clearFields();
                document.getElementById('fileseq').style.display = 'block'; // file form
                document.getElementById('txtseq').style.display = 'block'; // text form
                document.getElementById('hdnFile').style.display = 'none';
                document.getElementById('hdnActiont').value = 'INSERT'; // clear hidden field
                document.getElementById('hdnActionf').value = 'INSERT'; // clear hidden field
                document.getElementById('getSeqDiv').style.display = 'block';
                document.getElementById('seqtitle').innerHTML = 'New Sequence';
                document.getElementById('seqmask').style.display = 'block';
                document.getElementById('seqName').value = '';
                document.getElementById('txtseq').value = '';
                document.getElementById('seqName').focus();
                document.getElementById('btnCancel').onclick = function(){
                    alert('cancel');
                    document.getElementById('getSeqDiv').style.display = 'none';
                    document.getElementById('seqmask').style.display = 'none';
                }
            }
            
            function searchBtnClk() {
                alert('Searching...');
                document.getElementById('getSeqDiv').style.display = 'none';
                document.getElementById('seqmask').style.display = 'none';
                document.getElementById('seqsrchmask').style.display = 'block';
                document.getElementById('seqsrchdiv').style.display = 'block';
                document.getElementById('seqtitle2').innerHTML = 'Find Sequence';
                document.getElementById('hdnAction-s').value = 'SEARCH';
                document.getElementById('btnCancel-s').onclick = function() {
                    alert('Cancel');
                    document.getElementById('seqsrchmask').style.display = 'none';
                    document.getElementById('seqsrchdiv').style.display = 'none';
                };
                document.getElementById('sseqbtn').onclick = function() {
                    var sstitle = document.getElementById('seqdesc').value;
                    if(sstitle.length === 0) {
                        alert('Missing search title. Please enter a title:');
                        document.getElementById('seqdesc').focus();
                    } else {
                        alert('submitting...');            
                        document.getElementById('hdnSrchS').submit();
                    }
                };
            }//end searchBtnClk
            
            function clearFields() {
                document.getElementById('txtseq').value = '';
            }
            function validatet(evt){
                var err = '';
                var len1 = document.getElementById('seqName').value.trim().length;
                var len2 = document.getElementById('txtseq').value.trim().length;
                if (len1<1){
                    err += 'Sequence Name is missing.\n';
                }
                if (len2<1){
                    err += 'Sequence is missing.';
                }
                if (err.length>0){
                    evt.preventDefault();
                    alert(err);
                }else{
                    alert('validatet function submitting...');
                }
            }
            function validatef(evt){
                var len1 = document.getElementById('uploadfile').value.trim().length;
                if (len1<1){
                    evt.preventDefault();
                    alert('Sequence File is missing.\n');
                }else{
                    alert('validatef function submitting...');
                }
            }
    </script>   
</head>
<body>
    <h1>Sequences</h1>
    
    <div id="seqtblwrap" class="tblwrap">
        <table id="tblhead" class="thd">
            <tr>
                <th>Gene</th>
                <th>Date</th>
                <th></th>
            </tr>
        </table>

        <div id="seqwraptbody" class="tbdy">
            <table id="seqtbody" class="seqtbl">
                <c:forEach var="s" items="${seq}">
                <tr data-seqid="${s.seqID}" data-file="${s.seqPath}" data-data="${s.safeSeqData}">
                    <td>${s.seqName}</td>
                    <td>${s.seqDt}</td>
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
    </div>
    
   
    <div id="seqmask" class="mask">
        <div id="getSeqDiv">
            <h2 id="seqtitle">Add a New Sequence</h2>
            <form id="seq" action="Sequence" method="post">
                Name of Sequence/Gene:
                <input type="text" id="seqName" name="seqName">
                <p>Cut and paste Sequence here:<br>
                <i>Note: Sequence must be in FASTA format</i></p>

                <textarea id="txtseq" name="txtseq" rows="10" maxlength="40000" cols="60" wrap="soft"></textarea>
                <input type="submit" value="Submit" name="btnSubmit">
                <input type="hidden" id="hdnActiont" name="hdnAction" value="">
                <input type="hidden" id="hdnSeqId" name="hdnSeqId" value="">
                <input type="hidden" id="hdnSeqDate" name="hdnSeqDate" value=""><br/>
            </form>
            <br><br>
            <a href="" id="hdnFile">Download Current File</a>
            <form id="fileseq" action="SequenceUpload" method="post" enctype="multipart/form-data">
                <p>Or Select Sequence File To Upload... 
                <input type="file" id="uploadfile" name="uploadfile" accept=".txt, .pdf, .doc, .docx" size="50"/>
                </p>
                <input type="button" value="Cancel" id="btnCancel">
                <input type="submit" id="seqsub" value="Upload File" name="btnSubmit">
                <input type="hidden" id="hdnActionf" name="hdnAction" value="">
            </form>
        </div>
        <!-- a class="button"  href="page1.jsp">Return to Main Menu</a -->
    </div>
    <form id="hdnSrchS" action="Sequence" method="post">
        <div id="seqsrchmask" class="searchMask">
            <div id="seqsrchdiv" class="searchDiv">
                <h2 id="seqtitle2">Find Sequence</h2>
                <input type="text" id="seqdesc" name="seqdesc" placeholder="Name of Sequence...">
                <input type="button" id="sseqbtn" value="Search Sequences">
                <br><input type="button" value="Cancel" id="btnCancel-s" style="margin-left:20px">
                <input type="hidden" value="SEARCH" id="hdnAction-s" name="hdnAction">
            </div>
        </div>
    </form>
    <%--
    <p>${msg}</p>
    <p>${cntmsg}</p>
    --%>
    <h4 class="msgctr" id="btnmsg">${msg} ${btnmsg}</h4><br>
    <p class="msgctr" style="text-align: center"> ${cntmsg} </p>
    <!-- a class="button"  href="page1.jsp">Return to Main Menu</a -->
    </body>
</html>
