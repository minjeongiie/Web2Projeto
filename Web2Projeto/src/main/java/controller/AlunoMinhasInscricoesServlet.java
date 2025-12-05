package controller;

import java.io.IOException;
import java.util.List;

import dao.InscricaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Aluno;
import model.Inscricao;

@WebServlet("/aluno/inscricoes")
public class AlunoMinhasInscricoesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Object user = session.getAttribute("usuario");

        if (!(user instanceof Aluno)) {
            resp.sendRedirect("../login.jsp");
            return;
        }

        Aluno aluno = (Aluno) user;

        InscricaoDAO dao = new InscricaoDAO();
        List<Inscricao> lista = dao.listarPorAluno(aluno.getId());

        req.setAttribute("lista", lista);
        req.getRequestDispatcher("/view/aluno/inscricoes.jsp").forward(req, resp);
    }
}
