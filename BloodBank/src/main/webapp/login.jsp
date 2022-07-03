<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<style>
    div.ex
    {
        width:300px;
        padding:10px;
        border:5px solid gray;
        margin:0px;
    }
#emailBox {
    margin-left: 22px;
}
#lastRow {
    margin-left: 0px;
}
</style>
  <head>
    <title>Login</title>
    </head>
  <body>
    <button type="button" name="back" onclick="history.back()">Back</button>
    <center><h1>Login</h1>
    <form>
    <p>
        <label>
            Email
            <input type="text" name="id" id="emailBox"/>
        </label>
    </p>
    <p>
        <label>
            Password
            <input type="password" name="password"/>
        </label>
    </p>
    <p>
        <div id="lastRow">
            <label><input type="checkbox" name="rememberMe">Keep me logged in</label>
            <input type="submit" value="Login"/>
        </div>
    </p>
  </form>
    </center>
   </table>
  </body>
</html>
