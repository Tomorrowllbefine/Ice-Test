package com.ice.server.service.impl;

import com.ice.server.dao.mapper.IceConfMapper;
import com.ice.server.dao.model.IceConf;
import com.ice.server.model.IceLeafClass;
import com.ice.server.service.IceConfService;
import com.ice.server.service.IceServerService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;

@Slf4j
@Service
public class IceConfServiceImpl implements IceConfService {

    @Resource
    private IceConfMapper iceConfMapper;

    @Resource
    private IceServerService serverService;

    @Override
    @Transactional
    public Long confEdit(IceConf conf, Long parentId, Long nextId) {
        conf.setUpdateAt(new Date());
        if (conf.getId() == null) {
            if (parentId != null) {
                /*add son*/
                IceConf parent = iceConfMapper.selectByPrimaryKey(parentId);
                if (parent == null) {
                    return -1L;
                }
                iceConfMapper.insertSelective(conf);
                Long id = conf.getId();
                if (StringUtils.isEmpty(parent.getSonIds())) {
                    parent.setSonIds(id + "");
                } else {
                    parent.setSonIds(parent.getSonIds() + "," + id);
                }
                parent.setUpdateAt(new Date());
                iceConfMapper.updateByPrimaryKeySelective(parent);
                return id;
            }
            if (nextId != null) {
                /*add forward*/
                IceConf next = iceConfMapper.selectByPrimaryKey(nextId);
                if (next == null) {
                    return -1L;
                }
                if (next.getForwardId() != null && next.getForwardId() > 0) {
                    return -1L;
                }
                iceConfMapper.insertSelective(conf);
                Long id = conf.getId();
                next.setForwardId(id);
                next.setUpdateAt(new Date());
                iceConfMapper.updateByPrimaryKeySelective(next);
                return id;
            }
        }
        iceConfMapper.updateByPrimaryKeySelective(conf);
        return conf.getId();
    }

    @Override
    public List<IceLeafClass> confLeafClass(Integer app, Byte type) {
        List<IceLeafClass> list = new ArrayList<>();
        Map<String, Integer> leafClassMap = serverService.getLeafClassMap(app, type);
        if (leafClassMap != null) {
            for (Map.Entry<String, Integer> entry : leafClassMap.entrySet()) {
                IceLeafClass leafClass = new IceLeafClass();
                leafClass.setFullName(entry.getKey());
                leafClass.setCount(entry.getValue());
                leafClass.setShortName(entry.getKey().substring(entry.getKey().lastIndexOf('.') + 1));
                list.add(leafClass);
            }
        }
        list.sort(Comparator.comparingInt(IceLeafClass::sortNegativeCount));
        return list;
    }
}
