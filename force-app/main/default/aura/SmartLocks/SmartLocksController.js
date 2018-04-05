({
	onInit : function(component) {
		var locks = [];
        locks.push({label: "Front Door", value: 1});
        locks.push({label: "Garage Door", value: 1});
        component.set("v.locks", locks);
	}
})