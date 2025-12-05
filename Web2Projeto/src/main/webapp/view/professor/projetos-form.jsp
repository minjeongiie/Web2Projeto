<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Projeto" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Curso" %>
<%@ page import="model.Servico" %>

<%
    Projeto p = (Projeto) request.getAttribute("projeto");

    // Cursos e serviços enviados pelo servlet quando acao=form ou acao=editar
    List<Curso> cursos = (List<Curso>) request.getAttribute("cursos");
    List<Servico> servicos = (List<Servico>) request.getAttribute("servicos");

    String cursosIds = (p.getCursosIds() == null ? "" : p.getCursosIds());
    String servicosIds = (p.getServicosIds() == null ? "" : p.getServicosIds());
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
	<title>Projeto</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

	<style>
	    .modal-body {
	        max-height: 400px;
	        overflow-y: auto;
	    }
	</style>
</head>
<body>

<div class="container mt-4">
    <h2><%= (p.getId() == null ? "Novo Projeto" : "Editar Projeto") %></h2>

    <form action="${pageContext.request.contextPath}/prof/projetos" method="post">

        <% if (p.getId() != null) { %>
            <input type="hidden" name="id" value="<%= p.getId() %>">
        <% } %>

        <!-- CAMPOS PADRÃO DA EXTENSAO -->
        <div class="row">
            <div class="col-md-8 mb-3">
                <label class="form-label">Título</label>
                <input type="text" name="titulo" class="form-control" value="<%= p.getTitulo() %>" required>
            </div>

            <div class="col-md-4 mb-3">
                <label class="form-label">Responsável</label>
                <input type="text" name="responsavel" class="form-control" value="<%= p.getResponsavel() %>" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Descrição</label>
            <textarea name="descricao" class="form-control" rows="3"><%= p.getDescricao() %></textarea>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Local</label>
                <input type="text" name="local" class="form-control" value="<%= p.getLocal() %>">
            </div>

            <div class="col-md-3 mb-3">
                <label class="form-label">Status</label>
                <select class="form-select" name="status">
                    <option value="Ativo" <%= ("Ativo".equals(p.getStatus()) ? "selected" : "") %>>Ativo</option>
                    <option value="Encerrado" <%= ("Encerrado".equals(p.getStatus()) ? "selected" : "") %>>Encerrado</option>
                </select>
            </div>

            <div class="col-md-3 mb-3">
                <label class="form-label">Tem Taxa?</label>
                <input type="checkbox" name="temTaxa" class="form-check-input ms-2" <%= (p.isTemTaxa() ? "checked" : "") %> >
            </div>
        </div>

        <!-- DATA E HORÁRIO -->
        <div class="row">
            <div class="col-md-3 mb-3">
                <label class="form-label">Data Início</label>
                <input type="date" name="dataInicio" class="form-control"
                    value="<%= (p.getDataInicio() != null ? p.getDataInicio() : "") %>" required>
            </div>

            <div class="col-md-3 mb-3">
                <label class="form-label">Data Fim</label>
                <input type="date" name="dataFim" class="form-control"
                    value="<%= (p.getDataFim() != null ? p.getDataFim() : "") %>" required>
            </div>
        </div>

        <!-- DURAÇÃO -->
        <div class="mb-3">
            <label class="form-label">Duração</label>
            <input type="text" name="duracao" class="form-control" placeholder="ex: 6 meses"
                   value="<%= p.getDuracao() %>">
        </div>

        <hr>

        <!-- SELEÇÃO DE CURSOS E SERVIÇOS -->
        <div class="row">

            <div class="col-md-6 mb-3">
                <label class="form-label">Cursos relacionados:</label>

                <button type="button" class="btn btn-outline-primary w-100"
                        data-bs-toggle="modal" data-bs-target="#modalCursos">
                    Selecionar Cursos
                </button>

                <small class="text-muted">IDs selecionados: <span id="cursosSelecionados"><%= cursosIds %></span></small>

                <input type="hidden" id="cursosIds" name="cursosIds" value="<%= cursosIds %>">
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Serviços relacionados:</label>

                <button type="button" class="btn btn-outline-primary w-100"
                        data-bs-toggle="modal" data-bs-target="#modalServicos">
                    Selecionar Serviços
                </button>

                <small class="text-muted">IDs selecionados: <span id="servicosSelecionados"><%= servicosIds %></span></small>

                <input type="hidden" id="servicosIds" name="servicosIds" value="<%= servicosIds %>">
            </div>

        </div>

        <hr>

        <!-- BOTÃO -->
        <button type="submit" class="btn btn-success">Salvar</button>
        <a href="${pageContext.request.contextPath}/prof/projetos" class="btn btn-secondary">Cancelar</a>

    </form>
</div>




<!-- ================================================================== -->
<!-- =========================== MODAL CURSOS ========================= -->
<!-- ================================================================== -->
<div class="modal fade" id="modalCursos" tabindex="-1">
  <div class="modal-dialog modal-dialog-scrollable modal-lg">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Selecionar Cursos</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

        <table class="table table-hover">
            <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>Título</th>
                </tr>
            </thead>

            <tbody>
            <%  for (Curso c : cursos) { %>
                <tr>
                    <td>
                        <input type="checkbox" class="cursoCheck"
                            value="<%= c.getId() %>"
                            <%= cursosIds.contains(String.valueOf(c.getId())) ? "checked" : "" %>>
                    </td>
                    <td><%= c.getId() %></td>
                    <td><%= c.getTitulo() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>

      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="salvarCursos()">Salvar Seleção</button>
      </div>

    </div>
  </div>
</div>



<!-- ================================================================== -->
<!-- ========================== MODAL SERVIÇOS ======================== -->
<!-- ================================================================== -->
<div class="modal fade" id="modalServicos" tabindex="-1">
  <div class="modal-dialog modal-dialog-scrollable modal-lg">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Selecionar Serviços</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">

        <table class="table table-hover">
            <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>Título</th>
                </tr>
            </thead>

            <tbody>
            <%  for (Servico s : servicos) { %>
                <tr>
                    <td>
                        <input type="checkbox" class="servicoCheck"
                            value="<%= s.getId() %>"
                            <%= servicosIds.contains(String.valueOf(s.getId())) ? "checked" : "" %>>
                    </td>
                    <td><%= s.getId() %></td>
                    <td><%= s.getTitulo() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>

      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="salvarServicos()">Salvar Seleção</button>
      </div>

    </div>
  </div>
</div>



<!-- ================================================================== -->
<!-- =============================== SCRIPT =========================== -->
<!-- ================================================================== -->

<script>

function salvarCursos() {
    let selecionados = [];
    document.querySelectorAll(".cursoCheck:checked").forEach(c => selecionados.push(c.value));

    document.getElementById("cursosIds").value = selecionados.join(",");
    document.getElementById("cursosSelecionados").innerText = selecionados.join(",");

    var modal = bootstrap.Modal.getInstance(document.getElementById("modalCursos"));
    modal.hide();
}

function salvarServicos() {
    let selecionados = [];
    document.querySelectorAll(".servicoCheck:checked").forEach(s => selecionados.push(s.value));

    document.getElementById("servicosIds").value = selecionados.join(",");
    document.getElementById("servicosSelecionados").innerText = selecionados.join(",");

    var modal = bootstrap.Modal.getInstance(document.getElementById("modalServicos"));
    modal.hide();
}

</script>

</body>
</html>
