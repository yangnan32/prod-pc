package com.product.test;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yangn on 2017/5/9.
 */
@Repository
public class TestDaoImpl implements TestDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Test add(Test test) {
        Session session = sessionFactory.getCurrentSession();
        session.save(test);
        return test;
    }

    @Override
    public Test update(Test test) {
        Session session = sessionFactory.getCurrentSession();
        session.update(test);
        return test;
    }

    @Override
    public Test view(String id) {
        Session session = sessionFactory.getCurrentSession();
        String sql = "select * from TEST where id='"+id+"'";
        SQLQuery query = session.createSQLQuery(sql);
        Test test = (Test) query.addEntity(Test.class).uniqueResult();
        return test;
    }

    @Override
    public boolean delete(String id) {
        try {
            Session session = sessionFactory.getCurrentSession();
            String sql = "DELETE FROM Test WHERE id ='"+id+"'";
            session.createSQLQuery(sql).executeUpdate();
        } catch (HibernateException ex) {
            return false;
        }
        return true;
    }

    @Override
    public List<Test> queryTestList() {
        Session session = sessionFactory.getCurrentSession();
        String sql = "select * from TEST t";
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        List list = sqlQuery.addEntity(Test.class).list();
        return list;
    }
}
