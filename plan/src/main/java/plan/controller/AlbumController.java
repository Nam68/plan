package plan.controller;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import plan.app.AuthenticationApp;
import plan.app.MyEnum.ErrorJudgment;
import plan.domain.member.Member;
import plan.service.AlbumService;

@Controller
public class AlbumController {
	
	@Autowired
	private AuthenticationApp a;
	
	@Autowired
	private AlbumService as;
	
	@RequestMapping("/album/albumList.do")
	public ModelAndView albumList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(a.isAdmin(session, mav)) {
			session.setAttribute("header", "album");
		}
		return mav;
	}
	
	@RequestMapping(value = "/album/tempAlbumImgAdd.do", method = RequestMethod.POST)
	@ResponseBody
	public String tmpAlbumImgAdd(MultipartFile[] files, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		ErrorJudgment result = as.tmpAlbumImgAdd(files, member.getId());
		return result.getValue();
	}
	
}
