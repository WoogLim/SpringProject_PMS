/**
 * 
 */
package kr.or.ddit.enumpkg;

/**
 * @author 작성자명
 * @since 2021. 2. 3.
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * 
 *      <pre>
 * [[개정이력(Modification Information)]]
 * 수정일                          수정자               수정내용
 * --------     --------    ----------------------
 * 2021. 2. 3.     김근호	         최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
public enum Browser {
	EDG("엣지"), CHROME("크롬"), TRIDENT("익스플로러"), OTHER("기타");

	private String browserName;

	Browser(String browserName) {
		this.browserName = browserName;
	}

	public String getBrowser() {
		return browserName;
	}

	public static Browser getBrowserConstant(String agent) {
		Browser[] browsers = values();
		Browser finded = OTHER;
		for (Browser temp : browsers) {
			if (agent.toUpperCase().contains(temp.name())) {
				finded = temp;
				break;
			}
		}
		return finded;
	}

	public static String getBrowserName(String agent) {
		return getBrowserConstant(agent).getBrowser();
	}
}
