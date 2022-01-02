package plan.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import plan.domain.member.Member;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
	
	Member findById(String id);
	
	Member findByIdAndPassword(String id, String password);
	
}
