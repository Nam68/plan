package plan.controller;


import java.util.List;

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
import plan.model.vo.GlobalVO;
import plan.service.AlbumService;

@Controller
public class AlbumController {
	
	@Autowired
	private AlbumService service;
	
	@Autowired
	private AuthenticationApp auth;
	
	@RequestMapping("/album/albumList.do")
	public String albumList(HttpSession session, Model model, @RequestParam(defaultValue = "1")int page) {
		session.setAttribute("header", "album");
		
		//지역 전체를 넘겨주는 코드
		model.addAttribute("regions", Region.getJsonList());
		
		model.addAttribute("page", page);
		model.addAttribute("list", service.findAllWithPage(page));
		model.addAttribute("pageCode", service.pageCode(page));
		
		return "album/albumList";
	}
	
	@RequestMapping(value = "/album/albumContent.do")
	@ResponseBody
	public Album albumContent(Long index) {
		return service.find(index);
	}
	
	@RequestMapping(value = "/album/albumAdd.do", method = RequestMethod.GET)
	public ModelAndView albumAdd(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member member = (Member) session.getAttribute("member");
		
		if(auth.isAdmin(session, mav) && member != null) {
			mav.setViewName("album/albumAdd");
			mav.addObject("regions", Region.getJsonList());
			service.tempAlbumImageDelete(member.getId()); //임시폴더에 있을지도 모르는 파일들 삭제
		}
		return mav;
	}
	
	@RequestMapping(value = "/album/albumAdd.do", method = RequestMethod.POST)
	public String albumAdd(Album album, HttpSession session, Model model) {
		GlobalVO vo = new GlobalVO();
		
		Member member = (Member) session.getAttribute("member");
		if(member == null) {
			vo.setMassage("アカウント情報が見つかりません！");
			vo.setHref("/plan/signin.do");
		} else {
			
			if(service.save(album, member) == ErrorJudgment.SUCCESS) {
				vo.setMassage("登録が完了されました");
				vo.setHref("albumList.do");
			} else {
				vo.setMassage("登録できません！\n管理者にお問い合わせください");
				vo.setHref("albumAdd.do");
			}
			
		}
		
		model.addAttribute("vo", vo);
		return "global";
	}
	
	@RequestMapping(value = "/album/albumUpdate.do", method = RequestMethod.GET)
	@ResponseBody
	public ErrorJudgment albumUpdate(Long index, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if(member == null) return ErrorJudgment.ERROR;
		
		return service.tempAlbumImageForUpdate(service.find(index), member.getId());
	}
	
	@RequestMapping(value = "/album/albumUpdate.do", method = RequestMethod.POST)
	public String albumUpdate(Long index, Model model) {
		model.addAttribute("album", service.find(index));
		model.addAttribute("regions", Region.getJsonList());
		return "album/albumUpdate";
	}
	
	/**
	 * 이미지 관련 메서드
	 */
	@RequestMapping(value = "/album/tempAlbumImgAdd.do", method = RequestMethod.POST)
	@ResponseBody
	public ErrorJudgment tmpAlbumImgAdd(MultipartFile[] files, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if(member == null) return ErrorJudgment.ERROR;
		return service.tempAlbumImgAdd(files, member.getId());
	}
	
	@RequestMapping("/album/tempAlbumImageList.do")
	@ResponseBody
	public List<String> tempAlbumImageList(HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if(member == null) return null;
		
		return service.tempAlbumImageList(member.getId());
	}
	
	@RequestMapping(value = "/album/tempAlbumImageDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public ErrorJudgment tempAlbumImageDelete(@RequestParam(value = "urls")List<String> urls, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if(member == null) return ErrorJudgment.ERROR;
		System.out.println(urls.size());
		return service.tempAlbumImageDelete(member.getId(), urls);
	}
	
}
