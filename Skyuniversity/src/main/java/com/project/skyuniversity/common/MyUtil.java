package com.project.skyuniversity.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	// *** ? 다음의 데이터까지 포함한 현재 url주소를 알려주는 메소드 생성
	
	public static String getCurrentURL(HttpServletRequest request) {
		
		
		String currentURL = request.getRequestURL().toString();
		// http://localhost:9090/skyuniversity/index.sky
		
		// ? 뒤에 오는 URL주소를 얻어오는 메소드
		String queryString = request.getQueryString();
		// currentShowPageNo=17&sizePerPage=10&searchType=name&searchWord=
		if (queryString != null) {
			currentURL += "?" +  queryString;			
		}
		
		String ctxPath = request.getContextPath();
		// /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		
		
		currentURL = currentURL.substring(beginIndex + 1);
		
		return currentURL;
	}
	
	public static String secureCode(String item) {
		item = item.replaceAll("<", "&lt;");
		item = item.replaceAll(">", "&gt;");
		
		
		return item;
	}
}
