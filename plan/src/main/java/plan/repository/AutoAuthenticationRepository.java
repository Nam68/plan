package plan.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import plan.domain.member.AutoAuthentication;

@Repository
public interface AutoAuthenticationRepository extends JpaRepository<AutoAuthentication, String> {
	
	public AutoAuthentication findBySessionKey(String sessionKey);
	
}
