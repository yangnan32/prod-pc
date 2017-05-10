package com.product.test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by yangn on 2017/5/9.
 */
@Service
@Transactional
public class TestServiceImpl implements TestService {

    @Autowired
    private TestDao testDao;

    @Override
    public Test add(Test test) {
        test.setCreateTime(new Date());
        test.setUpdateTime(new Date());
        return testDao.add(test);
    }

    @Override
    public Test update(Test test) {
        test.setUpdateTime(new Date());
        return testDao.update(test);
    }

    @Override
    public Test view(String id) {
        return testDao.view(id);
    }

    @Override
    public boolean delete(String id) {
        return testDao.delete(id);
    }

    @Override
    public List<Test> queryTestList() {
        return testDao.queryTestList();
    }
}
