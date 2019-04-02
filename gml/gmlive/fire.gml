// Created with GMLive.js

f = 0;
particles = ds_list_create();

x_wind = 0;
y_wind = 0;

wind_ind_timer = 60;

_mode = 0;
_theme = 0;
_count = 16;
_debug = false;

#define step
base_x = window_get_width()/2;
base_y = window_get_height()/2;

for (var _x = -_count; _x <= _count; _x++) {
    ds_list_add(particles, [-32*_x, base_y, 0]);
}

x_wind += keyboard_check(vk_right) - keyboard_check(vk_left);
y_wind += keyboard_check(vk_up) - keyboard_check(vk_down);

if (keyboard_check(vk_anykey)) wind_ind_timer = 60;

if (keyboard_check_pressed(ord("M"))) {
    _mode = (_mode + 1) % 3;
    x_wind = floor(x_wind);
    y_wind = floor(y_wind);
}

if (keyboard_check_pressed(ord("T"))) _theme = (_theme + 1) % 7;

if (_mode == 1) {
    x_wind = x_wind * 0.95;
    y_wind = y_wind * 0.95;
} else if (_mode == 2) {
    x_wind = sin(current_time/1000) * 8;
    y_wind = cos(current_time/1000) * 8 + 10;
}
#define particle()
var x_off = argument[0];
var y_off = argument[1];
var life  = argument[2];

var old_c = draw_get_color();
var old_a = draw_get_alpha();

draw_set_circle_precision(4);

draw_set_alpha(0.5-((life-24)/36));
draw_set_color(merge_color(theme(0), theme(1), min(life/48,1)));

draw_circle(base_x + x_off, base_y + y_off, 32-(life/2), false);

draw_set_alpha(old_a);
draw_set_color(old_c);
#define mode()
input = argument0;
switch(input) {
    case 0: return "Normal";
    case 1: return "Joystick";
    case 2: return "Auto Circle";
    default: return "???";
}

#define theme()
_color = argument0;

switch (_theme) {
    case 0: {
        if (_color == 0) {
            return c_yellow;
        } else if (_color == 1) {
            return c_red;
        } else {
            return "Fire";
        }
    }
    
    case 1: {
        if (_color == 0) {
            return c_white;
        } else if (_color == 1) {
            return c_blue;
        } else {
            return "Blue Fire";
        }
    }
    
    case 2: {
        if (_color == 0) {
            return c_white;
        } else if (_color == 1) {
            return c_lime;
        } else {
            return "Green Fire";
        }
    }
    
    case 3: {
        if (_color == 0) {
            return c_aqua;
        } else if (_color == 1) {
            return c_purple;
        } else {
            return "Twilight";
        }
    }
    
    case 4: {
        if (_color == 0) {
            return c_white;
        } else if (_color == 1) {
            return c_red;
        } else {
            return "Rosy Fire";
        }
    }
    
    case 5: {
        if (_color == 0) {
            return c_dkgray;
        } else if (_color == 1) {
            return c_black;
        } else {
            return "Smoke";
        }
    }
    
    case 6: {
        if (_color == 0) {
            return c_white;
        } else if (_color == 1) {
            return c_orange;
        } else {
            return "Cream";
        }
    }
}

#define draw
draw_set_alpha(1);
draw_rectangle_color(0,0,window_get_width(),window_get_height(),c_black,c_black,c_black,c_black,false);

for (var i = 0; i < ds_list_size(particles); i++) {
    var data = ds_list_find_value(particles, i);
    particle(data[0], data[1], data[2]);
    
    ds_list_set(particles, i, [data[0]+random_range(0.0,x_wind),data[1]-random_range(0.5,y_wind)-(data[2]/5),data[2]+random(2)]);
    if ((data[2] + 5) > 48) ds_list_delete(particles, i);
}

draw_set_alpha(min(wind_ind_timer/30,1));
draw_set_color(merge_color(c_white,c_black,(sin(current_time/100))*0.5 + 0.5));
draw_circle(base_x + (x_wind * 8), (base_y*2) - (y_wind * 8), /*point_distance(base_x, base_y + 128, base_x + (x_wind * 8), base_y - (y_wind * 8) + 128)/2*/36, true);
draw_line_width(base_x, base_y*2, base_x + (x_wind * 8), (base_y*2) - (y_wind * 8), 4);

wind_ind_timer--;

draw_set_alpha(1);
draw_set_color(c_white);
if (_debug) {
    draw_text(2,2,mode(_mode) + "#" + theme(2) + "#PC: " + string(ds_list_size(particles)) + "#EC: " + string(_count * 2 + 1));
} else {
    draw_text(2,2,mode(_mode) + "#" + theme(2));
}

f += 5;
