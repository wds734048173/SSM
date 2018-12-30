package org.lanqiao.ssm.controller;

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

import javax.servlet.http.HttpServletRequest;
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
    public void getDeptById(){
        Dept dept = deptService.fingDeptById(10);
        System.out.println(dept);
    }

    @RequestMapping("/getDeptList.do")
    public String getDeptList(Model model, HttpServletRequest request,String mark){
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

        System.out.println(condition);
        List<Dept> deptList = deptService.findAll(condition);
        model.addAttribute("deptList",deptList);
        model.addAttribute("pm",pageModel);
        model.addAttribute("condition",condition);
        model.addAttribute("currentPage",pageNum);
        return "deptList";
    }

    @RequestMapping("/addDept.do")
    public void addDept(){
        Dept dept = Dept.builder().deptno(50).dname("wds").loc("cxy").build();
        deptService.addDept(dept);
    }


    @RequestMapping("/removeDept.do")
    public void removeDept(){
        deptService.removeDept(50);
    }

    @RequestMapping("/modifyDept.do")
    public void modifyDept(){
        Dept dept = Dept.builder().deptno(50).dname("wds1").loc("cxy1").build();
        deptService.modifyDept(dept);
    }
}