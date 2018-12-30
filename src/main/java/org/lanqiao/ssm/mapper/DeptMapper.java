package org.lanqiao.ssm.mapper;

import org.lanqiao.ssm.pojo.Condition;
import org.lanqiao.ssm.pojo.Dept;
import org.lanqiao.ssm.pojo.Emp;

import java.util.List;

/**
 * @Auther: WDS
 * @Date: 2018/12/30 22:31
 * @Description:
 */
public interface DeptMapper {
    //通过deptno获取dept信息
    public Dept getDeptById(int deptno);
    //获取dept列表
    public List<Dept> getAll(Condition condition);
    //新增dept
    public void insertDept(Dept dept);
    //修改dept
    public void updateDept(Dept dept);
    //删除dept
    public void deleteDept(int deptno);
    //获取部门总数
    public int getDeptCount(Condition condition);
}
