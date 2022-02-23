package plan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import plan.app.MyEnum.ErrorJudgment;
import plan.app.MyEnum.Region;
import plan.domain.item.Plan;
import plan.domain.member.Member;
import plan.repository.PlaceRepository;

@Service
@Transactional(readOnly = true)
public class PlaceService {
	
	@Autowired
	private PlaceRepository repository;
	
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
	
}
