package PayVO;

public class CouponVO {
	private String member_id;
	private String coupon_name;
	private int coupon_number;

	public CouponVO() {}

	public CouponVO(String member_id, String coupon_name, int coupon_number) {
		super();
		this.member_id = member_id;
		this.coupon_name = coupon_name;
		this.coupon_number = coupon_number;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getCoupon_name() {
		return coupon_name;
	}

	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}

	public int getCoupon_number() {
		return coupon_number;
	}

	public void setCoupon_number(int coupon_number) {
		this.coupon_number = coupon_number;
	}



}
