package plan.app;

public class PageApp {
	
	/**
	 * 전체 페이지의 개수를 반환(컨텐츠가 150개인 경우 30을 반환)
	 */
	private long getAllPage(long count, int contentsSize) {
		long result = count / contentsSize;
		if(count % contentsSize != 0) result++;
		return result;
	}
	
	/**
	 * 페이지 그룹 내 첫 번째 페이지를 반환(현재 3페이지면 1을 반환)
	 */
	private long getStartPage(int page, int pageSize) {
		long result = page / pageSize;
		if(page % pageSize == 0) result--;
		result = result * pageSize +1;		
		
		return result;
	}
	
	/**
	 * 페이지 그룹 내 마지막 페이지를 반환(현재 3페이지면 5를 반환)
	 */
	private long getEndPage(int page, int pageSize, long allPage) {
		long result = (page / pageSize) +1;
		if(page % pageSize == 0) result--;
		result = result * pageSize;
		if(result > allPage) result = allPage; //결과값이 전체 페이지보다 큰 경우 전체페이지까지만 반환
		return result;
	}
	
	/**
	 * 이전 화살표가 사용 가능한지 클래스에 추가
	 */
	private boolean previousPageIsAvailable(long startPage) {
		return startPage > 1;
	}
	
	/**
	 * 다음 화살표가 사용 가능한지 클래스에 추가
	 */
	private boolean nextPageIsAvailable(long allPage, long endPage) {
		return endPage < allPage;
	}
	
	/**
	 * 페이지네이션 코드를 생성 후 반환
	 */
	public String getPageCode(int page, long count, int contentsSize, int pageSize, String url) {
		long allPage = getAllPage(count, contentsSize);
		long startPage = getStartPage(page, pageSize);
		long endPage = getEndPage(page, pageSize, allPage);
		
		StringBuffer sb = new StringBuffer();
		
		//페이지네이션 시작
		sb.append("<nav aria-label=\"Page navigation example\">");
		sb.append("<ul class=\"pagination justify-content-center\">");
	    		 
		//이전 페이지네이션
		if(previousPageIsAvailable(startPage)) {
		sb.append("<li class=\"page-item\">");
		sb.append("<a class=\"page-link\" href=\""+url+"?page="+(startPage-pageSize)+"\" aria-label=\"Previous\">");
		sb.append("<span aria-hidden=\"true\">&laquo;</span>");
		sb.append("</a>");
		sb.append("</li>");
		}
	      
		//숫자로 된 페이지네이션 코드
		for(long i = startPage; i <= endPage; i++) {
		sb.append("<li class=\"page-item\"><a class=\"page-link\" href=\""+url+"?page="+i+"\">"+i+"</a></li>");
		}
		
		//다음 페이지네이션
		if(nextPageIsAvailable(allPage, endPage)) {
		sb.append("<li class=\"page-item\">");
		sb.append("<a class=\"page-link\" href=\""+url+"?page="+(endPage+1)+"\" aria-label=\"Next\">");
		sb.append("<span aria-hidden=\"true\">&raquo;</span>");
		sb.append("</a>");
		sb.append("</li>");
		}
	      
		//페이지네이션 닫음
		sb.append("</ul>");
		sb.append("</nav>");
		
		return sb.toString();
	}
	
}
