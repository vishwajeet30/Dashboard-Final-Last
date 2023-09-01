<%@ page language = 'java' import = 'java.sql.*, java.io.*, java.awt.*, java.text.*, javax.naming.*, javax.sql.*'%>
<%!
boolean isUrl_exist(String file_name)
{
	InputStream reader = null;	
	boolean  vMRZImagesCount = false;
	try
	{	
		String values [] = file_name.split("-");
		if(values [1].length() < 3)
		{
			if(values [1].length() == 1) values [1] = "00" + values [1].trim();
			if(values [1].length() == 2) values [1] = "0" + values [1].trim();
			file_name = values [0].trim() + "-" + values [1].trim();

		}
		java.net.URL url = new java.net.URL("http://172.16.1.59:8888/Imm/apis_manifest/international_flights_jpeg/" + file_name + ".jpg"); 
		//System.out.println(path_others + "/" + other_doc);
		url.openConnection(); 
		reader = url.openStream();
		vMRZImagesCount = true;
		reader.close();
	}
	catch(Exception e)
	{
		if(reader != null) reader.close();
		vMRZImagesCount = false;
	}
	finally
	{
		return vMRZImagesCount;
	}
	

}
%>
<html><head><title>Flight Routes</title>
<style type="text/css">
	BODY{background:url("bluecheck.gif"); background-repeat:repeat;}
</style>
<style type="text/css">
/* ------------- CSS Popup Image ------------- */
#thumbwrap {
width:252px;
height:252px;
}
.thumb {
float:left; /* must be floated for same cross browser position of larger image */
position:relative;
margin:3px;
}
.thumb img {
border:1px solid #000;
vertical-align:bottom;
}
.thumb:hover {
border:0; /* IE6 needs this to show large image */
z-index:1;
}
.thumb span {
position:absolute;
visibility:hidden;
}
.thumb:hover span {
visibility:visible;
top:37px;
left:37px;
}
</style> 
<script>
var prev_image = "";
	function image2(str, id_Image) 
	{
		var values = str.split("-");
		if(values[1].length < 3)
		{
			if(values[1].length == 1)
				values[1] = "00" + values[1];
			if(values[1].length == 2)
				values[1] = "0" + values[1];
			str = values[0] + "-" + values[1];
		}

		if(prev_image != "")	{document.getElementById(prev_image).src = '';	document.getElementById(prev_image).alt='';}
		prev_image = id_Image;
		//alert('http://172.16.1.59:8888/Imm/apis_manifest/international_flights_jpeg/'+str+ '.jpg');
		///usr/local/tomcat/webapps/Imm/misc_functionality_help/international_flights_jpeg
		//http://172.16.1.59:8888/Imm/apis_manifest/im_apis_status_html.jsp
		document.getElementById(id_Image).src='http://172.16.1.59:8888/Imm/apis_manifest/international_flights_jpeg/'+str+ '.jpg';
		document.getElementById(id_Image).alt='<BR>http://172.16.1.59:8888/Imm/apis_manifest/international_flights_jpeg/'+str+ '.jpg';
		prev_image = id_Image;
	}
	function back_win()
	{
		document.flightroutedetails.target="_top";
		document.flightroutedetails.action="im_manifest_received_status_report01.jsp";
		document.flightroutedetails.submit();
	}

</script>
</head>
<%
	java.util.ArrayList<String> all_flights =  new java.util.ArrayList<String>();
	String apisDate = request.getParameter("apisDate") == null ? "" : request.getParameter("apisDate");
	String usern1 = (String)session.getAttribute("username"); 
	String systime1 =(String)session.getAttribute("systemTime");
	String icp = (String)session.getAttribute("icpdesc");
	String icptype = (String)session.getAttribute("icptype");
	String icpStatus = request.getParameter("icpstatus");
	String icp_srno = (String)session.getAttribute("icpSrno");
	java.util.Date now = new java.util.Date();
	String dt = DateFormat.getDateInstance(DateFormat.MEDIUM).format(now);
	int yr = 1900 + now.getYear();
	DateFormat sdf = DateFormat.getDateInstance(DateFormat.MEDIUM);
		
	java.util.Date master = sdf.parse(dt);
	sdf = new SimpleDateFormat("dd/MM/yyyy");
	String formattedDate = sdf.format(master);
	Date currentDatetime = new Date(System.currentTimeMillis()); 
	SimpleDateFormat formatter = new SimpleDateFormat("HH:mm"); 
	String systime = formatter.format(currentDatetime); 

	java.util.Date current_Server_Time = new java.util.Date();
	DateFormat vDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	String vServerTime = vDateFormat.format(current_Server_Time);
	DateFormat vFileFormat = new SimpleDateFormat("yyyyMMddHHmmss");
	String vFileName = vFileFormat.format(current_Server_Time);
	
	Context ctx = null;
	ctx = new InitialContext();
	Context envCtx = (Context)ctx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/imreps");
	Connection vConnection = ds.getConnection();

	Statement stmt2 = null;
	Statement stmt = vConnection.createStatement();
	Statement stmt_temp = vConnection.createStatement();
	ResultSet rs = null;
	ResultSet rs1 = null;
	ResultSet rs_temp = null;
	ResultSetMetaData rsmd = null;

	String querry = "SELECT * FROM ((SELECT DISTINCT UPPER(DEST_PORT_DESC) FROM IMIGRATION.IM_ARR_FLIGHT_ROUTES WHERE UPPER(DEST_COUNTRY_DESC) = UPPER('India')) UNION (SELECT DISTINCT UPPER(HOP1_PORT_DESC) FROM IMIGRATION.IM_ARR_FLIGHT_ROUTES WHERE UPPER(HOP1_COUNTRY_DESC) = UPPER('India')) UNION (SELECT DISTINCT UPPER(HOP2_PORT_DESC) FROM IMIGRATION.IM_ARR_FLIGHT_ROUTES WHERE UPPER(HOP2_COUNTRY_DESC) = UPPER('India'))) ORDER BY 1";

	Statement vStatement2 = vConnection.createStatement();
	Statement vStatement3 = vConnection.createStatement();
	ResultSet vResultset2 = null;
	ResultSet vResultset3 = null;

	vResultset2 = vStatement2.executeQuery("SELECT COUNT(1) FROM IMIGRATION.IM_APIS_STATUS_TOTAL WHERE FLIGHT_SCHEDULE_DATE = TO_DATE('" + apisDate + "','DD/MM/YYYY') GROUP BY FLIGHT_SCHEDULE_DATE ORDER BY FLIGHT_SCHEDULE_DATE DESC");
	
	int totalpass = 0;

	if (vResultset2.next())
		totalpass = vResultset2.getInt(1);
	vResultset2.close();
	vStatement2.close();

	rs = stmt.executeQuery(querry);

if(totalpass == 0)
{%>
	<body>
	<h5 align="center"><b><font face="Verdana" color="RED">!!! Your Query Yields No Record !!!</font></b></h5>
<%}

else if(totalpass > 0)
{%>
	<form method="post" name="flightroutedetails">
	
	<TABLE width= "100%" cellpadding="3" cellspacing="3">
		<TR bgcolor="#FFFFCC">
			<TH align="center" colspan="9"><font size="2" face="Verdana" color="GREEN">Arrival/Departure Flight Route Details for Schedule Date <%=apisDate%></font></TH>
		</TR>
		<TR bgcolor="#FFFFCC">
			<TH align="left"><font size="1" face="Verdana" color="BLUE">S.No.&nbsp;&nbsp;</font></TH>
			<TH align="left"><font size="1" face="Verdana" color="BLUE">Destination Port</font></TH>
			<TH align="left"><font size="1" face="Verdana" color="BLUE">S.No.</font></TH>
			<TH align="left"><font size="1" face="Verdana" color="BLUE">Source Country</font></TH>
			<TH align="left"><font size="1" face="Verdana" color="BLUE">Carrier</font></TH>
			<TH align="left"><font size="1" face="Verdana" color="BLUE">Arr Flight</font></TH>
			<TH align="left"><font size="1" face="Verdana" color="BLUE">Arrival Route</font></TH>
			<TH align="left"><font size="1" face="Verdana" color="BLUE">Dep Flight</font></TH>
			<TH align="left"><font size="1" face="Verdana" color="BLUE">Departure Route</font></TH>	
					
		</TR>
<%
		int srno = 0;
		int flight_count = 0;
		String color_port = "";
		while(rs.next())
		{			
			if(srno%2 == 0) color_port = "#FFDDDD";
			else color_port = "#B9EEFF";
%>
			<tr>
			<td valign='top' align='right' bgcolor="<%=color_port%>"><font size="1" face="Verdana" ><B><%=++srno%></B></font></td>
			<td valign='top' bgcolor="<%=color_port%>"><font size="1" face="Verdana"><B><%=(rs.getString(1) == null ? "&nbsp;" : rs.getString(1))%></B></font></td>
<%
			ResultSet rs2 = null;
			stmt2 = vConnection.createStatement();
			String filter_qry2 = " AND A.FLIGHT_NO IN (SELECT DISTINCT FLIGHT_NO FROM IMIGRATION.IM_APIS_STATUS_TOTAL WHERE FLIGHT_SCHEDULE_DATE = TO_DATE('" + apisDate + "', 'DD/MM/YYYY'))";

			rs2 = stmt2.executeQuery("SELECT A.SRC_COUNTRY_DESC, A.CARRIER, A.FLIGHT_NO, A.ROUTE, D.FLIGHT_NO, D.ROUTE FROM IMIGRATION.IM_ARR_FLIGHT_ROUTES A, IMIGRATION.IM_DEP_FLIGHT_ROUTES D WHERE (UPPER(A.DEST_PORT_DESC) = '" + rs.getString(1).toUpperCase() + "' OR UPPER(A.HOP1_PORT_DESC) = '" + rs.getString(1).toUpperCase() + "' OR UPPER(A.HOP2_PORT_DESC) = '" + rs.getString(1).toUpperCase() + "') AND (A.FLIGHT_NO = D.ARR_FLIGHT_NO OR A.FLIGHT_NO = D.FLIGHT_NO) " + filter_qry2 + " ORDER BY A.SRC_COUNTRY_DESC, A.FLIGHT_NO");
			//System.out.println("SELECT A.SRC_COUNTRY_DESC, A.CARRIER, A.FLIGHT_NO, A.ROUTE, D.FLIGHT_NO, D.ROUTE FROM IMIGRATION.IM_ARR_FLIGHT_ROUTES A, IMIGRATION.IM_DEP_FLIGHT_ROUTES D WHERE (UPPER(A.DEST_PORT_DESC) = '" + rs.getString(1).toUpperCase() + "' OR UPPER(A.HOP1_PORT_DESC) = '" + rs.getString(1).toUpperCase() + "' OR UPPER(A.HOP2_PORT_DESC) = '" + rs.getString(1).toUpperCase() + "') AND (A.FLIGHT_NO = D.ARR_FLIGHT_NO OR A.FLIGHT_NO = D.FLIGHT_NO) " + filter_qry2 + " ORDER BY A.SRC_COUNTRY_DESC, A.FLIGHT_NO");

			int srno2 = 0;
			String src_country = "";
			String arr_flight = "";
			String dep_route;
			String str = "";
			String str1 = "";
			String str2 = "";
			
			while(rs2.next())
			{
				flight_count++;
				if(srno2 != 0)
				{

					%>
					<tr>
						<td valign='top'><font size="1" face="Verdana" ><B>&nbsp;</B></font></td>
						<td valign='top'><font size="1" face="Verdana"><B>&nbsp;</B></font></td>
					<%
				}

%>
	
			<td align='right' bgcolor="<%=color_port%>"><font size="1" face="Verdana"><B><%=++srno2%></font></td>
<%
				src_country = rs2.getString(1);
				arr_flight = rs2.getString(3);
				dep_route = rs2.getString(6);

				for(int i = 1; i <= 6; i++)
				{
					if (i == 1 && rs2.getString(i) != null)
					{	
						if(rs2.getString(i).equals(str))
						{
							str1 = "-- do --";
						}
					    else
						{	
							str = rs2.getString(i);
							str1 = str;
						}
					}
					else if (i == 2 && rs2.getString(i) != null && str1 != null)
					{	
						if(rs2.getString(i).equals(str2) && str1.equals("-- do --"))
							str1 = "-- do --";
						else
						{	
							str2 = rs2.getString(i);
							str1 = str2;
						}
					}
					else 
					{
						if(i == 5 && rs2.getString(i) != null && rs2.getString(i).equals(arr_flight))
							str1 = "&nbsp;";
						else
							str1 = rs2.getString(i);
					}
					
					String color_back = "";
					if (src_country != null)
					{
						if (src_country.equals("India"))
							color_back = "#FF9696";
						else if(dep_route == null)
							color_back = "#D8BFD8";
					}
					else
						color_back = "#996666";
%>	
<!--- <div  onclick='image2("${result.filenumber}");' style="cursor: pointer;text-decoration: underline;color: blue">
                    <c:out value="${result.imgname}"/></div> -->
			<td bgcolor="<%=color_back%>">
			<%
				if(i != 5 && i != 3)
				{
			%>
			<font size="1" face="Verdana"><%=(str1 == null ? "&nbsp;" : str1)%>	</font>
			<%
			}
			else
			{
			%>
				<!-- <div id="thumbwrap"> -->
				<a class="thumb" style="text-decoration:none" onmouseover='image2("<%=str1%>", "imag2<%=srno + "-" + srno2 + "-" + i%>");' href="#"><font color="#0000FF" size="1" face="Verdana"><%=str1%></font>
				<span><img id="imag2<%=srno + "-" + srno2 + "-" + i%>"  style="float:left" alt="" src=""></span></a>
				<!-- </div>	 -->	
			<%
					if(!"".equals(str1) && str1 != null && !"&nbsp;".equals(str1))	all_flights.add(str1);
			}
			%>
			</td>
<%
				}
			}
			if(srno2 == 0)
			{
				%>
					<td colspan='6' align="center"><font size="1" face="Verdana" color="red">No Flight</font></td>
				<%
			}
%>

		</tr>

<%
		}

%>
</table>
<br><br>
<%
		String filter_qry = " AND FLIGHT_NO IN (SELECT DISTINCT FLIGHT_NO FROM IMIGRATION.IM_APIS_STATUS_TOTAL WHERE FLIGHT_SCHEDULE_DATE = TO_DATE('" + apisDate + "', 'DD/MM/YYYY'))";
		stmt = vConnection.createStatement();
		rs = stmt.executeQuery("SELECT FLIGHT_NO FROM IMIGRATION.IM_ARR_FLIGHT_ROUTES WHERE SRC_PORT_CODE IS NULL " + filter_qry + " ORDER BY FLIGHT_NO");

		vResultset3 = vStatement3.executeQuery("SELECT COUNT(1) FROM (SELECT FLIGHT_NO FROM IMIGRATION.IM_ARR_FLIGHT_ROUTES WHERE SRC_PORT_CODE IS NULL " + filter_qry + " ORDER BY FLIGHT_NO)");
		
		int totalpass1 = 0;

		if (vResultset3.next())
			totalpass1 = vResultset3.getInt(1);
		vResultset3.close();
		vStatement3.close();

if(totalpass1 > 0)
{
%>
	<TABLE width= "100%" cellpadding="3" cellspacing="3">
		<TR bgcolor="#FFFFCC">
			<TH align="center" colspan="10"><font size="2" face="Verdana" color="GREEN">Flights not Found for Schedule Date <%=apisDate%></font></TH>
		</TR>
		<tr bgcolor="#FFE09F">
<%
		int kk=0;
		while(rs.next())
		{
			kk++;
%>
			<td>
				<a class="thumb" style="text-decoration:none" onmouseover='image2("<%=rs.getString(1)%>", "imag2<%="--" + kk %>");' href="#"><font color="#0000FF" size="1" face="Verdana"><%=rs.getString(1) == null ? "&nbsp;" : rs.getString(1)%></font>
				<span><img id="imag2<%="--" + kk%>"  style="float:left" alt="" src=""></span></a>
				<!-- </div>	 --></td>
<%
	if(kk%10 == 0)	%></tr><tr bgcolor="#FFE09F"><%
	if(!"".equals(rs.getString(1)) && rs.getString(1) != null)	all_flights.add(rs.getString(1));
		}
%>
</table>
<%}%>
<br><br>
<%
	if(all_flights.size() != 0)
{
%>
	<TABLE width= "100%" cellpadding="3" cellspacing="3">
		<TR bgcolor="#FFFFCC">
			<TH align="center" colspan="10"><font size="2" face="Verdana" color="GREEN">Flights with No Images for Schedule Date <%=apisDate%></font></TH>
		</TR>
<%
out.flush();
//all_flights.sort();
java.util.Collections.sort(all_flights);
//out.println("<BR>");
int jj=0;
%>
	<tr bgcolor="#E0EEE0">
<%
for(int i=0; i< all_flights.size(); i++)
{	
	if("".equals(all_flights.get(i).trim()))	continue;
	if(!isUrl_exist(all_flights.get(i)))
	{
		if("".equals(all_flights.get(i).trim()))	continue;
		jj++;
		//out.println(all_flights.get(i).trim() + " &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
%>
		<td><font size="1" face="Verdana"><%=(all_flights.get(i).trim() == null ? "&nbsp;" : all_flights.get(i).trim())%>	</font></td>
<%
		//out.flush();
		//if(jj%10 == 0)	out.println("<BR>");
		if(jj%10 == 0)	%></tr><tr bgcolor="#E0EEE0"><%
	}
}
%>
<tr><td align='center' colspan='10'><font size='2' face='Verdana' color='#FF0000'><b>End Of Report</b></font></td></tr>
<tr>
	<td colspan="10" align="center">
		<!-- <input type="button" value="Back" name="but_back" style="font-family: Verdana; font-size: 9pt; color:#000000; font-weight: bold" onclick="back_win()">&nbsp;&nbsp; -->
		<input type="button" value="Close" name="but_close" style="font-family: Verdana; font-size: 9pt; color:#000000; font-weight: bold" onclick="window.close()">
	</td>
</tr>

</table>
<%
}
//out.println("<BR><BR><font align='right' size='2' face='Verdana' color='#FF0000'><b>End Of Report</b></font>");
}
%>
</form>
</body></html>
