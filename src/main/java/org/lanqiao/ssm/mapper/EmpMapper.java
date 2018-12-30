package org.lanqiao.ssm.mapper;

import org.lanqiao.ssm.pojo.Emp;
import org.springframework.stereotype.Repository;

/**
 * @Auther: WDS
 * @Date: 2018/12/29 22:24
 * @Description:
 */
@Repository("empMapper")
public interface EmpMapper {
    public Emp getEmpById(int empno);
}
