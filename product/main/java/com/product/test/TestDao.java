package com.product.test;

import java.util.List;

/**
 * Created by yangn on 2017/5/9.
 */
public interface TestDao {
    /**
     * 新增
     *
     * @param
     * @return
     */
    public Test add(Test test);

    /**
     * 更新
     *
     * @param
     * @return
     */
    public Test update(Test test);

    /**
     * 查看
     *
     * @param id
     * @return
     */
    public Test view(String id);

    /**
     * 刪除
     *
     * @param id
     * @return
     */
    public boolean delete(String id);

    /**
     * 查询list数据
     *
     * @return
     */
    public List<Test> queryTestList();
}
