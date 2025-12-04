package dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.Servico;
import util.JPAUtil;

public class ServicoDAO {

    public void salvar(Servico s) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();

        if (s.getId() == null) {
            em.persist(s);
        } else {
            em.merge(s);
        }

        em.getTransaction().commit();
        em.close();
    }

    public Servico buscarPorId(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        Servico s = em.find(Servico.class, id);
        em.close();
        return s;
    }

    public List<Servico> listarTodos() {
        EntityManager em = JPAUtil.getEntityManager();
        TypedQuery<Servico> q = em.createQuery(
            "SELECT s FROM Servico s ORDER BY s.dataInicio DESC",
            Servico.class
        );
        List<Servico> lista = q.getResultList();
        em.close();
        return lista;
    }

    public void excluir(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();
        Servico s = em.find(Servico.class, id);

        if (s != null) {
            em.getTransaction().begin();
            em.remove(s);
            em.getTransaction().commit();
        }

        em.close();
    }
}