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
</head>
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
<% String heading = "International Flights not from India"; %>
<br>
<div id="loading" name="loading/" style="background-color: #f5f9ff; ">
	<br><br>
	<br><br><CENTER><font face="verdana" color="blue" size="3"><b><%=heading%></b></font></CENTER><br>
	<CENTER><IMG SRC="loading5.gif" HSPACE="0" VSPACE="0" BORDER="0" NAME="ProgBar" ALT="Generating Results, Please Wait...">
	</CENTER><BR><BR><br>
	<CENTER><font face="verdana" color="DarkGreen"><H2 ><i>Generating Results, Please Wait......</i></H2></font></CENTER><br><br>
</div>
			
	<h1 style="font-family: Arial;background-color: #D0DDEA; color: #347FAA; "><center>Hopping Flights Arriving to India</center></h1><br><br>

	<!--http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_03.jsp-->
	
	<%
	//////////////////////////////////////////////////////////////
	Context ctx = null;
	Connection con = null;

	ctx = new InitialContext();
	Context envCtx = (Context)ctx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/im_pax_flights");
	con = ds.getConnection();

	PreparedStatement psMain = null;
	PreparedStatement psTemp = null;

	ResultSet rsTemp = null;
	ResultSet rsMain = null;

	String selectQuery = "";
	String hopPort1 = "";
	String hopPort2 = "";
	String hopPortDep2 = "";
	String hopPortDep1 = "";
	String flightNumber1 = "";String  sourcePort1 = "" ;String  destinationPort1 = "" ;String sourceCountryCode1 = "";String  destinationCountryCode1 = "";
	String flightNumber2 = "";String  sourcePort2 = "" ;String  destinationPort2 = "" ;String sourceCountryCode2 = "";
	String destinationCountryCode2 = "";
	String dep_flt_no = "";			
	String selectSummary = "";
	String total_Flights_By_Digits = "";
	String bothIndiaFlights = "";
	int arr_dep_matched_flts = 0;
	int arr_dep_not_matched_flts = 0;
	int arr_dep_not_defined_matched_flts = 0;
	String totalflights= ""; String arrflights = ""; String depflights = ""; String neitherFlights = "";

	String sourcePortDesc1 = "";
	String destPortDesc1 = "";
	String sourceCountryDesc1 = "";
	String destCountryDesc1 = "";

	String sourcePortDesc2 = "";
	String destPortDesc2 = "";
	String sourceCountryDesc2 = "";
	String destCountryDesc2 = "";

	String hopPort1Desc = "";
	String hopPort2Desc = "";

	String hopPort1_Desc = "";
	String hopPort2_Desc = "";


	////////////////////////////////////////////////////// 	  Arrival Departure Main Table 		//////////////////////////////////////////////////////

				try{

				selectQuery = "SELECT * FROM IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' and (HOP1_PORT_CODE is not null or HOP2_PORT_CODE is not null) /*and flight_no like '3L%' */order by FLIGHT_NO";
				psMain = con.prepareStatement(selectQuery);
				
				
				rsMain = psMain.executeQuery();  
					
					%>
					<table align="center" width="100%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#FF99CC" 
					bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">
						<tr style=" background-color: #78a9ff;font-family: Verdana; font-size: 15px; color:white;font-weight: bold;">
							<td rowspan="2" align="center" bgcolor="#0072c3"><center>S.No.</center></td>
							<td colspan="5" bgcolor="#750e13"><center>Arrival Flights</center></td>
							<td colspan="5" bgcolor="#004144"><center>Departure Flights</center></td>
						</tr>
						<tr style=" background-color: #E6E6EA;font-family: Verdana; font-size: 15px; color:white;font-weight: bold;">
							
							<th align="center" bgcolor="#a2191f">Flight No.</th>
							<th align="center" bgcolor="#a2191f">Source Port</th>
							<th align="center" bgcolor="#a2191f">Hop Port 1</th>
							<th align="center" bgcolor="#a2191f">Hop Port 2</th>
							<th align="center" bgcolor="#a2191f">Destination Port</th>
							<th align="center" bgcolor="#005d5d">Flight No.</th>
							<th align="center" bgcolor="#005d5d">Source Port</th>
							<th align="center" bgcolor="#005d5d">Hop Port 1</th>
							<th align="center" bgcolor="#005d5d">Hop Port 2</th>
							<th align="center" bgcolor="#005d5d">Destination Port</th>
						</tr>
					<%
				int counter=0;
				arr_dep_matched_flts = 0;
				arr_dep_not_matched_flts = 0;
				arr_dep_not_defined_matched_flts=0;
				while(rsMain.next())
				{
						
					flightNumber1 = rsMain.getString("FLIGHT_NO");
					sourcePort1 = rsMain.getString("SRC_PORT_CODE");
					destinationPort1 = rsMain.getString("DEST_PORT_CODE");
					sourceCountryCode1 = rsMain.getString("SRC_COUNTRY_CODE");
					hopPort1 = rsMain.getString("HOP1_PORT_CODE")== null ? "": rsMain.getString("HOP1_PORT_CODE");
					hopPort2 = rsMain.getString("HOP2_PORT_CODE")== null ? "":rsMain.getString("HOP1_PORT_CODE");
					destinationCountryCode1 = rsMain.getString("DEST_COUNTRY_CODE");
					//out.println("While 1");
					sourcePortDesc1 = rsMain.getString("SRC_PORT_DESC");
					sourceCountryDesc1 = rsMain.getString("SRC_COUNTRY_DESC");
					destPortDesc1 = rsMain.getString("DEST_PORT_DESC");
					destCountryDesc1 = rsMain.getString("DEST_COUNTRY_DESC");
					hopPort1Desc = rsMain.getString("HOP1_PORT_DESC");
					hopPort2Desc = rsMain.getString("HOP2_PORT_DESC");

						%>	<tr>
							<td align= "center" bgcolor="#82cfff"><%=++counter%></td>
							<td align= "center" bgcolor="#da1e28"><%=flightNumber1%></td>
							<td align= "center" bgcolor="#fa4d56"><%=sourcePort1%> (<%=sourceCountryCode1%>) - <%=sourcePortDesc1%> (<%=sourceCountryDesc1%>)</td>
							<td align="center" bgcolor="#ff8389"><%=hopPort1%> (<%=destPortDesc1%>)</td>
							<td align="center" bgcolor="#ffb3b8"><%=hopPort2%> (<%=hopPort2Desc%>)</td>
							<td align= "center" bgcolor="#ffd7d9"><%=destinationPort1%> (<%=destinationCountryCode1%>) - <%=destPortDesc1%> (<%=destCountryDesc1%>)</td>								
						<%							
						
						String selectRevQuery = "";	

						//out.println("selectRevQuery11");
						//if(flightNumber1.contains("-") && flightNumber1.split("-")[1].contains("[0-9]+"))
						if(flightNumber1.contains("-"))
							if(!flightNumber1.split("-")[1].matches("[0-9]+"))
								{	
								
								%><td align= "center">##</td>
								  <td align= "center">##</td>
									<td align= "center">##</td>
								</tr>
								<%
									++arr_dep_not_defined_matched_flts;
									continue;
								}

						if(flightNumber1.length() == 6)
							dep_flt_no = flightNumber1.substring(0,3) + String.valueOf(Integer.parseInt(flightNumber1.substring(3,6)) + 1);
						else if(flightNumber1.length() == 7)
							dep_flt_no = flightNumber1.substring(0,3) + String.valueOf(Integer.parseInt(flightNumber1.substring(3,7)) + 1);
						else
							dep_flt_no = "Error";

						//out.println(flightNumber1 + "    " + dep_flt_no + "<BR>");


	/*Note*/						selectRevQuery = "SELECT * FROM IM_FLIGHT_ROUTES WHERE FLIGHT_NO = '" + dep_flt_no + "' and SRC_COUNTRY_CODE ='IND'";
						//out.println("selectRevQuery22 Done");
						
						
						psTemp = con.prepareStatement(selectRevQuery);
						
						
						rsTemp = psTemp.executeQuery();
						//out.println("selectRevQuery");

						if(rsTemp.next())  
						{
							++arr_dep_matched_flts;
										
							flightNumber2 = rsTemp.getString("FLIGHT_NO") == null ? "" : rsTemp.getString("FLIGHT_NO");
							destinationPort2 = rsTemp.getString("DEST_PORT_CODE") == null ? "" : rsTemp.getString("DEST_PORT_CODE");
							sourcePort2 = rsTemp.getString("SRC_PORT_CODE")== null ? "" : rsTemp.getString("SRC_PORT_CODE");
							sourceCountryCode2 = rsTemp.getString("SRC_COUNTRY_CODE")== null ? "" : rsTemp.getString("SRC_COUNTRY_CODE");
							hopPortDep1 = rsTemp.getString("HOP1_PORT_CODE")== null ? "":rsTemp.getString("HOP1_PORT_CODE");
							hopPortDep2 = rsTemp.getString("HOP2_PORT_CODE")== null ? "":rsTemp.getString("HOP2_PORT_CODE");
							destinationCountryCode2 = rsTemp.getString("DEST_COUNTRY_CODE")== null ? "" : rsTemp.getString("DEST_COUNTRY_CODE");
							//out.println("While 2");
							sourcePortDesc2 = rsTemp.getString("SRC_PORT_DESC");
							sourceCountryDesc2 = rsTemp.getString("SRC_COUNTRY_DESC");
							destPortDesc2 = rsTemp.getString("DEST_PORT_DESC");
							destCountryDesc2 = rsTemp.getString("DEST_COUNTRY_DESC");
							hopPort1_Desc = rsMain.getString("HOP1_PORT_DESC");
							hopPort2_Desc = rsMain.getString("HOP2_PORT_DESC");

							%>	
							<td align= "center" bgcolor="#007d79"><%=flightNumber2%></td>
							<td align= "center" bgcolor="#009d9a"><%=sourcePort2%> (<%=sourceCountryCode2%>) - <%=sourcePortDesc2%> (<%=sourceCountryDesc2%>)</td>
							<td align="center" bgcolor="#08bdba"><%=hopPort1%> (<%=hopPort1_Desc%>)</td>
							<td align="center" bgcolor="#3ddbd9"><%=hopPort2%> (<%=hopPort2_Desc%>)</td>
							<td align= "center" bgcolor="#9ef0f0"><%=destinationPort2%> (<%=destinationCountryCode2%>) - <%=destPortDesc2%> (<%=destCountryDesc2%>)</td>
							</tr>
							<%
						}
						else
							{
							  ++arr_dep_not_matched_flts;

								%>	
								<td align= "center" bgcolor="#007d79">&nbsp;</td>
								<td align= "center" bgcolor="#009d9a">&nbsp;</td>
								<td align= "center" bgcolor="#08bdba">&nbsp;</td>
								<td align= "center" bgcolor="#3ddbd9">&nbsp;</td>
								<td align= "center" bgcolor="#9ef0f0">&nbsp;</td>
								</tr>
								<%
							}
							if(rsTemp!=null)
								{		
									rsTemp.close();
									psTemp.close();
								}
						
					}
				}
				catch(Exception e){
					System.out.println("Main Table Exception");
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
					

///////////////////////////////////////////////////////////////////////////////////////////////////////////////						
					%>
					<tr style=" background-color: #78a9ff;font-family: Verdana; font-size: 12px; color:white;font-weight: bold;">			
					<td colspan="11" bgcolor="#a2191f"><center>End Of Report</center></td>
					</tr>
				</table><br><p>

				<table align="center" width="70%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#FF99CC" bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">
					<tr style=" background-color: #E6E6EA;font-family: Verdana; font-size: 15px; color:white;font-weight: bold;">
						<td bgcolor="#df979e"><center>Matching Arrival and Departure</font></center></td>
						<td bgcolor="#d7658b"><center>Matching Departure not available</center></td>
						<td bgcolor="#c80064"><center>Not Defined Arrival and Departure</center></td>
					</tr>

					<tr style="font-family: Verdana; font-size: 10pt; color:white;font-weight: bold">
						<td bgcolor="#df979e"><center><%=arr_dep_matched_flts%></center></td>
						<td bgcolor="#d7658b"><center><%=arr_dep_not_matched_flts%></center></td>
						<td bgcolor="#c80064"><center><%=arr_dep_not_defined_matched_flts%></center></td>
					</tr>
				</table><br><p><p>	
		
</body>

</html>