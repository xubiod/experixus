achievements = array_create(44);
total_ach    = 22;
achieve_string = "Wall Hit Achievements: #";
proced_ach = 1;
show_ach = true;

achievements[0][0] = 100;        //100
achievements[1][0] = 250;        //250
achievements[2][0] = 500;        //500
achievements[3][0] = 1000;       //1K
achievements[4][0] = 2500;       //2.5K
achievements[5][0] = 5000;       //5K
achievements[6][0] = 10000;      //10K
achievements[7][0] = 25000;      //25K
achievements[8][0] = 50000;      //50K
achievements[9][0] = 100000;     //100K
achievements[10][0] = 250000;    //250K
achievements[11][0] = 500000;    //500K
achievements[12][0] = 1000000;   //1M
achievements[13][0] = 2500000;   //2.5M
achievements[14][0] = 5000000;   //5M
achievements[15][0] = 10000000;  //10M
achievements[16][0] = 15000000;  //15M
achievements[17][0] = 20000000;  //20M
achievements[18][0] = 25000000;  //25M
achievements[19][0] = 50000000;  //50M
achievements[20][0] = 75000000;  //75M
achievements[21][0] = 100000000; //100M

achievements[0][1] = -1;
achievements[1][1] = -1;
achievements[2][1] = -1;
achievements[3][1] = -1;
achievements[4][1] = -1;
achievements[5][1] = -1;
achievements[6][1] = -1;
achievements[7][1] = -1;
achievements[8][1] = -1;
achievements[9][1] = -1;
achievements[10][1] = -1;
achievements[11][1] = -1;
achievements[12][1] = -1;
achievements[13][1] = -1;
achievements[14][1] = -1;
achievements[15][1] = -1;
achievements[16][1] = -1;
achievements[17][1] = -1;
achievements[18][1] = -1;
achievements[19][1] = -1;
achievements[20][1] = -1;
achievements[21][1] = -1;

#define achieve_get()

for (var i = 0; i < total_ach; i++) {
    if (achievements[i][1] == -1) {
        if (achievements[i][0] < total_hits) {
            achievements[i][1] = frame;
            
            achieve_string = achieve_string + numb_display(achievements[i][0]) + ": " + string(achievements[i][1]/60) + "s#";            
        }
    }
}

if (floor(total_hits / 10000000) > proced_ach) {
    proced_ach++;
    achieve_string = achieve_string + numb_display(proced_ach * 10000000) + ": " + string(frame/60) + "s#";
}

if (keyboard_check_pressed(ord('A'))) show_ach = !show_ach;

#define draw_achieve()

if (!show_ach) return;

draw_set_halign(fa_right);
draw_text(window_get_width(),0,achieve_string);

