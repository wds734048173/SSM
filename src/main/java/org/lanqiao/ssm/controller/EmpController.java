package org.lanqiao.ssm.controller;

import org.lanqiao.ssm.pojo.Emp;
import org.lanqiao.ssm.service.IEmpService;
import org.lanqiao.ssm.service.impl.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Auther: WDS
 * @Date: 2018/12/29 22:25
 * @Description:
 */

@Controller
public class EmpController {
    @Autowired
    IEmpService empService;
    @RequestMapping("/emp.do")
    public void getEmpById(){
        Emp emp = empService.fingEmpById(7369);
        System.out.println(emp);
    }
}
