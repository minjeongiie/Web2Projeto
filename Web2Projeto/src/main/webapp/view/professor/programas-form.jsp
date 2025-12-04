<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Programa" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Curso" %>
<%@ page import="model.Evento" %>
<%@ page import="model.Servico" %>
<%@ page import="model.Projeto" %>

<%
    Programa p = (Programa) request.getAttribute("programa");

    List<Curso> cursos = (List<Curso>) request.getAttribute("cursos");
    List<Evento> eventos = (List<Evento>) request.getAttribute("eventos");
    List<Servico> servicos = (List<Servico>) request.getAttribute("servicos");
    List<Projeto> projetos = (List<Projeto>) request.getAttribute("projetos");

    String cursosIds = (p.getCursosIds() == null ? "" : p.getCursosIds());
    String eventosIds = (p.getEventosIds() == null ? "" : p.getEventosIds());
    String servicosIds = (p.getServicosIds() == null ? "" : p.getServicosIds());
    String projetosIds = (p.getProjetosIds() == null ? "" : p.getProjetosIds());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Programa</title>
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

    <h2><%= (p.getId() == null ? "Novo Programa" : "Editar Programa") %></h2>

    <form action="${pageContext.request.contextPath}/prof/programas" method="post">

        <% if (p.getId() != null) { %>
            <input type="hidden" name="id" value="<%= p.getId() %>">
        <% } %>

        <!-- CAMPOS PADRÃO -->
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
                <input type="checkbox" name="temTaxa" class="form-check-input ms-2"
                       <%= (p.isTemTaxa() ? "checked" : "") %> >
            </div>
        </div>

        <!-- DATA -->
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
            <input type="text" name="duracao" class="form-control" value="<%= p.getDuracao() %>"
                   placeholder="ex: 12 meses">
        </div>

        <hr>

        <!-- SELEÇÕES -->
        <div class="row">

            <!-- Cursos -->
            <div class="col-md-6 mb-3">
                <label class="form-label">Cursos relacionados:</label>

                <button type="button" class="btn btn-outline-primary w-100"
                        data-bs-toggle="modal" data-bs-target="#modalCursos">
                    Selecionar Cursos
                </button>

                <small class="text-muted">IDs selecionados:
                    <span id="cursosSelecionados"><%= cursosIds %></span>
                </small>

                <input type="hidden" id="cursosIds" name="cursosIds" value="<%= cursosIds %>">
            </div>

            <!-- Eventos -->
            <div class="col-md-6 mb-3">
                <label class="form-label">Eventos relacionados:</label>

                <button type="button" class="btn btn-outline-primary w-100"
                        data-bs-toggle="modal" data-bs-target="#modalEventos">
                    Selecionar Eventos
                </button>

                <small class="text-muted">IDs selecionados:
                    <span id="eventosSelecionados"><%= eventosIds %></span>
                </small>

                <input type="hidden" id="eventosIds" name="eventosIds" value="<%= eventosIds %>">
            </div>

            <!-- Serviços -->
            <div class="col-md-6 mb-3">
                <label class="form-label mt-3">Serviços relacionados:</label>

                <button type="button" class="btn btn-outline-primary w-100"
                        data-bs-toggle="modal" data-bs-target="#modalServicos">
                    Selecionar Serviços
                </button>

                <small class="text-muted">IDs selecionados:
                    <span id="servicosSelecionados"><%= servicosIds %></span>
                </small>

                <input type="hidden" id="servicosIds" name="servicosIds" value="<%= servicosIds %>">
            </div>

            <!-- Projetos -->
            <div class="col-md-6 mb-3">
                <label class="form-label mt-3">Projetos relacionados:</label>

                <button type="button" class="btn btn-outline-primary w-100"
                        data-bs-toggle="modal" data-bs-target="#modalProjetos">
                    Selecionar Projetos
                </button>

                <small class="text-muted">IDs selecionados:
                    <span id="projetosSelecionados"><%= projetosIds %></span>
                </small>

                <input type="hidden" id="projetosIds" name="projetosIds" value="<%= projetosIds %>">
            </div>

        </div>

        <hr>

        <button type="submit" class="btn btn-success">Salvar</button>
        <a href="${pageContext.request.contextPath}/prof/programas" class="btn btn-secondary">Cancelar</a>

    </form>
</div>



<!-- ============================================== -->
<!-- ================ MODAL CURSOS ================= -->
<!-- ============================================== -->
<div class="modal fade" id="modalCursos" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
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
                    <% for (Curso c : cursos) { %>
                    <tr>
                        <td>
                            <input type="checkbox" class="checkCurso"
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
                <button class="btn btn-primary" onclick="salvarCursos()">Salvar Seleção</button>
            </div>

        </div>
    </div>
</div>


<!-- ============================================== -->
<!-- ================ MODAL EVENTOS ================ -->
<!-- ============================================== -->
<div class="modal fade" id="modalEventos" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Selecionar Eventos</h5>
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
                    <% for (Evento e : eventos) { %>
                    <tr>
                        <td>
                            <input type="checkbox" class="checkEvento"
                                   value="<%= e.getId() %>"
                                   <%= eventosIds.contains(String.valueOf(e.getId())) ? "checked" : "" %>>
                        </td>
                        <td><%= e.getId() %></td>
                        <td><%= e.getTitulo() %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="modal-footer">
                <button class="btn btn-primary" onclick="salvarEventos()">Salvar Seleção</button>
            </div>

        </div>
    </div>
</div>


<!-- ============================================== -->
<!-- ================ MODAL SERVIÇOS =============== -->
<!-- ============================================== -->
<div class="modal fade" id="modalServicos" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
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
                    <% for (Servico s : servicos) { %>
                    <tr>
                        <td>
                            <input type="checkbox" class="checkServico"
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
                <button class="btn btn-primary" onclick="salvarServicos()">Salvar Seleção</button>
            </div>

        </div>
    </div>
</div>


<!-- ============================================== -->
<!-- ================ MODAL PROJETOS ============== -->
<!-- ============================================== -->
<div class="modal fade" id="modalProjetos" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Selecionar Projetos</h5>
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
                    <% for (Projeto pr : projetos) { %>
                    <tr>
                        <td>
                            <input type="checkbox" class="checkProjeto"
                                   value="<%= pr.getId() %>"
                                   <%= projetosIds.contains(String.valueOf(pr.getId())) ? "checked" : "" %>>
                        </td>
                        <td><%= pr.getId() %></td>
                        <td><%= pr.getTitulo() %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="modal-footer">
                <button class="btn btn-primary" onclick="salvarProjetos()">Salvar Seleção</button>
            </div>

        </div>
    </div>
</div>


<!-- ============================================== -->
<!-- ================ JAVASCRIPT =================== -->
<!-- ============================================== -->
<script>

function coletarValores(classe) {
    let arr = [];
    document.querySelectorAll("." + classe + ":checked").forEach(item => arr.push(item.value));
    return arr.join(",");
}

function salvarCursos() {
    let ids = coletarValores("checkCurso");
    document.getElementById("cursosIds").value = ids;
    document.getElementById("cursosSelecionados").innerText = ids;
    bootstrap.Modal.getInstance(document.getElementById("modalCursos")).hide();
}

function salvarEventos() {
    let ids = coletarValores("checkEvento");
    document.getElementById("eventosIds").value = ids;
    document.getElementById("eventosSelecionados").innerText = ids;
    bootstrap.Modal.getInstance(document.getElementById("modalEventos")).hide();
}

function salvarServicos() {
    let ids = coletarValores("checkServico");
    document.getElementById("servicosIds").value = ids;
    document.getElementById("servicosSelecionados").innerText = ids;
    bootstrap.Modal.getInstance(document.getElementById("modalServicos")).hide();
}

function salvarProjetos() {
    let ids = coletarValores("checkProjeto");
    document.getElementById("projetosIds").value = ids;
    document.getElementById("projetosSelecionados").innerText = ids;
    bootstrap.Modal.getInstance(document.getElementById("modalProjetos")).hide();
}

</script>

</body>
</html>
