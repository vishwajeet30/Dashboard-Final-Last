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

	<!--http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_00.jsp-->
	
</head>
<script>

	function myFunction(tagname,carrier_code_link) 
	{
		
		if(tagname == 'arrival_carrier')
		{
			window.open("http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_01_arr.jsp?tagname="+tagname+"&from_carrier_pg=Y&flight_number="+carrier_code_link,'_blank', '0.80');

		}
		if(tagname == 'departure_carrier')
		{
			//modelWindow_download("im_flight_routes_dashboard_02_dep.jsp?tagname="+tagname,'_blank', '0.80');
			window.open("http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_02_dep.jsp?tagname="+tagname+"&from_carrier_pg=Y&flight_number="+carrier_code_link,'_blank', '0.80');
		}	
	}

	function reset_Values() {
		document.carrier_form.text_Input.value = "";
		document.carrier_form.carrier_Input.value = "";	
		document.carrier_form.action = "im_flight_routes_dashboard_08_carrier.jsp";
		document.carrier_form.submit();
	
	}
	function closeWindow() 
	{  
  		window.close();  
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
<% String heading = "Carrier-wise Arrival and Departure Flight Count"; %>
<br>
<div id="loading" name="loading/" style="background-color: #f5f9ff; ">
	<br><br>
	<br><br><CENTER><font face="verdana" color="blue" size="3"><b><%=heading%></b></font></CENTER><br>
	<CENTER><IMG SRC="loading5.gif" HSPACE="0" VSPACE="0" BORDER="0" NAME="ProgBar" ALT="Generating Results, Please Wait...">
	</CENTER><BR><BR><br>
	<CENTER><font face="verdana" color="DarkGreen"><H2 ><i>Generating Results, Please Wait......</i></H2></font></CENTER><br><br>
</div>
			
		<h1 style="font-family: Arial;background-color: #D0DDEA; color: #347FAA; font-size: 40px;"><center>Carrier-wise Arrival and Departure Flight Count</center></h1><br><br>

		<!--http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_08_carrier.jsp-->

		<%

		String carrier_code = request.getParameter("carrier_Input") == null ? "" : request.getParameter("carrier_Input");


	Context ctx = null;
	Connection con = null;

	ctx = new InitialContext();
	Context envCtx = (Context)ctx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/im_pax_flights");
	con = ds.getConnection();

		PreparedStatement ps = null;
		PreparedStatement psTemp = null;
		
		ResultSet rs = null;
		ResultSet rsTemp = null;
		
		%>

	<form action="" method="post" name="carrier_form">
	<table align="center" width="100%" border="0" cellspacing="0" cellpadding="2" bordercolorlight="#FF99CC" 
		bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #067c94; font-family: verdana;font-size: 10pt; font-weight: bold;color:white;">
		<tr>
		
			<td colspan="2" align="center">
				Filter by Carrier
       			<input type="text" style="color:white;font-weight:bold;height: 22px;font-size=12pt; background-color: #007d79;text-transform:uppercase;font-family:Verdana" size="3" maxlength="10" name="text_Input" onkeyup="filtery(this.value,this.form.carrier_Input)" onchange="filtery(this.value,this.form.carrier_Input)" onKeyDown="if(event.keyCode==13) event.keyCode=9;if (event.keyCode==8) event.keyCode=37+46;" onKeyPress="return letternumber(event, '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')">

				<select name="carrier_Input" style="width:400px;font-family: courier;font-size: 14px;color: blue; font-weight:bold;" onKeyDown="if(event.keyCode==13) event.keyCode=9;">
           		<option value="" selected>Select</option>
           	    <%

				 try
				{				 


				 psTemp = con.prepareStatement("select carrier_code as flight_carriers_Arr, carrier_code || ' - ' || carrier_desc as c_carrier_code from im_apis_carrier_code order by carrier_code");
	             rsTemp = psTemp.executeQuery(); 
				 while(rsTemp.next())
				 {				
					%>
				 <option value="<%=rsTemp.getString("flight_carriers_Arr")%>"  <%if(carrier_code.equals(rsTemp.getString("flight_carriers_Arr"))){%> selected <%}%> ><%=rsTemp.getString("c_carrier_code")%></option>
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

				  <button type="reset" value="reset" onclick="reset_Values();" style="background-color: #004144;color: white;font-weight: bold; font-size: 14px; border: none;padding: 10px 20px;
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
			
		//////////////////////////////////////////////////////	 Carriers Arr Dep List Table - Start  //////////////////////////////////////////////////////////////


String selectCarrier = "";
String carriers = "";
String carriersCount = "";
int carrierFlightCount = 0;
int total_Carrier_Arr_Count = 0;
int total_carrierFlightCount = 0;
int sum_Arr_Dep = 0;
int total_Arr_Carrier = 0;
int total_Final = 0;
String carrier_Arr = "";
String selectCarrierDep = "";
String carrier_Arr_Count = "";
String carrier_Dep = "";
String carrier_Dep_Count = "";
String bgcolor="e8daff";
String QueryCount = "";
String CountQuery = "";
String QueryCount2 = "";
String CountQuery2 = "";
int sum_Carriers_Record = 0;
int count1 = 0;
int count2 = 0;
int query1 = 0;
int query2 = 0;
StringBuilder selectCarrierArr = new StringBuilder("");
String lblQuery = "";

try{
selectCarrierArr.append("select substr(flight_no,1,2) as flight_carriers_Arr1, count(1) as ca_Arr_Count from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' ");

	////Arrival	
  if(!carrier_code.equals(""))
{
	selectCarrierArr.append(" and substr(flight_no,1,2) = '"+carrier_code+"'");
	lblQuery = lblQuery + "Carrier Code = " + carrier_code.toUpperCase();
}	
	selectCarrierArr.append(" group by substr(flight_no,1,2) ");
	selectCarrierArr.append(" order by 2 desc");
	//out.println(selectCarrierArr.toString());
	lblQuery = "You queried for :  " + lblQuery;
	if(lblQuery.equals("You queried for :  ")) lblQuery = "";
%><h3 style="font-family: Arial; color: #fa4d56; text-align: left;font-size: 12pt; background-color: #d0e2ff;"><%=lblQuery%></h3><%

		ps = con.prepareStatement(selectCarrierArr.toString());		

	try
		{
			CountQuery = "select count(1) from (" + selectCarrierArr.toString() + ")"; //out.println("<br>" + CountQuery);
			psTemp = con.prepareStatement(CountQuery);
			rsTemp = psTemp.executeQuery(); 
			if(rsTemp.next())
				{
					QueryCount = rsTemp.getString(1);
				}
				rsTemp.close();
									
				//out.println("      Your Query yields " + QueryCount + " Records");
				count1 = Integer.parseInt(QueryCount);
		}
		catch(Exception e)
		{
			out.println(e);
		}

		try
		{
			CountQuery2 = "select count(1) from (select substr(flight_no,1,2) as flight_carriers, count(1) as ca_dep_new_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and substr(flight_no,1,2) in (select substr(flight_no,1,2) as flight_carriers from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by substr(flight_no,1,2) minus select substr(flight_no,1,2) as flight_carriers from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by substr(flight_no,1,2)) group by substr(flight_no,1,2) order by 2 desc)"; 
			psTemp = con.prepareStatement(CountQuery2);
			rsTemp = psTemp.executeQuery(); 
			if(rsTemp.next())
				{
					QueryCount2 = rsTemp.getString(1);
				}
				rsTemp.close();
				psTemp.close();						
				//out.println("      Your Query yields " + QueryCount + " Records");
				count2 = Integer.parseInt(QueryCount2);
				sum_Carriers_Record = count1+count2;

			
		}
		catch(Exception e)
		{
			out.println(e);
		}

		 rs = ps.executeQuery(selectCarrierArr.toString());

	%><table align="center" width="100%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#FF99CC" bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;text-align: left; border-color:#e5f6ff;">
		<tr style=" background-color: #f6f2ff;font-family: Verdana; font-size: 10px; color:darkgreen;font-weight: bold;">
			<td align="right" colspan="5">Your Query yields <%=sum_Carriers_Record%> Record(s)</td>
		</tr>

		<tr style=" background-color: #8a3ffc;font-family: Verdana; font-size: 15px; color:white;font-weight: bold;">
			<td align="center">S.No.</td>
			<td align="left">&nbsp;Carrier</td>
			<td align="right">Arrival Flights</td>
			<td align="right">Departure Flights</td>
			<td align="right">Total Flights</td>			
		</tr>
	<%		int counter=0;
			int counter_T = 0;
			int innerCount = 0;
			String carrier_desc = "--";

	while(rs.next())
	{

				if(counter%2 == 0) bgcolor = "#d4bbff";
					else bgcolor = "#f6f2ff";

			carrier_Arr = rs.getString("flight_carriers_Arr1");

			carrier_desc = "--";
			psTemp = con.prepareStatement("select carrier_desc from im_apis_carrier_code where carrier_code = '" + carrier_Arr +"' ");
			rsTemp = psTemp.executeQuery();
			if(rsTemp.next()) {carrier_desc = rsTemp.getString(1);}	rsTemp.close();								
					
				
				if(carrier_desc.equals("--")) bgcolor = "#ffb3b8";

			carrier_Arr_Count = rs.getString("ca_Arr_Count");
			total_Carrier_Arr_Count = total_Carrier_Arr_Count + Integer.parseInt(carrier_Arr_Count);
			total_Arr_Carrier =  Integer.parseInt(carrier_Arr_Count);

			%>
			<tr style="font-family: Verdana; font-size: 15px; color:black;font-weight: normal; background-color: <%=bgcolor%>;">
					<td><center><%=++counter%></center></td>
					<td align= "left" bgcolor="<%=bgcolor%>">&nbsp;&nbsp;<%=carrier_desc%> (<%=carrier_Arr%>)</td>
					<td align="right"><a style="text-decoration:none;color:blue; font-weight: bold;" href="javascript:void(0);" onclick="myFunction('arrival_carrier','<%=carrier_Arr%>')"><%=carrier_Arr_Count%></td>
					
			<%
				try{

				selectCarrierDep ="select substr(flight_no,1,2) as flight_Carriers_Dep, count(1) as ca_Dep_Count from IM_FLIGHT_ROUTES where substr(flight_no,1,2) = '" + carrier_Arr + "' and SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by substr(flight_no,1,2) order by 2 desc";

				

					////Departure
				psTemp = con.prepareStatement(selectCarrierDep);
				rsTemp = psTemp.executeQuery();

				sum_Arr_Dep = total_Arr_Carrier;

				if(rsTemp.next())
				{
					
					carrier_Dep_Count = rsTemp.getString("ca_Dep_Count")== null ? "" :rsTemp.getString("ca_Dep_Count");
					total_carrierFlightCount = total_carrierFlightCount + Integer.parseInt(carrier_Dep_Count);
					//if(!carrier_Dep_Count.equals(""))
					sum_Arr_Dep = sum_Arr_Dep + Integer.parseInt(carrier_Dep_Count);	


				%>	<td align="right"><a style="text-decoration:none;color:blue; font-weight: bold;" href="javascript:void(0);" onclick="myFunction('departure_carrier','<%=carrier_Arr%>')"><%=carrier_Dep_Count%></td>
					<td align="right" style="font-weight: bold;"><%=sum_Arr_Dep%></td>
					</tr><%

				}else{
						%><td align="center" background-color: <%=bgcolor%> >&nbsp</td>
						<td align="right" style="font-weight:bold;"><%=sum_Arr_Dep%></td>
						</tr><%

						}
						
					rsTemp.close();
					psTemp.close();

						}catch(Exception e){
							out.println(e);
							}
		}
		
				rs.close();
				ps.close();					
		
/////////////////////////////////////////////////////////////////
		ResultSet rsTemp1 = null;
		PreparedStatement psTemp1 = null;

		try{		
				String filter_carrier = "";
						if(!carrier_code.equals("")) filter_carrier = " and substr(flight_no, 1, 2) = '" + carrier_code + "'" ;	
			selectCarrier = "select substr(flight_no,1,2) as flight_carriers, count(1) as ca_dep_new_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' " + filter_carrier + " and substr(flight_no,1,2) in (select substr(flight_no,1,2) as flight_carriers from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by substr(flight_no,1,2) minus select substr(flight_no,1,2) as flight_carriers from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by substr(flight_no,1,2)) group by substr(flight_no,1,2) order by 2 desc";

				psTemp1 = con.prepareStatement(selectCarrier);
				rsTemp1 = psTemp1.executeQuery();

				//ResultSet rsTemp = null;
				carrierFlightCount = 0;

				while(rsTemp1.next())
				{
				
					
					if(counter%2 == 0) bgcolor="#d4bbff";
					else bgcolor = "#f6f2ff";

					carriers=rsTemp1.getString("flight_carriers");

					carrier_desc = "--";
					psTemp = con.prepareStatement("select carrier_desc from im_apis_carrier_code where carrier_code = '" + carriers +"' ");
					rsTemp = psTemp.executeQuery();
					if(rsTemp.next()) {
						carrier_desc = rsTemp.getString(1);
						
						}									
						rsTemp.close();
						psTemp.close();
						
						if(carrier_desc.equals("--")) bgcolor = "#ffb3b8";

					carriersCount=rsTemp1.getString("ca_dep_new_count")== null ? "" :rsTemp1.getString("ca_dep_new_count");
					total_carrierFlightCount = total_carrierFlightCount + Integer.parseInt(carriersCount);

					
					%><tr  style="font-family: Verdana; font-size: 15px; color:black;font-weight: normal; background-color: <%=bgcolor%>;">	
							<td align="center" ><%=++counter%></td>
							<td align="left" ><%=carrier_desc%> (<%=carriers%>)</td>
							<td align= "center" >&nbsp;</td>
							<td align="right" ><a style="text-decoration:none;color:blue; font-weight: bold;" href="javascript:void(0);" onclick="myFunction('departure_carrier','<%=carrier_Arr%>')"><%=carriersCount%></td>
							<td align="right" style="font-weight:bold;"><%=carriersCount%></td>
							
						</tr>
						
						<%
				}
				if(counter == 0)
				{
					%>
					<tr  style="background-color: #e5f6ff; font-family: Verdana; font-size: 25px; color:#a2191f;font-weight: bold;">
						<td colspan="7" align="center"><br><br><p>!!! Your search returns no result !!!<br><br><br><br><p></td>	
					</tr>
					<%
				}						
				%>											
				<tr style="font-family: Verdana; font-size: 12pt; color:white;font-weight: bold">
					<td bgcolor="#a56eff" colspan="2" ><center>Total</center></td>
					<td bgcolor="#a56eff" align="right"><%=total_Carrier_Arr_Count%>&nbsp;&nbsp;&nbsp;</td>
					<td bgcolor="#a56eff" align="right"><%=total_carrierFlightCount%>&nbsp;&nbsp;&nbsp;</td>
					<td bgcolor="#a56eff" align="right"><%=total_Carrier_Arr_Count+total_carrierFlightCount%>&nbsp;&nbsp;&nbsp;</td>
				</tr>
			</table><br><p><p>
					<%
			}
			catch (Exception e){
				e.printStackTrace();
			}
			%></table><br><p><p><%
		}	
	catch(Exception e)
	{
		out.println("Carrier list Arr Dep table Exception");
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

				/////////////////////////////////////////////			Carriers Arr Dep List Table - End		////////////////////////////////////////////////////	
							psTemp.close();
							
														
							%>
</form>
</body>

</html>