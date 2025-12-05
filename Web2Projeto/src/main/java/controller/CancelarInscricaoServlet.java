package controller;

import java.io.IOException;

import dao.InscricaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Aluno;

@WebServlet("/aluno/cancelar")
public class CancelarInscricaoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Object user = session.getAttribute("usuario");

        if (!(user instanceof Aluno)) {
            resp.sendRedirect("../login.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id")); // ID da inscrição

        InscricaoDAO dao = new InscricaoDAO();
        dao.cancelar(id);

        resp.sendRedirect(req.getContextPath() + "/aluno/inscricoes?msg=cancelado");
    }
}
