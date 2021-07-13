package test.feed.dto;

public class FeedGoodDto {
	private int feed_num;
	private String liked_user;
	
	public FeedGoodDto() {}

	public FeedGoodDto(int feed_num, String liked_user) {
		super();
		this.feed_num = feed_num;
		this.liked_user = liked_user;
	}

	public int getFeed_num() {
		return feed_num;
	}

	public void setFeed_num(int feed_num) {
		this.feed_num = feed_num;
	}

	public String getLiked_user() {
		return liked_user;
	}

	public void setLiked_user(String liked_user) {
		this.liked_user = liked_user;
	};
	
	
	
	
}
