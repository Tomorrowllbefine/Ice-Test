package com.ice.test.result;

import com.ice.core.context.IceRoam;
import com.ice.core.leaf.roam.BaseLeafRoamResult;

/**
 * Raffle责任链 - 默认兜底抽奖逻辑 - 执行节点
 *
 * @author limoukun
 * @since 2025/1/19
 **/
public class LuckyAwardResult extends BaseLeafRoamResult {
    @Override
    protected boolean doRoamResult(IceRoam roam) {

        System.out.println("执行默认兜底抽奖逻辑....");

        return true;
    }
}
