/**
 * 
 */
package kr.or.ddit.projects.file;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.ddit.enumpkg.Browser;
import kr.or.ddit.projects.file.vo.AttatchVO;

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
 * 2021. 2. 3.     김근호	          최초작성
 * Copyright (c) 2021 by DDIT All right reserved
 *      </pre>
 */
public class downloadView extends AbstractView {

	@Value("#{appInfo.boardFolder}")
	private File saveFolder;

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse resp) throws Exception {

		AttatchVO attatch = (AttatchVO) model.get("attatch");
		String browser = request.getHeader("User-Agent");
		String savename = attatch.getAttSavename();
		String filename = attatch.getAttOriginname();
		if (Browser.TRIDENT.equals(browser)) {
			filename = URLEncoder.encode(filename, "UTF-8").replace("+", "%20");
		} else {
			byte[] bytes = filename.getBytes();
			filename = new String(bytes, "ISO-8859-1");
			System.out.println("===============>" + filename);
		}
		resp.setHeader("Content-Disposition", "attatchment;filename=\"" + filename + "\"");
		File saveFile = new File(saveFolder, savename);
		resp.setContentType("application/octet-stream");
		try (OutputStream os = resp.getOutputStream();) {
			FileUtils.copyFile(saveFile, os);
		}
	}

}
