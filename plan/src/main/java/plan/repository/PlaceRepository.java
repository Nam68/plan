package plan.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import plan.domain.item.Plan;

public interface PlaceRepository extends JpaRepository<Plan, Long> {

}
