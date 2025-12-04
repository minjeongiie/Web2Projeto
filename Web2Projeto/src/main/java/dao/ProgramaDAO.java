package dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import model.Programa;
import util.JPAUtil;

public class ProgramaDAO {

    public void salvar(Programa p) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        if (p.getId() == null) {
            em.persist(p);
        } else {
            em.merge(p);
        }
        em.getTransaction().commit();
        em.close();
    }

    public Programa buscarPorId(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        Programa p = em.find(Programa.class, id);
        em.close();
        return p;
    }

    public List<Programa> listarTodos() {
        EntityManager em = JPAUtil.getEntityManager();
        Query q = em.createQuery("SELECT p FROM Programa p ORDER BY p.dataInicio DESC");
        List<Programa> lista = q.getResultList();
        em.close();
        return lista;
    }

    public void excluir(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        Programa p = em.find(Programa.class, id);
        em.getTransaction().begin();
        if (p != null) {
            em.remove(p);
        }
        em.getTransaction().commit();
        em.close();
    }
}
