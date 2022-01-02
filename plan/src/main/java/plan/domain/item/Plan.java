package plan.domain.item;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;

import plan.app.MyEnum.Region;

@Entity
@DiscriminatorValue("P")
public class Plan extends Item {
	
	@Embedded
	private GeometryValue geomertry;
	
	private String address;
	
	@Enumerated(EnumType.STRING)
	private Region region;
	
	public Plan() {
		
	}
	
	public GeometryValue getGeomertry() {
		return geomertry;
	}

	public void setGeomertry(GeometryValue geomertry) {
		this.geomertry = geomertry;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Region getRegion() {
		return region;
	}

	public void setRegion(Region region) {
		this.region = region;
	}
	
}
