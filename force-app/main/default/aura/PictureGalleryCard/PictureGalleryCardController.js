({
    doInit: function (component) {
        // Hardcoding images in this demo component
        component.set('v.slides', [
            'https://s3-us-west-2.amazonaws.com/dev-or-devrl-s3-bucket/sample-apps/houses/living_room.jpg',
            'https://s3-us-west-2.amazonaws.com/dev-or-devrl-s3-bucket/sample-apps/houses/eatinkitchen.jpg',
            'https://s3-us-west-2.amazonaws.com/dev-or-devrl-s3-bucket/sample-apps/houses/kitchen.jpg'
        ]);
    },

    fullScreen: function (component) {
        component.set('v.fullScreen', true);
    },

    closeDialog: function (component) {
        component.set('v.fullScreen', false);
    }
});
