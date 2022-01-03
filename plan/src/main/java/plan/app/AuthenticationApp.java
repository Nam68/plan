package plan.app;

import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import plan.app.MyEnum.RoleType;
import plan.domain.member.Member;
import plan.model.vo.GlobalVO;

public class AuthenticationApp {
	
	public boolean isAdmin(HttpSession session, ModelAndView mav) {
		Member member = (Member) session.getAttribute("member");
		if(member == null || member.getRoleType() != RoleType.ADMIN) {
			mav.addObject("vo", new GlobalVO("管理者の権限がありません！", "/plan/index.do"));
			mav.setViewName("global");
			session.setAttribute("header", "home");
			return false;
		} else {
			return true;
		}
	}
	
	public boolean isUser(HttpSession session, ModelAndView mav) {
		Member member = (Member) session.getAttribute("member");
		if(member == null || member.getRoleType() == RoleType.AWIRTER) {
			mav.addObject("vo", new GlobalVO("権限がありません！", "/plan/index.do"));
			mav.setViewName("global");
			session.setAttribute("header", "home");
			return false;
		} else {
			return true;
		}
	}
	
}
