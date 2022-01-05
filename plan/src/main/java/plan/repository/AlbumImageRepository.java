package plan.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import plan.domain.item.AlbumImage;

@Repository
public interface AlbumImageRepository extends JpaRepository<AlbumImage, Long> {

}
