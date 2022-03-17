package plan.domain.item;

import java.util.Map;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;

import plan.app.MyEnum.Region;

@Entity
@DiscriminatorValue("P")
public class Place {
	
	@Embedded
	private GeometryValue geometry;
	
	private String address;
	
	@Enumerated(EnumType.STRING)
	private Region region; 
	
	public Place() {
		
	}
	
	public GeometryValue getGeometry() {
		return geometry;
	}

	public void setGeometry(GeometryValue geometry) {
		this.geometry = geometry;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Map<String, String> getRegion() {
		return Region.getMapData(region);
	}
	
	public Region getRegionEnum() {
		return region;
	}

	public void setRegion(Region region) {
		this.region = region;
	}
	
}
