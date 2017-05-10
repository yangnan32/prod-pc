<%@ tag pageEncoding="UTF-8" %>
<%@ tag import="com.samskivert.mustache.Template" %>
<%@ tag import="com.widget.framework.login.Identity"%>
<%@ tag import="com.widget.framework.system.engine.SystemContext" %>
<%@ tag import="com.widget.uiframe.uistate.ComponentStateService" %>
<%@ tag import="com.widget.uiframe.uistate.ComponentStateVo" %>
<%@ tag import="com.widget.uiframe.view.model.grid.Column" %>
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
<%@attribute name="bean" rtexprvalue="true" required="true" type="com.widget.uiframe.view.model.grid.Grid" description="bean"%>
<%@attribute name="singleSelect" rtexprvalue="true"  required="false" description="是否单选,值为true或者false，默认是false" %>
<%

    ComponentStateService componentStateService=(ComponentStateService) SystemContext.getBean("componentStateServiceImpl");
    Identity identity=(Identity)SystemContext.getBean("identity");
    ComponentStateVo vo=new ComponentStateVo();
    vo.setGroupId(identity.getUserId());
    vo.setComponentId(bean.getGridId());
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


    Boolean  singleSelectText;
    if(StringUtils.isNotBlank(width)){
        int w = Integer.parseInt(width);
        bean.setWidth(w);
    }
    if(StringUtils.isNotBlank(height)){
        int h = Integer.parseInt(height);
        bean.setHeight(h);
        bean.setGridDataHeight(h - 53);
    }
    if(StringUtils.isNotEmpty(singleSelect) && singleSelect.equalsIgnoreCase("true")){
        singleSelectText = true;
    } else {
        singleSelectText = false;
    }
    MustacheViewResolver mustacheViewResolver= (MustacheViewResolver)  RequestContextUtils.getWebApplicationContext(request).getBean("mustacheViewResolver");
    Template template = mustacheViewResolver.compileTemplate("WEB-INF/mustache/gridpanel.html");
    Map map = new HashMap();
    bean.setId(id);
    map.put("grid",bean);
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
%>
<%
%>
<script type="text/javascript">

    (function(){
        var s=function(){
            var params={
                gridId:"<%=id%>",                                     //表格的ID值
                singleSelect:<%=singleSelectText%>,                  //是否单选
                useCheckbox:<%=bean.getUseCheckbox()%>,              //是否使用复选框
                columns:<%=returnobj%>,                               //表头数据组
                forceFit:<%=bean.getForceFit()%>,                     //是否只适应宽度
                recordPage:<%=bean.getPageSize()%>,                   //每页显示条数
                dataTotal:<%=bean.getDataTotal()%>,                   //表格总数据条数
                totalPage:<%=bean.getTotalPage()%>,                   //表格总页数
                records:<%=bean.getGridDatasJson()%>                  //表格Json数据
            };
            var model=new $.SywMustacheGridModel(params);
            var view=new $.SywMustacheGridView({model:model,el:$("#<%=id%>")});
            if(<%=fitText%>){
                view.$el.hide();
                var $parent = view.$el.parent("div");
                $parent.resize(function(){
                    view.setWidth($parent.width());
//                    view.setHeight($parent.height());
                })
                var parentWidth = $parent.width();
                var parentHeight = $parent.height();
                view.setWidth(parentWidth);
                view.setHeight(parentHeight);
                view.$el.show();
            }
            widget.viewManager.addView("<%=id%>",view);      //创建视图
        };
        s.orderNumber=20;
        executeQueue.push(s);
    })();

</script>
<%=html%>
