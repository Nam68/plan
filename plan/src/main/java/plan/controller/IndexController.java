package plan.controller;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import plan.app.MyEnum.HeaderIcon;

@Controller
public class IndexController {
	
	@RequestMapping("/index.do")
	public String index(HttpSession session) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		long period = System.currentTimeMillis() - sdf.parse("2018-09-16").getTime();
		
		DecimalFormat df = new DecimalFormat("###,###");
		session.setAttribute("period", df.format(period/1000/60/60/24));
		
		session.setAttribute("header", HeaderIcon.HOME);
		
		return "index";
	}
	
}
