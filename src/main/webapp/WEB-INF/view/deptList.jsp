<%--
  Created by IntelliJ IDEA.
  User: WDS
  Date: 2018/12/30
  Time: 22:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>部门列表</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="/js/jquery.min.js" ></script>
    <script type="text/javascript" src="/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
        $(function () {
            //新增
            $("#addDept").click(function () {
                $("#mark").val("add");
                $("#deptno").val("");
                $("#dname").val("");
                $("#loc").val("");
                $('#addDeptModel').modal({
                    keyboard: false,
                    show:true
                })
            })
            //保存
            $("#save").click(function () {
                var deptno = $("#deptno").val();
                var dname = $("#dname").val();
                var loc = $("#loc").val();
                var mark = $("#mark").val();
                /*if(bookTypeName.length > 50){
                    alert("图书分类名称多于50字，请重新输入");
                    return;
                }*/
                //查询条件
                var searchename = $("#searchename").val();
                var searchdeptno = $("#searchdeptno").val();
                var currentPage = $("#currentPage").val();
                var url = "";
                if(mark == "add"){
                    url = "/addDept.do?currentPage="+currentPage
                        +"&searchename="+searchename+"&searchdeptno="+searchdeptno+"&deptno="+deptno+"&dname="+dname+"&loc="+loc;
                }else if(mark == "update"){
                    url = "/modifyDept.do?currentPage="+currentPage
                        +"&searchename="+searchename+"&searchdeptno="+searchdeptno+"&deptno="+deptno+"&dname="+dname+"&loc="+loc;
                }
                window.location.href = url;
                $(".modal-backdrop").remove();
            })
            //修改
            $(".updateDept").click(function () {
                var deptno = $(this).parent().parent().children("td:eq(0)").text();
                $("#mark").val("update");
                //这两处的赋值方法无效，需要修改的时候部门编号不可编辑
                $("#gridSystemModalLabel").innerHTML = "修改部门信息";
                $("#deptno").hidden="hidden"
                $.ajax({
                    //通过id获取图书分类信息
                    url:"/getDeptById.do?deptno=" + deptno,
                    success:function (data) {
                        var dept = eval(data);
                        $("#deptno").val(dept.deptno);
                        $("#dname").val(dept.dname);
                        $("#loc").val(dept.loc);
                    }
                })
                $('#addDeptModel').modal({
                    keyboard: false,
                    show:true
                })
            })
            //删除
            $(".deleteDept").click(function () {
                var isDelete = confirm ("确定删除吗？");
                if(isDelete){
                    var deptno = $(this).parent().parent().children("td:eq(0)").text();
                    //查询条件
                    var searchename = $("#searchename").val();
                    var searchdeptno = $("#searchdeptno").val();
                    var currentPage = $("#currentPage").val();
                    var url = "/removeDept.do?deptno=" + deptno + "&searchename=" + searchename + "&searchdeptno=" + searchdeptno + "&currentPage=" + currentPage;
                    window.location.href = url;
                }else{
                    return;
                }
            })
        })

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
    <a class="btn btn-default" href="#" role="button"  id="addDept" name="addDept">添加部门信息</a>
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
                    <a class="btn btn-default updateDept" href="#" role="button"  name="updateDept">修改</a>
                    <a class="btn btn-default deleteDept" href="#" role="button"  name="deleteDept">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<%--新增模态框插件--%>
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="addDeptModel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">新增部门信息</h4>
            </div>
            <div class="modal-body">
                <form method="post" action="#" id="addForm">
                    <input id="mark" value="add" hidden>
                    <div class="form-group">
                        <label for="deptno" class="control-label">部门编号:</label>
                        <input type="text" class="form-control" id="deptno" name="deptno" required>
                    </div>
                    <div class="form-group">
                        <label for="dname" class="control-label">部门名称:</label>
                        <input type="text" class="form-control" id="dname" name="dname" required>
                    </div>
                    <div class="form-group">
                        <label for="loc" class="control-label">部门地址:</label>
                        <input type="text" class="form-control" id="loc" name="loc" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


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
