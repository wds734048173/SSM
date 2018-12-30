package org.lanqiao.ssm.service;

import org.lanqiao.ssm.pojo.Condition;
import org.lanqiao.ssm.pojo.Dept;

import java.util.List;

public interface IDeptService {
    //通过deptno查找dept
    public Dept fingDeptById(int deptno);
    //查询全部
    public List<Dept> findAll(Condition condition);
    //修改dept
    public void modifyDept(Dept dept);
    //新增dept
    public void addDept(Dept dept);
    //删除dept
    public void removeDept(int deptno);
    //获取部门数量
    public int getDeptCount(Condition condition);
}
