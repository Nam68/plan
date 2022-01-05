package plan.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;

import plan.domain.item.Album;

@Repository
public interface AlbumRepository extends JpaRepository<Album, Long> {
	
	
}
