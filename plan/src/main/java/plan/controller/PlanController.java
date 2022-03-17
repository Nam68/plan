package plan.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import plan.app.AuthenticationApp;
import plan.app.MyEnum.Country;
import plan.app.MyEnum.HeaderIcon;
import plan.app.MyEnum.Region;
import plan.domain.member.Member;
import plan.service.PlaceService;

@Controller
public class PlanController {

	@Autowired
	private AuthenticationApp auth;
	
	@Autowired
	private PlaceService placeService;
	
	/*
	 * 플랜 등록 관련
	 */
	@RequestMapping(value = "/trip/plan/registerTripPlan.do", method = RequestMethod.GET)
	public ModelAndView registerTripPlan(HttpSession session) {
		session.setAttribute("header", HeaderIcon.TRIP);
		Member member = (Member) session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		if(auth.isAdmin(session, mav) && member != null) {
			mav.setViewName("trip/plan/registerTripPlan");
			mav.addObject("countries", Country.getMapData());
			mav.addObject("regions", Region.getMapData());
			mav.addObject("places", placeService.find());
		}
		
		return mav;
	}
	
	/*
	 * 플랜 리스트 관련
	 */
	@RequestMapping(value = "/trip/plan/tripPlanList.do", method = RequestMethod.GET)
	public ModelAndView tripPlanList(HttpSession session) {
		session.setAttribute("header", HeaderIcon.TRIP);
		Member member = (Member) session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		if(auth.isAdmin(session, mav) && member != null) {
			mav.setViewName("trip/plan/tripPlanList");
		}
		
		return mav;
	}
	
}
