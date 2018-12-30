<%--
  Created by IntelliJ IDEA.
  User: WDS
  Date: 2018/12/30
  Time: 22:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>部门列表</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="/js/jquery.min.js" ></script>
    <script type="text/javascript" src="/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
        //查询的手动提交方式
        function search(currentPage) {
            var searchename = $("#searchename").val();
            var searchdeptno = $("#searchdeptno").val();
            if(currentPage == null){
                var currentPage = $("#currentPage").val();
            }else{
                var currentPage = currentPage;
            }
            var url = "/getDeptList.do?currentPage="+currentPage+"&searchename="+searchename+"&searchdeptno="+searchdeptno;
            window.location.href = url;
        }
    </script>
</head>
<body>
<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}">
<div class="modal-body">
    <div class="form-group row">
        <div class="col-xs-3">
            <label for="searchename" >部门名称:</label>
            <input type="text" class="myinput"  placeholder="" id="searchename" name="searchename" value="${condition.name}">
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
            <th>deptno</th>
            <th>dname</th>
            <th>loc</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach begin="0" end="${deptList.size()}" items="${deptList}" var="dept" step="1">
            <tr>
                <td>${dept.deptno}</td>
                <td>${dept.dname}</td>
                <td>${dept.loc}</td>
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
