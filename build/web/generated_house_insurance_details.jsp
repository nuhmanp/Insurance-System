<%-- 
    Document   : generated_house_insurance_details
    Created on : May 4, 2013, 12:01:34 PM
    Author     : Sac
--%>

<%@ page  import="java.util.Vector"%>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%!

      Vector vmemid=new Vector();
      Vector vname=new Vector();
      Vector vdob=new Vector();
      Vector voccupation=new Vector();
       
     String type,cust_id,premium,msg,sum_insured, premium_paying_term,frequency,name,dob= "";
     String purchase_date,next_premium_date,start_date,expiry_date,email,policy_no,buildingcost="";
     String var_policy_no;
       Connection conn=null;
       PreparedStatement stmt=null;
       

       public void connect() {

        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            conn = DriverManager.getConnection("jdbc:odbc:insuranc"," "," ");
        } catch (Exception ex) {

             msg= ex.getMessage();
        }

    }
       public void fetch()
       {
           try
            {
                stmt=conn.prepareStatement("select A.cust_id,A.name,A.dob,A.email_id,B.policy_no,B.frequency,B.premium_amt,B.policy_start_date,B.policy_exp_date,B.next_premium_date,C.buildingcost,C.sum_insured from cust A,policy B,house_insurance C where B.policy_no=? and B.cust_id=A.cust_id and B.policy_no=C.policy_no");             
                stmt.setString(1,var_policy_no);
                ResultSet rs=stmt.executeQuery();
                rs.next();
                
               cust_id=rs.getString("cust_id");
                name=rs.getString("name");
                dob =rs.getString("dob");
                email=rs.getString("email_id");
                policy_no=rs.getString("policy_no");
                frequency=rs.getString("frequency");
                premium=rs.getString("premium_amt");
               start_date=rs.getString("policy_start_date");
               expiry_date=rs.getString("policy_exp_date");
               next_premium_date=rs.getString("next_premium_date");
               buildingcost=rs.getString("buildingcost");
               sum_insured=rs.getString("sum_insured");
               rs.close();
        stmt.clearParameters();
        stmt.close();
        
                
        stmt=conn.prepareStatement("select A.memberid,A.name,A.date_of_birth,A.occupation from house_members A,house_insurance B, policy C where C.policy_no=? and C.policy_no=B.policy_no and B.policy_no=A.policy_no");             
                stmt.setString(1,var_policy_no);
                ResultSet rs1=stmt.executeQuery();
               while(rs1.next())
                    {
                   vmemid.add(rs1.getString("memberid"));
                    vname.add(rs1.getString("name"));
                    vdob.add(rs1.getString("date_of_birth"));
                    voccupation.add(rs1.getString("occupation"));
                   }
                rs1.close();
           stmt.clearParameters();
           stmt.close();
           
           conn.close();
           msg="POLICY GENERATED";
                
       }    
  catch(Exception ex)
            {
            msg=ex.getMessage();
         }                  
    }                      
  %>
  
  <%
           HttpSession obj=request.getSession(false);
           var_policy_no=obj.getAttribute("session_policy").toString(); //Session variable created in house_insurance.jsp
           
           connect();
           fetch();
   %>  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="http://fonts.googleapis.com/css?family=Abel" rel="stylesheet" type="text/css" />
<link href="Template/style.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="Template/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="Template/jquery.slidertron-1.0.js"></script>
<script type="text/javascript" src="Template/jquery.dropotron-1.0.js"></script>
<script type="text/javascript" src="Template/jquery.poptrox-1.0.js"></script>
        <title>House Insurance Policy Details</title>
    </head>
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
                    <li class="current_page_item"><a href="Co.jsp"><span> Employee Home  </span></a></li>
        <li> <span>   My Account  </span>

			  <ul>
                                         <li><a href="view_profile.jsp"> View Profile </a></li>
                                         <li><a href="change_password.jsp" target="_blank">Change Password </a></li>
                                         <li><a href="logout.jsp"> logout </a></li>
                                         
					 <li class="last"></li>
			  </ul>
            		
          <li><a href="about.jsp" target="_blank"><span>About</span></a></li>
			
		</ul>
		<script type="text/javascript">
			$('#menu').dropotron();
		</script>
	</div>
    <form action="generated_house_insurance_details.jsp" method="POST" >
    <body>
        <br>
        <h3 align="center"> CUSTOMER DETAILS</h3>
        <table border="1" align="center">
            <tr>
                <th>Customer ID</th>       
                <td><%=cust_id%></td>
           </tr> 
           <tr>
                <th>Customer Name</th>       
                <td><%=name%></td>
           </tr> 
           <tr>
                <th>Email ID</th>       
                <td><%=email%></td>
           </tr> 
           <tr>
                <th>Date Of Birth</th>       
                <td><%=dob%></td>
           </tr> 
           </table>
           
          <br>
          <br>
           <h3 align="center"> POLICY DETAILS</h3>
          <table border="1" align="center">
              <tr>
                <th>Policy No</th>       
                <td><%=policy_no%></td>
           </tr> 
        <tr>
                <th>Frequency</th>       
                <td><%=frequency%></td>
           </tr> 
           <tr>
                <th>Premium Amount</th>       
                <td>Rs.<%=premium%></td>
           </tr> 
           <tr>
                <th>Policy Start Date</th>       
                <td><%=start_date%></td>
           </tr> 
           <tr>
                <th>Policy Expiry Date</th>       
                <td><%=expiry_date%></td>
           </tr> 
           <tr>
                <th>Next Premium Date</th>       
                <td><%=next_premium_date%></td>
           </tr> 
            <tr>
                <th>Building Cost</th>       
                <td>Rs.<%=buildingcost%></td>
           </tr> 
           <tr>
                <th>Sum Insured</th>       
                <td>Rs.<%=sum_insured%></td>
           </tr> 
          </table>
           <br>
           <br>
           
           <h3 align="center"> MEMBER DETAILS </h3>
            <table bgcolor ="white" border="1" align="center" width="50" height="50">
                <thead>
                    <tr>
                        <th>Member ID</th>
                        <th>NAME</th>
                        <th>DATE OF BIRTH</th>
                        <th>OCCUPATION</th>
            </tr>
                </thead>
                <tbody>
                    <tr>
                        <br>
                        <%
                            for(int i=0;i<vmemid.size();i++)
                            {
                        %> 
                         <td><%=vmemid.get(i)%></td> 
                         <td><%=vname.get(i)%></td>
                         <td><%=vdob.get(i)%></td>
                         <td><%=voccupation.get(i)%></td>
                     </tr>
                        <% }
                         vmemid.clear();
                         vname.clear();
                         vdob.clear();
                         voccupation.clear();
                        %>
                        
            </tbody>
            </table>
                 <script>             
         alert("<%=msg%>");
    </script>   
        </form>
       <a href="Co.jsp">HOME</a>             
    </body>
</html>