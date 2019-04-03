help_toggle = false;

#define draw_help_screen()

if (keyboard_check_pressed(ord('H'))) help_toggle = !help_toggle;

if (help_toggle) {
    draw_text(72,72,
    "Help:" +
    "##Quality: Q then UP/DOWN (the guide below) arrows or LEFT/RIGHT (Half/double)" +
    "#> No modifiers = Change by 0.25#> Ctrl = Change by 5#> Shift = Change by 0.05#> D = Reset to 4" +
    "##Achievements: Toggle visibility with A" +
    "##Help: Toggle visibility with H"
    
    );
}
