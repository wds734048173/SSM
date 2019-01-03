package org.lanqiao.ssm.service.impl;

import org.lanqiao.ssm.mapper.EmpMapper;
import org.lanqiao.ssm.pojo.Condition;
import org.lanqiao.ssm.pojo.Emp;
import org.lanqiao.ssm.service.IEmpService;
import org.lanqiao.ssm.utils.DataMapUtil;

import java.util.List;
import java.util.Map;

/**
 * @Auther: WDS
 * @Date: 2018/12/29 22:23
 * @Description:
 */

public class EmpServiceImpl implements IEmpService {

    EmpMapper empMapper;

    public void setEmpMapper(EmpMapper empMapper) {
        this.empMapper = empMapper;
    }

    @Override
    public Emp fingEmpById(int empno) {
        return empMapper.getEmpById(empno);
    }

    @Override
    public List<Emp> findAll(Condition condition) {
        List<Emp> empList = empMapper.getAll(condition);
        Map<Integer,String> deptMap = DataMapUtil.getDeptMap();
        Map<Integer,String> empMap = DataMapUtil.getEmpMap();
        for(Emp emp : empList){
            int  deptno = emp.getDeptno();
            int mgr = emp.getMgr();
            if(deptMap.containsKey(deptno)){
                emp.setDeptName(deptMap.get(deptno));
            }
            if(empMap.containsKey(mgr)){
                emp.setMgrName(empMap.get(mgr));
            }
        }
        return empList;
    }

    @Override
    public void modifyEmp(Emp emp) {
        empMapper.updateEmp(emp);
    }

    @Override
    public void addEmp(Emp emp) {
        empMapper.insertEmp(emp);
    }

    @Override
    public void removeEmp(int empno) {
        empMapper.deleteEmp(empno);
    }

    @Override
    public int getEmpCount(Condition condition) {
        return empMapper.getEmpCount(condition);
    }
}
