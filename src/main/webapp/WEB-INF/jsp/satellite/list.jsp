<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="it" class="h-100">
<head>

<!-- Common imports in pages -->
<jsp:include page="../header.jsp" />

<meta charset="ISO-8859-1">
<title>Lista Satelliti</title>
</head>
<body  class="d-flex flex-column h-100">
<!-- Fixed navbar -->
	<jsp:include page="../navbar.jsp"></jsp:include>


	<!-- Begin page content -->
	<main class="flex-shrink-0">
		<div class="container">

			<div
				class="alert alert-success alert-dismissible fade show  ${successMessage==null?'d-none':'' }"
				role="alert">
				${successMessage}
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>
			<div class="alert alert-danger alert-dismissible fade show d-none"
				role="alert">
				Esempio di operazione fallita!
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>
			<div class="alert alert-info alert-dismissible fade show d-none"
				role="alert">
				Aggiungere d-none nelle class per non far apparire
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>



			<div class='card'>
				<div class='card-header'>
					<h5>Lista dei risultati</h5>
				</div>
				<div class='card-body'>
					<a class="btn btn-primary "
						href="${pageContext.request.contextPath}/satellite/insert">Add
						New</a>

					<div class='table-responsive'>
						<table class='table table-striped '>
							<thead>
								<tr>
									<th>Denominazione</th>
									<th>Codice</th>
									<th>Data di Lancio</th>
									<th>Data di Rientro</th>
									<th>Stato</th>
									<th>Azioni</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${satellite_list_attribute }"
									var="satelliteItem">
									<tr>
										<td>${satelliteItem.denominazione }</td>
										<td>${satelliteItem.codice }</td>
										<td><fmt:parseDate value="${satelliteItem.dataLancio}"
												pattern="yyyy-MM-dd" var="localDateToBeParsed" type="date" />
											<fmt:formatDate pattern="dd/MM/yyyy"
												value="${localDateToBeParsed}" /></td>
										<td><fmt:parseDate value="${satelliteItem.dataRientro}"
												pattern="yyyy-MM-dd" var="localDateToBeParsed" type="date" />
											<fmt:formatDate pattern="dd/MM/yyyy"
												value="${localDateToBeParsed}" /></td>
										<td>${satelliteItem.stato }</td>
										<td>
											<div>
												<a class="btn  btn-sm btn-outline-secondary"
													href="${pageContext.request.contextPath}/satellite/show/${satelliteItem.id }">Visualizza</a>
												<a class="btn  btn-sm btn-outline-primary ml-2 mr-2"
													href="${pageContext.request.contextPath}/satellite/edit/${satelliteItem.id }">Edit</a>
												<a class="btn btn-outline-danger btn-sm"
													href="${pageContext.request.contextPath}/satellite/delete/${satelliteItem.id }">Delete</a>
												<form:form modelAttribute="satellite_list_attribute"
													class="btn-group mr-2 ml-2" method="post"
													action="${pageContext.request.contextPath}/satellite/lancio"
													novalidate="novalidate">
													<c:if test="${satelliteItem.dataLancio == null}">


														<input type="hidden" name="id"
															value="${satelliteItem.id }">
														<input type="hidden" name="dataLancio"
															value="${satelliteItem.dataLancio }">
														<input type="hidden" name="stato"
															value="${satelliteItem.stato }">
														<button type="submit" name="submit" value="submit"
															id="submit"
															class="btn  btn-sm btn-outline-primary ml-2 mr-2">Lancio</button>
													</c:if>
												</form:form>

												<form:form modelAttribute="satellite_list_attribute"
													class="btn-group mr-2 ml-2" method="post"
													action="${pageContext.request.contextPath}/satellite/rientro"
													novalidate="novalidate">

													<c:if
														test="${satelliteItem.dataRientro == null && satelliteItem.dataLancio != null}">


														<input type="hidden" name="id"
															value="${satelliteItem.id }">
														<input type="hidden" name="stato"
															value="${satelliteItem.stato }">
														<input type="hidden" name="dataRientro"
															value="${satelliteItem.dataRientro }">

														<button type="submit" name="submit" value="submit"
															id="submit"
															class="btn  btn-sm btn-outline-primary ml-2 mr-2">Rientro</button>


													</c:if>
												</form:form>
											</div>
										</td>


									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="col-12">
						<a href="${pageContext.request.contextPath}/satellite/search"
							class='btn btn-outline-secondary' style='width: 80px'> <i
							class='fa fa-chevron-left'></i> Back
						</a>
					</div>

					<!-- end card-body -->
				</div>
				<!-- end card -->
			</div>


			<!-- end container -->
		</div>

	</main>

	<!-- Footer -->
	<jsp:include page="../footer.jsp" />

</body>
</html>