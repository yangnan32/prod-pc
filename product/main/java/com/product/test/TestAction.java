package com.product.test;

import com.product.utils.UiframeConvertDate;
import com.product.utils.UiframePageWrite;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by yangn on 2017/5/9.
 */
@Controller
@RequestMapping(value = "test/")
public class TestAction {

    @Autowired
    private TestService testService;

    /**
     * test首页
     * @param
     * @return
     */
    @RequestMapping(value = "index")
    public String ui_sample() {
        return "product/test/test";
    }

    /**
     * 新建
     * @param
     * @return
     */
    @RequestMapping(value = "addTest")
    public void addClassify(Test test, HttpServletRequest request, HttpServletResponse response) {
        Test newTest = testService.add(test);
        UiframePageWrite.writeTOPage(response, "{success:true}");
    }

    /**
     * 编辑
     *
     * @param
     * @return
     */
    @RequestMapping(value = "updateTest")
    public void updateClassify(Test test, HttpServletRequest request, HttpServletResponse response) {
        String createTime = request.getParameter("myTime") != null ? request.getParameter("myTime") : "";
        test.setCreateTime(UiframeConvertDate.StrToTimes(createTime));
        Test newTest = testService.update(test);
        UiframePageWrite.writeTOPage(response, "{success:true}");
    }

    /**
     * 删除
     *
     * @return
     */
    @RequestMapping(value = "deleteTest")
    public void deleteClassify(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id") != null ? request.getParameter("id") : "";
        boolean flag = testService.delete(id);
        UiframePageWrite.writeTOPage(response, "{success:" + flag + "}");
    }

    /**
     * 查看
     * @param
     * @return
     */
    @RequestMapping(value = "viewTest")
    public String viewClassify(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id") != null ? request.getParameter("id") : "";
        Test test = null;
        if (id != null && !id.equals("")) {
            test = testService.view(id);
        }
        request.setAttribute("data", test);
        return "product/test/testForm";
    }



    @RequestMapping(value = "queryTestList")
    public String queryClassfiyList(HttpServletRequest request, HttpServletResponse response) {
        List<Test> tests = testService.queryTestList();
        request.setAttribute("dataCount", 10);
        request.setAttribute("dataList", tests);
        return "product/test/testData";
    }
}
