$(function() {
    window.addEventListener("message", function(event) {
        var data = event.data;

        if (typeof data.additem !== 'undefined') {
            iziToast.show({
                theme: 'dark',
                icon: 'icon-person',
                progressBarColor: 'rgb(0, 255, 184)',
                position: 'bottomRight', // bottomRight, bottomLeft, topRight, topLeft, topCenter, bottomCenter
                timeout: 2000,
                title: '+ ' + data.item + ' x' + data.count,
            });
        }

        if (typeof data.rmvItem !== 'undefined') {
            iziToast.show({
                theme: 'dark',
                icon: 'icon-person',
                progressBarColor: 'rgb(255, 17, 0)',
                position: 'bottomRight', // bottomRight, bottomLeft, topRight, topLeft, topCenter, bottomCenter
                timeout: 2000,
                title: '- ' + data.item + ' x' + data.count,
            });
        }
    });

});