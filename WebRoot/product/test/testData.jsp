<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sysware" tagdir="/WEB-INF/tags/uiframe" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<tr style="display:none;"><input type="hidden" class="dataTotal" value="${dataCount}"></tr>
<c:forEach var="item" items="${dataList}">
    <tr dataId="${item.id}" >
        <td checkbox="false" class="uiframe-jspGrid-checkbox jspGrid-nocheck checkboxes">
            <div class="uiframe-jspGrid-checkBg"></div>
        </td>
        <td>
            <div style="width:300px;">
                <div style="width:200px;height:30px;line-height:30px;text-align:left;float:left;">
                     ${item.name}
                </div>
                <div style="float:right;display:none;" class="grid_iconTools">
                    <div class="icon-icon-edit tooltip iconEdit" dataId="${item.id}"  myTitle="编辑"><span></span></div>
                    <div class="icon-icon-delete tooltip iconDelete" dataId="${item.id}"  myTitle="删除" style="width:20px;margin-right:10px;"><span></span></div>
                </div>
            </div>
        </td>
        <td>
            <div style="width: 150px; text-align: left;">
                ${item.createTime}
            </div>
        </td>
        <td>
            <div style="width: 150px; text-align: left;">
                ${item.updateTime}
            </div>
        </td>
        <td>
            <div style="width: 300px; text-align: left;">${item.description}</div>
        </td>
    </tr>
</c:forEach>
