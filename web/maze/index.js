var map, px, py, ps, mw, mh, menu;
var theme_index = 0;
var themes = ["./themes/green.css", "./themes/yellow.css", "./themes/orange.css", "./themes/red.css", "./themes/classic.css", "./themes/blue.css", "./themes/paper.css"];
var noice = new Audio("60hz.ogg");
noice.loop = true;

function init() {
    map = [
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 4, 4, 4, 4, 1],
        [0, 0, 0, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 4, 2, 2, 4, 1],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 5, 5, 2, 2, 4, 1],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 4, 4, 4, 4, 1],
        [1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [2, 3, 3, 2, 1, 0, 0, 4, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [3, 4, 4, 5, 5, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [3, 4, 4, 3, 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [2, 3, 3, 2, 1, 4, 4, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [1, 1, 1, 1, 1, 1, 1, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ];

    px = 0;
    py = 0;
    ps = 0;
    mh = map.length;
    mw = map[0].length;

    render();
}

function render() {
    var string = "";

    for (y = 0; y < map.length; y++) {
        for (x = 0; x < map[y].length; x++) {
            if (x == px && y == py) {
                string += "<span id='player'>@</span>";
                continue;
            }

            switch (map[y][x]) {
                case 0:
                    string += ".";
                    break;
                case 1:
                    string += "#";
                    break;
                case 2:
                    string += "$";
                    break;
                case 3:
                    string += "X";
                    break;
                case 4:
                    string += "^";
                    break;
                case 5:
                    string += "W";
                    break;
                case 6:
                    string += "*";
                    break;
                case 7:
                    string += "%";
                    break;
                default:
                    string += "?";
                    break;
            }
        }
        string += "<br>";
    }

    string += (px + 1) + "," + (py + 1) + "<br>" + ps + "<br><a href='#' onclick='init()'>RESTART</a> <a href='#' onclick='goToMenu()'>MENU</a>";

    document.getElementById("field").innerHTML = string;
}

/*
 KEY CODES
 
 left = 37
 up = 38
 right = 39
 down = 40
*/

function handleInput(event) {
    var opx = px;
    var opy = py;
    switch (event.keyCode) {
        case 37:
            if (px !== 0) { px--; }
            break;
        case 38:
            if (py !== 0) { py--; }
            break;
        case 39:
            if (px < mw - 1) { px++; }
            break;
        case 40:
            if (py < mh - 1) { py++; }
            break;
        default:
            break;
    }

    switch (map[py][px]) {
        case 1:
            px = opx;
            py = opy;
            break;
        case 2:
            ps += 100;
            map[py][px] = 0;
            break;
        case 3:
            map[py][px] = 1;
            break;
        case 4:
            init();
            break;
        case 5:
            map[py][px] = 3;
            break;
        case 6:
            map[py][px] = 4;
            break;
        case 7:
            ps += 50;
            map[py][px] = 0;
            break;
        default:
            break;
    }

    render();
}

function goToMenu() {
    document.getElementById("field").innerHTML = menu;
}

function theme(id) {
    //theme_index = (theme_index + 1) % themes.length;
    document.getElementById("theme").href = themes[id];
}

function help() {
    document.getElementById("field").innerHTML = ": HELP ::::::<br><br>YOU ARE <span id='player'>@</span><br>COLLECT $<br>AVOID ^<br><br># ARE WALLS<br>X BECOME # WHEN STEPPED OFF<br>W BECOME X WHEN STEPPED OFF<br><br><a href='#' onclick='goToMenu()'>MENU</a>";
}

function mapmaking() {
    document.getElementById("field").innerHTML = ": MAKING MAPS ::::::<br><br>ALL BLOCKS HAVE ID<br>0 MAKES NOTHING, 1 MAKES #, ETC.<br>INVALID BLOCK IS ? AND DOES NOTHING<br><br>MAP IS STORED IN MAP ARRAY IN INDEX.JS.<br>MAP CAN BE ANY SIZE BUT MUST BE RECTANGLE<br><br>MAKING BLOCKS EASY. CODE IT YOURSELF.<br><a href='#' onclick='goToMenu()'>MENU</a>";
}

function thememaking() {
    document.getElementById("field").innerHTML = ": MAKING THEMES ::::::<br><br>THEME IS JUST A FUCKING CSS FILE.<br>COLOR ANYTHING YOU PLEASE<br><a href='#' onclick='goToMenu()'>MENU</a>";
}

function thememenu() {
    document.getElementById("field").innerHTML = ": THEMES ::::::<br><br><a href='#' onclick='theme(0)'>GREEN</a><br><a href='#' onclick='theme(1)'>YELLOW</a><br><a href='#' onclick='theme(2)'>ORANGE</a><br><a href='#' onclick='theme(3)'>RED</a><br><a href='#' onclick='theme(4)'>CLASSIC</a><br><a href='#' onclick='theme(5)'>BLUE</a><br><a href='#' onclick='theme(6)'>PAPER</a><br><br><a href='#' onclick='goToMenu()'>MENU</a>";
}