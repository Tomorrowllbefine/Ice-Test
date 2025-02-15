package com.ice.test.flow;

import com.ice.core.context.IceRoam;
import com.ice.core.leaf.roam.BaseLeafRoamFlow;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Objects;

/**
 * Raffle责任链 - 黑名单规则 - 判断节点
 *
 * @author limoukun
 * @since 2025/1/19
 **/
@Data
@EqualsAndHashCode(callSuper = true)
public class BlacklistFlow extends BaseLeafRoamFlow {
    /** 黑名单uid */
    private String key;
    /** 黑名单默认积分0.1 */
    private double defaultValue;
    /** 运营配置的黑名单列表 */
    private Integer blacklist;

    @Override
    protected boolean doRoamFlow(IceRoam roam) {
        Object userId = roam.getMulti(key);
        if(userId == null){
            System.out.println("Raffle责任链 - 黑名单规则 - 判断节点: key为null" );
            return false;
        }

        return Objects.equals(userId, blacklist);
    }
}
