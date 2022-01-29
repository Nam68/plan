package plan.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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
import plan.app.PageApp;
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
	private PageApp pageApp;
	
	@Autowired
	private AlbumRepository repository;
	
	private static final int CONTENTS_SIZE = 9;
	private static final int PAGE_SIZE = 5;
	private static final String URL = "albumList.do";
	
	/**
	 * JPA
	 */
	public Album find(Long index) {
		Optional<Album> result = repository.findById(index);
		return result.get();
	}
	
	@Transactional
	public ErrorJudgment save(Album album, Member member) {
		if(album == null) return ErrorJudgment.ERROR; 
		
		List<AlbumImage> images = getTempAlbumImageList(member.getId(), album);
		if(images == null) return ErrorJudgment.ERROR;
		
		album.setMember(member);
		album.setImages(images);
		repository.save(album);
				
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
		
		//업데이트 submit시 momory 폴더의 기존 파일 삭제
		if(album.getImages().size() > 0) {
			for(AlbumImage image : album.getImages()) {
				String name = manager.getFileName(image.getPath());
				File viewFile = new File(view.getPath()+"/"+name);
				if(viewFile.exists()) viewFile.delete();
			}
		}
				
		//temp의 새로운 파일 등록
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
	
	/**
	 * 임시폴더에서 이미지 삭제
	 */
	public ErrorJudgment tempAlbumImageDelete(String id, List<String> urls) {
		List<File> list = new ArrayList<File>();
		File temp = manager.getTempFolder(id);
		
		for(String url : urls) {
			String name = manager.getFileName(url);
			File tempFile = new File(temp.getPath()+"/"+name);
			
			if(tempFile.exists()) {
				list.add(tempFile);
			} else {
				return ErrorJudgment.ERROR;
			}
		}
		
		for(File file : list) {
			file.delete();
		}
		return ErrorJudgment.SUCCESS;
	}
	
	/**
	 * 업데이트할 앨범의 이미지들을 임시폴더로 이동
	 */
	public ErrorJudgment tempAlbumImageForUpdate(Album album, String id) {
		ErrorJudgment result = ErrorJudgment.ERROR;
		
		List<AlbumImage> images = album.getImages();
		File view = manager.getViewFolder();
		File temp = manager.getTempFolder(id);
		
		//temp폴더에 파일이 있으면 temp폴더를 삭제하고 다시 생성
		if(temp.listFiles().length != 0) {
			manager.deleteAllFiles(temp);
			temp = manager.getTempFolder(id);
		}
		
		for(AlbumImage image : images) {
			String name = manager.getFileName(image.getPath());
			
			File viewFile = new File(view.getPath()+"/"+name);
			File tempFile = new File(temp.getPath()+"/"+name);
			
			result = manager.copyFile(viewFile, tempFile);	
			
			if(result == ErrorJudgment.ERROR) break;
		}
		
		if(result == ErrorJudgment.ERROR) {
			//temp폴더로 옮기는 데에 실패한 경우 이미 옮겨진 temp폴더 내 이미지 삭제
			manager.deleteAllFiles(temp);
		}
				
		return result;
	}
	
	
	
	/**
	 * 페이징된 album 가져오기
	 */
	public List<Album> findAllWithPage(int page) {
		//페이지 시작이 0페이지부터이므로 1부터 시작으로 계산된 page 변수에서 1을 뺌
		PageRequest pageRequest = PageRequest.of(page-1, CONTENTS_SIZE, Direction.DESC, "index");
		List<Album> result = repository.findAll(pageRequest).getContent();
		return result;
	}
	
	/**
	 * 앱을 통해 페이지네이션 코드를 반환하는 메서드
	 */
	public String pageCode(int page) {
		return pageApp.getPageCode(page, repository.count(), CONTENTS_SIZE, PAGE_SIZE, URL);
	}
	
}
