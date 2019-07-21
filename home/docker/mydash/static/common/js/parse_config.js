var request = new XMLHttpRequest();
request.overrideMimeType("application/json");
request.open("GET", 'config.json');
request.onload = function () {
    if (request.status >= 200 && request.status < 400) {
        var config = JSON.parse(this.response);
        console.log(config);

        // Set page title
        document.title = config.title;

        // Hide github corner
        if (config.hide_corner == true) {
            document.getElementById("corner").style.visibility = 'hidden'
        }

        // Generate icons
        var itemlistHTML = '';
        for (var i = 0; i < config.items.length; i++) {
            var item = config.items[i];
            itemlistHTML += '<a target="'+item.target+'" href="'+item.link+'" title="'+item.alt+'"><i class="'+item.icon+' fa-fw"></i></a>';
        }
        document.getElementById("itemlist").innerHTML = itemlistHTML;
    } else {
        var error_text = "Error: "+request.status;
        console.error(error_text);
        document.title = error_text;
    }
}
request.send(null);