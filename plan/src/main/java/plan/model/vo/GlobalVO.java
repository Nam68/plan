package plan.model.vo;

public class GlobalVO {
	
	private String massage, href;
	
	public GlobalVO() {
		
	}

	public GlobalVO(String massage, String href) {
		super();
		this.massage = massage;
		this.href = href;
	}

	public String getMassage() {
		return massage;
	}

	public void setMassage(String massage) {
		this.massage = massage;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}
	
}
