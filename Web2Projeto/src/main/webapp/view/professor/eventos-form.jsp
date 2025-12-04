<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Evento" %>

<%
    model.Evento e = (model.Evento) request.getAttribute("evento");
    boolean editando = (e != null);
%>

<%
    Object user = session.getAttribute("usuario");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/view/login.jsp");
        return;
    }

    model.Professor prof = (model.Professor) user;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= editando ? "Editar Evento" : "Novo Evento" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="bg-light">
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
		<h2><%= editando ? "Editar Evento" : "Cadastrar Evento" %></h2>
		<hr>
		
		<form action="<%= request.getContextPath() %>/prof/eventos" method="post">
		
		    <% if (editando) { %>
		        <input type="hidden" name="id" value="<%= e.getId() %>">
		    <% } %>
		
		    <div class="mb-3">
		        <label>Título:</label>
		        <input type="text" class="form-control" name="titulo"
		               value="<%= editando ? e.getTitulo() : "" %>" required>
		    </div>
		
		    <div class="mb-3">
		        <label>Descrição:</label>
		        <textarea class="form-control" name="descricao" required><%= editando ? e.getDescricao() : "" %></textarea>
		    </div>
		
		    <div class="mb-3">
		        <label>Responsável:</label>
		        <input type="text" class="form-control" name="responsavel"
		               value="<%= editando ? e.getResponsavel() : "" %>" required>
		    </div>
		
		    <div class="mb-3">
		        <label>Local:</label>
		        <input type="text" class="form-control" name="local"
		               value="<%= editando ? e.getLocal() : "" %>" required>
		    </div>
		
		    <div class="row">
		        <div class="col">
		            <label>Data Início:</label>
		            <input type="date" class="form-control" name="dataInicio"
		                   value="<%= editando ? e.getDataInicio() : "" %>" required>
		        </div>
		        <div class="col">
		            <label>Data Fim:</label>
		            <input type="date" class="form-control" name="dataFim"
		                   value="<%= editando ? e.getDataFim() : "" %>" required>
		        </div>
		    </div>
		
		    <div class="row mt-3">
		        <div class="col">
		            <label>Hora Início:</label>
		            <input type="time" class="form-control" name="horaInicio"
		                   value="<%= editando ? e.getHoraDeInicio() : "" %>" required>
		        </div>
		        <div class="col">
		            <label>Hora Fim:</label>
		            <input type="time" class="form-control" name="horaFim"
		                   value="<%= editando ? e.getHoraDeTermino() : "" %>" required>
		        </div>
		    </div>
		
		    <div class="mb-3 mt-3">
		        <label>Máximo de participantes:</label>
		        <input type="number" class="form-control" name="maxParticipantes"
		               value="<%= editando ? e.getMaxParticipantes() : "" %>" required>
		    </div>
		
		    <div class="mb-3">
		        <label>Status:</label>
		        <select name="status" class="form-control">
		            <option value="aberto" <%= editando && e.getStatus().equals("aberto") ? "selected" : "" %>>Aberto</option>
		            <option value="encerrado" <%= editando && e.getStatus().equals("encerrado") ? "selected" : "" %>>Encerrado</option>
		        </select>
		    </div>
		
		    <div class="form-check mb-3">
		        <input type="checkbox" class="form-check-input" name="temTaxa"
		               <%= editando && e.isTemTaxa() ? "checked" : "" %>>
		        <label class="form-check-label">Possui taxa?</label>
		    </div>
		
		    <button class="btn btn-success">Salvar</button>
		    <a href="<%= request.getContextPath() %>/prof/eventos" class="btn btn-secondary">Cancelar</a>
		
		</form>
	</div>
</body>
</html>
