/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.api.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.api.entity.ApiInterface;
import com.thinkgem.jeesite.modules.api.dao.ApiInterfaceDao;

/**
 * API接口接入Service
 * @author xucaikai
 * @version 2017-12-06
 */
@Service
@Transactional(readOnly = true)
public class ApiInterfaceService extends CrudService<ApiInterfaceDao, ApiInterface> {

	@Autowired
	private ApiInterfaceDao apiInterfaceDao;

	public ApiInterface get(String id) {
		return super.get(id);
	}
	
	public List<ApiInterface> findList(ApiInterface apiInterface) {
		return super.findList(apiInterface);
	}
	
	public Page<ApiInterface> findPage(Page<ApiInterface> page, ApiInterface apiInterface) {
		return super.findPage(page, apiInterface);
	}
	
	@Transactional(readOnly = false)
	public void save(ApiInterface apiInterface) {
		super.save(apiInterface);
	}
	
	@Transactional(readOnly = false)
	public void delete(ApiInterface apiInterface) {
		super.delete(apiInterface);
	}

	@Transactional(readOnly = false)
	public  ApiInterface isExistToken(String accesstoken){
		return  apiInterfaceDao.isExistToken(accesstoken);
	}
/**
 * @author 许彩开
 * @TODO (注：获取token)
  * @param appid
 * @DATE: 2017\12\6 0006 17:30
 */

	@Transactional(readOnly = false)
	public  ApiInterface getToken(String appid,String appseceret){
		return  apiInterfaceDao.getToken(appid,appseceret);
	}

}