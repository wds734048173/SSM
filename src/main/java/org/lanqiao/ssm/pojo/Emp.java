package org.lanqiao.ssm.pojo;

import lombok.*;

import java.util.Date;

/**
 * @Auther: WDS
 * @Date: 2018/12/29 22:23
 * @Description:
 */
@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Emp {
    private int empno;
    private String ename;
    private String job;
    private int mgr;
    private String mgrName;
    private Date hiredate;
    private double sal;
    private double comm;
    private int deptno;
    private String deptName;
}
