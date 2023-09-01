<%@ page language = "java" import = "java.sql.*, java.io.IOException, java.lang.*,java.text.*,java.util.*,java.awt.*,javax.naming.*,javax.sql.*"%>

<html>
<head>
	<title>Database</title>
<!--loader-->
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style>
			 #loading {
				 position: fixed;
				 display: block;
				 width: 100%;
				 height: 100%;	
				 }
	</style>


	<!--http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_09_airport.jsp-->
</head>
<script>
	
	function myFunction(tagname,port_Code_Link) 
	{
		
		if(tagname == 'arrival_country')
		{
			window.open("http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_01_arr.jsp?tagname="+tagname+"&source_port="+port_Code_Link,'_blank', '0.80');
		}
		if(tagname == 'departure_country')
		{
			//modelWindow_download("im_flight_routes_dashboard_02_dep.jsp?tagname="+tagname,'_blank', '0.80');
			window.open("http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_02_dep.jsp?tagname="+tagname+"&dest_port="+port_Code_Link,'_blank', '0.80');
		}	
	}
function modelWindow_download (mypage, myname, v_size)
	{
		var tmp_width = Math.round(screen.width * 0.70);
		var tmp_height = Math.round(screen.height * 0.80);
		var LeftPosition = (screen.width) ? (screen.width-tmp_width)/2 : 0;
		var TopPosition = (screen.height) ? (screen.height-tmp_height)/2 : 0;

		settings = 'dialogWidth:'+tmp_width+'px; dialogHeight:'+tmp_height+'px; dialogLeft:'+LeftPosition+'px;'+';dialogTop:'+TopPosition+'px;'+';toolbar=no;location=no;directories=no;menubar=no;scrollbars=yes;resizable=yes;';
		//win2 = window.showModalDialog(mypage, settings, settings);
			//window.open(mypage,"_blank","toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=400,height=400");
			
			if(popupWindow && !popupWindow.closed){
				popupWindow.focus();

				document.onmousedown = popupWindow.focus();
				document.onkeyup = popupWindow.focus();
				document.onmousemove = popupWindow.focus();
			}
			else{

				popupWindow = window.open(mypage,"_blank","toolbar=yes,scrollbars=yes,resizable=0,location=yes,directories=no,menubar=yes,width="+tmp_width+",height="+tmp_height+",left="+LeftPosition+",top="+TopPosition);

				popupWindow.focus();
				
				document.onmousedown = popupWindow.focus();
				document.onkeyup = popupWindow.focus();
				document.onmousemove = popupWindow.focus();
			}

	}
	function closeWindow() 
	{  
  		window.close();  
	}  

	function reset_Values() {
		document.airport_form.text_Input.value = "";
		document.airport_form.source_port_Input.value = "";	
		document.airport_form.action="im_flight_routes_dashboard_09_airport.jsp";
		document.airport_form.submit();
	}

	function letternumber(e, str)
		{
			var key;
			var keychar;
			if (window.event)
			   key = window.event.keyCode;
			else if (e)
			   key = e.which;
			else
			   return true;
			keychar = String.fromCharCode(key);
			keychar = keychar.toLowerCase();
			// control keys
			if ((key==null) || (key==0) || (key==8) || 
				(key==9) || (key==13) || (key==27) )
			   return true;
			// alphas and numbers
			else if ((str.indexOf(keychar) > -1))
			   return true;
			else
			   return false;
		}

		function filtery(pattern, list){
         
		  /*

		  if the dropdown list passed in hasn't

		  already been backed up, we'll do that now

		  */

		  if (!list.bak){

			/*

			We're going to attach an array to the select object

			where we'll keep a backup of the original dropdown list

			*/

			list.bak = new Array();

			for (n=0;n<list.length;n++){

			  list.bak[list.bak.length] = new Array(list[n].value, list[n].text);

			}

		  }

		  /*

		  We're going to iterate through the backed up dropdown

		  list. If an item matches, it is added to the list of

		  matches. If not, then it is added to the list of non matches.

		  */

		  match = new Array();

		  nomatch = new Array();

		  for (n=0;n<list.bak.length;n++){

			if(list.bak[n][1].toLowerCase().indexOf(pattern.toLowerCase())!=-1){

			  match[match.length] = new Array(list.bak[n][0], list.bak[n][1]);//value found

			}else{

			  nomatch[nomatch.length] = new Array(list.bak[n][0], list.bak[n][1]);

			}

		  }

		  /*

		  Now we completely rewrite the dropdown list.

		  First we write in the matches, then we write

		  in the non matches

		  */

		  for (n=0;n<match.length;n++){

			list[n].value = match[n][0];

			list[n].text = match[n][1];

		  }

		  for (n=0;n<nomatch.length;n++){

			list[n+match.length].value = nomatch[n][0];

			list[n+match.length].text = nomatch[n][1];

		  }

		  /*

		  Finally, we make the 1st item selected - this

		  makes sure that the matching options are

		  immediately apparent

		  */

		  list.selectedIndex=0;

		}
</script>

<script>

////////////////////////////////////////////////// Cursor Code ////////////////////////////////////////////////////////////////////////////

function SetCursor()
		{
			var tDate = new Date(); 
			var yy1 = tDate.getFullYear();
			var mm1 = tDate.getMonth();
			var dd1 = tDate.getDate();
			var hh1 = tDate.getHours();
			var hh2 = tDate.getHours();
			var mm2 = tDate.getMinutes();
			var ss1 = tDate.getSeconds();
			var nDate = new Date(yy1, mm1, dd1, hh1, mm2,ss1); 
			var sDate = new Date(yy1, mm1, dd1-7, hh1, mm2,ss1); 

			tDate =  ('0' + tDate.getDate()).substring(('0' + tDate.getDate()).length-2) + "/" +  ('0' + (tDate.getMonth()+1)).substring(('0' + (tDate.getMonth()+1)).length-2) + "/" + tDate.getFullYear();

			nDate =  ('0' + nDate.getDate()).substring(('0' + nDate.getDate()).length-2) + "/" +  ('0' + (nDate.getMonth()+1)).substring(('0' + (nDate.getMonth()+1)).length-2) + "/" + nDate.getFullYear();

			sDate =  ('0' + sDate.getDate()).substring(('0' + sDate.getDate()).length-2) + "/" +  ('0' + (sDate.getMonth()+1)).substring(('0' + (sDate.getMonth()+1)).length-2) + "/" + sDate.getFullYear(); //one week before date
	
			
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////// Below are the list of the Function requred to enable the loading division and the timer... /////////////////////////////////////////////////

	function parent_disable(){
		if(window && !window.closed)
			window.focus();
	}
	


/////////////// Below are the list of the Function requred to enable the loading division and the timer/////////////////////////////////////////////////

	function enableTimer()
	{
			document.getElementById("loading").style.display='none';
			document.clkfrm.stop_timer.value = "0";
			SetCursor();
	}
			
	var TotalSeconds;
	function CreateTimer(Time) 
	{
		TotalSeconds = Time;
		UpdateTimer();
		window.setTimeout("Tick()", 1000);
	}

	function Tick() 
	{
		if(document.clkfrm.stop_timer.value == "0") return;
		TotalSeconds += 1;
		UpdateTimer();
		window.setTimeout("Tick()", 1000);
	}

	function LeadingZero(Time) 
	{
		return (Time < 10) ? "0" + Time : + Time;
	}

	function UpdateTimer() 
	{
		
		var Seconds = TotalSeconds;
		var Days = Math.floor(Seconds / 86400);
		Seconds -= Days * 86400;

		var Hours = Math.floor(Seconds / 3600);
		Seconds -= Hours * (3600);

		var Minutes = Math.floor(Seconds / 60);
		Seconds -= Minutes * (60);

		var TimeStr = ((Days > 0) ? Days + " days " : "") + LeadingZero(Hours) + ":" + LeadingZero(Minutes) + ":" + LeadingZero(Seconds)

		digclock = "<font face='Verdana' size='2' color='#FF0000'><b>Timer :- " + TimeStr + "</b></font>";
      Clock.innerHTML = digclock;
			
			
		/*if (document.layers)
		{	
			document.layers.Clock.document.write(digclock);
			document.layers.Clock.document.close();
		}
		else if (document.all) {	
			
			Clock.innerHTML = digclock;
		}*/
	}
///////////////////////////////////////////////////////////////////////////////////////////////////



</script>

<body onload="enableTimer();" onclick = "parent_disable();" onFocus = "parent_disable();" style="background-color:#f5f9ff;">
<!--20/09/2022 use for loader-->
<form name="clkfrm" method="post">
	<input type="hidden" name="stop_timer" value="1">
	<SPAN id="Clock" style="position:absolute;left:15px;top:5px;width:250px;height:50px;"></span>
</form>

<script>
	CreateTimer(0);
</script>
<% String heading = "Airport-wise Arrival and Departure Flight Count"; %>
<br>
<div id="loading" name="loading/" style="background-color: #f5f9ff; ">
	<br><br>
	<br><br><CENTER><font face="verdana" color="blue" size="3"><b><%=heading%></b></font></CENTER><br>
	<CENTER><IMG SRC="loading5.gif" HSPACE="0" VSPACE="0" BORDER="0" NAME="ProgBar" ALT="Generating Results, Please Wait...">
	</CENTER><BR><BR><br>
	<CENTER><font face="verdana" color="DarkGreen"><H2 ><i>Generating Results, Please Wait......</i></H2></font></CENTER><br><br>
</div>
			
<h1 style="font-family: Arial;background-color: #D0DDEA; color: #347FAA; font-size: 40px;"><center>Airport-wise Arrival and Departure Flight Count</center></h1><br><br>

<!--http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_00.jsp-->

<%
	String port_code = request.getParameter("source_port_Input") == null ? "" : request.getParameter("source_port_Input");
	//out.println("port_code--"+port_code);


	Context ctx = null;
	Connection con = null;

	ctx = new InitialContext();
	Context envCtx = (Context)ctx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/im_pax_flights");
	con = ds.getConnection();

PreparedStatement psTemp = null;
PreparedStatement psMain = null;
ResultSet rsMain = null;
ResultSet rsTemp = null;

%>
<form action="" method="post" name="airport_form">
	<table align="center" width="100%" border="0" cellspacing="0" cellpadding="2" bordercolorlight="#FF99CC" 
		bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #067c94; font-family: verdana;font-size: 10pt; font-weight: bold;color:white;">
	<tr>
	
		<td colspan="2" align="center">
			Filter by Airport
   			<input type="text" style="color:white;font-weight:bold;height: 22px;font-size=12pt; background-color: #007d79;text-transform:uppercase;font-family:Verdana" size="3" maxlength="10" name="text_Input" onkeyup="filtery(this.value,this.form.source_port_Input)" onchange="filtery(this.value,this.form.source_port_Input)" onKeyDown="if(event.keyCode==13) event.keyCode=9;if (event.keyCode==8) event.keyCode=37+46;" onKeyPress="return letternumber(event, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')">

			<select name="source_port_Input" style="width:400px;font-family: courier;font-size: 14px;color: blue; font-weight:bold;" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
       	<option value="" selected>Select</option>
       	    <%

			 try
			{				 
			 psTemp = con.prepareStatement("select PORT_CODE,PORT_DESC from IM_APIS_AIRPORTS order by PORT_CODE asc");
             rsTemp = psTemp.executeQuery(); 
			 while(rsTemp.next())
			 {				
				%>
			 <option value="<%=rsTemp.getString("PORT_CODE")%>"  <%if(port_code.equals(rsTemp.getString("PORT_CODE"))){%> selected <%}%> ><%=rsTemp.getString("PORT_CODE")+" - "+rsTemp.getString("PORT_DESC")%></option>
			 <%				
			 }
			 rsTemp.close();
			 psTemp.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		
			 %>
			 </select>&nbsp;&nbsp;				
				
				<button type="submit" value="Submit" style="background-color: #004144;color: white;font-weight: bold; font-size: 14px; border: none;padding: 10px 20px;
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 14px;
			  margin: 4px 2px;
			  cursor: pointer;">Submit</button>

			   <button type="reset" value="reset" onclick="reset_Values()" style="background-color: #004144;color: white;font-weight: bold; font-size: 14px; border: none;padding: 10px 20px;
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 14px;
			  margin: 4px 2px;
			  cursor: pointer;">Reset</button>

			   <button type="close" value="close" onclick="closeWindow();" style="background-color: #004144;color: white;font-weight: bold;font-size: 14px;
				   border: none;padding: 10px 20px;text-align: center;text-decoration: none;display: inline-block;
				   font-size: 14px;margin: 4px 2px;cursor: pointer;">Close</button> 
			</td>
		</tr>
			</table><br><br>
<%		
//////////////////////////////////////////////////////////////////////////////////////////////////////			

//	String select_Arr_CarrierTotal = "";
String select_Dep_AirportTotal = "";

String srcPortCode = "";
String srcPortCode2 = "";
String airportCount2 = "";
String airportCount3 = "";
String airportCount4 = "";
String CountQuery3 = "";
String CountQuery4 = "";
String QueryCount3 = "";
String QueryCount4 = "";
String select_Arr_CarrierTotal = "";
String error_bgColour = "";

int carrierCount5 = 0;
int total_Arr_Airport = 0;
int sum_Arr_Dep_Airport = 0;
int count3 = 0;
int count4 = 0;
int sum_Airport_Record = 0;

StringBuilder select_Arr_AirportTotal = new StringBuilder("");
String lblQuery = "";

				
try{
	//select SRC_PORT_CODE as src_port, count(1) as airport_arr_count from IM_FLIGHT_ROUTES WHERE SRC_PORT_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_PORT_CODE order by 2 desc
		select_Arr_AirportTotal.append("select SRC_PORT_CODE as src_port, count(1) as airport_arr_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND'");
		//out.println("port_code---"+port_code);
		if(!port_code.equals(""))
		{
			select_Arr_AirportTotal.append(" and SRC_PORT_CODE = '"+port_code+"'");
			lblQuery = lblQuery + "Port Code = " + port_code.toUpperCase();
		}	
			select_Arr_AirportTotal.append(" group by SRC_PORT_CODE");
			select_Arr_AirportTotal.append(" order by 2 desc");
			//out.println(select_Arr_AirportTotal.toString());
			lblQuery = "You queried for :  " + lblQuery;
			if(lblQuery.equals("You queried for :  ")) lblQuery = "";
%><h3 style="font-family: Arial; color: #fa4d56; text-align: left;font-size: 12pt; background-color: #d0e2ff;"><%=lblQuery%></h3><%

			psMain = con.prepareStatement(select_Arr_AirportTotal.toString());
					rsMain = psMain.executeQuery();  

			
		////// COUNT ////
			 try{	//select count(1) from (select SRC_PORT_CODE as src_port, count(1) as airport_arr_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_PORT_CODE order by 2 desc)
				CountQuery3 = "select count(1) from (" + select_Arr_AirportTotal.toString() + ")"; //out.println("<br>" + CountQuery3);
				psTemp = con.prepareStatement(CountQuery3);
				rsTemp = psTemp.executeQuery();
				count3 = 0;
				if(rsTemp.next())
					{
						QueryCount3 = rsTemp.getString(1);
					}
					rsTemp.close();
					psTemp.close();
					//out.println("      Your Query yields " + QueryCount3 + " Records");
					count3 = Integer.parseInt(QueryCount3);
				}
				catch(Exception e)
				{
					out.println(e);
				}
				
			 try{
				CountQuery4 = "select count(1) from (select DEST_PORT_CODE as src_port, count(1) as airport_arr_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and DEST_PORT_CODE in (select DEST_PORT_CODE as dest_port from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by DEST_PORT_CODE minus select SRC_PORT_CODE as src_port from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_PORT_CODE) group by DEST_PORT_CODE order by 2 desc)"; 
				//out.println("<br>" + CountQuery4);
				psTemp = con.prepareStatement(CountQuery4);
				rsTemp = psTemp.executeQuery(); 
				count4 = 0;
				if(rsTemp.next())
					{
						QueryCount4 = rsTemp.getString(1);
					}
					rsTemp.close();
					psTemp.close();						
					//out.println("      Your Query yields " + QueryCount4 + " Records");
					count4 = Integer.parseInt(QueryCount4);
					

				}
				catch(Exception e)
				{
					out.println(e);
				}
				
					
				sum_Airport_Record = count3 + count4;

				%>
		<table align="center" width="100%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#FF99CC" bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">
			<tr style=" background-color: #f6f2ff;font-family: Verdana; font-size: 12px; color:darkgreen;font-weight: bold;">
				<td align="right" colspan="5">Your Query yields <%=sum_Airport_Record%> Record(s)</td>
			</tr>

			<tr style=" background-color: #78a9ff;font-family: Verdana; font-size: 15px; color:white;font-weight: bold;">
				<td  bgcolor="#0072c3"><center>S.No.</center></td>
				<td  bgcolor="#0072c3" align="left" width="62%">&nbsp;Airports</td>
				<td  bgcolor="#0072c3" align="right" >Arrival Flights</td>
				<td  bgcolor="#0072c3" align="right" >Departure Flights</td>
				<td bgcolor="#0072c3" align="right">Total Flights</td>
			</tr>
			
		<%
		int counter=0;
		int arrival_total = 0;
		int dep_total = 0;
		String port_desc = "--";
		
		while(rsMain.next())
		{
			srcPortCode = rsMain.getString("src_port"); 

			port_desc = "--";
			psTemp = con.prepareStatement("select port_desc from im_apis_airports where port_code = '" + srcPortCode +"' ");
			rsTemp = psTemp.executeQuery();

			port_desc = "--"; error_bgColour = "--";
			if(rsTemp.next()) {port_desc = rsTemp.getString(1);} rsTemp.close(); psTemp.close();
				
			if(port_desc.equals("--")) error_bgColour = "#ffb3b8";

			airportCount2 = rsMain.getString("airport_arr_count");
			arrival_total = arrival_total + Integer.parseInt(airportCount2);/////////
			total_Arr_Airport = Integer.parseInt(airportCount2);

			%>	<tr style="font-size: 13px;">
				<td align= "center" <%if (error_bgColour.equals("--")) {%> bgcolor="#1192e8" <%} else{%> bgcolor = "#ffb3b8"<%}%>><%=++counter%></td>
				<td align= "left" <%if (error_bgColour.equals("--")) {%> bgcolor="#33b1ff" <%} else{%> bgcolor = "#ffb3b8"<%}%>>&nbsp;&nbsp;(<%=srcPortCode%>) <%=port_desc%></td>

				<td align= "right" <%if (error_bgColour.equals("--")) {%> bgcolor="#82cfff" <%} else{%> bgcolor = "#ffb3b8"<%}%>><a style="text-decoration:none;color:blue; font-weight: bold;" href="javascript:void(0);" onclick="myFunction('arrival_country','<%=srcPortCode%>')"><%=airportCount2%></a></td>

			<%		


			//select DEST_PORT_CODE as dest_port, count(1) as airport_dep_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and DEST_PORT_CODE = 'JED' group by DEST_PORT_CODE order by 2 desc

			select_Dep_AirportTotal = "select DEST_PORT_CODE as dest_port, count(1) as airport_dep_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and DEST_PORT_CODE = '" + srcPortCode + "' group by DEST_PORT_CODE order by 2 desc";
			//out.println("select_Dep_AirportTotal"+ select_Dep_AirportTotal);
			psTemp = con.prepareStatement(select_Dep_AirportTotal);
			rsTemp = psTemp.executeQuery();

			sum_Arr_Dep_Airport = total_Arr_Airport;
			if(rsTemp.next()) 
			{

				airportCount3 = rsTemp.getString("airport_dep_count")== null ? "" :rsTemp.getString("airport_dep_count");
				dep_total = dep_total+ Integer.parseInt(airportCount3);////////
				sum_Arr_Dep_Airport = sum_Arr_Dep_Airport + Integer.parseInt(airportCount3);

				%>
				<td align="right"  <%if (error_bgColour.equals("--")) {%> bgcolor="#bae6ff" <%} else{%> bgcolor = "#ffb3b8"<%}%>><a style="text-decoration:none;color:blue;font-weight:bold ;" href="javascript:void(0);" onclick="myFunction('departure_country','<%=srcPortCode%>')"><%=airportCount3%></a></td>
				<td align="right"  <%if (error_bgColour.equals("--")) {%> bgcolor="#e5f6ff" <%} else{%> bgcolor = "#ffb3b8"<%}%> style="font-weight: bold;"><%=sum_Arr_Dep_Airport%></td>					
				<%	
			} 
			else
			{
				%><td align="center" <%if (error_bgColour.equals("--")) {%> bgcolor="#bae6ff" <%} else{%> bgcolor = "#ffb3b8"<%}%>>&nbsp</td>
				  <td align="right" <%if (error_bgColour.equals("--")) {%> bgcolor="#e5f6ff"  <%} else{%> bgcolor = "#ffb3b8"<%}%>style="font-weight: bold;"><%=sum_Arr_Dep_Airport%></td><%	
			}	
			%></tr><%	
			rsTemp.close();
			psTemp.close();
		}
		if(counter == 0)
			{
				%>
				<tr  style="background-color: #e5f6ff; font-family: Verdana; font-size: 25px; color:#a2191f;font-weight: bold;">
					<td colspan="7" align="center"><br><br><p>!!! Your search returns no result !!!<br><br><br><br><p></td>	
				</tr>
				
				<%
			}
			rsMain.close();
			psMain.close();



									///////////////////////////////////////////////////////////////////////////////////////////							
			try{

				String filter_port_code = "";
				if(!port_code.equals("")) filter_port_code = " and dest_port_code = '" + port_code + "'" ;

					

				select_Arr_CarrierTotal = "select DEST_PORT_CODE as dest_port, count(1) as airport_arr_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND'  " + filter_port_code + " and DEST_PORT_CODE in (select DEST_PORT_CODE as dest_port from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by DEST_PORT_CODE minus select SRC_PORT_CODE as src_port from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_PORT_CODE) group by DEST_PORT_CODE order by 2 desc";

				
				psTemp = con.prepareStatement(select_Arr_CarrierTotal);
				rsTemp = psTemp.executeQuery(); 

				
				carrierCount5 = 0;
				while(rsTemp.next())
				{
					srcPortCode2 = rsTemp.getString("dest_port");
					port_desc = "--";
					psTemp = con.prepareStatement("select port_desc from im_apis_airports where port_code = '" + srcPortCode2 +"' ");
					
					rsMain = psTemp.executeQuery();

					port_desc = "--"; error_bgColour = "--";
					if(rsMain.next()) {port_desc = rsMain.getString(1);} rsMain.close();
						
					if(port_desc.equals("--")) error_bgColour = "#ffb3b8";

					
						
					airportCount4 = rsTemp.getString("airport_arr_count");
					dep_total = dep_total+Integer.parseInt(airportCount4);

					%>	<tr><td align= "center" bgcolor="#1192e8"><%=++counter%></td>
						<td align= "left" <%if (error_bgColour.equals("--")) {%> bgcolor="#33b1ff" <%} else{%> bgcolor = "#ffb3b8"<%}%>>&nbsp;&nbsp;<%=port_desc%> (<%=srcPortCode2%>)</td>
								
							<td align= "center" <%if (error_bgColour.equals("--")) {%> bgcolor="#82cfff" <%} else{%> bgcolor = "#ffb3b8"<%}%>>&nbsp;</td>
							<td align= "right" <%if (error_bgColour.equals("--")) {%> bgcolor="#bae6ff" <%} else{%> bgcolor = "#ffb3b8"<%}%> ><a style="text-decoration:none;color:blue;font-weight:bold ;" href="javascript:void(0);" onclick="myFunction('departure_country','<%=srcPortCode2%>')"><%=airportCount4%></a></td>
							<td align="right" <%if (error_bgColour.equals("--")) {%> bgcolor="#e5f6ff" <%} else{%> bgcolor = "#ffb3b8"<%}%> style="font-weight: bold;"><%=airportCount4%></td>
						</tr>
					<%	
				}
										
			} 
			catch(Exception e){
				e.printStackTrace();
			}

			%>
			<tr  style="background-color: #0072c3; font-family: Verdana; font-size: 15px; color:white;font-weight: bold;">
						<td colspan="2" align="center">Total</td>
						<td align="right"><%=arrival_total%></td>
						<td align="right"><%=dep_total%></td>
						<td align="right"><%=arrival_total+dep_total%></td>
			</tr>
		</table><br><p><%
		}
		catch(Exception e){
			e.printStackTrace();
		}
finally
	{
		try
		{
			if(con != null)
			{
				con.close();
			}
			if(ctx != null)
			{
				ctx.close();
			}
		}
		catch(Exception e)
		{
			//out.println(e.getMessage());
		}
	}		
						
							
%>
</body>

</html>