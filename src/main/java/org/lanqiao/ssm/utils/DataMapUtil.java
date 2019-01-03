package org.lanqiao.ssm.utils;

import org.lanqiao.ssm.mapper.DeptMapper;
import org.lanqiao.ssm.mapper.EmpMapper;
import org.lanqiao.ssm.pojo.Dept;
import org.lanqiao.ssm.pojo.Emp;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: WDS
 * @Date: 2018/12/30 22:34
 * @Description:
 */
@Component
public class DataMapUtil {

    private static DataMapUtil dataMapUtil;

    private  DeptMapper deptMapper;

    private  EmpMapper empMapper;

    public void setDeptMapper(DeptMapper deptMapper) {
        this.deptMapper = deptMapper;
    }

    public void setEmpMapper(EmpMapper empMapper) {
        this.empMapper = empMapper;
    }

    public static   Map<Integer,String> getDeptMap(){
        Map<Integer,String> deptMap = new HashMap<>();
        DeptMapper deptMapper = dataMapUtil.deptMapper;
        List<Dept> deptList = deptMapper.getAll(null);
        for (Dept dept : deptList){
            deptMap.put(dept.getDeptno(),dept.getDname());
        }
        return deptMap;
    }

    public static   Map<Integer,String> getEmpMap(){
        Map<Integer,String> empMap = new HashMap<>();
        EmpMapper empMapper = dataMapUtil.empMapper;
        List<Emp> empList = empMapper.getAll(null);
        for(Emp emp : empList){
            empMap.put(emp.getEmpno(),emp.getEname());
        }
        return empMap;
    }

    @PostConstruct
    public void init(){
        dataMapUtil = this;
        dataMapUtil.deptMapper = this.deptMapper;
        dataMapUtil.empMapper = this.empMapper;
    }
}
