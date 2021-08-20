package PayVO;

public class ProductVO {
	private String category_name_eng;
	private String product_name_eng;
	private String product_name;
	private int product_number;
	private int eachprice;
	private int amount;
	private int eachproductprice;
	private float rating;

	public ProductVO() {}
	public ProductVO(String category_name_eng, String product_name_eng, String product_name, int product_number,
			int eachprice, int amount, int eachproductprice, float rating) {
		super();
		this.category_name_eng = category_name_eng;
		this.product_name_eng = product_name_eng;
		this.product_name = product_name;
		this.product_number = product_number;
		this.eachprice = eachprice;
		this.amount = amount;
		this.eachproductprice = eachproductprice;
		this.rating = rating;
	}

	public String getCategory_name_eng() {
		return category_name_eng;
	}

	public void setCategory_name_eng(String category_name_eng) {
		this.category_name_eng = category_name_eng;
	}

	public String getProduct_name_eng() {
		return product_name_eng;
	}

	public void setProduct_name_eng(String product_name_eng) {
		this.product_name_eng = product_name_eng;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_number() {
		return product_number;
	}

	public void setProduct_number(int product_number) {
		this.product_number = product_number;
	}

	public int getEachprice() {
		return eachprice;
	}

	public void setEachprice(int eachprice) {
		this.eachprice = eachprice;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getEachproductprice() {
		return eachproductprice;
	}

	public void setEachproductprice(int eachproductprice) {
		this.eachproductprice = eachproductprice;
	}

	public float getRating() {
		return rating;
	}

	public void setRating(float rating) {
		this.rating = rating;
	}
	
}
