sprite_size = 18;

destroy_obj = function (x, y, t) {
    var o = instance_position(x, y, t);
    if(o != noone) instance_destroy(o);
}
destroy_below = function (o) {
    destroy_obj(x, y - 2, o);
    destroy_obj(x - sprite_size, y - 2, o);
    destroy_obj(x, y - sprite_size - 2, o);
    destroy_obj(x - sprite_size, y - sprite_size - 2, o);
}
destroy_below_mult = function (a) {
    array_foreach(a, destroy_below);
}
destroy_around = function () {
    x -= sprite_size;
    destroy_below_mult([oGrassInside, oBox1]);
    x += 2 * sprite_size;
    destroy_below_mult([oGrassInside, oBox1]);
    y += 2 * sprite_size;
    destroy_below_mult([oGrassInside, oBox1]);
    x -= 2 * sprite_size;
    destroy_below_mult([oGrassInside, oBox1]);
}

vis = [];
move_flag = false;

try_step_path = function(o) {
    if o == noone || move_flag return;
    for(var i = 0; i < array_length(vis); i++)
        if(vis[i].id == o.id)
            return;
    x += o.x + o.sprite_xoffset - x;
    y += o.y + o.sprite_yoffset - y + 2 * sprite_size;
    array_push(vis, o);
    move_flag = true;
}
step_path = function() {
    var ox = x;
    var oy = y;
    
    show_debug_message(array_length(vis));
    if array_length(vis) == 0 {
        var o = instance_nearest(x, y, oPath);
        if o == noone return [0, 0];
        x += o.x + o.sprite_xoffset - x;
        y += o.y + o.sprite_yoffset - y + 2 * sprite_size;
        array_push(vis, o);
        return [x - ox, y - oy];
    }
    var l = array_last(vis);
    var cx = l.x, cy = l.y + sprite_size;
    var o = [
        instance_place(cx - sprite_size, cy, oPath),
        instance_place(cx + sprite_size, cy, oPath),
        instance_place(cx, cy - sprite_size, oPath),
        instance_place(cx, cy + sprite_size, oPath),
    ];
    array_foreach(o, show_debug_message);
    move_flag = false;
    array_foreach(o, try_step_path);
    if !move_flag {
        var a = array_last(vis);
        vis = [];
        array_push(vis, a);
        // return step_path();
    }
    
    show_debug_message(111);
    show_debug_message(x - ox);
    show_debug_message(y - oy);
    return [x - ox, y - oy];
}

obj_near = function(x, y, r, o) {
    var player = instance_nearest(x, y, o);
    return sqrt(power((player.x - x), 2) + power((player.y - y), 2)) < sprite_size * r;
}
player_near = function(x, y, r) {
    return obj_near(x, y, r, oPlayer1);
}
hit_player = function(c) {
    var player = instance_nearest(x, y, oPlayer1);
    if(c - player.hit < 90) return;
    player.hit = c;
    player.stat_health--;
    if(player.stat_health <= 0) room_restart();
}