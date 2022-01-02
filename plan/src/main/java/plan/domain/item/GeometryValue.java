package plan.domain.item;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class GeometryValue {
	
	private Long lat;
	private Long lng;
	
}
