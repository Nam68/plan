package plan.service;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import plan.app.FileManager;
import plan.app.MyEnum.ErrorJudgment;

@Service
@Transactional(readOnly = true)
public class AlbumService {
	
	@Autowired
	private FileManager manager;
	
	public ErrorJudgment tmpAlbumImgAdd(MultipartFile[] files, String id) {
		File temp = manager.getTempFolder(id);
		ErrorJudgment result = ErrorJudgment.ERROR;
		for(MultipartFile originFile : files) {
			File newFile = new File(temp.getPath()+"/"+manager.getUuid(originFile));
			result = manager.copyFile(originFile, newFile);
			if(result == ErrorJudgment.ERROR) return ErrorJudgment.ERROR;
		}
		return result;
	}
	
}
