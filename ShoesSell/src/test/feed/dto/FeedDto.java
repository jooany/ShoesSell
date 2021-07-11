package test.feed.dto;

public class FeedDto {
	
	int num;
	String writer;
	String title;
	String content;
	int viewCount;
	int regdate;
	String imagePath;
	
	
	public FeedDto(int num, String writer, String title, String content, int viewCount, int regdate, String imagePath) {
		super();
		this.num = num;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.viewCount = viewCount;
		this.regdate = regdate;
		this.imagePath = imagePath;
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


	public int getViewCount() {
		return viewCount;
	}


	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}


	public int getRegdate() {
		return regdate;
	}


	public void setRegdate(int regdate) {
		this.regdate = regdate;
	}


	public String getImagePath() {
		return imagePath;
	}


	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
	
	
	
}
