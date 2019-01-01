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
    <link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap-datetimepicker.min.css">
    <script type="text/javascript" src="/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript">

        Date.prototype.format = function(format){
            var o = {
                "M+" : this.getMonth()+1, //month
                "d+" : this.getDate(), //day
                "H+" : this.getHours(), //hour
                "m+" : this.getMinutes(), //minute
                "s+" : this.getSeconds(), //second
                "q+" : Math.floor((this.getMonth()+3)/3), //quarter
                "S" : this.getMilliseconds() //millisecond
            }

            if(/(y+)/.test(format)) {
                format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
            }

            for(var k in o) {
                if(new RegExp("("+ k +")").test(format)) {
                    format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
                }
            }
            return format;
        }

        $(function () {
            //新增
            $("#addEmp").click(function () {
                $("#mark").val("add");
                $("#empno").val("");
                $("#ename").val("");
                $("#job").val("");
                $("#mgr").val("");
                $("#hiredate").val("");
                $("#sal").val("");
                $("#comm").val("");
                $("#deptno").val("");
                $('#addEmpModel').modal({
                    keyboard: false,
                    show:true
                })
            })
            //保存
            $("#save").click(function () {
                var empno = $("#empno").val();
                /*if(empno ==null || empno==""){
                    alert("请输入员工编号")
                    return;
                }*/
                var ename = $("#ename").val();
                if(ename ==null || ename==""){
                    alert("请输入员工名称")
                    return;
                }
                var job = $("#job").val();
                if(job ==null || job==""){
                    alert("请输入工作名称")
                    return;
                }
                var mgr = $("#mgr").val();
                if(mgr ==null || mgr==""){
                    alert("请输入经理编号")
                    return;
                }
                var hiredate = $("#hiredate").val();
                if(hiredate ==null || hiredate==""){
                    alert("请输入入职日期")
                    return;
                }
                var sal = $("#sal").val();
                if(sal ==null || sal==""){
                    alert("请输入工资")
                    return;
                }
                var comm = $("#comm").val();
                if(comm ==null || comm==""){
                    alert("请输入奖金")
                    return;
                }
                var deptno = $("#deptno").val();
                if(deptno ==null || deptno==""){
                    alert("请输入部门编号")
                    return;
                }

                var mark = $("#mark").val();
                //查询条件
                var searchename = $("#searchename").val();
                var searchempno = $("#searchempno").val();
                var searchdeptno = $("#searchdeptno").val();
                var currentPage = $("#currentPage").val();
                var url = "";
                if(mark == "add"){
                    url = "/addEmp.do?currentPage="+currentPage
                        +"&searchename="+searchename+"&searchdeptno="+searchdeptno+"&searchempno="+searchempno
                        +"&ename="+ename+"&job="+job+"&mgr="+mgr+"&hiredate="+hiredate+"&sal="+sal+"&comm="+comm+"&deptno="+deptno;
                }else if(mark == "update"){
                    url = "/modifyEmp.do?currentPage="+currentPage
                        +"&searchename="+searchename+"&searchdeptno="+searchdeptno+"&searchempno="+searchempno
                        +"&empno="+empno+"&ename="+ename+"&job="+job+"&mgr="+mgr+"&hiredate="+hiredate+"&sal="+sal+"&comm="+comm+"&deptno="+deptno;
                }
                window.location.href = url;
                $(".modal-backdrop").remove();
            })
            //修改
            $(".updateEmp").click(function () {
                var empno = $(this).parent().parent().children("td:eq(0)").text();
                $("#mark").val("update");
                //这两处的赋值方法无效，需要修改的时候部门编号不可编辑
                $("#gridSystemModalLabel").innerHTML = "修改部门信息";
                $("#empno").hidden="hidden"
                $.ajax({
                    //通过id获取图书分类信息
                    url:"/getEmpById.do?empno=" + empno,
                    success:function (data) {
                        var emp = eval(data);
                        $("#empno").val(emp.empno);
                        $("#ename").val(emp.ename);
                        $("#job").val(emp.job);
                        $("#mgr").val(emp.mgr);
                        $("#hiredate").val(<fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd"></fmt:formatDate>);
                        $("#sal").val(emp.sal);
                        $("#comm").val(emp.comm);
                        $("#deptno").val(emp.deptno);
                    }
                })
                $('#addEmpModel').modal({
                    keyboard: false,
                    show:true
                })
            })
            //删除
            $(".deleteEmp").click(function () {
                var isDelete = confirm ("确定删除吗？");
                if(isDelete){
                    var empno = $(this).parent().parent().children("td:eq(0)").text();
                    //查询条件
                    var searchename = $("#searchename").val();
                    var searchempno = $("#searchempno").val();
                    var searchdeptno = $("#searchdeptno").val();
                    var currentPage = $("#currentPage").val();
                    var url = "/removeEmp.do?empno=" + empno + "&searchename=" + searchename + "&searchdeptno=" + searchdeptno + "&searchempno=" + searchempno + "&currentPage=" + currentPage;
                    window.location.href = url;
                }else{
                    return;
                }
            })
        })
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

        $('#hiredate').datetimepicker({
            format: 'yyyy-mm-dd',
            language:"zh-CN",
            minView:"month",
            autoclose:true,
            todayBtn:true
        })
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
    <a class="btn btn-default" href="/getDeptList.do" role="button">部门列表</a>
    <a class="btn btn-default" href="#" role="button"  id="addEmp" name="addEmp">添加员工信息</a>
</div>
<div class="modal-body">
    <table class="table table-hover table-bordered">
        <thead>
            <tr>
                <th>员工编号</th>
                <th>员工名称</th>
                <th>工作</th>
                <th>经理</th>
                <th>入职日期</th>
                <th>工资</th>
                <th>奖金comm</th>
                <th>部门deptno</th>
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
                    <td><fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
                    <td>${emp.sal}</td>
                    <td>${emp.comm}</td>
                    <td>${emp.deptno}</td>
                    <%--<td>${emp.deptName}</td>--%>
                    <td>
                        <a class="btn btn-default updateEmp" href="#" role="button"  name="updateEmp">修改</a>
                        <a class="btn btn-default deleteEmp" href="#" role="button"  name="deleteEmp">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%--新增模态框插件--%>
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" id="addEmpModel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">新增员工信息</h4>
            </div>
            <div class="modal-body">
                <form method="post" action="#" id="addForm">
                    <input hidden id="mark" value="add"/>
                    <div class="form-group hidden">
                        <label for="empno" class="control-label">员工编号:</label>
                        <input type="text" class="form-control" id="empno" name="empno">
                    </div>
                    <div class="form-group">
                        <label for="ename" class="control-label">员工名称:</label>
                        <input type="text" class="form-control" id="ename" name="ename" required>
                    </div>
                    <div class="form-group">
                        <label for="job" class="control-label">工作:</label>
                        <input type="text" class="form-control" id="job" name="job" required>
                    </div>
                    <div class="form-group">
                        <label for="mgr" class="control-label">员工经理:</label>
                        <input type="text" class="form-control" id="mgr" name="mgr" required>
                    </div>
                    <div class="form-group">
                        <label for="hiredate" class="control-label">入职日期:</label>
                        <input type="text" class="form-control" id="hiredate" name="hiredate" required>
                    </div>
                    <div class="form-group">
                        <label for="sal" class="control-label">员工工资:</label>
                        <input type="text" class="form-control" id="sal" name="sal" required>
                    </div>
                    <div class="form-group">
                        <label for="comm" class="control-label">员工奖金:</label>
                        <input type="text" class="form-control" id="comm" name="comm" required>
                    </div>
                    <div class="form-group">
                        <label for="deptno" class="control-label">员工部门:</label>
                        <input type="text" class="form-control" id="deptno" name="deptno" required>
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
                <li onclick="search(${pm.endPage})"><a href="#"><span>尾页</span></a></li>
            </ul>
        </nav>
    </center>
</c:if>
</body>
</html>
