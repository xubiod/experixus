// Created with GMLive.js

f = 0;
particles = ds_list_create();

#define step
base_x = window_get_width()/2;
base_y = window_get_height()/2;

for (var amt = 0; amt < 32; amt++) {
    if (irandom(3) == 0) ds_list_add(particles, [0, random(360)]);
}

f++;
#define draw

draw_set_color(c_black);
draw_rectangle(0,0,base_x*2,base_y*2,false);

draw_set_color(c_white);

for (var i = 0; i < ds_list_size(particles); i++) {
    var data = ds_list_find_value(particles, i);
    
    draw_set_circle_precision(floor(data[0]/30)+2);
    
    var _co = merge_color(c_black, make_color_hsv((data[0]/2+(247*f))%255,255,255), min(data[0]/base_y,1));
    
    var q = ((f/2)%8)+4;
    
    draw_set_color(_co);
    
    draw_circle(
        base_x + lengthdir_x(data[0], data[1]),
        base_y + lengthdir_y(data[0], data[1]),
        data[0]/q, false);
        
    draw_set_color(c_black);
    
    draw_circle(
        base_x + lengthdir_x(data[0], data[1]),
        base_y + lengthdir_y(data[0], data[1]),
        data[0]/((q/3)*4), false);
    
    ds_list_set(particles, i, [(1.1*data[0])+1, data[1]+((sin(f/60)+2)*2)]);
    if ((data[0]) > (2*base_x)) ds_list_delete(particles, i);
}
