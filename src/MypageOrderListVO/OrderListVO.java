package MypageOrderListVO;

public class OrderListVO {
	private String product_number;
	private int each_amount;
	private String product_name;
	private String product_name_eng;
	private String category_name_eng;
	private String order_date;
	private int order_number;
	private int price;
	private int cost;
	private float rating;
	
	public OrderListVO() { }
	public OrderListVO(String product_number, int each_amount, String product_name, String product_name_eng,
			String category_name_eng, String order_date, int order_number, int price, int cost, float rating) {
		this.product_number = product_number;
		this.each_amount = each_amount;
		this.product_name = product_name;
		this.product_name_eng = product_name_eng;
		this.category_name_eng = category_name_eng;
		this.order_date = order_date;
		this.order_number = order_number;
		this.price = price;
		this.cost = cost;
		this.rating = rating;
	}
	
	public String getProduct_number() {
		return product_number;
	}
	public void setProduct_number(String product_number) {
		this.product_number = product_number;
	}
	public int getEach_amount() {
		return each_amount;
	}
	public void setEach_amount(int each_amount) {
		this.each_amount = each_amount;
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
	public String getCategory_name_eng() {
		return category_name_eng;
	}
	public void setCategory_name_eng(String category_name_eng) {
		this.category_name_eng = category_name_eng;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public int getOrder_number() {
		return order_number;
	}
	public void setOrder_number(int order_number) {
		this.order_number = order_number;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public float getRating() {
		return rating;
	}
	public void setRating(float rating) {
		this.rating = rating;
	}
	@Override
	public String toString() {
		return "OrderListVO [product_number=" + product_number + ", each_amount=" + each_amount + ", product_name="
				+ product_name + ", product_name_eng=" + product_name_eng + ", category_name_eng=" + category_name_eng
				+ ", order_date=" + order_date + ", order_number=" + order_number + ", price=" + price + ", cost="
				+ cost + ", rating=" + rating + "]";
	}
	
	
}
