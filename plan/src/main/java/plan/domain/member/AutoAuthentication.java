package plan.domain.member;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.domain.Persistable;

@Entity
public class AutoAuthentication implements Persistable<String> {
		
	@Id
	@Column(name = "SESSION_KEY")
	private String sessionKey;
	
	@Temporal(TemporalType.DATE)
	private Date sessionLimit;
	
	@OneToOne
	@JoinColumn(name = "MEMBER_INDEX")
	private Member member;
	
	public AutoAuthentication() {
		
	}
	
	public AutoAuthentication(String sessionKey) {
		super();
		this.sessionKey = sessionKey;
	}
	
	public AutoAuthentication(String sessionKey, Date sessionLimit, Long memberidx) {
		super();
		this.sessionKey = sessionKey;
		this.sessionLimit = sessionLimit;
		Member temp = new Member();
		temp.setIndex(memberidx);
		this.member = temp;
	}
	
	public String getSessionKey() {
		return sessionKey;
	}

	public void setSessionKey(String sessionKey) {
		this.sessionKey = sessionKey;
	}

	public Date getSessionLimit() {
		return sessionLimit;
	}

	public void setSessionLimit(Date sessionLimit) {
		this.sessionLimit = sessionLimit;
	}
	
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public String getId() {
		return sessionKey;
	}

	@Override
	public boolean isNew() {
		return true;
	}
		
}
