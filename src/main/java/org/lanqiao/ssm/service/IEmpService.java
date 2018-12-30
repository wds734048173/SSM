package org.lanqiao.ssm.service;

import org.lanqiao.ssm.pojo.Condition;
import org.lanqiao.ssm.pojo.Emp;

import java.util.List;

/**
 * @Auther: WDS
 * @Date: 2018/12/29 22:22
 * @Description:
 */
public interface IEmpService {
    //通过empno查找emp
    public Emp fingEmpById(int empno);
    //查询全部
    public List<Emp> findAll(Condition condition);
    //修改emp
    public void modifyEmp(Emp emp);
    //新增emp
    public void addEmp(Emp emp);
    //删除emp
    public void removeEmp(int empno);
    //获取总数
    public int getEmpCount(Condition condition);
}
