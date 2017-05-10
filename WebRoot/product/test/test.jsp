<%--
  Created by IntelliJ IDEA.
  User: yangn
  Date: 2017/5/9
  Time: 20:58
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.util.Set"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="widget" tagdir="/WEB-INF/tags/simpleuiframe"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath",basePath);
%>
<!DOCTYPE html>
<html >
<head>
    <title>测试系统</title>
    <widget:widget-base />
    <link rel="stylesheet" href="<%=basePath %>/product/lib/css/index.css" type="text/css"/>
</head>
<body class="body" id="body">
<div class="uiframe-layoutDiv" id="optcenterLayoutDiv">
    <script type="text/javascript">
		$("#optcenterLayoutDiv").height($(window).height());
    </script>
    <div class="icon-header" id="uiframe-header">
        <%--<div class="icon-logo"><a style="display:block;cursor:pointer;" href="${basePath}"></a></div>--%>
        <div class="icon-nav">
            <ul>
                <li><a href="${basePath}/index.htm">XXXXXXXXX测试系统</a></li>
            </ul>
        </div>
        <div class="rightNav fr">
            <a href="javascript:void(0);" id="userInfoDiv" data-userId="" data-regionId="">测试用户</a>
            <a href="#" id="logout">退出</a>
        </div>
    </div>
    <div style="height:10px;"></div>
    <div class="uiframe-fit">
        <widget:twoColumn leftId="dataLeft" rightId="dataRight" leftWidth="200">
      <jsp:attribute name="leftPanel">
        <div id="pathMenu" class="path-pathMenu">
            <div class="widgetPathNode">
                <span>一级导航</span>
                <div data-url="javascript:void(0);">二级导航</div>
                <div data-url="javascript:void(0);" class="">二级导航</div>
            </div>
            <div class="widgetPathNode">
                <span>一级导航</span>
                <div data-url="javascript:void(0);">二级导航</div>
                <div data-url="javascript:void(0);">二级导航</div>
            </div>
        </div>
      </jsp:attribute>
        <jsp:attribute name="rightPanel">
            <widget:titleLong id="titleLong" title="测试功能" />
            <div style="height:10px;"></div>
            <div class="newToolbar">
                <div id="addTest" class="icon-icon-new"><span></span>新增</div>
            </div>
            <div id="myGrid" class="uiframe-fit">
            <widget:jspGrid id="testGrid" limit="20" url="/test/queryTestList.action">
            <jsp:attribute name="gridHeader">
                <tr>
                    <td checkbox="false" class="uiframe-jspGrid-checkbox jspGrid-nocheck">
                        <div class="uiframe-jspGrid-checkBg"></div>
                    </td>
                    <td>
                        <div style="width: 300px; text-align: left;">名称</div>
                    </td>
                    <td>
                        <div style="width: 150px; text-align: left;">创建时间</div>
                    </td>
                    <td>
                        <div style="width: 150px; text-align: left;">更新时间</div>
                    </td>
                    <td>
                        <div style="width: 300px; text-align: left;">描述</div>
                    </td>
                </tr>
            </jsp:attribute>
        </widget:jspGrid>
            </div>
      </jsp:attribute>
        </widget:twoColumn>
    </div>
</div>
<script type="text/javascript">
	sywBase.initFit("optcenterLayoutDiv");
	$(function(){
		$("#pathMenu").on("click", ".widgetPathNode", function(){
			if ($(this).hasClass("selectPath")) {
				$(this).removeClass("selectPath");
			} else {
				$(this).addClass("selectPath").siblings().removeClass("selectPath");
			}
		}).on("click", ".widgetPathNode div", function(){
			$(".syswarePathNode").find("div").removeClass("pathNodeSelect");
			$(this).addClass("pathNodeSelect");
			return false;
		}).on("mouseover",".widgetPathNode div",function(){
			$(".widgetPathNode").find("div").removeClass("pathNodeHover");
			$(this).addClass("pathNodeHover");
		}).on("mouseleave",".widgetPathNode div",function(){
			$(this).removeClass("pathNodeHover");
		});
	})

</script>
<script type="text/javascript" src="${basePath}/product/test/js/test.js"></script>
<widget:widget-plugins />
</body>
</html>

