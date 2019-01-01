package org.lanqiao.ssm.controller;

import com.alibaba.fastjson.JSON;
import org.lanqiao.ssm.pojo.Condition;
import org.lanqiao.ssm.pojo.Dept;
import org.lanqiao.ssm.pojo.Emp;
import org.lanqiao.ssm.service.IDeptService;
import org.lanqiao.ssm.service.IEmpService;
import org.lanqiao.ssm.utils.PageModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * @Auther: WDS
 * @Date: 2018/12/30 22:32
 * @Description:
 */
@Controller
public class DeptController {
    @Autowired
    IDeptService deptService;

    @RequestMapping("/getDeptById.do")
    public void getDeptById(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/json;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Object deptno = request.getParameter("deptno");
        Dept dept = deptService.fingDeptById(Integer.valueOf(deptno.toString()));
        String deptJson = JSON.toJSONString(dept);
        out.print(deptJson);
    }

    @RequestMapping("/getDeptList.do")
    public ModelAndView getDeptList(HttpServletRequest request, String mark){
        int pageSize = 5;
        int pageNum = 1;
        if(!StringUtils.isEmpty(request.getParameter("currentPage"))){
            pageNum = Integer.valueOf(request.getParameter("currentPage"));
        }
        Condition condition = Condition.builder().build();
        Object deptno = request.getParameter("searchdeptno");
        if(!StringUtils.isEmpty(deptno) && Integer.valueOf(deptno.toString()) != 0){
            condition.setDeptno(Integer.valueOf(deptno.toString()));
        }
        Object ename = request.getParameter("searchename");
        if(!StringUtils.isEmpty(ename)){
            condition.setName(ename.toString());
        }

        int totalRecords = deptService.getDeptCount(condition);
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
        List<Dept> deptList = deptService.findAll(condition);
        /*model.addAttribute("deptList",deptList);
        model.addAttribute("pm",pageModel);
        model.addAttribute("condition",condition);
        model.addAttribute("currentPage",pageNum);*/
        ModelAndView mv = new ModelAndView();
        mv.setViewName("deptList");
        mv.addObject("deptList",deptList);
        mv.addObject("pm",pageModel);
        mv.addObject("condition",condition);
        mv.addObject("currentPage",pageNum);
        return mv;
    }

    @RequestMapping("/addDept.do")
    public ModelAndView addDept(HttpServletRequest request){
        Object deptno = request.getParameter("deptno");
        Object dname = request.getParameter("dname");
        Object loc = request.getParameter("loc");
        Dept dept = Dept.builder().deptno(Integer.valueOf(deptno.toString())).dname(dname.toString()).loc(loc.toString()).build();
        deptService.addDept(dept);
        return getDeptList(request,"delete");
    }


    @RequestMapping("/removeDept.do")
    public ModelAndView removeDept(HttpServletRequest request){
        Object deptno = request.getParameter("deptno");
        deptService.removeDept(Integer.valueOf(deptno.toString()));
        return getDeptList(request,"delete");
    }

    @RequestMapping("/modifyDept.do")
    public ModelAndView modifyDept(HttpServletRequest request){
        Object deptno = request.getParameter("deptno");
        Object dname = request.getParameter("dname");
        Object loc = request.getParameter("loc");
        Dept dept = Dept.builder().deptno(Integer.valueOf(deptno.toString())).dname(dname.toString()).loc(loc.toString()).build();
        deptService.modifyDept(dept);
        return getDeptList(request,"delete");
    }
}
