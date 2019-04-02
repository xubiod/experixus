// Created with GMLive.js

background_color = $F5F5F5; draw_set_color(0); // (legacy colors)
#define main
// init code here
_dir = 0;
_spd = 32;
_wid = 48;
_dist = 4;
_box = 500;
_bAl = .25;

new_str();

#define step
// update code here
if (keyboard_check_pressed(vk_space)) {
    new_str();
}

if (keyboard_check_pressed(ord("S"))) {
    _strTemp = get_string("",_strTemp);
}

if (keyboard_check_pressed(ord("D"))) {
    _spd = get_integer("",_spd);
}

if (keyboard_check_pressed(ord("A"))) {
    _dist = get_integer("",_dist);
    _wid = _dist+44;
}

if (keyboard_check_pressed(ord("F"))) {
    _box = get_integer("",_box);
}


if (keyboard_check_pressed(ord("G"))) {
    _bAl = get_integer("",_bAl);
}

#define draw
// draw code here
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(0,0,view_wport[0],view_hport[0], false);

draw_set_alpha(_bAl);
draw_set_halign(fa_left);
draw_set_valign(fa_left);

repeat _box {
    if (irandom(1) == 1) {
        draw_rectangle_color(
            irandom_range(0,view_wport[0]), 
            irandom_range(0,view_hport[0]),
            irandom_range(0,view_wport[0]), 
            irandom_range(0,view_hport[0]),
            make_color_rgb(
                irandom(255),
                irandom(255),
                irandom(255)
            ),
            make_color_rgb(
                irandom(255),
                irandom(255),
                irandom(255)
            ),
            make_color_rgb(
                irandom(255),
                irandom(255),
                irandom(255)
            ),
            make_color_rgb(
                irandom(255),
                irandom(255),
                irandom(255)
            ),
            false
        );
    } else {
        draw_line_color(
            irandom_range(0,view_wport[0]), 
            irandom_range(0,view_hport[0]),
            irandom_range(0,view_wport[0]), 
            irandom_range(0,view_hport[0]),
            make_color_rgb(
                irandom(255),
                irandom(255),
                irandom(255)
            ),
            make_color_rgb(
                irandom(255),
                irandom(255),
                irandom(255)
            )
        );
    }
}

draw_set_color(c_black);
draw_set_alpha(0.75);

draw_rectangle(
    0,
    (view_hport[0]/2)-_wid,
    (view_wport[0]),
    (view_hport[0]/2)+_wid,
    false
);

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

_str = _strTemp;

_str = string_replace_all(
    _str,
    "%time",
    better_time(current_hour%12) + 
    ":" + 
    better_time(current_minute) +
    ":" +
    better_time(current_second)
);

_str = string_replace_all(
    _str,
    "%date",
    better_time(current_month%12) + 
    "/" + 
    better_time(current_day) +
    "/" +
    better_time(current_year)
);

_str = string_replace_all(
    _str,
    "%date",
    better_time(current_month%12) + 
    "/" + 
    better_time(current_day) +
    "/" +
    better_time(current_year)
);

_str = string_replace_all(
    _str,
    "%weekdayl",
    weekday_as_text_l()
);

_str = string_replace_all(
    _str,
    "%weekday",
    weekday_as_text()
);

_str = string_replace_all(
    _str,
    "%fpsreal",
    string(fps_real)
);

_str = string_replace_all(
    _str,
    "%fps",
    string(fps)
);

_str = string_replace_all(
    _str,
    "%roomspd",
    string(room_speed)
);

draw_set_alpha(1.0);
draw_text_transformed(
    (view_wport[0]/2)+lengthdir_x(_dist,_dir),
    (view_hport[0]/2)+lengthdir_y(_dist,_dir),
    _str,
    4,2,0
);
if (true) {
    draw_set_alpha(0.25);
    draw_text_transformed(
        (view_wport[0]/2)+lengthdir_x(_dist/2,_dir),
        (view_hport[0]/2)+lengthdir_y(_dist/2,_dir),
        _str,
        4,2,0
    );
    
    draw_text_transformed(
        (view_wport[0]/2)-lengthdir_x(0,_dir),
        (view_hport[0]/2)-lengthdir_y(0,_dir),
        _str,
        4,2,0
    );
    
    draw_text_transformed(
        (view_wport[0]/2)-lengthdir_x(_dist/2,_dir),
        (view_hport[0]/2)-lengthdir_y(_dist/2,_dir),
        _str,
        4,2,0
    );
}

draw_text_transformed(
    (view_wport[0]/2)-lengthdir_x(_dist,_dir),
    (view_hport[0]/2)-lengthdir_y(_dist,_dir),
    _str,
    4,2,0
);

_dir += _spd;

_dir = _dir%360;
draw_self();

#define new_str
if (true) {
    _q = irandom(7);
    
    if (_q == 0) {
        _strTemp = "nice jazz";
    } else if (_q == 1) {
        _strTemp = "BEES? BEES! BBBEEEEEESSS!!!!";
    } else if (_q == 2) {
        _strTemp = "stay in skool kiddo";
    } else if (_q == 3) {
        _strTemp = "good morning";
    } else if (_q == 4) {
       _strTemp = ":^)";
    } else if (_q == 5) {
    _strTemp = "hahahahahahahhahahah";
    } else if (_q == 6) {
       _strTemp = "PINK FLUFFY UNICORNS#DANCING ON RAINBOWS";
    } else if (_q == 7) {
        _strTemp = "v a p o u r w a v e";
    }
}

#define better_time
if (string_length(string(argument0)) = 1) {
    return "0" + string(argument0);
} else {
    return string(argument0);
}

#define weekday_as_text
var day;
switch(current_weekday)
   {
   case 0: day = "Sunday"; break;
   case 1: day = "Monday"; break;
   case 2: day = "Tuesday"; break;
   case 3: day = "Wednesday"; break;
   case 4: day = "Thursday"; break;
   case 5: day = "Friday"; break;
   case 6: day = "Saturday"; break;
   }
return day;

#define weekday_as_text_l
var day;
switch(current_weekday)
   {
   case 0: day = "sunday"; break;
   case 1: day = "monday"; break;
   case 2: day = "tuesday"; break;
   case 3: day = "wednesday"; break;
   case 4: day = "thursday"; break;
   case 5: day = "friday"; break;
   case 6: day = "saturday"; break;
   }
return day;
