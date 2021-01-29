<%--
  Created by IntelliJ IDEA.
  User: OTF
  Date: 2021/1/7
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%
    request.setAttribute("APP_PATH",request.getContextPath());
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
    <title>员工列表</title>
    <script type="text/javascript"
            src="${ APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link href="${ APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="${ APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">

    <div class="row">
        <h1>SSM-CRUD</h1>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>

    <div class="row">

        <table class="table table-striped">
            <thead>
            <tr>
                <th style="text-align:center">empId</th>
                <th style="text-align:center">lastName</th>
                <th style="text-align:center">gender</th>
                <th style="text-align:center">email</th>
                <th style="text-align:center">deptName</th>
                <th style="text-align:center">操作</th>
            </tr>
            </thead>
            <tbody>
            
            <c:forEach items="${ pageInfo.list }" var="emp">
                <tr>
                    <td align="center">${ emp.id }</td>
                    <td align="center">${ emp.lastName }</td>
                    <td align="center">${ emp.gender }</td>
                    <td align="center">${ emp.email }</td>
                    <td align="center">${ emp.department.deptName }</td>
                    <td align="center">
                        <button type="button" class="btn btn-primary btn-xs">编辑</button>
                        <button type="button" class="btn btn-danger btn-xs">删除</button>
                    </td>
                </tr>
            </c:forEach>
            
            
            </tbody>
        </table>

    </div>

    <div class="row">
        
        <div class="col-md-6">
            当前第${ pageInfo.pageNum }页，共有${ pageInfo.pages }页，总计${ pageInfo.total }条记录
        </div>
        
        <ul class="col-md-6 pagination">
            <c:if test="${ pageInfo.pageNum != 1 }">
                <li><a href="${ APP_PATH }/emps?pageNum=1">首页</a></li>
            </c:if>
            
            <c:if test="${ pageInfo.hasPreviousPage }">
                <li><a href="${ APP_PATH }/emps?pageNum=${ pageInfo.pageNum - 1 }">&laquo;</a></li>
            </c:if>

            
            <c:forEach items="${ pageInfo.navigatepageNums }" var="page_Num">
                <c:if test="${ page_Num == pageInfo.pageNum }">
                    <li class="active"><a href="${ APP_PATH }/emps?pageNum=${ page_Num }">${ page_Num }</a></li>
                </c:if>
                
                <c:if test="${ page_Num != pageInfo.pageNum }">
                    <li><a href="${ APP_PATH }/emps?pageNum=${ page_Num }">${ page_Num }</a></li>
                </c:if>
            </c:forEach>
            
            <c:if test="${ pageInfo.hasNextPage }">
                <li><a href="${ APP_PATH }/emps?pageNum=${ pageInfo.pageNum + 1 }">&raquo;</a></li>
            </c:if>
            
            <c:if test="${ pageInfo.pageNum != pageInfo.pages }">
                <li><a href="${ APP_PATH }/emps?pageNum=${ pageInfo.pages }">末页</a></li>
            </c:if>

        </ul>
    </div>

</div>
</body>
</html>
