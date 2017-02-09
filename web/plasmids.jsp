<%-- 
    Document   : plasmids
    Created on : Jun 8, 2016, 6:24:06 PM
    Author     : Miriam
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Plasmids</title>
        <link href="iici_db.css" rel="stylesheet" type="text/css">
        <!-- style>
            body{
                background-color: #d2b48c;
            }
            h1{
                text-align: center;
            }
            #plasmid{width:100%;height:90%;}
            #plasmid,th,td{border: 1px solid #555;}
            #tblwrap{
                background-color: #ffffcc;
                position: fixed;
                width: 95%;
                padding: 0;
            }
            /*th {
                border-left: none;
                border-right: none;
            }*/
            th:nth-child(1){
                width: 5%;
                min-width:100px;
            }
            th:nth-child(2){
                width: 5%;
                min-width:100px;
            }
            th:nth-child(3){
                width: 5%;
                min-width:100px;
            }
            th:nth-child(4){
                width: 5%;
                min-width:100px;
            }
            th:nth-child(5){
                /*width: 60%;*/
                min-width: 100px;
            } 
            th:nth-child(6){
                width: 4%;
                min-width:100px;
                border-right: none;
            }
            th:nth-child(7){
                width: 16%;
                min-width:100px;
                border-left: none;
            }
            #tblhead {
                width: 100%;
                border-collapse: collapse;
                border: 2px solid #555;
                border-bottom: none;
            }
            #wraptbody {
                height: 200px;
                overflow-y: auto;
            }
            #plasmidtbl {
                width: 100%;
                border-collapse: collapse;
                border: 2px solid #555;
            }
            plasmidtbl.edbtn {
                margin: 1px 1px;
                float: right;
            }
            tr:nth-child(odd) {background: #ffffcc}
            tr:nth-child(even) {background: #ccff66}
            td{
                border: 1px solid #bbb;
                border-top: none;
                border-bottom: none;
            }
            td:first-child{
                width: 5%;
                min-width:100px;
                border-right: none;
            }
            td:nth-child(2){
                width: 5%;
                min-width: 100px;
            }
            td:nth-child(3){
                width: 5%;
                min-width: 100px;
            }
            td:nth-child(4){
                width: 5%;
                min-width: 100px;
            }
            td:nth-child(5){
                /*width: 60%;*/
                min-width: 100px;
            }
            td:nth-child(6){
                width: 4%;
                min-width: 100px;
            }
            td:nth-child(7){
                width: 16%;
                min-width: 100px;
            }
            #pledit td:first-child{
                min-width: 250px;
            }
            #pledit td:nth-child(2){
                width: 60%;
            }
            #editpldiv{
                display:none;
                z-index:1;
                position:fixed;
                top:25px;
                left:10px;
                right:10px;
                border:1px solid #fff;
                border-radius: 10px;
                margin: 0 auto;
                color:#ffffcc;
                padding: 0 5px;
            }
          #editpldiv2{
                display:none;
                z-index:1;
                position:fixed;
                top:25px;
                left:10px;
                right:10px;
                border:1px solid #fff;
                border-radius: 10px;
                margin: 0 auto;
                color:#ffffcc;
                padding:0 5px;
            }
            #plasmidmask {
                display:none;
                z-index:0;
                position:fixed;
                top:10px;
                left:2px;
                right:2px;
                height:400px;
                opacity:0.95;
                background-color:#020;
                border-radius:10px;
            }
            #plasmidmask2 {
                display:none;
                z-index:0;
                position:fixed;
                top:10px;
                left:2px;
                right:2px;
                height:400px;
                opacity:0.95;
                background-color:#020;
                border-radius:10px;
            }
            #pltitle{
                color:#fff;
                text-align:center;
                background-color:#797;
            }
            #pltitle2{
                color:#fff;
                text-align:center;
                background-color:#797;
            }
            #pldesc{
                width: 75%;
                height: auto;
            }
            #pldesc2{
                width: 75%;
                height: auto;
            }
            #btnSrch{margin-top: 10px; margin-right: 10px; float: right;}
            #btnNew{margin-top: 10px; float: right;}
            a.button {
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
            #cntmsg{
                position:fixed;
                bottom:100px;
                width:100%;
                text-align: center;
            }
            #msg{
                position:fixed;
                bottom:50px;
            }
        </style -->
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
                document.getElementById('plasmidtbl').onclick = frmbtnclk;
                document.getElementById('hdnplfrm').onsubmit = validate;
                document.getElementById('hdnfrm2').onsubmit = validate2; // search form has no validate
                document.getElementById('btnSrch').onclick = searchBtnClk;
                document.getElementById('btnNew').onclick = newBtnClk;
            }//end function init
        
            function frmbtnclk(evt) {
                //alert('button click');
                if (evt.target.tagName == 'INPUT' && evt.target.className == 'edbtn'){      
                    var btn = evt.target;
                    var tr = btn.parentNode.parentNode;
                    var tdlist = tr.getElementsByTagName('TD');
                    var td1 = tdlist[0].innerHTML;
                    var td2 = tdlist[1].innerHTML;
                    var td3 = tdlist[2].innerHTML;
                    var td4 = tdlist[3].innerHTML;
                    var td5 = tdlist[4].innerHTML;
                    var td6 = tdlist[5].innerHTML;
                    var hid = tdlist[6].getElementsByTagName('input')[0];
                    if(btn.value=='More/Edit'){
                        //alert('More/Edit button clicked');
                        document.getElementById('hdnCmd1').value = "MORE/EDIT";
                        document.getElementById('pltitle').innerHTML = 'View/Edit Plasmid';
                        document.getElementById('editpldiv').style.display = 'block';
                        document.getElementById('plasmidmask').style.display = 'block';
                        document.getElementById('plnum').value = td1;
                        document.getElementById('bin').value = td2;
                        document.getElementById('intermed').value = td3;
                        document.getElementById('res').value = td4;
                        document.getElementById('pldesc').value = td5;
                        document.getElementById('author').value = td6;
                        document.getElementById('nbnum').value = hid.getAttribute('data-nbnum');
                        document.getElementById('nbpg').value = hid.getAttribute('data-nbpg');
                        var dtstr = hid.getAttribute('data-ckdt');
                        //alert('['+ dtstr +']');
                        if(dtstr==null || dtstr=='') {
                            // clear the date in the form
                            document.getElementById('yr').value = '00';
                            document.getElementById('month').value = '00';
                            document.getElementById('day').value = '00'; 
                            //alert('empty');
                            
                        ckbinval();    
                            
                        }else if(dtstr.length == 10){
                            //alert('insert date');
                            var y = dtstr.substring(0, 4);
                            var m = dtstr.substring(5, 7);
                            var d = dtstr.substring(8);
                            var fdate =  y + '-' + m + '-' + d;
                            //alert('['+ fdate +']');
                            document.getElementById('yr').value = y;
                            document.getElementById('month').value = m;
                            document.getElementById('day').value = d; 
                        }else{
                            alert('Problem with database date: '+ fdate);
                        }
                        
                        document.getElementById('cknbnum').value = hid.getAttribute('data-cknbnum');
                        if(document.getElementById('cknbnum').value <= 0) {
                            document.getElementById('cknbnum').value='';
                        }
                        document.getElementById('cknbp').value = hid.getAttribute('data-cknbp');
                        if(document.getElementById('cknbp').value <= 0) {
                            document.getElementById('cknbp').value='';
                        }
                        document.getElementById('btnCancel').onclick = function(){
                        //alert('cancel');
                        document.getElementById('editpldiv').style.display = 'none';
                        document.getElementById('plasmidmask').style.display = 'none';
                        }//end cancel
                } else if (btn.value=='Delete') {
                        document.getElementById('hdnCmd1').value = "DELETE";
                        var r = window.confirm('You are about to permanently delete plasmid number ' 
                                + td1 + '\n Are you sure?');
                        if(r==true){
                        clearFields();                
                        document.getElementById('plnum').value = td1;
                        alert('submitting...');
                        document.getElementById('hdnplfrm').submit();
                        }
                    }
                }
            }//End of frmbtnclk
            function ckbinval() {
                var binval = document.getElementById('bin').value.toUpperCase();
                            if(binval == 'NO') {
                                document.getElementById('month').disabled='true';
                                document.getElementById('day').disabled='true';
                                document.getElementById('yr').disabled='true';
                                document.getElementById('cknbnum').disabled='true';
                                document.getElementById('cknbp').disabled='true';
                            }
            }
             function validate2() { // used only for SEARCH
                var fail = false;
                var y1 = document.getElementById('yr1').value;
                var m1 = document.getElementById('month1').value;
                var d1 = document.getElementById('day1').value;
                var y2 = document.getElementById('yr1').value;
                var m2 = document.getElementById('month1').value;
                var d2 = document.getElementById('day1').value;
                if (y1 == '00' || m1 == '00' || d1 == '00'){
                    if (y1 != '00' || m1 != '00' || d1 != '00'){
                        fail = true;
                    }
                }
                if (y2 == '00' || m2 == '00' || d2 == '00'){
                    if (y2 != '00' || m2 != '00' || d2 != '00'){
                        fail = true;
                    }
                }
                if(fail == true) {
                    evt.preventDefault();
                    alert('Error: partial date');
                }
             }// end of validate2
            function validate() {
                //alert('validate function called');
                var fail = false;
                var plnum = document.getElementById('plnum').value.trim();
                if(plnum.length > 0) {
                    var plnumi=parseInt(plnum);
                    if(isNaN(plnumi)) {
                        alert('Error: plasmid id must be an integer');
                        fail = true;
                        document.getElementById('plnum').focus();
                    }
                    if(plnumi <= 0) {
                        alert('Error: plasmid id must be greater than zero');
                        fail = true;
                        document.getElementById('plnum').focus();
                    }
                }//end chk plnum
                var sres = document.getElementById('res').value.trim();
                if(sres == null) {
                    alert('Error, antibiotic resistance missing!');
                    fail = true;
                    document.getElementById('res').focus();
                }//end resistance
                var spldesc = document.getElementById('pldesc').value.trim();
                if(spldesc == null) {
                    alert('Error: missing description!');
                    fail = true;
                    document.getElementById('pldesc').focus();
                }//end pldesc
                var sauthor = document.getElementById('author').value.trim();
                if(sauthor == null) {
                    alert('Error: missing author!');
                    fail = true;
                    document.getElementById('author').focus();
                }
            
                if(fail == true) {
                    evt.preventDefault();
                    alert('submit was aborted');
                }else{
                    alert('submitting form...');
                }
            }//End validate
            function searchBtnClk() { // search button click event
                //alert('srchBtnClk');
                clearFields();
                document.getElementById('hdnCmd2').value = 'SEARCH'; // set hidden field
                //document.getElementById('pltitle2').innerHTML = 'Search2';//set title
                document.getElementById('editpldiv2').style.display = 'block';
                document.getElementById('plasmidmask2').style.display = 'block';
                document.getElementById('plnum2').focus();
                
                document.getElementById('btnCancel2').onclick = function(){
                    //alert('cancel');
                    document.getElementById('editpldiv2').style.display = 'none';
                    document.getElementById('plasmidmask2').style.display = 'none';
                }//end cancel            
            }//end searchBtnClk
            function newBtnClk() { // new button click event
                //alert('newBtnClk');
                clearFields();
                document.getElementById('hdnCmd1').value = 'INSERT'; // clear hidden field
                document.getElementById('editpldiv').style.display = 'block';
                document.getElementById('pltitle').innerHTML = 'New Plasmid';
                document.getElementById('plasmidmask').style.display = 'block';
                document.getElementById('plnum').disabled='true';
                document.getElementById('bin').focus();
                document.getElementById('btnCancel').onclick = function(){
                    //alert('cancel');
                document.getElementById('editpldiv').style.display = 'none';
                document.getElementById('plasmidmask').style.display = 'none';
                }
            }//end newBtnClk
            function clearFields() {
                //document.getElementById('hdnCmd1').value = '';
                document.getElementById('plnum').value = '';
                document.getElementById('bin').value = '';
                document.getElementById('intermed').value = '';
                document.getElementById('res').value = '';
                document.getElementById('pldesc').value = '';
                document.getElementById('author').value = '';
                document.getElementById('nbnum').value = '';
                document.getElementById('nbpg').value = '';
                document.getElementById('yr').value = '';
                document.getElementById('month').value = '';
                document.getElementById('day').value = '';
                document.getElementById('cknbnum').value = '';
                document.getElementById('cknbp').value = '';
            }// end of clearFields
            
        </script>
    </head>
    
    <body>
        <h1>Plasmids</h1>
            <div id="tblwrap" class="tblwrap">
                <table id="tblhead" class="tblhd">
                    <tr>
                        <th>Plasmid Number</th>
                        <th>Binary?</th>
                        <th>Intermediate /Final</th>
                        <!-- <th>Notebook #/Page #</th> -->
                        <th>Resistance</th>
                        <!-- <th>E. coli Glycerol Stock</th> -->
                        <!-- <th>Agro Glycerol Stock</th> -->
                        <th>Description</th>
                        <!-- <th>Final Check After Agro</th> -->
                        <th>Author</th>
                        <th></th>
                    </tr>
                    
                </table>
                <div id="wraptbody" class="tbdy">
                <table id="plasmidtbl" class="pltbl">
                    <c:forEach var="pl" items="${plasmids}">
                    <tr>
                        <td>${pl.plasmidID}</td>
                        <td>${pl.bin}</td>
                        <td>${pl.intermed}</td>
                        <td>${pl.res}</td>
                        <td>${pl.pldesc}</td>
                        <td>${pl.author}</td>
                        <td><input type="hidden" 
                                   data-nbnum="${pl.nbnum}"  
                                   data-nbpg="${pl.nbpg}" 
                                   data-ckdt="${pl.ckdt}"  
                                   data-cknbnum="${pl.cknbnum}" 
                                   data-cknbp="${pl.cknbpg}" 
                                   />
                            <input type="button" class="edbtn" value="More/Edit">
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
            </div>
            <form id="hdnplfrm" method="post" action="Plasmid">
                <div id="plasmidmask" class="mask">
                    <div id="editpldiv">
                        <h2 id="pltitle">Edit Plasmid</h2>
                        Plasmid Number:
                        <input type="text" id="plnum" name="plnum">
                        Binary?
                        <select id="bin" name="bin">
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>
                        Resistance:
                        <input type="text" id="res" name="res">
                        Final/Intermediate:
                        <select id="intermed" name="intermed">
                            <option value="Intermediate">Intermediate</option>
                            <option value="Final">Final</option>
                        </select><br><br><br>
                        Description:
                        <input type="text" id="pldesc" name="pldesc"><br><br>
                        Author:
                        <input type="text" id="author" name="author">
                        Notebook Number:
                        <input type="text" id="nbnum" name="nbnum">
                        Notebook Page:
                        <input type="text" id="nbpg" name="nbpg"><br><br>
                        Check After Agro. Date:
                        <select id="month" name="month1">
                            <option value="00"></option>
                            <option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04">April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">August</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>
                        <select id="day" name="day1">
                            <option value="00"></option>
                            <option value="01">1</option>
                            <option value="02">2</option>
                            <option value="03">3</option>
                            <option value="04">4</option>
                            <option value="05">5</option>
                            <option value="06">6</option>
                            <option value="07">7</option>
                            <option value="08">8</option>
                            <option value="09">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                            <option value="24">24</option>
                            <option value="25">25</option>
                            <option value="26">26</option>
                            <option value="27">27</option>
                            <option value="28">28</option>
                            <option value="29">29</option>
                            <option value="30">30</option>
                            <option value="31">31</option>
                        </select>
                        <select id="yr" name="yr1">
                            <option value="00"></option>
                            <option value="2001">2001</option>
                            <option value="2002">2002</option>
                            <option value="2003">2003</option>
                            <option value="2004">2004</option>
                            <option value="2005">2005</option>
                            <option value="2006">2006</option>
                            <option value="2007">2007</option>
                            <option value="2008">2008</option>
                            <option value="2009">2009</option>
                            <option value="2010">2010</option>
                            <option value="2011">2011</option>
                            <option value="2012">2012</option>
                            <option value="2013">2013</option>
                            <option value="2014">2014</option>
                            <option value="2015">2015</option>
                            <option value="2016">2016</option>
                            <option value="2017">2017</option>
                            <option value="2018">2018</option>
                            <option value="2019">2019</option>
                            <option value="2020">2020</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2027</option>
                            <option value="2024">2026</option>
                            <option value="2025">2025</option>
                        </select>
                        Check After Agro. Notebook Number:
                        <input type="text" id="cknbnum" name="cknbnum" class="ckflds" value="">
                        Check After Agro. Notebook Page:
                        <input type="text" id="cknbp" name="cknbp" class="ckflds" value="">
                        <br/><br/>

                        <input type="submit" value="Submit" id="btnSubmit" name="btnSubmit">
                        <input type="button" value="Cancel" id="btnCancel" style="margin-left:20px">
                        <input type="hidden" value="" id="hdnCmd1" name="hdnCmd">
                        <!--input type="hidden" value="" id="hdnSearch" name="hdnSearch" -->
                    </div>
                </div>
        </form>
        <form id="hdnfrm2" method="post" action="Plasmid">
            <div id="plasmidmask2" class="mask2">
                    <div id="editpldiv2">
                        <h2 id="pltitle2">Search Plasmids</h2>
                        Plasmid Number:
                        <input type="text" id="plnum2" name="plnum">
                        Binary?
                        <select id="bin2" name="bin">
                            <option value=""></option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>
                        Resistance:
                        <input type="text" id="res2" name="res">
                        Final/Intermediate:
                        <select id="intermed2" name="intermed">
                            <option></option>
                            <option value="Intermediate">Intermediate</option>
                            <option value="Final">Final</option>
                        </select><br><br><br>
                        Description:
                        <input type="text" id="pldesc2" name="pldesc"><br><br>
                        Author:
                        <input type="text" id="author2" name="author">
                        Notebook Number:
                        <input type="text" id="nbnum2" name="nbnum">
                        Notebook Page:
                        <input type="text" id="nbpg2" name="nbpg"><br><br>
                        <label for="month1">From Date:</label>
                        <select id="month1" name="month1">
                            <option value="00"></option>
                            <option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04">April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">August</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>
                        <!-- <label for="day1">Day:</label> -->
                        <select id="day1" name="day1">
                            <option value="00"></option>
                            <option value="01">1</option>
                            <option value="02">2</option>
                            <option value="03">3</option>
                            <option value="04">4</option>
                            <option value="05">5</option>
                            <option value="06">6</option>
                            <option value="07">7</option>
                            <option value="08">8</option>
                            <option value="09">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                            <option value="24">24</option>
                            <option value="25">25</option>
                            <option value="26">26</option>
                            <option value="27">27</option>
                            <option value="28">28</option>
                            <option value="29">29</option>
                            <option value="30">30</option>
                            <option value="31">31</option>
                        </select>
                    <!--  <label for="yr1">Year:</label> -->
                        <select id="yr1" name="yr1">
                            <option value="00"></option>
                            <option value="2001">2001</option>
                            <option value="2002">2002</option>
                            <option value="2003">2003</option>
                            <option value="2004">2004</option>
                            <option value="2005">2005</option>
                            <option value="2006">2006</option>
                            <option value="2007">2007</option>
                            <option value="2008">2008</option>
                            <option value="2009">2009</option>
                            <option value="2010">2010</option>
                            <option value="2011">2011</option>
                            <option value="2012">2012</option>
                            <option value="2013">2013</option>
                            <option value="2014">2014</option>
                            <option value="2015">2015</option>
                            <option value="2016">2016</option>
                            <option value="2017">2017</option>
                            <option value="2018">2018</option>
                            <option value="2019">2019</option>
                            <option value="2020">2020</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2027</option>
                            <option value="2024">2026</option>
                            <option value="2025">2025</option>
                        </select>
                        
                        <label for="month2">To Date:</label> 
                        <select id="month2" name="month2">
                            <option value="00"></option>
                            <option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04">April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">August</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>
                    <!--  <label for="day2">Day:</label> -->
                        <select id="day2" name="day2">
                            <option value="00"></option>
                            <option value="01">1</option>
                            <option value="02">2</option>
                            <option value="03">3</option>
                            <option value="04">4</option>
                            <option value="05">5</option>
                            <option value="06">6</option>
                            <option value="07">7</option>
                            <option value="08">8</option>
                            <option value="09">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                            <option value="21">21</option>
                            <option value="22">22</option>
                            <option value="23">23</option>
                            <option value="24">24</option>
                            <option value="25">25</option>
                            <option value="26">26</option>
                            <option value="27">27</option>
                            <option value="28">28</option>
                            <option value="29">29</option>
                            <option value="30">30</option>
                            <option value="31">31</option>
                        </select>
                   <!-- <label for="yr1">Year:</label> -->
                        <select id="yr2" name="yr2">
                            <option value="00"></option>
                            <option value="2001">2001</option>
                            <option value="2002">2002</option>
                            <option value="2003">2003</option>
                            <option value="2004">2004</option>
                            <option value="2005">2005</option>
                            <option value="2006">2006</option>
                            <option value="2007">2007</option>
                            <option value="2008">2008</option>
                            <option value="2009">2009</option>
                            <option value="2010">2010</option>
                            <option value="2011">2011</option>
                            <option value="2012">2012</option>
                            <option value="2013">2013</option>
                            <option value="2014">2014</option>
                            <option value="2015">2015</option>
                            <option value="2016">2016</option>
                            <option value="2017">2017</option>
                            <option value="2018">2018</option>
                            <option value="2019">2019</option>
                            <option value="2020">2020</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2027</option>
                            <option value="2024">2026</option>
                            <option value="2025">2025</option>
                        </select>
                        <br><br>
                        Check After Agro. Notebook Number:
                        <input type="text" id="cknb2" name="cknb" value="">
                        Check After Agro. Notebook Page:
                        <input type="text" id="ckpg2" name="ckpg" value="">
                        <br/><br/>
                        <input type="submit" value="Submit">
                        <input type="button" value="Cancel" id="btnCancel2" style="margin-left:20px">
                        <input type="hidden" value="SEARCH" id="hdnCmd2" name="hdnCmd">
                        <!-- input type="hidden" value="search" id="hdnSearch2" name="hdnSearch2" -->
                    </div>
                </div>
        </form>
        <%--
        <p id="cntmsg" class="msgctr"> ${cntmsg} </p>
        <p id="msg"> ${msg} </p>
        --%>
        <h4 class="msgctr" id="btnmsg">${msg} ${btnmsg}</h4><br>
        <p class="msgctr" style="text-align: center"> ${cntmsg} </p>
        
    </body>
</html>
