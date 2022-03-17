package plan.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import plan.domain.item.Place;

public interface PlaceRepository extends JpaRepository<Place, Long> {

}
