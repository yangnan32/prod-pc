<%--
    * copyright    : widget Technology Co., Ltd
    * @version     : 1.0 
    * @created     : 12-8-11下午1:30
    * @team	    : 
    * @author      : yangn
--%>
<%@tag pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ tag import="java.util.Date" %>
<!-- 标签属性 -->
<%@attribute name="id" rtexprvalue="true" required="true" description="控件ID,必填" %>
<%@attribute name="name" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="groupName" rtexprvalue="true"  required="false" description="控件下拉框name,后台根据name获取选择的值" %>
<%@attribute name="cls" rtexprvalue="true"  required="false" description="控件下拉框class样式名称" %>
<%@attribute name="width" rtexprvalue="true"  required="false" description="控件宽度，不填则取默认值" %>
<%@attribute name="height" rtexprvalue="true"  required="false" description="控件高度，不填则取默认值" %>
<%@attribute name="url" rtexprvalue="true"  required="true" description="加载数据的url" %>
<%@attribute name="value" rtexprvalue="true" required="false" description="json数据中value的名称,选填" %>
<%@attribute name="dataRoot" rtexprvalue="true" type="java.lang.String" required="true" description="ajax data root,必填" %>
<%@attribute name="must" rtexprvalue="true"  required="false" description="是否必填，true或false" %>
<%@attribute name="outCls" rtexprvalue="true"  required="false" description="最外层控件的cls" %>
<%@attribute name="outStyle" rtexprvalue="true"  required="false" description="最外层控件的style" %>
<%@attribute name="style" rtexprvalue="true"  required="false" description="行内样式style" %>


<%
    long uuid=new Date().getTime();
    if(width==null||width.equalsIgnoreCase("")){
        width="220";
    }
    float w=220;
    try{
        w=Float.parseFloat(width);
    }catch (NumberFormatException ex){
        w=220;
    }
%>
<script type="text/javascript">
    var portalSelectMan${id}<%=uuid%> = {
        textMask:null,
        listMask:null,
        toolMask:null,
        selectName: "",                //load条件
        selectData: "",                //加载数据
        selectManId: "",              //选中man数据id字符串集合
        selectGroupId: "",              //选中group数据id字符串集合
        changeUrl:"<%=url%>",         //修改时传的url
        total:0,                      // 总条数
        totalPage:1,                  // 总页数
        params:{
            limit:10,
            dataName:"",
            start:0
        },
        selectEdit:""                //修改时传递的数据（字符串类型）
    };
    //加载数据方法
    portalSelectMan<%=id%><%=uuid%>.loadajax = function(){
        $.ajax({
            type: "POST",
            url: portalSelectMan<%=id%><%=uuid%>.changeUrl,
            dataType: "json",
            data:portalSelectMan<%=id%><%=uuid%>.params,
            success:function(data_name){
                if(data_name){
                    var data=data_name.<%=dataRoot%>;
                    if(data==undefined){return;}
                    portalSelectMan<%=id%><%=uuid%>.total = data.recordtotal||0;
                    portalSelectMan<%=id%><%=uuid%>.selectData = data.resultSet||[];
                }
                var ulDiv=$("#<%=id%>ListUl");
                ulDiv.empty();       //清空数据
                var ul=$('<ul></ul>');
                for(var i=0;i<portalSelectMan<%=id%><%=uuid%>.selectData.length;i++){
                    var record=portalSelectMan<%=id%><%=uuid%>.selectData[i];
                    if(record){
                        var dataId=record["id"];
                        var name=record["name"]||"";
                        var iconCls = "icon-611soft-obs-user";
                        var xtype = record["type"];
                        var checkbox = "false";
                        var selectCls = "";
                        var selectManArray = portalSelectMan<%=id%><%=uuid%>.selectManId.split(",");
                        var selectGroupArray = portalSelectMan<%=id%><%=uuid%>.selectGroupId.split(",");
                        if (xtype == "group") {
                            iconCls = "icon-role";
                            for (var m = 0; m < selectGroupArray.length; m++) {
                                if (dataId == selectGroupArray[m]) {
                                    checkbox = "true";
                                    selectCls = "uiframe-checkbox-selected";
                                }
                            }
                        } else {
                            for (var n = 0; n < selectManArray.length; n++) {
                                if (dataId == selectManArray[n]) {
                                    checkbox = "true";
                                    selectCls = "uiframe-checkbox-selected";
                                }
                            }
                        }
                        ul.append('<li tabindex=0 check="'+checkbox+'" dataId="'+dataId+'" xtype="'+xtype+'" class="click-select-checkbox receiveManLi '+selectCls+'"><div class="uiframe-selectbox-select"><div class="receiveManLiIcon '+iconCls+'"></div><div class="receiveLiName">'+name+'</div></div></li>');
                    }
                    ulDiv.append(ul);
                }
                portalSelectMan<%=id%><%=uuid%>.setLiClick();
                portalSelectMan<%=id%><%=uuid%>.totalPage = Math.ceil(portalSelectMan<%=id%><%=uuid%>.total/portalSelectMan<%=id%><%=uuid%>.params.limit);
                portalSelectMan<%=id%><%=uuid%>.initBbar();
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){

            }
        });
    };

    // 按钮禁用事件
    portalSelectMan<%=id%><%=uuid%>.initBbar = function(){
        if (portalSelectMan<%=id%><%=uuid%>.total > portalSelectMan<%=id%><%=uuid%>.params.limit) {
            if (portalSelectMan<%=id%><%=uuid%>.params.start == 0) {
                $("#<%=id%>PrevBtn").attr("disabled","disabled").addClass("btnDisabled");
                $("#<%=id%>NextBtn").removeAttr("disabled").removeClass("btnDisabled");
            } else if (portalSelectMan<%=id%><%=uuid%>.params.start == (portalSelectMan<%=id%><%=uuid%>.totalPage-1)*portalSelectMan<%=id%><%=uuid%>.params.limit) {
                $("#<%=id%>PrevBtn").removeAttr("disabled").removeClass("btnDisabled");
                $("#<%=id%>NextBtn").attr("disabled","disabled").addClass("btnDisabled");
            } else {
                $("#<%=id%>PrevBtn").removeAttr("disabled").removeClass("btnDisabled");
                $("#<%=id%>NextBtn").removeAttr("disabled").removeClass("btnDisabled");
            }
        }
    };

    // 绑定数据点击事件
    portalSelectMan<%=id%><%=uuid%>.setLiClick = function(){
        $("#<%=id%>ListUl").find("li.click-select-checkbox").each(function(){
            $(this).off("click");
            $(this).on("click", function(){
                portalSelectMan<%=id%><%=uuid%>.getValue($(this));
                return false;
            });
        });
    };

    // 数组去重方法
    portalSelectMan<%=id%><%=uuid%>.noRepeatArray = function(str){
        var oldArray = str.split(',');
        var dic = {};
        for (var i = 0; i < oldArray.length; i++) {
            if (oldArray[i] != "") {
                dic[oldArray[i]]=oldArray[i];
            }
        }
        var newArray = [];
        for (var ary in dic) {
            if (dic[ary] != "") {
                newArray.push(dic[ary]);
            }
        }
        return newArray
    };

    // 获取数据方法
    portalSelectMan<%=id%><%=uuid%>.getValue = function($query){

        if ($query.attr("check") !== "" && $query.attr("check") === "true") {
            $query.removeClass('uiframe-checkbox-selected');
            $query.attr("check", "false");
            if ($query.attr("xtype") == "user") {
                portalSelectMan${id}<%=uuid%>.selectManId = portalSelectMan${id}<%=uuid%>.selectManId.replace($query.attr("dataId"),"");
            } else {
                portalSelectMan${id}<%=uuid%>.selectGroupId = portalSelectMan${id}<%=uuid%>.selectGroupId.replace($query.attr("dataId"),"");
            }
        } else {
            $query.addClass('uiframe-checkbox-selected');
            $query.attr("check", "true");
            if ($query.attr("xtype") == "user") {
                if (portalSelectMan${id}<%=uuid%>.selectManId == "") {
                    portalSelectMan${id}<%=uuid%>.selectManId += $query.attr("dataId");
                } else {
                    portalSelectMan${id}<%=uuid%>.selectManId += ","+$query.attr("dataId");
                }
            } else {
                if (portalSelectMan${id}<%=uuid%>.selectGroupId == "") {
                    portalSelectMan${id}<%=uuid%>.selectGroupId += $query.attr("dataId");
                } else {
                    portalSelectMan${id}<%=uuid%>.selectGroupId += ","+$query.attr("dataId");
                }
            }
        }
        var nowManId = portalSelectMan<%=id%><%=uuid%>.noRepeatArray(portalSelectMan${id}<%=uuid%>.selectManId);
        var nowGroupId = portalSelectMan<%=id%><%=uuid%>.noRepeatArray(portalSelectMan${id}<%=uuid%>.selectGroupId);

        $("#<%=id%>").val(nowManId.join(","));
        $("#<%=id%>Group").val(nowGroupId.join(","));
        var selectText = "";
        if (nowManId.length > 0) {
            selectText += "选择"+nowManId.length+"个联系人;";
        }
        if (nowGroupId.length > 0) {
            selectText += "选择"+nowGroupId.length+"个群组;";
        }
        if (selectText != "") {
            $("#<%=id%>ShowReceiveMan").text("("+selectText+")")
        }
        if (nowManId.length == 0 && nowGroupId.length == 0) {
            $("#<%=id%>ShowReceiveMan").empty();
        }
    };

    (function(){
        var selectMan=function(){
            portalSelectMan<%=id%><%=uuid%>.loadajax();
            $("#<%=id%>SelectMan").on("click", function(){
                var display = $("#<%=id%>List").css("display");
                if (display == "none") {
                    $("#<%=id%>SearchName").val("");
                    $("#<%=id%>List").show();
                    portalSelectMan<%=id%><%=uuid%>.params.dataName = "";
                    portalSelectMan<%=id%><%=uuid%>.loadajax();
                } else {
                    $("#<%=id%>List").hide();
                }
            });
            //点击下拉框之外的元素，下拉列表隐藏
            $("body").on("click", function () {
                if ($("#<%=id%>List").css("display") === "block") {
                    $("#<%=id%>List").hide();
                }
            });
            $("#<%=id%>Layout").on("click", function (event) {
                event.stopPropagation();
            });
            //下拉列表修改传值操作
            if($("#<%=id%>").val() != ""){
                var dataArrayId = $("#<%=id%>").val().split(",");
                for (var i = 0;i < dataArrayId.length;i++) {
                    var newValue = dataArrayId[i];
                    $("#<%=id%>ListUl").find("li.click-select-checkbox").each(function () {
                        if ($(this).attr("dataId") === newValue) {
                            $(this).addClass('uiframe-checkbox-selected');
                            $(this).attr("check", "true");
                        }
                    });
                }
            }

            // 名称过滤事件
            $("#<%=id%>SearchName").on("keyup", function(e){
                if(e.keyCode === 40 || e.keyCode === 39 ||e.keyCode === 38 || e.keyCode === 37 || e.keyCode === 27 || e.keyCode === 13 ) {
                    return false;
                }
                portalSelectMan<%=id%><%=uuid%>.params.dataName = $(this).val();
                portalSelectMan<%=id%><%=uuid%>.loadajax();
            });

            // 选择全体员工事件
            $("#<%=id%>AllUserId").on("click", function(){
                if ($(this).attr("check") !== "" && $(this).attr("check") === "true") {
                    $(this).removeClass('uiframe-checkbox-selected');
                    $(this).attr("check", "false");
                    $("#<%=id%>").val("");
                    $("#<%=id%>ShowReceiveMan").text("");
                    portalSelectMan${id}<%=uuid%>.textMask.hide();
                    portalSelectMan${id}<%=uuid%>.listMask.hide();
                    portalSelectMan${id}<%=uuid%>.toolMask.hide();
                } else {
                    $(this).addClass('uiframe-checkbox-selected');
                    $(this).attr("check", "true");
                    $("#<%=id%>").val("allUser");
                    $("#<%=id%>ShowReceiveMan").text("(全体员工)");
                    $("#<%=id%>ListUl").find("li").removeClass('uiframe-checkbox-selected');
                    $("#<%=id%>ListUl").attr("check", "false");
                    portalSelectMan${id}<%=uuid%>.textMask = $.sywMask.show({target:$("#<%=id%>SearchNameDiv")});
                    portalSelectMan${id}<%=uuid%>.listMask = $.sywMask.show({target:$("#<%=id%>ListUl")});
                    portalSelectMan${id}<%=uuid%>.toolMask = $.sywMask.show({target:$("#select_bbar<%=id%>")});
                }

                return false;
            });

            // 上一页按钮绑定事件
            $("#<%=id%>PrevBtn").on("click", function(){
                portalSelectMan<%=id%><%=uuid%>.params.start = portalSelectMan<%=id%><%=uuid%>.params.start - portalSelectMan<%=id%><%=uuid%>.params.limit;
                portalSelectMan<%=id%><%=uuid%>.loadajax();
            });

            // 下一页按钮绑定事件
            $("#<%=id%>NextBtn").on("click", function(){
                portalSelectMan<%=id%><%=uuid%>.params.start = portalSelectMan<%=id%><%=uuid%>.params.start + portalSelectMan<%=id%><%=uuid%>.params.limit;
                portalSelectMan<%=id%><%=uuid%>.loadajax();
            });
            // 清空方法
            $("#clearBtn${id}").on("click", function(){
                $("#<%=id%>ShowReceiveMan").empty();
                $("#<%=id%>").val("");
                $("#<%=id%>SearchName").val("");
                portalSelectMan${id}<%=uuid%>.selectManId = "";
                portalSelectMan${id}<%=uuid%>.selectGroupId = "";
                $("#<%=id%>ListUl").find("li.click-select-checkbox").removeClass("uiframe-checkbox-selected").attr("check", "false");
            });
            $("#<%=id%>").on("clear", function(){
                $("#clearBtn${id}").trigger("click");
            });
        };
        selectMan.orderNumber=51;
        executeQueue.push(selectMan);
    })();
</script>
<div id="<%=id%>Layout" class="uiframe-mainCon ${outCls}" style="*-width:380px;${outStyle}">
    <input type="hidden" id="<%=id%>" value="" name="<%=name%>" />
    <input type="hidden" id="<%=id%>Group" value="" name="<%=groupName%>" />
    <div id="<%=id%>SelectMan" style="float:left;">选择收件人</div>
    <div class="showReceiveMan" id="<%=id%>ShowReceiveMan" style="*-width:280px;"></div>
    <div id="<%=id%>List" class="receiveManList uiframe-selectHide" style="width: <%=(w+10)%>px;*-width:<%=w%>px;*margin-left: -340px;">
        <div class="receiveMan-searchText" id="<%=id%>SearchNameDiv">
            <div style="float:left;line-height:28px;margin-top:5px;padding:0 10px;"><label>名称:</label></div>
            <div style="float:left;margin-top:6px;">
                <input type="text" style="display:none;">
                <input type="text" class="uiframe-textinput" style="width:150px;" id="<%=id%>SearchName" name="searchName" />
            </div>
        </div>
        <div id="<%=id%>AllUserDiv" style="width: <%=(w+10)%>px;*-width:<%=w%>px;overflow-y: auto;">
            <ul>
                <li tabindex=0 id="<%=id%>AllUserId" xtype="all" class="click-select-checkbox receiveManLi"><div class="uiframe-selectbox-select"><div class="receiveManLiIcon icon-role"></div><div class="receiveLiName">全体员工</div></div></li>
            </ul>
        </div>
        <div id="<%=id%>ListUl" style="width: <%=(w+10)%>px;*-width:<%=w%>px;overflow-y: auto;"></div>
        <div class="uiframe-select-bbar" id="select_bbar<%=id%>" style="padding-top:2px;border-top: 1px solid #ebebeb;">
            <table style="width:100%;">
                <tr>
                    <td class="uiframe-grid-span" align="left"></td>
                    <td>
                        <input type="button" class="uiframe-module-btn" id="clearBtn${id}" style="padding: 0 4px;*-padding:0 2px;" value="清空" />
                    </td>
                    <td class="uiframe-grid-span" align="left"></td>
                    <td align="right">
                        <table>
                            <tr>
                                <td class="uiframe-portalGrid-toolSpan"></td>
                                <td><button type="button" class="uiframe-portalGrid-prev-page" style="border:none;" id="<%=id%>PrevBtn">&nbsp;</button></td>
                                <td class="uiframe-portalGrid-toolSpan"></td>
                                <td><button type="button" class="uiframe-portalGrid-next-page" style="border:none;" id="<%=id%>NextBtn">&nbsp;</button></td>
                                <td class="uiframe-portalGrid-toolSpan"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

