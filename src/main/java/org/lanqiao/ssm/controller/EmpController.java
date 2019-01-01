package org.lanqiao.ssm.controller;

import org.lanqiao.ssm.pojo.Condition;
import org.lanqiao.ssm.pojo.Emp;
import org.lanqiao.ssm.service.IEmpService;
import org.lanqiao.ssm.utils.PageModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Auther: WDS
 * @Date: 2018/12/29 22:25
 * @Description:
 */

@Controller
public class EmpController {
    @Autowired
    IEmpService empService;

    @RequestMapping("/getEmpById.do")
    public void getEmpById(){
        Emp emp = empService.fingEmpById(7369);
        System.out.println(emp);
    }

    @RequestMapping("/getEmpList.do")
    public ModelAndView getEmpList(HttpServletRequest request, String mark){
        int pageSize = 5;
        int pageNum = 1;
        if(!StringUtils.isEmpty(request.getParameter("currentPage"))){
            pageNum = Integer.valueOf(request.getParameter("currentPage"));
        }
        Condition condition = Condition.builder().build();
        Object empno = request.getParameter("searchempno");
        if(!StringUtils.isEmpty(empno) && Integer.valueOf(empno.toString()) != 0){
            condition.setEmpno(Integer.valueOf(empno.toString()));
        }
        Object deptno = request.getParameter("searchdeptno");
        if(!StringUtils.isEmpty(deptno) && Integer.valueOf(deptno.toString()) != 0){
            condition.setDeptno(Integer.valueOf(deptno.toString()));
        }
        Object ename = request.getParameter("searchename");
        if(!StringUtils.isEmpty(ename)){
            condition.setName(ename.toString());
        }

        int totalRecords = empService.getEmpCount(condition);
        PageModel pm = new PageModel(pageNum,totalRecords,pageSize);
        if("add".equals(mark)){
            pageNum = pm.getEndPage();
        }else if("update".equals(mark)){
            pageNum = Integer.valueOf(request.getParameter("currentPage"));
        }else{
            //如果当前页大于总页数，但是排除查询不到数据的情况。当前页等于最大页
            if(pageNum > pm.getTotalPageNum() && pm.getTotalPageNum() != 0){
                pageNum = pm.getTotalPageNum();
            }
        }
        PageModel pageModel = new PageModel(pageNum,totalRecords,pageSize);
        //分页
        condition.setPageSize(pageSize);
        condition.setCurrentPage(pageModel.getStartIndex());

        System.out.println(condition);
        List<Emp> empList = empService.findAll(condition);
        ModelAndView mv = new ModelAndView();
        mv.addObject("empList",empList);
        mv.addObject("pm",pageModel);
        mv.addObject("condition",condition);
        mv.addObject("currentPage",pageNum);
        mv.setViewName("empList");
        return mv;
    }

    @RequestMapping("/addEmp.do")
    public ModelAndView addEmp(HttpServletRequest request){
        Emp emp = Emp.builder().empno(1001).ename("wds").job("cxy").build();
        empService.addEmp(emp);
        return getEmpList(request,"add");
    }


    @RequestMapping("/removeEmp.do")
    public ModelAndView removeEmp(HttpServletRequest request){
        empService.removeEmp(1001);
        return getEmpList(request,"delete");
    }

    @RequestMapping("/modifyEmp.do")
    public ModelAndView modifyEmp(HttpServletRequest request){
        Emp emp = Emp.builder().empno(1001).ename("wds1").job("cxy1").build();
        empService.modifyEmp(emp);
        return getEmpList(request,"update");
    }
}
