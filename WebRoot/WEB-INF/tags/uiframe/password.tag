<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-5-25下午3:42
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag import="org.apache.commons.lang.StringUtils" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="group" rtexprvalue="true" required="false" description="控件 群组class名称，根据class选择器选择所需" %>

<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="控件的默认值" %>
<%@attribute name="readonly" rtexprvalue="true"   required="false" description="只读,值为readonly" %>
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="禁用,值为disabled" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="style样式代码" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式代码" %>
<%@attribute name="emptyText" rtexprvalue="true"  required="false" description="水印文字" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>

<%
    long uuid=new Date().getTime();
    boolean readOnlyFlag=false;
    boolean disabledFlag=false;
    boolean mustFlag=false;

    if(StringUtils.isEmpty(emptyText)){
        emptyText="";
    }

    if(StringUtils.isEmpty(name)){
        name="textTag"+id+uuid;
    }

    if(StringUtils.isNotEmpty(readonly)&&(readonly.equalsIgnoreCase("readonly")||readonly.equalsIgnoreCase("true"))){
        readOnlyFlag=true;
    }
    if(StringUtils.isNotEmpty(disabled)&&(disabled.equalsIgnoreCase("disabled")||disabled.equalsIgnoreCase("true"))){
        disabledFlag=true;
    }
    if(StringUtils.isNotEmpty(must)&&(must.equalsIgnoreCase("must")||must.equalsIgnoreCase("true"))){
        mustFlag=true;
    }
    if(StringUtils.isNotBlank(value)){
        value=value.replaceAll("\"","&quot;");
    }else {
        value="";
    }

%>
<script type="text/javascript">

    (function(){
        executeQueue.push(function(){
            var params={
                value:$("#<%=id%>").val()||"",
                must:<%=mustFlag%>,
                isTag:true,
                disabled:<%=disabledFlag%>,
                readonly:<%=readOnlyFlag%>,
                cid:'<%=id%>',
                emptyText:"<%=emptyText%>"
            };
            var view=new $.SywTextView({model:new $.SywTextModel(params),el:$("#spanTag<%=id%>")});
            $("#${id}").on("disabled",function(e){
                view.model.set({disabled:true});
                e.preventDefault();
            });
            $("#${id}").on("enable",function(e){
                view.model.set({disabled:false});
                e.preventDefault();
            });
        });
    })();
</script>
<span id="spanTag<%=id%>">
        <input type="password" id="<%=id%>" class="uiframe-textinput ${cls} ${group} <%if(disabledFlag){%> uiframe-textinput-disabled <%}%>" style='<%if(readOnlyFlag){%> cursor: default;<%}%><%=style%>'
                <%if(readOnlyFlag){%> readonly="readonly" <%}%>
                <%if(disabledFlag){%> disabled="disabled" <%}%>
               name="<%=name%>"
               value="<%=value%>"/>
    <span class="mustWrite"<%if(!mustFlag){%>style="display:none"<%}%> style="*-margin-left:-1px;" >*</span>
</span>


