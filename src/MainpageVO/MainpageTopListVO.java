package MainpageVO;

public class MainpageTopListVO {
	private int rownum;
	private int product_number;
	private int price;
	private float rating;
	private String image_name;
	private String product_name;
	private String product_name_eng;
	private String attract_ment;
	
	public MainpageTopListVO() {}
	public MainpageTopListVO(int rownum, int product_number, int price, float rating, String image_name,
			String product_name, String product_name_eng, String attract_ment) {
		super();
		this.rownum = rownum;
		this.product_number = product_number;
		this.price = price;
		this.rating = rating;
		this.image_name = image_name;
		this.product_name = product_name;
		this.product_name_eng = product_name_eng;
		this.attract_ment = attract_ment;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public int getProduct_number() {
		return product_number;
	}
	public void setProduct_number(int product_number) {
		this.product_number = product_number;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public float getRating() {
		return rating;
	}
	public void setRating(float rating) {
		this.rating = rating;
	}
	public String getImage_name() {
		return image_name;
	}
	public void setImage_name(String image_name) {
		this.image_name = image_name;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_name_eng() {
		return product_name_eng;
	}
	public void setProduct_name_eng(String product_name_eng) {
		this.product_name_eng = product_name_eng;
	}
	public String getAttract_ment() {
		return attract_ment;
	}
	public void setAttract_ment(String attract_ment) {
		this.attract_ment = attract_ment;
	}
}
