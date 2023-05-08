<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
    
<!DOCTYPE html>
<html lang="it" class="h-100">
<head>
<!-- Common imports in pages -->
	 	<jsp:include page="../header.jsp" />
<meta charset="ISO-8859-1">
<title>Procedura di Emergenza</title>
</head>
<body  class="d-flex flex-column h-100">
<!-- Fixed navbar -->
	   		<jsp:include page="../navbar.jsp"></jsp:include>
	    
			
			<!-- Begin page content -->
			<main class="flex-shrink-0">
			  <div class="container">
			  
			  		<div class='card'>
					    <div class='card-header'>
					        <h5>Procedura di Emergenza</h5>
					    </div>
					    
					
					    <div class='card-body'>
					    	<p> Sta per essere applicata la procedura di emergenza. <br> Sei sicuro di voler procedere?</p>
					    	<p> Numero voci presenti nel sistema: ${satellite_lista_attribute}</p>
					    	<br>
					    	<br>
					    	<p> Numero voci che saranno modificate: ${satellite_size_list_attribute}</p>
					    	
					    	<c:forEach items="${satellite_emergenza_attr }"
									var="satelliteItem">
					    	<form:form modelAttribute="satellite_emergenza_attr"
													class="btn-group mr-2 ml-2" method="post"
													action="${pageContext.request.contextPath}/satellite/emergenza"
													novalidate="novalidate">


														
														<input type="hidden" name="dataRientro"
															value="${satelliteItem.dataRientro }">
														<input type="hidden" name="stato"
															value="${satelliteItem.stato }">
														<button type="submit" name="submit" value="submit"
															id="submit"
															class="btn  btn-sm btn-outline-primary ml-2 mr-2">Disabilita Tutti</button>
												</form:form>
					    	</c:forEach>
					    </div>
					    <!-- end card body -->
					    
					    <div class='card-footer'>
					        <a href="${pageContext.request.contextPath}/satellite" class='btn btn-outline-secondary' style='width:80px'>
					            <i class='fa fa-chevron-left'></i> Back
					        </a>
					    </div>
					<!-- end card -->
					</div>	
			  
			    
			  <!-- end container -->  
			  </div>
			  
			</main>
			
			<!-- Footer -->
			<jsp:include page="../footer.jsp" />
	  </body>


</body>
</html>