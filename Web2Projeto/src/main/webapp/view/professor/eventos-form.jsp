<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>

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
	<title>Novo Evento</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
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
        <span class="me-4">Olá, <strong><%= prof.getNome() %></strong></span>
        <a href="<%=request.getContextPath()%>/logout" class="btn btn-light btn-sm">Sair</a>
    </div>
  </div>
</nav>
<div class="container mt-4">

	<h2>Novo Evento</h2>

	<form action="${pageContext.request.contextPath}/prof/eventos" method="post">

		<div class="mb-3">
			<label class="form-label">Título</label>
			<input type="text" name="titulo" class="form-control" required>
		</div>

		<div class="mb-3">
			<label class="form-label">Descrição</label>
			<textarea name="descricao" class="form-control" rows="3" required></textarea>
		</div>

		<div class="mb-3">
			<label>Responsável</label>
			<input type="text" name="responsavel" class="form-control">
		</div>

		<div class="mb-3">
			<label>Contato</label>
			<input type="text" name="contato" class="form-control">
		</div>

		<div class="mb-3">
			<label>Link Externo</label>
			<input type="text" name="linkExterno" class="form-control">
		</div>

		<div class="mb-3">
			<label>Público Alvo</label>
			<input type="text" name="publicoAlvo" class="form-control">
		</div>

		<div class="row">
			<div class="col">
				<label>Data início</label>
				<input type="date" name="dataInicio" class="form-control" required>
			</div>

			<div class="col">
				<label>Data fim</label>
				<input type="date" name="dataFim" class="form-control" required>
			</div>
		</div>

		<div class="row mt-3">
			<div class="col">
				<label>Hora início</label>
				<input type="time" name="horaInicio" class="form-control" required>
			</div>

			<div class="col">
				<label>Hora fim</label>
				<input type="time" name="horaFim" class="form-control" required>
			</div>
		</div>

		<div class="mb-3 mt-3">
			<label>Máx participantes</label>
			<input type="number" name="maxParticipantes" class="form-control" required>
		</div>

		<div class="form-check mb-3">
			<input class="form-check-input" type="checkbox" name="temTaxa">
			<label class="form-check-label">Esta ação possui taxa?</label>
		</div>

		<div class="mb-3">
			<label>Status</label>
			<select class="form-select" name="status">
				<option value="ABERTO">Aberto</option>
				<option value="ENCERRADO">Encerrado</option>
				<option value="CANCELADO">Cancelado</option>
			</select>
		</div>

		<div class="mb-3">
			<label>Local</label>
			<input type="text" name="local" class="form-control" required placeholder="Local do Evento">
		</div>

		<button class="btn btn-success mt-3">Salvar</button>

	</form>

</div>

</body>
</html>
