sprite_size = 18;

destroy_obj = function (x, y, t) {
    var o = instance_position(x, y, t);
    if(o != noone) instance_destroy(o);
}
destroy_below = function () {
    destroy_obj(x, y - 2, oGrassInside);
    destroy_obj(x - sprite_size, y - 2, oGrassInside);
    destroy_obj(x, y - sprite_size - 2, oGrassInside);
    destroy_obj(x - sprite_size, y - sprite_size - 2, oGrassInside);
}

destroy_below();

move = function (k, ax, ay) {
    if keyboard_check(k) {
		move_and_collide(ax * sprite_size, ay * sprite_size, oSolid);
    }
    destroy_below();
}