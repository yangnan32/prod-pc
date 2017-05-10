<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 13-1-24下午1:58
    * @team	    : 
    * @author      : yangn
--%>
<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="com.samskivert.mustache.Template" %>
<%@ tag import="com.widget.framework.login.Identity"%>
<%@ tag import="com.widget.framework.system.engine.SystemContext" %>
<%@ tag import="com.widget.uiframe.uistate.ComponentStateService" %>
<%@ tag import="com.widget.uiframe.uistate.ComponentStateVo" %>
<%@ tag import="com.widget.uiframe.view.model.treegrid.Column" %>
<%@ tag import="com.widget.uiframe.view.mustache.MustacheViewResolver" %>
<%@ tag import="net.sf.json.JSONArray" %>
<%@ tag import="net.sf.json.JsonConfig" %>
<%@ tag import="net.sf.json.util.CycleDetectionStrategy" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="org.springframework.web.servlet.support.RequestContextUtils" %>
<%@ tag import="javax.script.Invocable" %>
<%@ tag import="javax.script.ScriptEngine" %>
<%@ tag import="javax.script.ScriptEngineManager" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="java.util.Map" %>
<%@attribute name="id" rtexprvalue="true" required="true" description="面板的id" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值500" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值300" %>
<%@attribute name="fit" rtexprvalue="true"  required="false" description="表格是否自适应父级宽高，默认是false" %>
<%@attribute name="bean" rtexprvalue="true" required="true" type="com.widget.uiframe.view.model.treegrid.TreeGrid" description="bean"%>
<%@attribute name="resizable" rtexprvalue="true"  required="false" description="是否可拖动" %>
<%

    ComponentStateService componentStateService=(ComponentStateService) SystemContext.getBean("componentStateServiceImpl");
    Identity identity=(Identity)SystemContext.getBean("identity");
    ComponentStateVo vo=new ComponentStateVo();
    vo.setGroupId(identity.getUserId());
    vo.setComponentId(bean.getTreeGridId());
    vo=componentStateService.fetchComponentState(vo);

    if(vo!=null && vo.getState()!=null&&!vo.getState().equals("")){
        ScriptEngineManager scriptEngineManager=new ScriptEngineManager();
        ScriptEngine scriptEngine=scriptEngineManager.getEngineByName("javascript");
        Invocable invocable=(Invocable)scriptEngine;
        scriptEngine.eval("function getColumnValue(columnId,columnName){var columns="+vo.getState()+";for(var i=0;i<columns.length;i++){if(columns[i].id==columnId) return (columns[i][columnName]);} }");
        for(Column column:bean.getColumns()){
            Double col_width = (Double) invocable.invokeFunction("getColumnValue",column.getId(),"width");
            Boolean col_hidden=(Boolean)invocable.invokeFunction("getColumnValue",column.getId(),"hidden");
            column.setWidth(col_width.intValue());
            column.setHidden(col_hidden);
        }
    }

    if(StringUtils.isNotBlank(width)){
        int w = Integer.parseInt(width);
        bean.setWidth(w);
    }
    if(StringUtils.isNotBlank(height)){
        int h = Integer.parseInt(height);
        bean.setHeight(h);
        bean.setTreeGridDataHeight(h - 28);
    }
    MustacheViewResolver mustacheViewResolver= (MustacheViewResolver)  RequestContextUtils.getWebApplicationContext(request).getBean("mustacheViewResolver");
    Template template = mustacheViewResolver.compileTemplate("WEB-INF/mustache/treeGridPanel.html");
    Map map = new HashMap();
    bean.setId(id);
    map.put("treeGrid",bean);
    JsonConfig jsonConfig = new JsonConfig();
    jsonConfig.setIgnoreDefaultExcludes(false);
    jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
    jsonConfig.setExcludes(new String[]{
            "render"
    });
    JSONArray returnobj =  JSONArray.fromObject(bean.getColumns(),jsonConfig);
    if(bean.getForceFit()){
        int fixColumn = 0;
        int fixColumnWidth = 20;
        int columnWidth;

        if(bean.getUseCheckbox()){
            fixColumnWidth += 18;
        }
        for(int i = 0; i < bean.getColumns().size(); i ++) {
            if(bean.getColumns().get(i).getFixColumn()){
                fixColumnWidth +=  bean.getColumns().get(i).getWidth() + 6;
                fixColumn++;
                if(bean.getColumns().get(i).getHidden()){
                    fixColumnWidth -=  bean.getColumns().get(i).getWidth() + 6;
                }
            } else {
                if(bean.getColumns().get(i).getHidden()){
                    fixColumn++;
                }
            }
        }

        columnWidth = (bean.getWidth() - fixColumnWidth) / (bean.getColumns().size() - fixColumn);

        for(int i = 0; i < bean.getColumns().size(); i ++) {
            if(!bean.getColumns().get(i).getFixColumn()){
                bean.getColumns().get(i).setWidth(columnWidth - 6);
            }
        }
    }

    String html=template.execute(map);
    if(html.codePointAt(0)==65279){
        html=html.substring(3);
    }
    boolean fitText;
    if(StringUtils.isNotEmpty(fit) && fit.equalsIgnoreCase("true")){
        fitText=true;
    } else {
        fitText=false;
    }
    boolean resizableFlag;
    if(StringUtils.isNotEmpty(resizable) && resizable.equalsIgnoreCase("true")){
        resizableFlag=true;
    } else {
        resizableFlag=false;
    }

%>
<script type="text/javascript">

    (function(){
        var treeGrid=function(){
            var params={
                treeGridId:"<%=id%>",                                //表格的ID值
                singleSelect:<%=bean.getSingleSelect()%>,            //是否单选
                resizable:<%=resizableFlag%>,                        //是否可拖动
                useCheckbox:<%=bean.getUseCheckbox()%>,              //是否使用复选框
                columns:<%=returnobj%>,                              //表头数据组
                records:<%=bean.getTreeGridDatasJson()%>,            //表格Json数据
                recordMaps:<%=JSONArray.fromObject(bean.getDataMap()).toString()%>[0]   //表格Map数据,key为每条数据的id值
            };
            var model=new $.SywMustacheTreeGridModel(params);
            var view=new $.SywMustacheTreeGridView({model:model,el:$("#<%=id%>")});
            if(<%=fitText%>){
                view.$el.hide();
                var $parent = view.$el.parent("div");
                $parent.resize(function(){
                    view.setWidth($parent.width());
//                    view.setHeight($parent.height());
                });
                var parentWidth = $parent.width();
                var parentHeight = $parent.height();
                view.setWidth(parentWidth);
                view.setHeight(parentHeight);
                view.$el.show();
            }
            widget.viewManager.addView("<%=id%>",view);      //创建视图
        };
        treeGrid.orderNumber=21;
        executeQueue.push(treeGrid);
    })();

</script>
<%=html%>