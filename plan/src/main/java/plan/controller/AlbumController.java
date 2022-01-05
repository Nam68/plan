package plan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import plan.app.AuthenticationApp;
import plan.app.MyEnum.ErrorJudgment;
import plan.app.MyEnum.Region;
import plan.domain.item.Album;
import plan.domain.member.Member;
import plan.service.AlbumService;

@Controller
public class AlbumController {
	
	@Autowired
	private AuthenticationApp a;
	
	@Autowired
	private AlbumService as;
	
	@RequestMapping("/album/albumList.do")
	public String albumList(HttpSession session, Model model, @RequestParam(defaultValue = "1")int page) {
		session.setAttribute("header", "album");
		
		//지역 전체를 넘겨주는 코드
		Region[] enums = Region.values();
		List<Map<String, String>> regionList = new ArrayList<Map<String, String>>();
		for(Region region : enums) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("name", region.getValue());
			map.put("value", region.toString());
			regionList.add(map);
		}
		model.addAttribute("regions", regionList);
		
		model.addAttribute("page", page);
		model.addAttribute("list", as.findAll(page));
		
		return "album/albumList";
	}
	
	@RequestMapping(value = "/album/albumAdd.do", method = RequestMethod.POST)
	@ResponseBody
	public ErrorJudgment albumAdd(Album album, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if(member == null) return ErrorJudgment.ERROR;
		
		return as.save(album, member);
	}
	
	/**
	 * 이미지 관련 메서드
	 */
	@RequestMapping(value = "/album/tempAlbumImgAdd.do", method = RequestMethod.POST)
	@ResponseBody
	public ErrorJudgment tmpAlbumImgAdd(MultipartFile[] files, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if(member == null) return ErrorJudgment.ERROR;
		return as.tempAlbumImgAdd(files, member.getId());
	}
	
	@RequestMapping("/album/tempAlbumImageList.do")
	@ResponseBody
	public List<String> tempAlbumImageList(HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if(member == null) return null;
		
		return as.tempAlbumImageList(member.getId());
	}
	
	@RequestMapping("/album/tempAlbumImageDelete.do")
	@ResponseBody
	public ErrorJudgment tempAlbumImageDelete(HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if(member == null) return ErrorJudgment.ERROR;
		as.tempAlbumImageDelete(member.getId());
		return ErrorJudgment.SUCCESS;
	}
	
}
