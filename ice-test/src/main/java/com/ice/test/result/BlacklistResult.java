package com.ice.test.result;

import com.ice.core.context.IceRoam;
import com.ice.core.leaf.roam.BaseLeafRoamResult;

/**
 * Raffle责任链 - 黑名单规则 - 执行节点
 *
 * @author limoukun
 * @since 2025/1/19
 **/
public class BlacklistResult extends BaseLeafRoamResult {
    @Override
    protected boolean doRoamResult(IceRoam roam) {

        System.out.println("执行黑名单接管逻辑...");
        return true;
    }
}
