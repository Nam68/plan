package plan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import plan.app.MyEnum.ErrorJudgment;
import plan.app.MyEnum.Region;
import plan.app.PageApp;
import plan.domain.item.Plan;
import plan.domain.member.Member;
import plan.repository.PlaceRepository;

@Service
@Transactional(readOnly = true)
public class PlaceService {
	
	@Autowired
	private PlaceRepository repository;
	
	@Autowired
	private PageApp pageApp;
	
	private static final int CONTENTS_SIZE = 20;
	private static final int PAGE_SIZE = 5;
	private static final String URL = "placeList.do";
	
	/**
	 * 구글맵에서 선택한 주소를 통해 지역 enum을 반환
	 */
	public Region regionPick(String region) {
		Region result = Region.OVERSEAS;
		for(Region r : Region.values()) {
			if(region.contains(r.getValue_kor())) {
				result = r;
				break;
			} else if(region.contains(r.getValue_jpn())) {
				result = r;
				break;
			} else if(region.contains(r.getValue_eng())) {
				result = r;
				break;
			}
		}
		return result;
	}
	
	@Transactional
	public ErrorJudgment save(Plan plan, Member member) {
		if(plan == null) return ErrorJudgment.ERROR;
		if(member == null) return ErrorJudgment.ERROR;
		
		plan.setMember(member);
		repository.save(plan);
		
		return ErrorJudgment.SUCCESS;
	}
	
	/**
	 * 페이징된 저장 장소 반환
	 */
	public List<Plan> findAllWithPage(int page) {
		//페이지 시작이 0페이지부터이므로 1부터 시작으로 계산된 page 변수에서 1을 뺌
		PageRequest pageRequest = PageRequest.of(page-1, CONTENTS_SIZE, Direction.DESC, "index");
		List<Plan> result = repository.findAll(pageRequest).getContent();
		return result;
	}
	
	/**
	 * 앱을 통해 페이지네이션 코드를 반환하는 메서드
	 */
	public String pageCode(int page) {
		return pageApp.getPageCode(page, repository.count(), CONTENTS_SIZE, PAGE_SIZE, URL);
	}
	
}
