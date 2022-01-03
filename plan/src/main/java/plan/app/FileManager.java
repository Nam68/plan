package plan.app;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import plan.app.MyEnum.ErrorJudgment;

public class FileManager {
	
	private enum FilePath {
		TEMP("/epoche02/tomcat/webapps/ROOT/temp/"),
		SERVER("/epoche02/tomcat/webapps/ROOT/img/memory/"), VIEW("http://myyk.co.kr/img/memory/"); 
		private String value;
		private FilePath(String value) {
			this.value = value;
		}
		private String getValue() {
			return value;
		}
	}
	
	/**
	 * 실제 서버 상에 저장될 폴더(img/memory)를 반환
	 */
	public String getServerPath() {
		return FilePath.SERVER.getValue();
	}
	
	/**
	 * View에서 사용될 URL을 반환
	 */
	public String getViewPath() {
		return FilePath.VIEW.getValue();
	}
	
	/**
	 * 구별자(id)를 통해 temp 폴더 내에 임시폴더를 생성함
	 */
	public File getTempFolder(String id) {
		File temp = new File(FilePath.TEMP.getValue()+"/"+id);
		if(!temp.exists()) temp.mkdirs();
		return temp;
	}
	
	/**
	 * MultipartFile을 통해 확장자를 추출, UUID 이름과 확장자를 가진 이름을 반환
	 */
	public String getUuid(MultipartFile file) {
		String name = file.getOriginalFilename();
		String extension = name.substring(name.lastIndexOf('.')); //.jpg처럼 닷(.)을 포함시켜서 반환함
		return UUID.randomUUID().toString()+extension;
	}
	
	/**
	 * MultipartFile을 File로 변환
	 */
	public ErrorJudgment copyFile(MultipartFile originFile, File newFile) {
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(newFile);
			fos.write(originFile.getBytes());
			return ErrorJudgment.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ErrorJudgment.ERROR;
		} finally {
			try {
				fos.close();
			} catch(IOException e) {
				e.printStackTrace();
				return ErrorJudgment.ERROR;
			}
		}
	}
	
	/**
	 * File을 새로운 File로 변환
	 */
	public ErrorJudgment copyFile(File originFile, File newFile) {
		FileInputStream fis = null;
		FileOutputStream fos = null;
		try {
			fis = new FileInputStream(originFile);
			fos = new FileOutputStream(newFile);
			
			byte[] buf = new byte[1024]; //한번에 가져올 데이터 양을 설정
			
			int readData;
			while((readData = fis.read(buf)) > 0) {
				fos.write(buf, 0, readData);
			}
			
			return ErrorJudgment.SUCCESS;
		} catch (IOException e) {
			e.printStackTrace();
			return ErrorJudgment.ERROR;
		} finally {
			try {
				fis.close();
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
				return ErrorJudgment.ERROR;
			}
		}
		
	}
	
	
}
