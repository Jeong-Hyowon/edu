package web;

public class AdminEdu {
	private int supportID;
	private String title;
	private String text;
	private String admin_id;
	private String supportDate;
	
	public String getSupportDate() {
		return supportDate;
	}

	public void setSupportDate(String SupportDate) {
		this.supportDate = SupportDate;
	}

	public int getSupportID() {
		return supportID;
	}

	public void setSupportID(int SupportID) {
		this.supportID = SupportID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

}
