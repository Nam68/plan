package plan.domain.item;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@DiscriminatorValue("R")
public class Request extends Item {
	
	@Enumerated(EnumType.STRING)
	private ProgressStatus status;
	
	@Temporal(TemporalType.DATE)
	private Date limitDate;
	
	@Enumerated(EnumType.STRING)
	private ImportanceLevel level;
	
	public Request() {
		
	}
		
	public ProgressStatus getStatus() {
		return status;
	}

	public void setStatus(ProgressStatus status) {
		this.status = status;
	}

	public Date getLimitDate() {
		return limitDate;
	}

	public void setLimitDate(Date limitDate) {
		this.limitDate = limitDate;
	}

	public ImportanceLevel getLevel() {
		return level;
	}

	public void setLevel(ImportanceLevel level) {
		this.level = level;
	}

	public enum ProgressStatus {
		COMPLETE, ONGOING, BEFORE
	}
	
	public enum ImportanceLevel {
		IMPORTANT, NOMAL, SLIGHT
	}
}
