<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%
if(session.getAttribute("user") == null) {
	System.out.println("no session!!");

%>

	<script type="text/javascript">

	window.location.href = "loginPage.jsp";
	</script>
<%
}

%>

</html>