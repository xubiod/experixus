// BE CAREFUL CHANGING THESE VALUES!!!
// IT DOES HAVE A MAXIMUM THAT WILL CAUSE MAJOR ISSES!!!
// THE MAX IS IN A GREY AREA, NOT SURE IF 32bit OR 64bit INTEGER
// 2 BILLION vs. 9 QUINTILLION
cap = 65536;
balls = array_create(cap * 8);
amt = 1;

amt = floor(min(abs(amt), cap));

total_hits  = 0;
corner_hits = 0;

frame = 0;

_quality = 16;

#define step
frame++
achieve_get();
if (frame != 2) exit;

for (i = 0; i < amt; i++) {
    randomize();
    random_set_seed(i + irandom_range(-255,255));

    //pos and unused direction
    balls[i][0] = irandom(window_get_width() - sprite_get_width(sDVD));
    balls[i][1] = irandom(window_get_height() - sprite_get_height(sDVD));
    balls[i][2] = irandom(4) * 90 + 45;
    
    //direction
    balls[i][3] = round(lengthdir_x(1, balls[i][2])/abs(lengthdir_x(1, balls[i][2])));
    balls[i][4] = round(lengthdir_y(1, balls[i][2])/abs(lengthdir_y(1, balls[i][2])));
    
    //start hue
    balls[i][5] = irandom(255);
    
    //id
    balls[i][6] = i;
    
    // FOR LATER USE POSSIBLY
    balls[i][7] = undefined;
    
    while (
        (balls[i][0] + sprite_get_width(sDVD)) > 
        window_get_width()) {
        balls[i][0]--;
    }
    
    while (
        (balls[i][1] + sprite_get_height(sDVD)) > 
        window_get_height()) {
        balls[i][1]--;
    }
}
#define draw
renders = 0;
draw_set_color(c_black);
draw_set_alpha(1);
draw_rectangle(0,0,window_get_width(),window_get_height(), false);

for (j = 0; j < amt; j++) {
    corner = 0;
    draw_set_color((make_color_hsv((((j/amt) * 255) + balls[j][5]) % 255,255,255)));
    
    dispx = round(balls[j][0]/2)*2 + 1;
    dispy = round(balls[j][1]/2)*2 + 1;
    
    /*
    draw_line(dispx, 0, dispx, window_get_height());
    draw_line(0, dispy, window_get_width(), dispy);
    
    draw_line(dispx+sprite_get_width(sDVD), 0, dispx+sprite_get_width(sDVD), window_get_height());
    draw_line(0, dispy+sprite_get_height(sDVD), window_get_width(), dispy+sprite_get_height(sDVD));
    */
    
    if (amt < (512 * _quality)) {
        draw_sprite_ext(sDVD, 0, dispx, dispy, 1,1, 0, draw_get_color(),1);
        renders++;
    }
    
    if ((balls[j][0] + balls[j][3]) < 0 || (balls[j][0] + balls[j][3]) > window_get_width() - sprite_get_width(sDVD))  { balls[j][3] = -balls[j][3]; balls[j][5] += irandom(180); corner++; }
    if ((balls[j][1] + balls[j][4]) < 0 || (balls[j][1] + balls[j][4]) > window_get_height() - sprite_get_height(sDVD)) { balls[j][4] = -balls[j][4]; balls[j][5] += irandom(180); corner++; }
    
    balls[j][0] += balls[j][3] * 4;
    balls[j][1] += balls[j][4] * 4;
    
    if (corner == 2) {
        if (amt >= (256 * _quality)) {
            draw_sprite(sDVD, 0,dispx,dispy);
            renders++;
        }
        corner_hits++;
    }
    
    if (amt < (1024 * _quality)) {
        if (corner > 0) {
            draw_sprite_ext(sDVD, 0, dispx, dispy, 1,1, 0, draw_get_color(),0.05);
            renders++;
        }
    }
    
    total_hits += corner;
}
    
if (keyboard_check(ord('Q'))) {
    change_amt = 0.25;
    if (keyboard_check(vk_shift)) change_amt = 0.05;
    if (keyboard_check(vk_control)) change_amt = 1;
    if (keyboard_check(ord('D'))) _quality = 4;
    
    if (keyboard_check_pressed(vk_up))   _quality += change_amt;
    if (keyboard_check_pressed(vk_down)) _quality -= change_amt;
    
    if (keyboard_check_pressed(vk_right))   _quality = _quality * 2;
    if (keyboard_check_pressed(vk_left)) _quality = _quality / 2;
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(4,4,
"Total: " + numb_display(total_hits) +  
"#Corner: " + numb_display(corner_hits) +
"#%: " + string((corner_hits/total_hits)*100));

draw_set_valign(fa_bottom);
draw_text(4,window_get_height(),
"##Quality: " + string(_quality) + 
"#Threshold: M. " + string(_quality * 1024) + " / L. " + string(_quality * 512) +
"##Capacity: S. " + string(amt) + "/" + string(cap) + " " + string((amt/cap)*100) + "% | D. " + string(renders) + " " + string((renders/amt)*100) + "%"
);

draw_set_valign(fa_top);
draw_achieve();
draw_set_halign(fa_left);
draw_help_screen();
#define numb_display(input)
output = "";

output = string(input);

if (input >= 1000000) {
    output = output + " (" + string(floor(input/10000)/100) + "M)";
} else if (input >= 1000) {
    output = output + " (" + string(floor(input/10)/100) + "K)";
}

return output;




