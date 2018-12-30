package org.lanqiao.ssm.service.impl;

import org.lanqiao.ssm.mapper.DeptMapper;
import org.lanqiao.ssm.pojo.Condition;
import org.lanqiao.ssm.pojo.Dept;
import org.lanqiao.ssm.service.IDeptService;

import java.util.List;

/**
 * @Auther: WDS
 * @Date: 2018/12/30 22:33
 * @Description:
 */
public class DeptServiceImpl implements IDeptService {

    DeptMapper deptMapper;

    public void setDeptMapper(DeptMapper deptMapper) {
        this.deptMapper = deptMapper;
    }

    @Override
    public Dept fingDeptById(int deptno) {
        return deptMapper.getDeptById(deptno);
    }

    @Override
    public List<Dept> findAll(Condition condition) {
        return deptMapper.getAll(condition);
    }

    @Override
    public void modifyDept(Dept dept) {
        deptMapper.updateDept(dept);
    }

    @Override
    public void addDept(Dept dept) {
        deptMapper.insertDept(dept);
    }

    @Override
    public void removeDept(int deptno) {
        deptMapper.deleteDept(deptno);
    }

    @Override
    public int getDeptCount(Condition condition) {
        return deptMapper.getDeptCount(condition);
    }
}
