<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Programa" %>

<%
    List<Programa> lista = (List<Programa>) request.getAttribute("lista");
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
    <title>Programas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">

    <h2 class="mb-4">Programas</h2>

    <a href="${pageContext.request.contextPath}/prof/programas?acao=form" 
       class="btn btn-primary mb-3">
        + Novo Programa
    </a>

    <table class="table table-hover">
        <thead>
            <tr>
                <th>Título</th>
                <th>Data</th>
                <th>Status</th>
                <th style="width:150px;">Ações</th>
            </tr>
        </thead>

        <tbody>
        <% 
            if (lista != null) {
                for (Programa p : lista) { 
        %>
            <tr>
                <td><%= p.getTitulo() %></td>
                <td>
                    <%= p.getDataInicio() %> até <%= p.getDataFim() %>
                </td>
                <td><%= p.getStatus() %></td>

                <td>
                    <a href="${pageContext.request.contextPath}/prof/programas?acao=editar&id=<%= p.getId() %>"
                       class="btn btn-sm btn-warning">
                        Editar
                    </a>

                    <a href="${pageContext.request.contextPath}/prof/programas?acao=excluir&id=<%= p.getId() %>"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Tem certeza que deseja excluir este programa?');">
                        Excluir
                    </a>
                </td>
            </tr>
        <% 
                }
            } 
        %>
        </tbody>
    </table>
</div>

</body>
</html>
