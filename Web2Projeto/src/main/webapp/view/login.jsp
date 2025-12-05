<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Extensão UFRRJ</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
     href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body class="bg-light">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<nav class="navbar navbar-expand-lg navbar-dark bg-cobalto text-white">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img src="<%=request.getContextPath()%>/img/rural_logo_branco04.png" alt="Logo UFRRJ" width="250">
    </a>
  </div>
</nav>
<div class="container col-4 mt-5">
    <h2 id="#" class="text-center mb-4">Login</h2>

    <form action="${pageContext.request.contextPath}/login" method="post">

        <div class="mb-3">
            <label>Email</label>
            <input type="text" name="email" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Senha</label>
            <input type="password" name="senha" class="form-control" required>
        </div>

        <% if (request.getAttribute("erro") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("erro") %>
            </div>
        <% } %>

        <button class="btn btn-primary w-100">Entrar</button>
    </form>
</div>
</body>
</html>
