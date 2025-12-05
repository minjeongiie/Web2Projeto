<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Inscricao" %>

<%
    Object user = session.getAttribute("usuario");
    if (user == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    model.Aluno Aluno = (model.Aluno) user;
    List<Inscricao> lista = (List<Inscricao>) request.getAttribute("lista");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Minhas Inscrições</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
		<nav class="navbar navbar-expand-lg navbar-dark bg-cobalto text-white">
		  <div class="container-fluid">
		    <a class="navbar-brand" href="<%=request.getContextPath()%>/view/aluno/home.jsp">
		      <img src="<%=request.getContextPath()%>/img/rural_logo_branco04.png" alt="Logo UFRRJ" width="250">
		    </a>
		
		    <div class="ms-auto text-end">
		        <span class="me-4">Olá, <strong><%= Aluno.getNome() %></strong></span>
		        <a href="<%=request.getContextPath()%>/logout" class="btn btn-light btn-sm">Sair</a>
		    </div>
		  </div>
				  <a href="${pageContext.request.contextPath}/aluno/inscricoes"
		   class="btn btn-outline-light btn-sm">Minhas Inscrições</a>
		  
		</nav>
<div class="container mt-4">
    <h2 class="mb-4">Minhas Inscrições</h2>

    <% if (request.getParameter("msg") != null && request.getParameter("msg").equals("cancelado")) { %>
        <div class="alert alert-success">Inscrição cancelada com sucesso!</div>
    <% } %>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>Título</th>
                <th>Tipo</th>
                <th>Data</th>
                <th>Status</th>
                <th width="130">Ações</th>
            </tr>
        </thead>

        <tbody>
            <% for (Inscricao i : lista) { %>
                <tr>
                    <td><%= i.getTituloAtividade() %></td>
                    <td><%= i.getTipo() %></td>
                    <td><%= i.getDataInscricao() %></td>
                    <td><%= i.getStatus() %></td>

                    <td>
                        <a class="btn btn-danger btn-sm"
                           href="<%=request.getContextPath()%>/aluno/cancelar?id=<%= i.getId() %>">
                           Cancelar
                        </a>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
