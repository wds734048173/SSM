package org.lanqiao.ssm.utils;

import org.lanqiao.ssm.mapper.DeptMapper;
import org.lanqiao.ssm.mapper.EmpMapper;
import org.lanqiao.ssm.pojo.Dept;
import org.lanqiao.ssm.pojo.Emp;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: WDS
 * @Date: 2018/12/30 22:34
 * @Description:
 */

public class DataMapUtil {
    @Autowired
    private static DeptMapper deptMapper;
    @Autowired
    private static EmpMapper empMapper;

    public static void setDeptMapper(DeptMapper deptMapper) {
        DataMapUtil.deptMapper = deptMapper;
    }

    public static void setEmpMapper(EmpMapper empMapper) {
        DataMapUtil.empMapper = empMapper;
    }

    public static Map<Integer,String> getDeptMap(){
        Map<Integer,String> deptMap = new HashMap<>();
        List<Dept> deptList = deptMapper.getAll(null);
        System.out.println("deptList==================="+deptList.size());
        for (Dept dept : deptList){
            deptMap.put(dept.getDeptno(),dept.getDname());
        }
        return deptMap;
    }

    public static Map<Integer,String> getEmpMap(){
        Map<Integer,String> empMap = new HashMap<>();
        List<Emp> empList = empMapper.getAll(null);
        System.out.println("emp============"+empList.size());
        for(Emp emp : empList){
            empMap.put(emp.getEmpno(),emp.getEname());
        }
        return empMap;
    }
}
