/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.api.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.api.entity.ApiInterface;
import org.apache.ibatis.annotations.Param;

/**
 * API接口接入DAO接口
 * @author xucaikai
 * @version 2017-12-06
 */
@MyBatisDao
public interface ApiInterfaceDao extends CrudDao<ApiInterface> {
    //判断是否存在该token
    ApiInterface isExistToken(String accesstoken);
    //返回token
    ApiInterface getToken(@Param("appid")String appid,@Param("appseceret") String appseceret);
}