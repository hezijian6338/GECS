package com.thinkgem.jeesite.modules.sign.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sign.dao.ClientTestDao;
import com.thinkgem.jeesite.modules.sign.entity.Client;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 业务逻辑实现类
 *Created by bb on 2017-11-11.
 */
@Service
public class ClientTestService {

    @Autowired
    ClientTestDao clientTestDao;

    public int insert(Client client){
        return clientTestDao.insert(client);
    }

    public Client isPass(Client client) {
        Client client2 = clientTestDao.isPass(client);
        System.out.println("clientTestDao.isPass(client):"+client2);
        if (client2 != null){
            return client2;
        }
        return null;
    }

}
