<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Servico, java.time.format.DateTimeFormatter" %>

<%
	Object user = session.getAttribute("usuario");
	if (user == null) {
	    response.sendRedirect(request.getContextPath() + "/view/login.jsp");
	    return;
	}
	
	model.Professor prof = (model.Professor) user;

    DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Serviços</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<nav class="navbar navbar-expand-lg navbar-dark bg-cobalto text-white">
  <div class="container-fluid">
    <a class="navbar-brand" href="<%=request.getContextPath()%>/view/professor/home.jsp">
      <img src="<%=request.getContextPath()%>/img/rural_logo_branco04.png" alt="Logo UFRRJ" width="250">
    </a>

    <div class="ms-auto text-end">
        <span class="me-4">Olá, <strong><%= prof.getNome() %></strong></span>
        <a href="<%=request.getContextPath()%>/logout" class="btn btn-light btn-sm">Sair</a>
    </div>
  </div>
</nav>

<div class="container mt-4">
    <h2 class="mb-4">Serviços</h2>

    <a href="${pageContext.request.contextPath}/prof/servicos?acao=form" 
       class="btn btn-primary mb-3">+ Novo Serviço</a>

    <table class="table table-hover">
        <thead>
            <tr>
                <th>Título</th>
                <th>Tipo</th>
                <th>Período</th>
                <th>Horário</th>
                <th>Modalidade</th>
                <th>Dias</th>
                <th>Status</th>
                <th></th>
            </tr>
        </thead>

        <tbody>
        <%
            List<Servico> lista = (List<Servico>) request.getAttribute("lista");
            for (Servico s : lista) {
        %>
            <tr>
                <td><%= s.getTitulo() %></td>
                <td><%= s.getTipoServico() %></td>
                <td><%= df.format(s.getDataInicio()) %> até <%= df.format(s.getDataFim()) %></td>
                <td><%= s.getHoraDeInicio() %> - <%= s.getHoraDeTermino() %></td>
                <td><%= s.getModalidadeAtendimento() %></td>
                <td><%= s.getDiasAtendimento() %></td>


                <td><%= s.getStatus() %></td>

                <td>
                    <a href="${pageContext.request.contextPath}/prof/servicos?acao=editar&id=<%= s.getId() %>" 
                       class="btn btn-sm btn-warning">
                        <i class="bi bi-pencil"></i>
                    </a>

                    <a href="${pageContext.request.contextPath}/prof/servicos?acao=excluir&id=<%= s.getId() %>" 
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Excluir este serviço?')">
                        <i class="bi bi-trash"></i>
                    </a>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
