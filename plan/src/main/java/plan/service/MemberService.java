package plan.service;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.WebUtils;

import plan.app.MyEnum.ErrorJudgment;
import plan.domain.member.Member;
import plan.domain.member.AutoAuthentication;
import plan.repository.AutoAuthenticationRepository;
import plan.repository.MemberRepository;

@Service
@Transactional(readOnly = true)
public class MemberService {
	
	@Autowired
	private MemberRepository mr;
	
	@Autowired
	private AutoAuthenticationRepository ar;
	
	@PersistenceContext
	EntityManager em;
	
	/**
	 * 회원가입
	 */
	@Transactional
	public String join(Member member) {
		if(isExistMember(member)) { //중복 검증(아이디가 이미 존재하는지?)
			//아이디가 존재한다면
			return ErrorJudgment.ERROR.getValue();
		}
		mr.save(member);
		return ErrorJudgment.SUCCESS.getValue();
	}
	
	private boolean isExistMember(Member member) {
		Member findMember = mr.findById(member.getId());
		if(findMember != null) return true; //이미 아이디가 있으면 true 반환
		return false;
	}
	
	
	/**
	 * 로그인
	 */
	public Member signin(Member member) {
		return mr.findByIdAndPassword(member.getId(), member.getPassword());
	}
	
	/**
	 * 로그인 유지 쿠키 생성
	 */
	@Transactional
	public void setSigninCookie(HttpServletResponse res, Long memberIndex, String sessionId) {
		// 로그인용 쿠키 생성
		Cookie cookie = new Cookie("autoSignin", sessionId);
		long age = 60 * 60 * 24 * 365; //초 분 시 일
		cookie.setMaxAge((int)age);
		cookie.setPath("/"); //어디서든 찾을 수 있게 path 설정
		res.addCookie(cookie);

		// DB에 쿠키정보를 저장
		Date sessionAge = new Date(System.currentTimeMillis() + (1000 * age)); //밀리세컨드 | age는 초
		
		if(!ar.findById(sessionId).isEmpty()) ar.delete(new AutoAuthentication(sessionId));
		ar.save(new AutoAuthentication(sessionId, sessionAge, memberIndex));
	}
	
	/***
	 * 로그아웃 후 자동로그인 쿠키 삭제
	 */
	@Transactional
	public void removeSigninCookie(HttpServletRequest req, HttpServletResponse res) {
		Cookie cookie = WebUtils.getCookie(req, "autoSignin");
		Member member = (Member) req.getSession().getAttribute("member");
		if(cookie != null) {
			cookie.setMaxAge(0);
			cookie.setPath("/");
			res.addCookie(cookie);
			
			ar.delete(new AutoAuthentication(cookie.getValue()));
		}
	}
	
}
