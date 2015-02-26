<%-- 
    Document   : view_policy_status
    Created on : May 12, 2013, 1:35:17 PM
    Author     : Amol
--%>
<%@page import="java.util.Vector" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
Connection conn=null;
PreparedStatement stmt=null;
String msg="",login_id="",policy_no="",status="";
Vector vpolicy_no=new Vector();
Vector vstatus=new Vector();
Vector vcust_id=new Vector();



void connect()
{
 try{
     Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
     conn=DriverManager.getConnection("jdbc:odbc:insuranc"," "," ");
     }
     catch(Exception ex)
     {
            msg=ex.getMessage();     
     }     
}        
void fetch_loginid(HttpServletRequest request)
{
HttpSession obj=request.getSession(false);
login_id=obj.getAttribute("session_loginid").toString();
} 

void fetch_input(HttpServletRequest request)
{
     policy_no=request.getParameter("policy_no");

}             


void fetch()
{
try{
    stmt=conn.prepareStatement("select C.cust_id,P.policy_no,P.approved from cust C,policy P,login L where L.loginid=C.loginid and C.cust_id=P.cust_id and L.loginid=?");
    stmt.setString(1,login_id);
    ResultSet rs=stmt.executeQuery();
    while(rs.next())
     {
        vcust_id.add(rs.getString("cust_id"));
        vpolicy_no.add(rs.getString("policy_no"));
        
    }
 
    rs.close();
    stmt.clearParameters();
    stmt.close();
}
catch(Exception ex)
{
   msg=ex.getMessage();

}        

}
void fetch_status()
{
try{
    stmt=conn.prepareStatement("select approved from policy where policy_no=?");
    stmt.setString(1,policy_no);
    ResultSet rs=stmt.executeQuery();
     rs.next();
     {
        
       status= rs.getString("approved");
        
    }
     if("YES".equals(status))
              {
         status="POLICY HAS BEEN APPROVED";
     }
     else
         status="POLICY YET TO BE APPROVED";
 
    rs.close();
    stmt.clearParameters();
    stmt.close();
    conn.close();
}
catch(Exception ex)
{
   msg=ex.getMessage();

}        

}
      
%>
<%
connect();
fetch_loginid(request);
fetch();

if(request.getParameter("btngo")!=null)
    {
    
     connect();
    fetch_input(request);
    fetch_status();
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="http://fonts.googleapis.com/css?family=Abel" rel="stylesheet" type="text/css" />
<link href="Template/style.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="Template/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="Template/jquery.slidertron-1.0.js"></script>
<script type="text/javascript" src="Template/jquery.dropotron-1.0.js"></script>
<script type="text/javascript" src="Template/jquery.poptrox-1.0.js"></script>
<title>Policy Status</title>
    </head>
    <form name="frm" action="view_policy_status.jsp" method="POST">
    <div id="wrapper">
	<div id="header-wrapper">
		<div id="header">
			<div id="logo">
				<h1><span> INSURANCE SYSTEM WITH </span></h1>
				<h1><span>TRACKING MANAGER</span>		  </h1>
		  </div>
		</div>
	</div>
        <div id="menu-wrapper">
		<ul id="menu">
                    <li class="current_page_item"><a href="Cust.jsp"><span> Customer Home  </span></a></li>
        <li> <span>   My Account  </span>

			  <ul>
                           <li><a href="view_cust_profile.jsp"> View Profile </a></li>
                           <li><a href="change_password.jsp" target="_blank"> Change Password </a></li>
			  <li><a href="logout.jsp"> logout </a></li>
                                         
					 <li class="last"></li>
			  </ul>
           
        <li><a href="disscussionforum.jsp" target="_blank"> <span>Discussion Forum </span></a></li>
         <li><a href="about.jsp" target="_blank"><span>About</span></a></li>
			
		</ul>
		<script type="text/javascript">
			$('#menu').dropotron();
		</script>
	</div>
    <body>
        <br>
        <table align="center">
            <tr>
                <td>CUSTOMER ID:<input type="text" name="cust_id" value="<%=vcust_id.get(0)%>" readonly="readonly" /></td>
            </tr>
            <tr>
                
               
              
                    <td>POLICY NO:
                    <select name="policy_no" >
                <%
                        for(int i=0;i<vpolicy_no.size();i++)
                                                   { %>
                      <option><%=vpolicy_no.get(i)%></option>
                   
                    <% }
                     vpolicy_no.clear();
                    %>
                </select></td><td><input type="submit" value="Go" name="btngo" /></td>
            </tr>
        </table>
                   
         <script>       
 <%
                if(request.getParameter("btngo")!=null)    
                     {
                    %>
                    alert("<%=status%>");
                    <%}
                    %>
        </script>
                
    </body>
    </form>
</html>