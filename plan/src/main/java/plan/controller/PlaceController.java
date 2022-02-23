package plan.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import plan.app.AuthenticationApp;
import plan.app.MyEnum.ErrorJudgment;
import plan.app.MyEnum.Region;
import plan.domain.item.GeometryValue;
import plan.domain.item.Plan;
import plan.domain.member.Member;
import plan.service.PlaceService;

@Controller
public class PlaceController {
	
	@Autowired
	private AuthenticationApp auth;
	
	@Autowired
	private PlaceService service;
	
	@RequestMapping(value = "/trip/place/registerPlace.do", method = RequestMethod.GET)
	public ModelAndView registerPlace(HttpSession session) {
		session.setAttribute("header", "trip");
		Member member = (Member) session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		if(auth.isAdmin(session, mav) && member != null) {
			mav.setViewName("trip/place/registerPlace");
			mav.addObject("region", Region.getJsonList());
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/trip/place/regionPick.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> regionPick(String region) {
		Region r = service.regionPick(region);
		Map<String, String> map = new HashMap<String, String>();
		map.put("input", r.getValue_jpn());
		map.put("value", r.toString());
		return map;
	}
	
	@RequestMapping(value = "/trip/place/placeAdd.do", method = RequestMethod.POST)
	@ResponseBody
	public ErrorJudgment placeAdd(Plan plan, String lat, String lng, HttpSession session) {
		plan.setGeomertry(new GeometryValue(Double.parseDouble(lat), Double.parseDouble(lng)));
		return service.save(plan, (Member) session.getAttribute("member"));
	}
	
}
