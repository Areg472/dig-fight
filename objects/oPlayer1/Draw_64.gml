draw_set_colour(c_black);
draw_set_font(fFont);
draw_text(0, 0, "HP: " + string(stat_health));
draw_text(0, 18, "C$: " + string(stat_coins));
if won {
    var old = draw_get_halign(); var old2 = draw_get_colour();
    draw_set_colour(c_white);
    draw_set_halign(textalign_center);
    draw_text_transformed(room_width, room_height, "YOU WIN!!", 4, 4, 0);
    draw_set_halign(old);
    draw_set_colour(old2);
}
