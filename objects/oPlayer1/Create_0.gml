event_inherited();

destroy_below(oGrassInside);

move_and_collide_but_actually_good = function (ax, ay, o) {
    ox = x;
    oy = y;
    var col = move_and_collide(ax, ay, o);
    if array_length(col) != 0 {
        x = ox;
        y = oy;
    }
}
move = function (k, ax, ay) {
    if !keyboard_check_pressed(k) return;
        
    move_and_collide_but_actually_good(ax * sprite_size, ay * sprite_size, oSolid);
    if ax < 0 image_xscale = 1;
    if ax > 0 image_xscale = -1;
        
    destroy_below(oGrassInside);
}