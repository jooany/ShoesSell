package test.feed.dto;

public class FeedDto {
	
	private int num;
	private String writer;
	private String title;
	private String content;
	private String regdate;
	private String imagePath;
	private String profile;
	private int goodCount;
	private String isGood;
	private int articleNum;
	
	public FeedDto() {}

	public FeedDto(int num, String writer, String title, String content, String regdate, String imagePath, String profile,
			int goodCount, String isGood, int articleNum) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.imagePath = imagePath;
		this.profile = profile;
		this.goodCount = goodCount;
		this.isGood = isGood;
		this.articleNum = articleNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public int getGoodCount() {
		return goodCount;
	}

	public void setGoodCount(int goodCount) {
		this.goodCount = goodCount;
	}

	public String getIsGood() {
		return isGood;
	}

	public void setIsGood(String isGood) {
		this.isGood = isGood;
	}

	public int getArticleNum() {
		return articleNum;
	}

	public void setArticleNum(int articleNum) {
		this.articleNum = articleNum;
	}
	
	

	
	
	
	
	
	
}
