package com.ice.test.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.coyote.http11.Constants;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 * 策略规则实体
 *
 * @author limoukun
 * @since 2025/1/19
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class StrategyRuleEntity {

    /** 抽奖策略ID */
    private Long strategyId;
    /** 抽奖奖品ID */
    private Integer awardId;
    /** 抽奖规则类型 【1-策略类型、2-奖品规则】 */
    private Integer ruleType;
    /** 抽奖规则模型 【rule_random, rule_lock, rule_lucky_award, rule_blacklist】 */
    private String ruleModel;
    /** 抽奖规则的比值 */
    private String ruleValue;
    /** 抽奖规则描述 */
    private String ruleDesc;


    /**
     * 拆解value串封装为Map
     * <p>
     *     样例数据：4000:102,103,104,105 5000:102,103,104,105,106,107 6000:102,103,104,105,106,107,108
     * </p>
     * @return java.util.Map<java.lang.String,java.util.List<java.lang.Integer>>
     **/
    public Map<String, List<Integer>> getRuleWeightValues(){
        if(!"rule_weight".equals(ruleModel))
            return null;
        Map<String, List<Integer>> resultMap = new TreeMap<>();
        // 用空格分隔
        String[] strings = ruleValue.split(" ");
        for(String item : strings){
            System.out.println(item);
            // 用:分隔
            String[] strings1 = item.split(":");
            if(strings1.length != 2){
                throw new IllegalArgumentException("rule_weight invalid input! " + strings1);
            }
            String key = strings1[0];
            // 用,分隔
            String[] valuesArray  = strings1[1].split(",");
            List<Integer> valueList = new ArrayList<>();
            for (String str : valuesArray) {
                valueList.add(Integer.parseInt(str));
            }
            resultMap.put(key, valueList);
        }
        System.out.println(resultMap);
        return resultMap;
    }

    // Test
    public static void main(String[] args) {
        StrategyRuleEntity strategyRuleEntity = new StrategyRuleEntity();
        strategyRuleEntity.setRuleValue("4000:102,103,104,105 5000:102,103,104,105,106,107 6000:102,103,104,105,106,107,108");
        strategyRuleEntity.getRuleWeightValues();
    }
}