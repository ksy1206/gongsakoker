package gongsakoker.helper.exception;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import gongsakoker.vo.MemberVO;




public class EventInterceptor extends HandlerInterceptorAdapter{

	private final static Log logger = LogFactory.getLog(EventInterceptor.class);
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {	
		
		//ModelAndView output = null;
        String combo = request.getParameter("combo");
        
        String uri = request.getRequestURI();
        int i = uri.indexOf("/", uri.indexOf("/")+1) + 1;
        int j = uri.indexOf(".", i+1);
        String method = uri.substring(i, j);
        
        logger.debug("* URI : " + uri);
        
        if((!method.equals("loginInit") && !method.equals("doLogin")  && !method.equals("autoLogin")   && !method.equals("modifyOutUserPswd") 
        		&& !method.equals("doLogout") && !method.equals("sessionCheck")) && !sessionChk(request, response)) {
        	String cp = request.getContextPath();
        	response.sendRedirect(cp+"/login/doLogout.do");
        	return false;
        }
        
      
        Map<String, Object> uMap = new HashMap<String, Object>();
        HttpSession session = request.getSession(true);
        if(session != null) {
        	uMap = (Map<String, Object>)session.getAttribute("sessionData");
        	if(uMap != null) {
        		MemberVO member = (MemberVO)uMap.get("member");
        		request.setAttribute("member_id", member.getMember_id());
        	}
        }
        
  		
        return true;
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean sessionChk(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Map<String, Object> uMap = new HashMap<String, Object>();
        HttpSession session = request.getSession(true);
        uMap = (Map<String, Object>)session.getAttribute("sessionData");
        
        if(uMap==null){
        	return false;
        }
        
        MemberVO member = (MemberVO)uMap.get("member");
		
        if(member == null) {
			return false;
		}
			
		return true;
	}
	
	
	
}
