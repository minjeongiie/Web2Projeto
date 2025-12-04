<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Extensao" %>
<%@ page import="model.Curso" %>
<%@ page import="model.Servico" %>
<%@ page import="model.Projeto" %>
<%@ page import="model.Programa" %>
<%@ page import="java.util.*" %>

<%
    // Verificação de login (aluno)
    Object user = session.getAttribute("usuario");
    if (user == null || !(user instanceof model.Aluno)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Extensao e = (Extensao) request.getAttribute("extensao");

    if (e == null) {
        out.println("<h3>Erro: Nenhuma atividade encontrada.</h3>");
        return;
    }

    String tipo = request.getParameter("tipo"); // Evento, Curso, Servico, Projeto, Programa
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes da Atividade</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-4">

    <h2>Detalhes - <%= e.getTitulo() %></h2>
    <p class="text-muted">Tipo: <strong><%= tipo %></strong></p>

    <hr>

    <!-- DADOS BÁSICOS -->
    <div class="row">

        <div class="col-md-8 mb-3">
            <label class="form-label">Descrição:</label>
            <div class="border p-2 rounded bg-light">
                <%= (e.getDescricao() == null ? "Sem descrição." : e.getDescricao()) %>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <label class="form-label">Responsável:</label>
            <div class="border p-2 rounded bg-light">
                <%= e.getResponsavel() %>
            </div>
        </div>

    </div>

    <div class="row">

        <div class="col-md-3 mb-3">
            <label class="form-label">Status:</label>
            <div class="border p-2 rounded bg-light">
                <%= e.getStatus() %>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <label class="form-label">Tem taxa?</label>
            <div class="border p-2 rounded bg-light">
                <%= (e.isTemTaxa() ? "Sim" : "Não") %>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <label class="form-label">Local:</label>
            <div class="border p-2 rounded bg-light">
                <%= (e.getLocal() == null ? "Não informado" : e.getLocal()) %>
            </div>
        </div>

    </div>

    <!-- DATAS -->
    <div class="row">

        <div class="col-md-3 mb-3">
            <label class="form-label">Data Início:</label>
            <div class="border p-2 rounded bg-light">
                <%= e.getDataInicio() %>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <label class="form-label">Data Fim:</label>
            <div class="border p-2 rounded bg-light">
                <%= e.getDataFim() %>
            </div>
        </div>

        <%-- EXIBE HORÁRIO SE FOR CURSO, EVENTO ou SERVIÇO --%>
        <%
            java.time.LocalTime hi = null;
            java.time.LocalTime hf = null;

            try {
                java.lang.reflect.Method m1 = e.getClass().getMethod("getHoraDeInicio");
                hi = (java.time.LocalTime) m1.invoke(e);

                java.lang.reflect.Method m2 = e.getClass().getMethod("getHoraDeTermino");
                hf = (java.time.LocalTime) m2.invoke(e);
            } catch (Exception ex) {}
        %>

        <% if (hi != null && hf != null) { %>
            <div class="col-md-3 mb-3">
                <label class="form-label">Início:</label>
                <div class="border p-2 rounded bg-light"><%= hi %></div>
            </div>

            <div class="col-md-3 mb-3">
                <label class="form-label">Término:</label>
                <div class="border p-2 rounded bg-light"><%= hf %></div>
            </div>
        <% } %>

    </div>

    <hr>

    <!-- RELACIONAMENTOS (PROJETO / PROGRAMA) -->
    <%
        if (e instanceof Projeto) {
            Projeto pr = (Projeto) e;
    %>
        <h4>Cursos Relacionados</h4>
        <p><%= (pr.getCursosIds() == null || pr.getCursosIds().isEmpty() ? "Nenhum" : pr.getCursosIds()) %></p>

        <h4>Serviços Relacionados</h4>
        <p><%= (pr.getServicosIds() == null || pr.getServicosIds().isEmpty() ? "Nenhum" : pr.getServicosIds()) %></p>

    <% } else if (e instanceof Programa) {
            Programa pg = (Programa) e;
    %>

        <h4>Cursos</h4>
        <p><%= (pg.getCursosIds() == null || pg.getCursosIds().isEmpty() ? "Nenhum" : pg.getCursosIds()) %></p>

        <h4>Serviços</h4>
        <p><%= (pg.getServicosIds() == null || pg.getServicosIds().isEmpty() ? "Nenhum" : pg.getServicosIds()) %></p>

        <h4>Eventos</h4>
        <p><%= (pg.getEventosIds() == null || pg.getEventosIds().isEmpty() ? "Nenhum" : pg.getEventosIds()) %></p>

        <h4>Projetos</h4>
        <p><%= (pg.getProjetosIds() == null || pg.getProjetosIds().isEmpty() ? "Nenhum" : pg.getProjetosIds()) %></p>

    <% } %>

    <hr>

    <!-- BOTÕES -->
    <a href="${pageContext.request.contextPath}/aluno/inscrever?tipo=<%= tipo %>&id=<%= e.getId() %>"
       class="btn btn-success btn-lg">Inscrever-se</a>

    <a href="<%=request.getContextPath()%>/view/aluno/home.jsp" class="btn btn-secondary btn-lg">Voltar</a>

</div>

</body>
</html>
