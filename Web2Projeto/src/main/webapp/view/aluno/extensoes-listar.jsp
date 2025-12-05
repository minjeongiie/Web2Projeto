<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.ExtensaoResumo" %>

<%
    List<ExtensaoResumo> lista = (List<ExtensaoResumo>) request.getAttribute("lista");
%>
<%
    Object user = session.getAttribute("usuario");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    model.Aluno Aluno = (model.Aluno) user;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Atividades de Extensão</title>
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
	    <link rel="stylesheet"
	     href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
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
		</nav>
<div class="container mt-4">

    <h2 class="mb-4">Atividades de Extensão</h2>

    <table class="table table-hover">
        <thead>
            <tr>
                <th>Título</th>
                <th>Tipo</th>
                <th>Período</th>
                <th>Status</th>
                <th style="width:160px;">Ações</th>
            </tr>
        </thead>

        <tbody>
        <% for (ExtensaoResumo e : lista) { %>

            <tr>
                <td><%= e.getTitulo() %></td>
                <td><%= e.getTipo() %></td>
                <td><%= e.getDataInicio() %> → <%= e.getDataFim() %></td>
                <td><%= e.getStatus() %></td>

                <td>
                    <a href="${pageContext.request.contextPath}/aluno/extensao-detalhes?tipo=<%= e.getTipo() %>&id=<%= e.getId() %>" 
                       class="btn btn-sm btn-primary">
                        Ver detalhes
                    </a>

                    <a href="${pageContext.request.contextPath}/aluno/inscrever?tipo=<%= e.getTipo() %>&id=<%= e.getId() %>" 
                       class="btn btn-sm btn-success">
                        Inscrever-se
                    </a>
                </td>
            </tr>

        <% } %>
        </tbody>

    </table>

</div>

</body>
</html>
