<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Blood Transfusions</title>
    </head>
  <body>
  <button type="button" name="back" onclick="history.back()">Back</button>
    <center><h1>Blood Transfusion Log</h1>
    <center>
    <% 
    String db = "BloodBank";
    String user = "root";
    String pw = "password";
        try {
            java.sql.Connection con; 
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, user, pw);
            Statement stmt = con.createStatement();
            
            ResultSet rs = stmt.executeQuery("SELECT t.transfusion_id, t.patient_id, p.first_name, p.last_name, t.employee_id, e.first_name, e.last_name, t.amount_received FROM transfusion t, person p, employee e WHERE t.patient_id = p.id AND t.employee_id = e.id");
            %>
            <table border="2">
            <tr>
                <th>Donation ID</th>
                <th>Patient ID</th>
                <th>Patient Name</th>
                <th>Employee ID</th>
                <th>Employee Name</th>
                <th>Amount Donated (cc)</th>
            </tr>
            <% while (rs.next()) { %>
                <tr>
                    <td><%=rs.getInt(1)%></td>
                    <td><%=rs.getInt(2)%></td>
                    <td><%=rs.getString(3)%> <%=rs.getString(4)%></td>
                    <td><%=rs.getInt(5)%></td>
                    <td><%=rs.getString(6)%> <%=rs.getString(7)%></td>
                    <td><%=rs.getDouble(8)%></td>
                </tr>
            <% }
            rs.close();
            stmt.close();
            con.close();
        }
        catch(SQLException e) {
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
    </center>
   </table>
  </body>
</html>
