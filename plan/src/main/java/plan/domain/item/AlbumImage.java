package plan.domain.item;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class AlbumImage {
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ALBUM_IMAGE_INDEX")
	private Long index;

	@ManyToOne(fetch = FetchType.EAGER) @JoinColumn(name = "ITEM_INDEX")
	private Album album;
	
	private String path;
	
	public AlbumImage() {
		
	}

	public Long getIndex() {
		return index;
	}

	public void setIndex(Long index) {
		this.index = index;
	}

	public Album getAlbum() {
		return album;
	}

	public void setAlbum(Album album) {
		this.album = album;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
}
