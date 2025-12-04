package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.EventoDAO;
import dao.CursoDAO;
import dao.ServicoDAO;
import dao.ProjetoDAO;
import dao.ProgramaDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Evento;
import model.Curso;
import model.Servico;
import model.Projeto;
import model.Programa;
import model.ExtensaoResumo;

@WebServlet("/aluno/home")
public class AlunoHomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<ExtensaoResumo> lista = new ArrayList<>();

        // EVENTOS
        for (Evento e : new EventoDAO().listarTodos()) {
            lista.add(new ExtensaoResumo(
                    e.getId(),
                    e.getTitulo(),
                    "Evento",
                    String.valueOf(e.getDataInicio()),
                    String.valueOf(e.getDataFim()),
                    e.getStatus()
            ));
        }

        // CURSOS
        for (Curso c : new CursoDAO().listarTodos()) {
            lista.add(new ExtensaoResumo(
                    c.getId(),
                    c.getTitulo(),
                    "Curso",
                    String.valueOf(c.getDataInicio()),
                    String.valueOf(c.getDataFim()),
                    c.getStatus()
            ));
        }

        // SERVICOS
        for (Servico s : new ServicoDAO().listarTodos()) {
            lista.add(new ExtensaoResumo(
                    s.getId(),
                    s.getTitulo(),
                    "Serviço",
                    String.valueOf(s.getDataInicio()),
                    String.valueOf(s.getDataFim()),
                    s.getStatus()
            ));
        }

        // PROJETOS
        for (Projeto p : new ProjetoDAO().listarTodos()) {
            lista.add(new ExtensaoResumo(
                    p.getId(),
                    p.getTitulo(),
                    "Projeto",
                    String.valueOf(p.getDataInicio()),
                    String.valueOf(p.getDataFim()),
                    p.getStatus()
            ));
        }

        // PROGRAMAS
        for (Programa pg : new ProgramaDAO().listarTodos()) {
            lista.add(new ExtensaoResumo(
                    pg.getId(),
                    pg.getTitulo(),
                    "Programa",
                    String.valueOf(pg.getDataInicio()),
                    String.valueOf(pg.getDataFim()),
                    pg.getStatus()
            ));
        }

        req.setAttribute("lista", lista);
        req.getRequestDispatcher("/view/aluno/home.jsp").forward(req, resp);
    }
}
