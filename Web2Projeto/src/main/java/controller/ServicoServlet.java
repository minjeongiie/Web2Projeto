package controller;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import dao.ServicoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Servico;

@WebServlet("/prof/servicos")
public class ServicoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");
        ServicoDAO dao = new ServicoDAO();

        if (acao == null) {
            req.setAttribute("lista", dao.listarTodos());
            req.getRequestDispatcher("/view/professor/servicos-listar.jsp")
               .forward(req, resp);
            return;
        }

        switch (acao) {

        case "form":
            req.getRequestDispatcher("/view/professor/servicos-form.jsp")
               .forward(req, resp);
            break;

        case "editar":
            Integer id = Integer.valueOf(req.getParameter("id"));
            Servico s = dao.buscarPorId(id);
            req.setAttribute("servico", s);
            req.getRequestDispatcher("/view/professor/servicos-form.jsp")
               .forward(req, resp);
            break;

        case "excluir":
            dao.excluir(Integer.valueOf(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/prof/servicos");
            break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String idParam = req.getParameter("id");
        Integer id = (idParam != null && !idParam.isBlank()) ? Integer.parseInt(idParam) : null;

        ServicoDAO dao = new ServicoDAO();
        Servico s = (id == null) ? new Servico() : dao.buscarPorId(id);

        // CAMPOS DE EXTENSAO
        s.setTitulo(req.getParameter("titulo"));
        s.setDescricao(req.getParameter("descricao"));
        s.setResponsavel(req.getParameter("responsavel"));
        s.setContatoInscricao(req.getParameter("contato"));
        s.setLinkExterno(req.getParameter("linkExterno"));
        s.setPublicoAlvo(req.getParameter("publicoAlvo"));
        s.setStatus(req.getParameter("status"));
        s.setTemTaxa(req.getParameter("temTaxa") != null);
        s.setLocal(req.getParameter("local"));
        s.setDataInicio(LocalDate.parse(req.getParameter("dataInicio")));
        s.setDataFim(LocalDate.parse(req.getParameter("dataFim")));


        // CAMPOS ESPECÍFICOS DO SERVIÇO
        s.setTipoServico(req.getParameter("tipoServico"));
        s.setHoraDeInicio(LocalTime.parse(req.getParameter("horarioInicio")));
        s.setHoraDeTermino(LocalTime.parse(req.getParameter("horarioFim")));
        s.setModalidadeAtendimento(req.getParameter("modalidadeAtendimento"));

        // LISTA DE DIAS (checkboxes)
        String[] dias = req.getParameterValues("diasAtendimento");
        String diasStr = "";

        if (dias != null) {
            diasStr = String.join(", ", dias);  // "SEG, TER, QUA"
        }

        s.setDiasAtendimento(req.getParameter("diasAtendimento"));



        dao.salvar(s);

        resp.sendRedirect(req.getContextPath() + "/prof/servicos");
    }
}