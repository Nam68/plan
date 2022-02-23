package plan.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import plan.app.AuthenticationApp;
import plan.app.MyEnum.ErrorJudgment;
import plan.app.MyEnum.Region;
import plan.domain.item.GeometryValue;
import plan.domain.item.Item;
import plan.domain.item.Plan;
import plan.domain.member.Member;
import plan.service.PlaceService;

@Controller
public class PlaceController {
	
	@Autowired
	private AuthenticationApp auth;
	
	@Autowired
	private PlaceService service;
	
	/*
	 * 장소 등록 관련
	 */
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
		plan.setGeometry(new GeometryValue(Double.parseDouble(lat), Double.parseDouble(lng)));
		return service.save(plan, (Member) session.getAttribute("member"));
	}
	
	
	/*
	 * 등록된 장소 리스트 관련
	 */
	@RequestMapping(value = "/trip/place/placeList.do", method = RequestMethod.GET)
	public ModelAndView placeList(HttpSession session, @RequestParam(defaultValue = "1")int page) {
		session.setAttribute("header", "trip");
		Member member = (Member) session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView();
		if(auth.isAdmin(session, mav) && member != null) {
			mav.setViewName("trip/place/placeList");
			mav.addObject("page", service.pageCode(page));
			mav.addObject("placesave", service.findAllWithPage(page));
		}
		
		return mav;
	} 
	
	@RequestMapping("/trip/place/placeContentFind.do")
	@ResponseBody
	public Plan placeContentFind(@RequestParam("index") Plan plan) {
		return plan;
	}
	
}
