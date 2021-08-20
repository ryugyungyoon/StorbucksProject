package SearchPageVO;

public class SearchPageVO {
	private String category_name_eng;
	private String product_name;
	private String product_name_eng;
	private int product_number;
	private int price;
	private float rating;
	
	public SearchPageVO() {}

	public SearchPageVO(String category_name_eng, String product_name, String product_name_eng, int product_number,
			int price, float rating) {
		super();
		this.category_name_eng = category_name_eng;
		this.product_name = product_name;
		this.product_name_eng = product_name_eng;
		this.product_number = product_number;
		this.price = price;
		this.rating = rating;
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

	public String getProduct_name_eng() {
		return product_name_eng;
	}

	public void setProduct_name_eng(String product_name_eng) {
		this.product_name_eng = product_name_eng;
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
}
