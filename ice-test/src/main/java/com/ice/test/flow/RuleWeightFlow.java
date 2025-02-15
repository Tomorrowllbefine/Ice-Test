package com.ice.test.flow;

import com.ice.core.annotation.IceField;
import com.ice.core.context.IceRoam;
import com.ice.core.leaf.roam.BaseLeafRoamFlow;
import com.ice.test.model.StrategyRuleEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;
import java.util.Map;

/**
 * Raffle责任链 - 权重规则 - 判断节点
 *
 * @author limoukun
 * @since 2025/1/19
 **/
@Data
@EqualsAndHashCode(callSuper = true)
public class RuleWeightFlow extends BaseLeafRoamFlow {

    // 4000:102,103,104,105 5000:102,103,104,105,106,107 6000:102,103,104,105,106,107,108
    @IceField(name = "weightRule", desc = "权重规则描述")
    private String weightRule;
    /** 用户积分 */
//    private Integer credit;

    // todo 抽奖次数等条件

    @Override
    protected boolean doRoamFlow(IceRoam roam) {

        if(weightRule == null || weightRule.isEmpty()){
            System.err.println("未配置权重规则!");
            return false;
        }

        // 获取入参的用户积分
        Integer credit = (Integer)roam.getMulti("credit");

        StrategyRuleEntity strategyRuleEntity = new StrategyRuleEntity();
        strategyRuleEntity.setRuleModel("rule_weight");
        strategyRuleEntity.setRuleValue(weightRule);
        Map<String, List<Integer>> ruleWeightValuesTreeMap = strategyRuleEntity.getRuleWeightValues();
        System.out.println(ruleWeightValuesTreeMap);

        String prev = null;
        String cur = null;
        for (String key : ruleWeightValuesTreeMap.keySet())
        {
            cur = key;
            if(credit < Integer.parseInt(cur)) break;
            prev = cur;
        }
        System.out.println("当前匹配的权重积分" + prev);

        if(null == prev){
            System.err.println("放行:用户积分未达最低标准");
            return false;
        }

        return Boolean.TRUE;
    }
}
