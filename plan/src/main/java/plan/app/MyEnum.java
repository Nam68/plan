package plan.app;

public class MyEnum {
	
	public enum ErrorJudgment {
		SUCCESS("1"), ERROR("0");
		private String value;
		
		ErrorJudgment(String value) {
			this.value = value;
		}
		public String getValue() {
			return value;
		}
	}
	
	public enum RoleType {
		ADMIN, USER, AWIRTER
	}
	
	public enum Region {
		INCHEON("仁川", 1), SEOUL("ソウル", 2), BUSAN("釜山", 3), DAEGU("大邱", 4), ULSAN("蔚山", 5), DAEJEON("大田", 6), GWANGJU("光州", 7), SEJONG("世宗", 8),
		GYEONGGI_DO("京畿道", 51), GANGWON_DO("江原道", 52), CHUNGCHEONGBUK_DO("忠清北道", 53), CHUNGCHEONGNAM_DO("忠清南道", 54),
		JEOLLABUK_DO("全羅北道", 55), JEOLLANAM_DO("全羅北道", 56), GYEONGSANGBUK_DO("慶尚北道", 57), GYEONGSANGNAM_DO("慶尚南道", 58), JEJU("済州", 59),
		
		HOKKAIDO("北海道", 101), AOMORI("青森", 102), IWATE("岩手", 103), MIYAGI("宮城", 104), AKITA("秋田", 105), YAMAGATA("山形", 106), FUKUSHIMA("福島", 107), 
		IBARAKI("茨城", 108), TOCHIGI("栃木", 109), GUNMA("群馬", 110), SAITAMA("埼玉", 111), CHIBA("千葉", 112), TOKYO("東京", 113), KANAGAWA("神奈川", 114), 
		NIIGATA("新潟", 115), TOYAMA("富山", 116), ISHIKAWA("石川", 117), FUKUI("福井", 118), YAMANASHI("山梨", 119), NAGANO("長野", 120), GIFU("岐阜", 121), SHIZUOKA("静岡", 122), AICHI("愛知", 123),
		MIE("三重", 124), SHIGA("滋賀", 125), KYOTO("京都", 126), OSAKA("大阪", 127), HYOGO("兵庫", 128), NARA("奈良", 129), WAKAYAMA("和歌山", 130),
		TOTTORI("鳥取", 131), SHIMANE("島根", 132), OKAYAMA("岡山", 133), HIROSHIMA("広島", 134), YAMAGUCHI("山口", 135), 
		TOKUSHIMA("徳島", 136), EHIME("愛媛", 137), KOCHI("高知", 138), FUKUOKA("福岡", 139),
		SAGA("佐賀", 140), NAGASAKI("長崎", 141), KUMAMOTO("熊本", 142), OITA("大分", 143), MIYAZAKI("宮崎", 144), KAGOSHIMA("鹿児島", 145), OKINAWA("沖縄", 146),
		
		OVERSEAS("海外", 201);
		
		private int index;
		private String value;
		private Country country;
		
		Region(String value, int index) {
			this.index = index;
			this.value = value;
			if(index < 100) {
				this.country = Country.KOREA;
			} else if(index < 200) {
				this.country = Country.JAPAN;
			} else {
				this.country = Country.OVERSEAS;
			}
		}
		
		public int getIndex() {
			return index;
		}
		
		public Country getCountry() {
			return country;
		}
		
		public String getValue() {
			return value;
		}
	}
	
	private enum Country {
		KOREA("韓国", 1), JAPAN("日本", 2), OVERSEAS("海外", 3);
		
		private int index;
		private String value;
		
		Country(String value, int index) {
			this.value = value;
			this.index = index;
		}
		
		public int getIndex() {
			return index;
		}
		
		public String getValue() {
			return value;
		}
	}
	
}
