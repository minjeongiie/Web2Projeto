package dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import model.Inscricao;
import util.JPAUtil;

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
}
