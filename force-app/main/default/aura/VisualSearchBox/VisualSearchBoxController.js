({
    onDragOver: function (component, event) {
        event.preventDefault();
    },

    onFileChange: function (component, event, helper) {
        var fileInput = component.find('fileInput').getElement();
        var files = fileInput.files;
        helper.readFile(component, helper, files[0]);
    },

    onDrop: function (component, event, helper) {
        console.log('ondrop: ' + new Date());
        event.stopPropagation();
        event.preventDefault();
        event.dataTransfer.dropEffect = 'copy';
        var files = event.dataTransfer.files;
        if (files.length > 1) {
            return alert('You can only upload one profile picture');
        }
        helper.readFile(component, helper, files[0]);
    }
});
