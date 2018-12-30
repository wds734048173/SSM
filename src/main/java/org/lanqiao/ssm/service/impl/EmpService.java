package org.lanqiao.ssm.service.impl;

import org.lanqiao.ssm.mapper.EmpMapper;
import org.lanqiao.ssm.pojo.Emp;
import org.lanqiao.ssm.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Auther: WDS
 * @Date: 2018/12/29 22:23
 * @Description:
 */

public class EmpService implements IEmpService {

    EmpMapper empMapper;

    public void setEmpMapper(EmpMapper empMapper) {
        this.empMapper = empMapper;
    }

    @Override
    public Emp fingEmpById(int empno) {
        return empMapper.getEmpById(empno);
    }
}
