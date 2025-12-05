package controller;

import java.io.IOException;

import dao.CursoDAO;
import dao.EventoDAO;
import dao.ServicoDAO;
import dao.ProjetoDAO;
import dao.ProgramaDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Extensao;

@WebServlet("/aluno/detalhes")
public class AlunoDetalhesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String tipo = req.getParameter("tipo");   // evento, curso, servico, projeto, programa
        String idParam = req.getParameter("id");

        if (tipo == null || idParam == null) {
            resp.getWriter().println("Parâmetros inválidos!");
            return;
        }

        int id = Integer.parseInt(idParam);

        Extensao extensao = null;

        switch (tipo.toLowerCase()) {

            case "evento":
                extensao = new EventoDAO().buscarPorId(id);
                break;

            case "curso":
                extensao = new CursoDAO().buscarPorId(id);
                break;

            case "serviço":
                extensao = new ServicoDAO().buscarPorId(id);
                break;

            case "projeto":
                extensao = new ProjetoDAO().buscarPorId(id);
                break;

            case "programa":
                extensao = new ProgramaDAO().buscarPorId(id);
                break;

            default:
                resp.getWriter().println("Tipo desconhecido!");
                return;
        }

        if (extensao == null) {
            resp.getWriter().println("Atividade não encontrada!");
            return;
        }

        // ENVIA PARA O JSP
        req.setAttribute("extensao", extensao);
        req.setAttribute("tipo", tipo.substring(0, 1).toUpperCase() + tipo.substring(1)); // formata tipo

        req.getRequestDispatcher("/view/aluno/detalhes.jsp").forward(req, resp);
    }
}

