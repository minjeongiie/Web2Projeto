package controller;

import java.io.IOException;
import java.time.LocalDate;

import dao.InscricaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Aluno;
import model.Inscricao;

@WebServlet("/aluno/inscrever")
public class AlunoInscricaoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Object user = session.getAttribute("usuario");

        if (!(user instanceof Aluno)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Aluno aluno = (Aluno) user;

        String tipo = req.getParameter("tipo");
        int id = Integer.parseInt(req.getParameter("id"));

        InscricaoDAO dao = new InscricaoDAO();

        // Verifica se já existe inscrição
        Inscricao existente = dao.buscarExistente(aluno.getId(), tipo, id);
        if (existente != null) {
            resp.sendRedirect(req.getContextPath() + "/aluno/home?msg=ja_inscrito");
            return;
        }

        // Criar nova inscrição
        Inscricao i = new Inscricao();
        i.setAluno(aluno);
        i.setTipo(tipo);
        i.setExtensaoId(id);
        i.setDataInscricao(LocalDate.now());
        i.setStatus("Inscrito");

        dao.salvar(i);

        resp.sendRedirect(req.getContextPath() + "/aluno/home?msg=ok");
    }
}
