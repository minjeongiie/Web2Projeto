package dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import model.Inscricao;
import util.JPAUtil;
import jakarta.persistence.EntityManager;

public class InscricaoDAO {

    public void salvar(Inscricao i) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(i);
        em.getTransaction().commit();
        em.close();
    }

    public List<Inscricao> buscarPorAluno(int alunoId) {
        EntityManager em = JPAUtil.getEntityManager();

        Query q = em.createQuery(
            "SELECT i FROM Inscricao i WHERE i.aluno.id = :alunoId"
        );
        q.setParameter("alunoId", alunoId);

        List<Inscricao> lista = q.getResultList();
        em.close();

        return lista;
    }

    public Inscricao buscarExistente(int alunoId, String tipo, int extensaoId) {
        EntityManager em = JPAUtil.getEntityManager();

        Query q = em.createQuery(
            "SELECT i FROM Inscricao i WHERE i.aluno.id = :aluno AND i.tipo = :tipo AND i.extensaoId = :ext"
        );
        q.setParameter("aluno", alunoId);
        q.setParameter("tipo", tipo);
        q.setParameter("ext", extensaoId);

        List<Inscricao> lista = q.getResultList();
        em.close();

        if (lista.isEmpty()) return null;
        return lista.get(0);
    }
    public List<Inscricao> listarPorAluno(int alunoId) {
        EntityManager em = JPAUtil.getEntityManager();

        List<Inscricao> lista = em.createQuery(
            "SELECT i FROM Inscricao i WHERE i.aluno.id = :a", Inscricao.class)
            .setParameter("a", alunoId)
            .getResultList();

        // Preencher os títulos dinamicamente
        for (Inscricao i : lista) {
            String tipo = i.getTipo();
            int id = i.getExtensaoId();

            String titulo = "";

            switch (tipo) {
                case "Curso":
                    titulo = em.find(model.Curso.class, id).getTitulo();
                    break;
                case "Serviço":
                    titulo = em.find(model.Servico.class, id).getTitulo();
                    break;
                case "Evento":
                    titulo = em.find(model.Evento.class, id).getTitulo();
                    break;
                case "Projeto":
                    titulo = em.find(model.Projeto.class, id).getTitulo();
                    break;
                case "Programa":
                    titulo = em.find(model.Programa.class, id).getTitulo();
                    break;
            }

            i.setTituloAtividade(titulo);
        }

        em.close();
        return lista;
    }

    public void cancelar(int id) {
    	EntityManager em = JPAUtil.getEntityManager();
    	
        Inscricao i = em.find(Inscricao.class, id);
        if (i != null) {
            em.getTransaction().begin();
            em.remove(i);
            em.getTransaction().commit();
        }
    }


}
