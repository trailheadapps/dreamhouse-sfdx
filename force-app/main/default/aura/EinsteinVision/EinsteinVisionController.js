({
    readFile: function(component, event, helper) {
        var files = component.get("v.files");
        if (files && files.length > 0) {
	        var file = files[0][0];
            if (!file.type.match(/(image.*)/)) {
                return alert('Image file not supported');
            }
            var reader = new FileReader();
            reader.onloadend = function() {
                var dataURL = reader.result;
                component.set("v.pictureSrc", dataURL);
                helper.upload(component, file, dataURL.match(/,(.*)$/)[1]);
            };
            reader.readAsDataURL(file);
        }
        
	}
    
})