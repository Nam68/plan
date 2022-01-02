package plan.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import plan.app.MyEnum.ErrorJudgment;
import plan.domain.member.Member;
import plan.service.MemberService;

@Controller
public class UserController {
	
	@Autowired
	private MemberService ms;
	
	@RequestMapping("/signin.do")
	public String signin(HttpSession session) {
		session.setAttribute("header", "user");
		return "user/signin";
	}	
	
	@RequestMapping(value = "/signin.do", method = RequestMethod.POST)
	@ResponseBody
	public String signin(Member member, boolean check, HttpSession session, HttpServletResponse res) {
		
		Member signinMember = ms.signin(member);
		session.setAttribute("member", signinMember);

		// check되어 있다면 로그인용 쿠키를 생성
		if(signinMember != null && check == true) ms.setSigninCookie(res, signinMember.getIndex(), session.getId());
		
		ErrorJudgment ej = signinMember == null? ErrorJudgment.ERROR : ErrorJudgment.SUCCESS;
		return ej.getValue();
	}
	
	@RequestMapping("/signup.do")
	public String signup(HttpSession session) {
		session.setAttribute("header", "user");
		return "user/signup";
	}
	
	@RequestMapping(value = "/signup.do", method = RequestMethod.POST)
	@ResponseBody
	public String signup(Member member) {
		return ms.join(member);
	}
	
	@RequestMapping("/signout.do")
	public String signout(HttpServletRequest req, HttpServletResponse res) {
		ms.removeSigninCookie(req, res);
		req.getSession().invalidate();
		return ErrorJudgment.SUCCESS.getValue();
	}
	
}
