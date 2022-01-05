package plan.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import plan.app.FileManager;
import plan.app.MyEnum.ErrorJudgment;
import plan.domain.item.Album;
import plan.domain.item.AlbumImage;
import plan.domain.member.Member;
import plan.repository.AlbumImageRepository;
import plan.repository.AlbumRepository;

@Service
@EnableJpaAuditing
@Transactional(readOnly = true)
public class AlbumService {
	
	@Autowired
	private FileManager manager;
	
	@Autowired
	private AlbumRepository ar;
	
	@Autowired
	private AlbumImageRepository air;
	
	/**
	 * JPA
	 */
	@Transactional
	public ErrorJudgment save(Album album, Member member) {
		if(album == null) return ErrorJudgment.ERROR; 
		
		
		List<AlbumImage> images = getTempAlbumImageList(member.getId(), album);
		if(images == null) return ErrorJudgment.ERROR;
		

		album.setMember(member);
		album.setImages(images);
		ar.save(album);
		
		//air.saveAll(images);
		
		return ErrorJudgment.SUCCESS;
	}
	
	
	
	/**
	 * 임시 폴더에 등록한 이미지를 저장
	 */
	public ErrorJudgment tempAlbumImgAdd(MultipartFile[] files, String id) {
		File temp = manager.getTempFolder(id);
		ErrorJudgment result = ErrorJudgment.ERROR;
		
		for(MultipartFile originFile : files) {
			File newFile = new File(temp.getPath()+"/"+manager.getUuid(originFile));
			result = manager.copyFile(originFile, newFile);
			if(result == ErrorJudgment.ERROR) return ErrorJudgment.ERROR;
		}
		return result;
	}
	
	/**
	 * 임시 폴더에 저장된 이미지 목록을 http 경로로 가져옴(새 파일이 등록될 때마다 실행)
	 */
	public List<String> tempAlbumImageList(String id) {
		File temp = manager.getTempFolder(id);
		
		List<String> result = new ArrayList<String>();
		for(File file : temp.listFiles()) {
			if(file.isFile()) result.add(manager.getTempPath(id)+file.getName());
		}
		return result;
	}
	
	/**
	 * 임시 폴더에 저장된 이미지 목록을 memory폴더로 이동하면서 AlbumImage 리스트를 반환(submit을 하면 실행)
	 */
	public List<AlbumImage> getTempAlbumImageList(String id, Album album) {
		File temp = manager.getTempFolder(id);
		File view = manager.getViewFolder();
		
		List<AlbumImage> result = new ArrayList<AlbumImage>();
		for(File file : temp.listFiles()) {
			//temp 폴더의 이미지를 memory 폴더로 복사
			File newFile = new File(view.getPath()+"/"+file.getName());
			if(manager.copyFile(file, newFile) == ErrorJudgment.ERROR) return null;
			
			//memory 폴더의 이미지 경로를 DB에 저장할 수 있도록 가공 후 엔티티에 전달
			AlbumImage image = new AlbumImage();
			image.setAlbum(album);
			image.setPath(manager.getViewPath() + newFile.getName());
			result.add(image);
		}
		
		if(result != null) tempAlbumImageDelete(id);
		return result;
	}
	
	/**
	 * 임시 폴더 삭제
	 */
	public void tempAlbumImageDelete(String id) {
		File temp = manager.getTempFolder(id);
		manager.deleteAllFiles(temp);
	}
	
	
	
	
	
	
	public List<Album> findAll(int page) {
		PageRequest pageRequest = PageRequest.of(page, 9, Direction.DESC, "index");
		List<Album> result = ar.findAll(pageRequest).getContent();
		return result;
	}
	
}
