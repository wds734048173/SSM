package org.lanqiao.ssm.pojo;

import lombok.*;

/**
 * @Auther: WDS
 * @Date: 2018/12/31 00:09
 * @Description:
 */

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Condition {
    private int deptno;
    private int empno;
    private String name;
    private int currentPage;
    private int pageSize;
}
