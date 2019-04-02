//https://picsum.photos/200/300/?random
//                      w   h

var height, width, transparency, location, locale, weather, moon, background, can, ctx, preview, weather_src, moon_src, back_src;

function start() {
    height,
    width,
    transparency,
    location,
    locale;
    weather = new Image();
    moon = new Image();
    background = new Image();
    can = document.getElementById("result");
    ctx = document.getElementById("result").getContext('2d');
    preview = false;

    //weather.crossOrigin    = "Anonymous";
    moon.crossOrigin = "Anonymous";
    background.crossOrigin = "Anonymous";
}

function getSizeByDropDown() {
    var ele = document.getElementById("res_select");

    width = Number(ele.value.split(",")[0]);
    height = Number(ele.value.split(",")[1]);
}

function generate() {
    if (document.getElementById("res_select").value != "userdef") {
        getSizeByDropDown();
    } else {
        width = Number(document.getElementById("wideness").value);
        height = Number(document.getElementById("tallness").value);
    }

    can.width = width;
    can.height = height;

    transparency = document.getElementById("seethruness").value;
    if (transparency === "") { transparency = "150"; }

    switch (document.getElementById('provider').value) {
        case "0":
            { background.src = "https://picsum.photos/" + width.toString() + "/" + height.toString() + "?random"; break; }
        case "1":
            { background.src = "https://lorempixel.com/" + width.toString() + "/" + height.toString() + "/" + document.getElementById("tags").value; break; }
        case "2":
            { background.src = "https://loremflickr.com/" + width.toString() + "/" + height.toString() + "/" + document.getElementById("tags").value + "?random=" + (Math.random() * 10000).toString(); break; }
        case "3":
            { background.src = "https://placeimg.com/" + width.toString() + "/" + height.toString() + "/" + document.getElementById("tags").value; break; }
        default:
            { alert("invalid site!"); }
    }

    var locale = document.getElementById("locale").value;

    if (document.getElementById("overlay-mode").value == "weather") {
        weather.src = "http://wttr.in/MyLocation.png?F" + document.getElementById("unit").value + document.getElementById("thicky-ness").value + "&transparency=" + transparency + "&lang=" + locale;
    } else {
        moon.src = "http://wttr.in/moon.png?F" + document.getElementById("unit").value + "&transparency=" + transparency + "&lang=" + locale;
    }

    background.onload = function() {
        ctx.drawImage(background, 0, 0);
        if (document.getElementById("overlay-mode").value == "weather") {
            ctx.drawImage(weather, 50, 50);
        } else {
            ctx.drawImage(moon, 50, 50);
        }
        back_src = background.src;
    }

    weather.onload = function() {
        ctx.drawImage(background, 0, 0);
        ctx.drawImage(weather, 50, 50);
        weather_src = weather.src;
    }

    moon.onload = function() {
        ctx.drawImage(background, 0, 0);
        ctx.drawImage(moon, 50, 50);
        moon_src = moon.src;
    }
}

function update() {
    if (document.getElementById("res_select").value != "userdef") {
        getSizeByDropDown();
    } else {
        width = Number(document.getElementById("wideness").value);
        height = Number(document.getElementById("tallness").value);
    }

    can.width = width;
    can.height = height;

    transparency = document.getElementById("seethruness").value;
    if (transparency === "") { transparency = "150"; }

    var locale = document.getElementById("locale").value;

    if (document.getElementById("overlay-mode").value == "weather") {
        weather.src = "http://wttr.in/MyLocation.png?F" + document.getElementById("unit").value + document.getElementById("thicky-ness").value + "&transparency=" + transparency + "&lang=" + locale;
    } else {
        moon.src = "http://wttr.in/moon.png?F" + document.getElementById("unit").value + "&transparency=" + transparency + "&lang=" + locale;
    }

    weather.onload = function() {
        ctx.drawImage(background, 0, 0);
        ctx.drawImage(weather, 50, 50);
        weather_src = weather.src;
    }

    moon.onload = function() {
        ctx.drawImage(background, 0, 0);
        ctx.drawImage(moon, 50, 50);
        moon_src = moon.src;
    }
}

function save() {
    var img = can.toDataURL("image/png");

    window.open(img, "_blank");
}

function _preview() {
    preview = document.getElementById('chk').checked;

    if (preview) {
        can.classList.add("preview");
    } else {
        can.classList.remove("preview");
    }
    update();
}