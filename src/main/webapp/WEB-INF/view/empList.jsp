<%--
  Created by IntelliJ IDEA.
  User: WDS
  Date: 2018/12/30
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>员工列表</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="/js/jquery.min.js" ></script>
    <script type="text/javascript" src="/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
        //查询的手动提交方式
        function search(currentPage) {
            var searchename = $("#searchename").val();
            var searchempno = $("#searchempno").val();
            var searchdeptno = $("#searchdeptno").val();
            if(currentPage == null){
                var currentPage = $("#currentPage").val();
            }else{
                var currentPage = currentPage;
            }
            var url = "/getEmpList.do?currentPage="+currentPage+"&searchename="+searchename+"&searchempno="+searchempno+"&searchdeptno="+searchdeptno;
            window.location.href = url;
        }
    </script>
</head>
<body>
<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}">
<div class="modal-body">
    <div class="form-group row">
        <div class="col-xs-3">
            <label for="searchename" >员工名称:</label>
            <input type="text" class="myinput"  placeholder="" id="searchename" name="searchename" value="${condition.name}">
        </div>
        <div class="col-xs-3">
            <label for="searchempno" >员工编号:</label>
            <input type="text" class="myinput"  placeholder="" id="searchempno" name="searchempno" value="${condition.empno}">
        </div>
        <div class="col-xs-2">
            <label for="searchdeptno">部门编号</label>
            <input class="myinput" name="searchdeptno" id="searchdeptno" value="${condition.deptno}"/>
        </div>
    </div>
    <div class="form-group">
        <input type="button" class="btn btn-primary" id="search" value="查询" onclick="search(null)"/>
    </div>
</div>
<div class="modal-body">
    <a class="btn btn-default" href="#" role="button"  id="addBook" name="addBook">添加图书信息</a>
</div>
<div class="modal-body">
    <table class="table table-hover table-bordered">
        <thead>
            <tr>
                <th>empno</th>
                <th>ename</th>
                <th>job</th>
                <th>mgr</th>
                <th>hiredate</th>
                <th>sal</th>
                <th>comm</th>
                <th>deptno</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach begin="0" end="${empList.size()}" items="${empList}" var="emp" step="1">
                <tr>
                    <td>${emp.empno}</td>
                    <td>${emp.ename}</td>
                    <td>${emp.job}</td>
                    <%--<td>${emp.mgrName}</td>--%>
                    <td>${emp.mgr}</td>
                    <td><fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                    <td>${emp.sal}</td>
                    <td>${emp.comm}</td>
                    <td>${emp.deptno}</td>
                    <%--<td>${emp.deptName}</td>--%>
                    <td>
                        <a class="btn btn-default updateBook" href="#" role="button"  name="updateBook">修改</a>
                        <a class="btn btn-default deleteBook" href="#" role="button"  name="deleteBook">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<c:if test="${bookList.size() != 0}">
    <center>
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li  onclick="search(${pm.startPage})"><a href="#"><apan>首页</apan></a></li>
                <li  onclick="search(${pm.prePageNum})">
                    <a href="#"  aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach step="1" var="i" begin="1" end="${pm.totalPageNum}">
                    <li onclick="search(${i})"><a href="#"><span <c:if test="${i==pm.currentPageNum}"> style = 'color:red;' </c:if>> ${i}</span></a></li>
                </c:forEach>
                <li onclick="search(${pm.nextPageNum})">
                    <a href="#" class="page"  aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                    <%--实现方法一，但是目前不可以--%>
                <li onclick="search(${pm.endPage})"><a href="#"><span>尾页</span></a></li>
            </ul>
        </nav>
    </center>
</c:if>
</body>
</html>
