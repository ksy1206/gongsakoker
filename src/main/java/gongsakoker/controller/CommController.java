package gongsakoker.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import gongsakoker.helper.exception.BusinessException;



/**s
 * 설명 : 공통관리
 * 
 ************************************************ 
 * DATE AUTHOR DESCRIPTION ---------------------------------------------- 
 * 2015.11. 30. 박정후 Initial Release
 ************************************************ 
 * 
 */
@Controller
@RequestMapping("/comm")
public class CommController {
	private final static Log logger = LogFactory.getLog(CommController.class);

	
	/**
	 * 첨부파일 등록(일반)
	 * 
	 * @param req
	 * @param res
	 * @return ModelAndView
	 * @throws BusinessException
	 */
	@RequestMapping("/saveFileUpload.do")
	public ModelAndView saveFileUpload(HttpServletRequest req,
			HttpServletResponse res, @RequestParam Map<String, Object> pMap)
			throws BusinessException {
		System.out.println("+++++++++++++++++++++++++++++++++++++++++");
		// ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		PrintWriter out = null;
		int result = 0;
		try {

			String fileGbn = req.getParameter("fileGbn");

			HttpSession session = req.getSession();
			String doc_root = session.getServletContext().getRealPath("/upload");
			
			String os = System.getProperty("os.name");

			String fileDestPath = "";
			logger.debug("* 현재운영체제 : " + os);

			fileDestPath = doc_root + File.separator + "img"
					+ File.separator + "temp";
	
			logger.debug("* 파일 저장 경로 : " + fileDestPath);
			
			File destinationDir = new File(fileDestPath);
			if (!destinationDir.exists()) {
				destinationDir.mkdirs();
			}
			
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
			
		
			MultipartFile file = multipartRequest.getFile("file");
			
			String fileName = file.getOriginalFilename();
			System.out.println("filename=--->"+fileName);
			
			String fileType = fileName.substring(fileName.indexOf("."));
			
			File destination = File.createTempFile(fileGbn.toUpperCase(),fileType, destinationDir);
			
			
			int fileSize = FileCopyUtils.copy(file.getInputStream(),
					new FileOutputStream(destination));
		
				rMap.put("fileName", fileName);
				rMap.put("fileUploadPath", fileDestPath);
				rMap.put("destination", destination.toString());
				rMap.put("fileSize", fileSize);
				rMap.put("fileSeparator", File.separator);
				rMap.put("osName", os);

				result = 1;
				
			rMap.put("resultCode", result);
				
			JSONObject jsonObject = JSONObject.fromObject(rMap);
			logger.debug("json - " + jsonObject);

			// 아래 부분은 IE8과 IE9에서 업로드후, json데이터를 제대로 받지 못하여 수정함.
			res.setContentType("text/plain; charset=UTF-8"); // HttpServletResponse
																// response

			out = res.getWriter();
			out.print(jsonObject.toString());
			out.flush();
			
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		return null;

	}
	

	
	


}
