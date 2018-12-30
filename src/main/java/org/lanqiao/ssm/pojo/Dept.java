package org.lanqiao.ssm.pojo;

import lombok.*;

/**
 * @Auther: WDS
 * @Date: 2018/12/30 22:32
 * @Description:
 */

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Dept {
    private int deptno;
    private String dname;
    private String loc;
}
