package gongsakoker.serviceImpl;


import java.util.Iterator;

import javax.annotation.Resource;

import org.apache.commons.collections.functors.ForClosure;
import org.springframework.stereotype.Service;
import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.AddCompanyService;

/**
* 설명 : 업체등록 관련 서비스 구현 클래스
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2015.12.01    권세윤    
*************************
*
*/

@Service ("gongsakoker.AddCompanyService")
public class AddCompanyServiceImpl implements AddCompanyService {
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public String insertAddCompany(gongsakoker.vo.AddCompanyVO company) {
		// TODO Auto-generated method stub

		int check=0;
		String add_company_check = null;
		
		try {
		
			check = this.commonDao.insertData("addCompany.insertAddCompany", company);
			
			if(check==0){
				add_company_check="N";
			} else {
				add_company_check="Y";
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return add_company_check;
	}
}
