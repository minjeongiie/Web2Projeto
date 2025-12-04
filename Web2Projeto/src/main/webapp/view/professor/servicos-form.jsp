<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Servico, java.time.*"%>
<%@ page import="java.util.List" %>

<%
	Object user = session.getAttribute("usuario");
	if (user == null) {
	    response.sendRedirect(request.getContextPath() + "/view/login.jsp");
	    return;
	}
	
	model.Professor prof = (model.Professor) user;

    Servico s = (Servico) request.getAttribute("servico");
    boolean editando = (s != null);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%= editando ? "Editar Serviço" : "Novo Serviço" %></title>
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

    <h3><%= editando ? "Editar Serviço" : "Cadastrar Serviço" %></h3>
    <hr>

    <form action="${pageContext.request.contextPath}/prof/servicos" method="post">

        <% if (editando) { %>
            <input type="hidden" name="id" value="<%= s.getId() %>">
        <% } %>

        <!-- CAMPOS PADRÕES DE EXTENSÃO -->
        <div class="row">

            <div class="col-md-6 mb-3">
                <label class="form-label">Título</label>
                <input type="text" class="form-control" name="titulo"
                       value="<%= editando ? s.getTitulo() : "" %>" required>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Responsável</label>
                <input type="text" class="form-control" name="responsavel"
                       value="<%= editando ? s.getResponsavel() : "" %>">
            </div>
        </div>

        <div class="mb-3">
            <label>Descrição</label>
            <textarea class="form-control" name="descricao" rows="3"><%= editando ? s.getDescricao() : "" %></textarea>
        </div>

        <div class="row">

            <div class="col-md-4 mb-3">
                <label>Contato Inscrição</label>
                <input type="text" class="form-control" name="contato"
                       value="<%= editando ? s.getContatoInscricao() : "" %>">
            </div>

            <div class="col-md-4 mb-3">
                <label>Link Externo</label>
                <input type="text" class="form-control" name="linkExterno"
                       value="<%= editando ? s.getLinkExterno() : "" %>">
            </div>

            <div class="col-md-4 mb-3">
                <label>Local</label>
                <input type="text" class="form-control" name="local"
                       value="<%= editando ? s.getLocal() : "" %>">
            </div>
        </div>

        <!-- PERÍODO -->
        <div class="row">

            <div class="col-md-3 mb-3">
                <label>Data Início</label>
                <input type="date" class="form-control" name="dataInicio"
                       value="<%= editando ? s.getDataInicio() : "" %>" required>
            </div>

            <div class="col-md-3 mb-3">
                <label>Data Fim</label>
                <input type="date" class="form-control" name="dataFim"
                       value="<%= editando ? s.getDataFim() : "" %>" required>
            </div>

            <div class="col-md-3 mb-3">
                <label>Hora Início</label>
                <input type="time" class="form-control" name="horaInicio"
                       value="<%= editando ? s.getHoraDeInicio() : "" %>" required>
            </div>

            <div class="col-md-3 mb-3">
                <label>Hora Fim</label>
                <input type="time" class="form-control" name="horaFim"
                       value="<%= editando ? s.getHoraDeTermino() : "" %>" required>
            </div>
        </div>

        <hr>

        <!-- CAMPOS ESPECÍFICOS DO SERVIÇO -->
        <h4>Informações do Serviço</h4>

        <div class="row">

            <div class="col-md-4 mb-3">
                <label>Tipo do Serviço</label>
                <input type="text" class="form-control" name="tipoServico"
                       value="<%= editando ? s.getTipoServico() : "" %>" required>
            </div>

            <div class="col-md-4 mb-3">
                <label>Modalidade de Atendimento</label>
                <select class="form-select" name="modalidadeAtendimento">
                    <option value="Presencial" <%= editando && "Presencial".equals(s.getModalidadeAtendimento()) ? "selected" : "" %>>Presencial</option>
                    <option value="Online" <%= editando && "Online".equals(s.getModalidadeAtendimento()) ? "selected" : "" %>>Online</option>
                    <option value="Híbrido" <%= editando && "Híbrido".equals(s.getModalidadeAtendimento()) ? "selected" : "" %>>Híbrido</option>
                </select>
            </div>

            <div class="col-md-4 mb-3">
                <label>Existe Taxa?</label><br>
                <input type="checkbox" name="temTaxa" <%= editando && s.isTemTaxa() ? "checked" : "" %>>
            </div>
        </div>

        <!-- HORÁRIOS DE ATENDIMENTO -->
        <div class="row">

            <div class="col-md-3 mb-3">
                <label>Horário Início Atendimento</label>
                <input type="time" class="form-control" name="horarioInicio"
                       value="<%= editando ? s.getHoraDeInicio() : "" %>" required>
            </div>

            <div class="col-md-3 mb-3">
                <label>Horário Fim Atendimento</label>
                <input type="time" class="form-control" name="horarioFim"
                       value="<%= editando ? s.getHoraDeTermino() : "" %>" required>
            </div>

            <div class="col-md-6 mb-3">
			    <label>Dias de Atendimento (ex: SEG, TER, QUA)</label>
			    <input type="text" class="form-control" name="diasAtendimento"
			           value="<%= editando ? s.getDiasAtendimento() : "" %>">
			</div>

        </div>

        <!-- STATUS -->
        <div class="col-md-3 mb-3">
            <label>Status</label>
            <select class="form-select" name="status">
                <option value="Aberto" <%= editando && "Aberto".equals(s.getStatus()) ? "selected" : "" %>>Aberto</option>
                <option value="Encerrado" <%= editando && "Encerrado".equals(s.getStatus()) ? "selected" : "" %>>Encerrado</option>
            </select>
        </div>

        <button class="btn btn-success mt-3">Salvar</button>

    </form>
</div>
</body>
</html>