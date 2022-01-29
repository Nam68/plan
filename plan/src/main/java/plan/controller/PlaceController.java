package plan.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import plan.app.AuthenticationApp;
import plan.domain.member.Member;

@Controller
public class PlaceController {
	
	@Autowired
	private AuthenticationApp auth;
	
	@RequestMapping(value = "/trip/place/registerPlace.do", method = RequestMethod.GET)
	public ModelAndView registerPlace(HttpSession session) {
		session.setAttribute("header", "trip");
		Member member = (Member) session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		if(auth.isAdmin(session, mav) && member != null) {
			mav.setViewName("trip/place/registerPlace");
		}
		
		return mav;
	}
	
}
