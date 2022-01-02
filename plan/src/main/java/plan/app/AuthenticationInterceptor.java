package plan.app;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import plan.domain.member.AutoAuthentication;
import plan.domain.member.Member;
import plan.repository.AutoAuthenticationRepository;
import plan.service.MemberService;

@Component
public class AuthenticationInterceptor extends HandlerInterceptorAdapter {
	
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
				if(authInfo != null) session.setAttribute("member", authInfo.getMember()); 
			}
		}
		
		return super.preHandle(request, response, handler);
	}
	
}
