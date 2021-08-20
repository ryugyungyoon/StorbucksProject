package EachproductVO;

public class EachprojectReviewVO {
	private int rno;
	private String writer_id;
	private String title;
	private String content;
	private int rating;
	private int product_number;
	private String review_date;
	
	public EachprojectReviewVO() {}

	public EachprojectReviewVO(int rno, String writer_id, String title, String content, int rating, int product_number, String review_date) {
		this.rno = rno;
		this.writer_id = writer_id;
		this.title = title;
		this.content = content;
		this.rating = rating;
		this.product_number = product_number;
		this.review_date = review_date;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public String getWriter_id() {
		return writer_id;
	}

	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
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

	public int getProduct_number() {
		return product_number;
	}

	public void setProduct_number(int product_number) {
		this.product_number = product_number;
	}

	public String getReview_date() {
		return review_date;
	}

	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	
}
