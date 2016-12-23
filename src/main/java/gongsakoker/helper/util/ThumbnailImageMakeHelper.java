package gongsakoker.helper.util;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.imageio.ImageIO;

import net.coobird.thumbnailator.Thumbnails;


public abstract class ThumbnailImageMakeHelper {


	

	
	/**
	 * 썸네일 이미지 만들기
	 * @param load
	 * @param savePath
	 * @param saveName
	 * @param w
	 * @param h
	 */
	
	public static Boolean createThumbnail(String load, String savePath, String saveName, int w, int h) {

		Boolean result = false;
		try {
			BufferedInputStream stream_file = new BufferedInputStream(new FileInputStream(load));
			BufferedImage bi = ImageIO.read(stream_file);
			
			//원본 이미지의 해상도 크기
			int width = bi.getWidth();
			int height = bi.getHeight();
			
			if(width > w && height > h) {
				Thumbnails.of(new File(load))
					.size(w, h)
					.toFile(new File(savePath + File.separator + saveName));

				result = true;
				//System.gc();		// WAS의 가비지 컬렉터가 메모리상에서 풀어주기 전에 삭제를 하려했더니 안지워져서.... 강제로 정리를함. (단, 이 method를 호출해도  언제 쓰레기를 처리할지는 모른다네 ㅠㅠ)
				//FileUtil.deleteFile(load);
			}else{
				Thumbnails.of(new File(load))
				.size(width, height)
				.toFile(new File(savePath + File.separator + saveName));
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
 

}
