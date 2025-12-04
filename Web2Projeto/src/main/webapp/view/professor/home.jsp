<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Área do Professor</title>

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
        <span class="me-4">Olá, <strong><%= prof.getNome() %></strong></span>
        <a href="<%=request.getContextPath()%>/logout" class="btn btn-light btn-sm">Sair</a>
    </div>
  </div>
</nav>

<div id="#" class="container mt-5">

    <h2 class="text-center mb-4">Gerenciar Atividades de Extensão</h2>

    <div class="row g-4">

        <!-- Eventos -->
        <div class="col-md-4">
            <a href="<%=request.getContextPath()%>/prof/eventos" class="text-decoration-none">
                <div class="card shadow-sm text-center p-4">
                    <i class="bi bi-calendar-event display-3 text-primary"></i>
                    <h4 class="mt-3">Eventos</h4>
                    <p>Gerenciar eventos acadêmicos, palestras e workshops.</p>
                </div>
            </a>
        </div>

        <!-- Cursos -->
        <div class="col-md-4">
            <a href="<%=request.getContextPath()%>/prof/cursos" class="text-decoration-none">
                <div class="card shadow-sm text-center p-4">
                    <i class="bi bi-journal-bookmark display-3 text-success"></i>
                    <h4 class="mt-3">Cursos</h4>
                    <p>Abrir, alterar ou encerrar cursos de extensão.</p>
                </div>
            </a>
        </div>

        <!-- Projetos -->
        <div class="col-md-4">
            <a href="<%=request.getContextPath()%>/prof/projetos" class="text-decoration-none">
                <div class="card shadow-sm text-center p-4">
                    <i class="bi bi-folder2-open display-3 text-warning"></i>
                    <h4 class="mt-3">Projetos</h4>
                    <p>Gerenciar projetos de pesquisa e extensão.</p>
                </div>
            </a>
        </div>

        <!-- Programas -->
        <div class="col-md-4">
            <a href="<%=request.getContextPath()%>/prof/programas" class="text-decoration-none">
                <div class="card shadow-sm text-center p-4">
                    <i class="bi bi-columns-gap display-3 text-info"></i>
                    <h4 class="mt-3">Programas</h4>
                    <p>Criar e editar programas institucionais.</p>
                </div>
            </a>
        </div>

        <!-- Serviços -->
        <div class="col-md-4">
            <a href="<%=request.getContextPath()%>/prof/servicos" class="text-decoration-none">
                <div class="card shadow-sm text-center p-4">
                    <i class="bi bi-tools display-3 text-danger"></i>
                    <h4 class="mt-3">Serviços</h4>
                    <p>Gerenciar serviços ofertados à comunidade.</p>
                </div>
            </a>
        </div>

    </div>
</div>

</body>
</html>
