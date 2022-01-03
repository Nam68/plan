package plan.app;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import plan.domain.member.AutoAuthentication;
import plan.repository.AutoAuthenticationRepository;

public class AutoSigninInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	private AutoAuthenticationRepository ar;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Object signinMember = session.getAttribute("member");
		
		if(signinMember == null) {
			Cookie cookie = WebUtils.getCookie(request, "autoSignin");
			if(cookie != null) {
				AutoAuthentication authInfo = ar.findBySessionKey(cookie.getValue());
				if(authInfo != null && authInfo.getSessionLimit().after(new Date(System.currentTimeMillis()))) {
					session.setAttribute("member", authInfo.getMember()); 
				}
			}
		}
		
		return super.preHandle(request, response, handler);
	}
	
}
