<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-5-28下午3:16
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
<%@attribute name="disabled" rtexprvalue="true"  required="false" description="禁用,值为disabled" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="style样式代码" %>
<%@attribute name="value" rtexprvalue="true"  required="false" description="日期默认值" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="class样式代码" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="readonly" rtexprvalue="true"  required="false" description="只读,true为只读" %>


<%
    long uuid=new Date().getTime();
    String readonlyText="";
    String disableText="";
    if(StringUtils.isNotEmpty(readonly) && readonly.equalsIgnoreCase("true")){
        readonlyText="readonly='readonly'";
    } else {
        readonlyText="";
    }
    if(StringUtils.isNotEmpty(disabled) && disabled.equalsIgnoreCase("true")){
        disableText="disabled='disabled'";
    }
    if(StringUtils.isNotBlank(name)){
        name="name='"+name+"'";
    }else {
        name="";
    }

    if(StringUtils.isNotBlank(value)){
        value = value;
    }else {
        value="";
    }
%>
<script type="text/javascript">
    var time${id}<%=uuid%> = {};
    //小时点击按钮方法
    time${id}<%=uuid%>.setValH = function(){
        var that = $("#${id}Th"+<%=uuid%>);
        $("#${id}Up"+<%=uuid%>).on("click", function(){
            var val = that.val();
            var m = parseInt(val,10);
            if(m == 23){
                that.val("00");
            } else {
                m++;
                if(m<10){
                    m = "0" +m
                }
                that.val(m);
            }
            that.focus();
        });
        $("#${id}Down"+<%=uuid%>).on("click", function(){
            var val = that.val();
            var n = parseInt(val,10);
            if(n == 0){
                that.val(23);
            } else {
                n--;
                if(n<10){
                    n = "0" + n
                }
                that.val(n);
            }
            that.focus();
        });
    };
    //分钟点击按钮方法
    time${id}<%=uuid%>.setValM = function(){
        var that = $("#${id}Tm"+<%=uuid%>);
        $("#${id}Up"+<%=uuid%>).on("click", function(){
            var val = that.val();
            var m = parseInt(val,10);
            if(m == 59){
                that.val("00");
            } else {
                m++;
                if(m<10){
                    m = "0" + m
                }
                that.val(m);
            }
            that.focus();
        });
        $("#${id}Down"+<%=uuid%>).on("click", function(){
            var val = that.val();
            var n = parseInt(val,10);
            if(n == 0){
                that.val(59);
            } else {
                n--;
                if(n<10){
                    n = "0" + n
                }
                that.val(n);
            }
            that.focus();
        });

    };
    (function(){
        var time=function(){
            //回显显示日期方法
            if($('#${id}').val() != ""){
                var valArray = $('#${id}').val().split(":");
                $("#${id}Th"+<%=uuid%>).val(valArray[0]);
                $("#${id}Tm"+<%=uuid%>).val(valArray[1]);
            }
            $("#${id}Th"+<%=uuid%>).on("focus", function(){
                $("#${id}Up"+<%=uuid%>).off("click");
                $("#${id}Down"+<%=uuid%>).off("click");
                time${id}<%=uuid%>.setValH();
            });
            $("#${id}Tm"+<%=uuid%>).on("focus", function(){
                $("#${id}Up"+<%=uuid%>).off("click");
                $("#${id}Down"+<%=uuid%>).off("click");
                time${id}<%=uuid%>.setValM();
            });
            $("#${id}Th"+<%=uuid%>).keyup(function(){
               var value=$(this).val();
               if(isNaN(value)){
                   $(this).val("00");
               }else if(parseInt(value,10)>23){
                   $(this).val("23");
               }
            });

            $("#${id}Tm"+<%=uuid%>).keyup(function(){
                var value=$(this).val();
                if(isNaN(value)){
                    $(this).val("00");
                }else if(parseInt(value,10)>59){
                    $(this).val("59");
                }
            });

            $("#${id}Th"+<%=uuid%>).on("blur", function(){
                var val = $("#${id}Th"+<%=uuid%>).val();
                if(val.length==1){
                    val="0"+val;
                    $("#${id}Th"+<%=uuid%>).val(val);
                }
                if(!/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(val) || parseInt(val) > 23){
                    $.sywDialog.warn("警告信息","请输入正确的小时格式");
                    $("#${id}Th"+<%=uuid%>).val("00");
                } else {
                    var hVal;
                    var mVal;
                    if($("#${id}Th"+<%=uuid%>).val() == ""){
                        hVal = "00";
                    } else {
                        hVal = $("#${id}Th"+<%=uuid%>).val();
                    }
                    if($("#${id}Tm"+<%=uuid%>).val() == ""){
                        mVal = "00";
                    } else {
                        mVal = $("#${id}Tm"+<%=uuid%>).val();
                    }
                    $("#${id}").val(hVal+":"+mVal);

                }
            });
            $("#${id}Tm"+<%=uuid%>).on("blur", function(){
                var val = $("#${id}Tm"+<%=uuid%>).val();
                if(val.length==1){
                    val="0"+val;
                    $("#${id}Tm"+<%=uuid%>).val(val);
                }
                if(!/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(val) || parseInt(val) > 59){
                    $.sywDialog.warn("警告信息","请输入正确的分钟格式");
                    $("#${id}Tm"+<%=uuid%>).val("00");
                } else {
                    var hVal;
                    var mVal;
                    if($("#${id}Th"+<%=uuid%>).val() == ""){
                        hVal = "00";
                    } else {
                        hVal = $("#${id}Th"+<%=uuid%>).val();
                    }
                    if($("#${id}Tm"+<%=uuid%>).val() == ""){
                        mVal = "00";
                    } else {
                        mVal = $("#${id}Tm"+<%=uuid%>).val();
                    }
                    $("#${id}").val(hVal+":"+mVal);
                }
            });
            //点击下拉框之外的元素，下拉列表隐藏
            $("body").on("click", function () {
                if($("#${id}Th"+<%=uuid%>).val() == ""){
                    $("#${id}Th"+<%=uuid%>).val("00");
                }
                if($("#${id}Tm"+<%=uuid%>).val() == ""){
                    $("#${id}Tm"+<%=uuid%>).val("00");
                }
            });
            $("#${id}timeDiv"+<%=uuid%>).on("click", function (event) {
                event.stopPropagation();
            });
            //动态传值方法
            $("#${id}").on("setValue", function(e,val){
                $('#${id}').val(val);
                var myVal = ""+val;
                var valArray = myVal.split(":");
                $("#${id}Th"+<%=uuid%>).val(valArray[0]);
                $("#${id}Tm"+<%=uuid%>).val(valArray[1]);
            });
            //只读方法
            $("#${id}").on("readonly", function(){
                $("#${id}Th"+<%=uuid%>).attr("readonly","readonly");
                $("#${id}Tm"+<%=uuid%>).attr("readonly","readonly");
                $("#${id}Up"+<%=uuid%>).attr("disabled","disable");
                $("#${id}Down"+<%=uuid%>).attr("disabled","disable");
            });
            //取消只读方法
            $("#${id}").on("unreadonly", function(){
                $("#${id}Th"+<%=uuid%>).removeAttr("readonly");
                $("#${id}Tm"+<%=uuid%>).removeAttr("readonly");
                $("#${id}Up"+<%=uuid%>).removeAttr("disabled");
                $("#${id}Down"+<%=uuid%>).removeAttr("disabled");
            });
            //禁用方法
            $("#${id}").on("disabled", function(){
                $("#${id}Th"+<%=uuid%>).attr("disabled","disable");
                $("#${id}Tm"+<%=uuid%>).attr("disabled","disable");
                $("#${id}Tt"+<%=uuid%>).attr("disabled","disable");
                $("#${id}Up"+<%=uuid%>).attr("disabled","disable");
                $("#${id}Down"+<%=uuid%>).attr("disabled","disable");
            });
            //取消方法
            $("#${id}").on("enable", function(){
                $("#${id}Th"+<%=uuid%>).removeAttr("disabled");
                $("#${id}Tm"+<%=uuid%>).removeAttr("disabled");
                $("#${id}Tt"+<%=uuid%>).removeAttr("disabled");
                $("#${id}Up"+<%=uuid%>).removeAttr("disabled");
                $("#${id}Down"+<%=uuid%>).removeAttr("disabled");
            });
            //上下选择按钮默认绑定给小时
            time${id}<%=uuid%>.setValH();
        };
        time.orderNumber=50;
        executeQueue.push(time);
    })();
</script>
<div id="${id}timeDiv<%=uuid%>" class="uiframe-timeDiv <%=cls%>" style="<%=style%>">
    <input type="hidden" id="${id}" <%=name%> value="<%=value%>" >
    <table cellspacing="0" cellpadding="0" border="0">
        <tbody>
        <tr>
            <td rowspan="2">
                <input maxlength="2" id="${id}Th<%=uuid%>" class="uiframe-timeTh" <%=readonlyText%> <%=disableText%>><input id="${id}Tt<%=uuid%>" readonly="" class="uiframe-timeTt" value=":" <%=disableText%>><input id="${id}Tm<%=uuid%>" maxlength="2" class="uiframe-timeTm" <%=readonlyText%> <%=disableText%>>
            </td>
            <td><input id="${id}Up<%=uuid%>" type="button" class="uiframe-timeUp" <%=disableText%>></td>
        </tr>
        <tr>
            <td><input id="${id}Down<%=uuid%>" type="button" class="uiframe-timeDown" <%=disableText%>></td>
        </tr>
        </tbody>
    </table>
</div>
<c:choose>
    <c:when test="${not empty must and must=='true'}">
        <span class="mustWrite">*</span>
    </c:when>
</c:choose>

