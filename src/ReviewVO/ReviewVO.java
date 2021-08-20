package ReviewVO;

public class ReviewVO {
	private String title;
	private String content;
	private int rating;
	private int rno;
	private int product_number;
	
	public ReviewVO() {}
	public ReviewVO(String title, String content, int rating, int rno, int product_number) {
		super();
		this.title = title;
		this.content = content;
		this.rating = rating;
		this.rno = rno;
		this.product_number = product_number;
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
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getProduct_number() {
		return product_number;
	}
	public void setProduct_number(int product_number) {
		this.product_number = product_number;
	}
}
