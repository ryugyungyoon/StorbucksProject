package EachproductVO;

public class EachproductVO {
	private int product_number;
	private String category_name_eng;        // 카테고리 영문 이름
	private String product_name;
	private String image_name;
	private String product_name_eng;
	private String info_title;
	private String info_content;
	private int price;
	private float rating;
	
	public EachproductVO() {}

	public EachproductVO(int product_number, String category_name_eng, String product_name, String image_name,
			String product_name_eng, String info_title, String info_content, int price, float rating) {
		super();
		this.product_number = product_number;
		this.category_name_eng = category_name_eng;
		this.product_name = product_name;
		this.image_name = image_name;
		this.product_name_eng = product_name_eng;
		this.info_title = info_title;
		this.info_content = info_content;
		this.price = price;
		this.rating = rating;
	}

	public int getProduct_number() {
		return product_number;
	}

	public void setProduct_number(int product_number) {
		this.product_number = product_number;
	}

	public String getCategory_name_eng() {
		return category_name_eng;
	}

	public void setCategory_name_eng(String category_name_eng) {
		this.category_name_eng = category_name_eng;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getImage_name() {
		return image_name;
	}

	public void setImage_name(String image_name) {
		this.image_name = image_name;
	}

	public String getProduct_name_eng() {
		return product_name_eng;
	}

	public void setProduct_name_eng(String product_name_eng) {
		this.product_name_eng = product_name_eng;
	}

	public String getInfo_title() {
		return info_title;
	}

	public void setInfo_title(String info_title) {
		this.info_title = info_title;
	}

	public String getInfo_content() {
		return info_content;
	}

	public void setInfo_content(String info_content) {
		this.info_content = info_content;
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

	
}
