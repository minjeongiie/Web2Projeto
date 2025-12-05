<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.ExtensaoResumo" %>
<%
    List<ExtensaoResumo> lista = (List<ExtensaoResumo>) request.getAttribute("lista");
%>
<%
    Object user = session.getAttribute("usuario");
    if (user == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    model.Aluno Aluno = (model.Aluno) user;
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Home</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
	    <link rel="stylesheet"
	     href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
	    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
	</head>
	<body>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
		<nav class="navbar navbar-expand-lg navbar-dark bg-cobalto text-white">
		  <div class="container-fluid">
		    <a class="navbar-brand" href="#">
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
		<% if (request.getParameter("msg") != null) { %>
		    <div class="alert alert-success">
		        Inscrição realizada com sucesso!
		    </div>
		<% } %>

		<% if ("ja_inscrito".equals(request.getParameter("msg"))) { %>
		    <div class="alert alert-warning">
		        Você já está inscrito nesta atividade.
		    </div>
		<% } %>
		
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
        <%
		    if (lista == null) {
		        response.sendRedirect(request.getContextPath() + "/aluno/home");
		        return;
		    }
		%>
        <% for (ExtensaoResumo e : lista) { %>

            <tr>
                <td><%= e.getTitulo() %></td>
                <td><%= e.getTipo() %></td>
                <td><%= e.getDataInicio() %> → <%= e.getDataFim() %></td>
                <td><%= e.getStatus() %></td>

                <td>
				    <a href="${pageContext.request.contextPath}/aluno/detalhes?tipo=<%= e.getTipo() %>&id=<%= e.getId() %>"
				       class="btn btn-primary btn-sm">Ver detalhes</a>
				
				    <a href="${pageContext.request.contextPath}/aluno/inscrever?tipo=<%= e.getTipo() %>&id=<%= e.getId() %>"
				       class="btn btn-success btn-sm">Inscrever-se</a>
				</td>

            </tr>

        <% } %>
        </tbody>
		
    </table>

</div>
		<footer id="sticky-footer" class="bg-cobalto text-light text-center py-3 mt-5">
		    <div class="container">
		        <p class="mb-1">Projeto desenvolvido por: Laís de Souza Martins Cano e  Caio Luiz Ramos De Souza</p>
		        <p class="mb-0">© 2025</p>
		    </div>
		</footer>
	</body>
</html>