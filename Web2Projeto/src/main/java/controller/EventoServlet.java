package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

import dao.EventoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Evento;

@WebServlet("/prof/eventos")
public class EventoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");

        if (acao == null) {
            // LISTAR
            EventoDAO dao = new EventoDAO();
            req.setAttribute("lista", dao.listarTodos());
            req.getRequestDispatcher("/view/professor/eventos-listar.jsp").forward(req, resp);
            return;
        }
        	// FORMULÁRIO
        if ("form".equals(acao)) {
            req.getRequestDispatcher("/view/professor/eventos-form.jsp").forward(req, resp);
            return;
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        Evento e = new Evento();

        e.setTitulo(req.getParameter("titulo"));
        e.setDescricao(req.getParameter("descricao"));
        e.setResponsavel(req.getParameter("responsavel"));
        e.setContatoInscricao(req.getParameter("contato"));
        e.setLinkExterno(req.getParameter("linkExterno"));
        e.setPublicoAlvo(req.getParameter("publicoAlvo"));
        e.setStatus(req.getParameter("status"));

        e.setTemTaxa(req.getParameter("temTaxa") != null);

        e.setDataInicio(LocalDate.parse(req.getParameter("dataInicio")));
        e.setDataFim(LocalDate.parse(req.getParameter("dataFim")));

        e.setHoraDeInicio(LocalTime.parse(req.getParameter("horaInicio")));
        e.setHoraDeTermino(LocalTime.parse(req.getParameter("horaFim")));

        e.setMaxParticipantes(Integer.parseInt(req.getParameter("maxParticipantes")));

        e.setLocal(req.getParameter("local"));


        new EventoDAO().salvar(e);

        resp.sendRedirect(req.getContextPath() + "/prof/eventos");
    }
}
