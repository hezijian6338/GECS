package com.thinkgem.jeesite.modules.sign.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sign.entity.Client;
import org.springframework.stereotype.Component;

/**
 *  DAO 接口类
 * Created by bb on 2017-11-11.
 */
@MyBatisDao
public interface ClientTestDao {

     int insert(Client client);

     Client isPass(Client client);
}
