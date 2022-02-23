package plan.app;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import plan.app.MyEnum.Region;

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
		INCHEON("仁川", "인천", "Incheon", 1), SEOUL("ソウル", "서울", "Seoul", 2), BUSAN("釜山", "부산", "Busan", 3), DAEGU("大邱", "대구", "Daegu", 4), ULSAN("蔚山", "울산", "Ulsan", 5), DAEJEON("大田", "대전", "Daejeon", 6), GWANGJU("光州", "광주", "Gwangju", 7), SEJONG("世宗", "세종", "Sejong", 8),
		GYEONGGI_DO("京畿道", "경기도", "Gyeonggi-do", 51), GANGWON_DO("江原道", "강원도", "Gangwon-do", 52), CHUNGCHEONGBUK_DO("忠清北道", "충청북도", "Chungcheongbuk-do", 53), CHUNGCHEONGNAM_DO("忠清南道", "충청남도", "Chungcheongnam-do", 54),
		JEOLLABUK_DO("全羅北道", "전라북도", "Jeollabuk-do", 55), JEOLLANAM_DO("全羅北道", "전라남도", "Jeollanam-do", 56), GYEONGSANGBUK_DO("慶尚北道", "경상북도", "Gyeongsangbuk-do", 57), GYEONGSANGNAM_DO("慶尚南道", "경상남도", "Gyeongsangnam-do", 58), JEJU("済州", "제주", "Jeju", 59),
		
		HOKKAIDO("北海道", "홋카이도", "Hokkaido", 101), AOMORI("青森", "아오모리", "Aomori", 102), IWATE("岩手", "이와테", "Iwate", 103), MIYAGI("宮城", "미야기", "Miyagi", 104), AKITA("秋田", "아키타", "Akita", 105), YAMAGATA("山形", "야마가타", "Yamagata", 106), FUKUSHIMA("福島", "후쿠시마", "Fukushima", 107), 
		IBARAKI("茨城", "이바라키", "Ibaraki", 108), TOCHIGI("栃木", "도치기", "Tochigi", 109), GUNMA("群馬", "군마", "Gunma", 110), SAITAMA("埼玉", "사이타마", "Saitama", 111), CHIBA("千葉", "지바", "Chiba", 112), TOKYO("東京", "도쿄", "Tokyo", 113), KANAGAWA("神奈川", "가나가와", "Kanagawa", 114), 
		NIIGATA("新潟", "니가타", "Niigata", 115), TOYAMA("富山", "도야마", "Toyama", 116), ISHIKAWA("石川", "이시카와", "Ishikawa", 117), FUKUI("福井", "후쿠이", "Fukui", 118), YAMANASHI("山梨", "야마나시", "Yamanashi", 119), NAGANO("長野", "나가노", "Nagano", 120), GIFU("岐阜", "기후", "Gifu", 121), SHIZUOKA("静岡", "시즈오카", "Shizuoka", 122), AICHI("愛知", "아이치", "Aichi", 123),
		MIE("三重", "미에", "Mie", 124), SHIGA("滋賀", "시가", "Shiga", 125), KYOTO("京都", "교토", "Kyoto", 126), OSAKA("大阪", "오사카", "Osaka", 127), HYOGO("兵庫", "효고", "Hyogo", 128), NARA("奈良", "나라", "Nara", 129), WAKAYAMA("和歌山", "와카야마", "Wakayama", 130),
		TOTTORI("鳥取", "돗토리", "Tottori", 131), SHIMANE("島根", "시마네", "Shimane", 132), OKAYAMA("岡山", "오카야마", "Okayama", 133), HIROSHIMA("広島", "히로시마", "Hiroshima", 134), YAMAGUCHI("山口", "야마구치", "Yamaguchi", 135), 
		TOKUSHIMA("徳島", "도쿠시마", "Tokushima", 136), EHIME("愛媛", "에히메", "Ehime", 137), KOCHI("高知", "고치", "Kochi", 138), FUKUOKA("福岡", "후쿠오카", "Fukuoka", 139),
		SAGA("佐賀", "사가", "Saga", 140), NAGASAKI("長崎", "나가사키", "Nagasaki", 141), KUMAMOTO("熊本", "구마모토", "Kumamoto", 142), OITA("大分", "오이타", "Oita", 143), MIYAZAKI("宮崎", "미야자키", "Miyazaki", 144), KAGOSHIMA("鹿児島", "가고시마", "Kagoshima", 145), OKINAWA("沖縄", "오키나와", "Okinawa", 146),
		
		OVERSEAS("海外", "해외", "Overseas", 201);
		
		private int index;
		private String value_jpn;
		private String value_kor;
		private String value_eng;
		private Country country;
		
		Region(String value_jpn, String value_kor, String value_eng, int index) {
			this.index = index;
			this.value_jpn = value_jpn;
			this.value_kor = value_kor;
			this.value_eng = value_eng;
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
		
		public String getValue_jpn() {
			return value_jpn;
		}
		
		public String getValue_kor() {
			return value_kor;
		}
		
		public String getValue_eng() {
			return value_eng;
		}
		
		public static List<Map<String, String>> getJsonList() {
			Region[] enums = Region.values();
			List<Map<String, String>> regionList = new ArrayList<Map<String, String>>();
			for(Region region : enums) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("name", region.getValue_jpn());
				map.put("value", region.toString());
				regionList.add(map);
			}
			return regionList;
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
