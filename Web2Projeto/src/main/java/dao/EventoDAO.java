package dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.Evento;
import util.JPAUtil;

public class EventoDAO {

    public void salvar(Evento e) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(e);
        em.getTransaction().commit();
        em.close();
    }

    public List<Evento> listarTodos() {
        EntityManager em = JPAUtil.getEntityManager();
        TypedQuery<Evento> q = em.createQuery("SELECT e FROM Evento e ORDER BY e.dataInicio DESC", Evento.class);
        return q.getResultList();
    }

    public Evento buscarPorId(int id) {
        return JPAUtil.getEntityManager().find(Evento.class, id);
    }

    public void atualizar(Evento e) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(e);
        em.getTransaction().commit();
        em.close();
    }
}
