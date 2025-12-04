package controller;

import java.io.IOException;
import java.time.LocalDate;

import dao.CursoDAO;
import dao.EventoDAO;
import dao.ProjetoDAO;
import dao.ProgramaDAO;
import dao.ServicoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Programa;

@WebServlet("/prof/programas")
public class ProgramaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");
        ProgramaDAO dao = new ProgramaDAO();

        if (acao == null) {
            req.setAttribute("lista", dao.listarTodos());
            req.getRequestDispatcher("/view/professor/programas-listar.jsp").forward(req, resp);
            return;
        }

        if ("form".equals(acao)) {
            // novo
            Programa p = new Programa();
            req.setAttribute("programa", p);

            // enviar listas para modais
            req.setAttribute("cursos", new CursoDAO().listarTodos());
            req.setAttribute("eventos", new EventoDAO().listarTodos());
            req.setAttribute("servicos", new ServicoDAO().listarTodos());
            req.setAttribute("projetos", new ProjetoDAO().listarTodos());

            req.getRequestDispatcher("/view/professor/programas-form.jsp").forward(req, resp);
            return;
        }

        if ("editar".equals(acao)) {
            Integer id = Integer.valueOf(req.getParameter("id"));
            Programa p = dao.buscarPorId(id);
            req.setAttribute("programa", p);

            // enviar listas para modais
            req.setAttribute("cursos", new CursoDAO().listarTodos());
            req.setAttribute("eventos", new EventoDAO().listarTodos());
            req.setAttribute("servicos", new ServicoDAO().listarTodos());
            req.setAttribute("projetos", new ProjetoDAO().listarTodos());

            req.getRequestDispatcher("/view/professor/programas-form.jsp").forward(req, resp);
            return;
        }

        if ("excluir".equals(acao)) {
            Integer id = Integer.valueOf(req.getParameter("id"));
            dao.excluir(id);
            resp.sendRedirect(req.getContextPath() + "/prof/programas");
            return;
        }

        // se não reconheceu a ação, volta para listagem
        resp.sendRedirect(req.getContextPath() + "/prof/programas");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String idParam = req.getParameter("id");
        Integer id = (idParam != null && !idParam.isBlank()) ? Integer.valueOf(idParam) : null;

        ProgramaDAO dao = new ProgramaDAO();
        Programa p = (id == null) ? new Programa() : dao.buscarPorId(id);

        // CAMPOS (Extensao)
        p.setTitulo(req.getParameter("titulo"));
        p.setDescricao(req.getParameter("descricao"));
        p.setResponsavel(req.getParameter("responsavel"));
        p.setContatoInscricao(req.getParameter("contato"));
        p.setLinkExterno(req.getParameter("linkExterno"));
        p.setPublicoAlvo(req.getParameter("publicoAlvo"));
        p.setStatus(req.getParameter("status"));
        p.setTemTaxa(req.getParameter("temTaxa") != null);
        p.setLocal(req.getParameter("local"));

        // datas/horas (defensivo: checar nulls)
        String di = req.getParameter("dataInicio");
        if (di != null && !di.isBlank()) p.setDataInicio(LocalDate.parse(di));

        String df = req.getParameter("dataFim");
        if (df != null && !df.isBlank()) p.setDataFim(LocalDate.parse(df));


        // CAMPOS ESPECÍFICOS DO PROGRAMA (modelo string-ids)
        p.setDuracao(req.getParameter("duracao"));
        p.setCursosIds(req.getParameter("cursosIds"));
        p.setEventosIds(req.getParameter("eventosIds"));
        p.setServicosIds(req.getParameter("servicosIds"));
        p.setProjetosIds(req.getParameter("projetosIds"));

        dao.salvar(p);

        resp.sendRedirect(req.getContextPath() + "/prof/programas");
    }
}
