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

vis = [];
move_flag = false;

try_step_path = function(o) {
    if o == noone || array_contains(vis, o) || move_flag return;
    x += o.x + o.sprite_xoffset - x - sprite_xoffset;
    y += o.y + o.sprite_yoffset - y - sprite_yoffset;
    array_push(vis, o);
    move_flag = true;
}
step_path = function() {
    var ox = x;
    var oy = y;
    
    if array_length(vis) <= 1 {
        var o = instance_nearest(x, y, oPath);
        x += o.x + o.sprite_xoffset - x - sprite_xoffset;
        y += o.y + o.sprite_yoffset - y - sprite_yoffset;
        array_push(vis, o);
        return [x - ox, y - oy];
    }
    var cx = array_last(vis).x, cy = array_last(vis).y;
    var o = [
        instance_position(cx - 1, cy, oPath),
        instance_position(cx + 1, cy, oPath),
        instance_position(cx, cy - 1, oPath),
        instance_position(cx, cy + 1, oPath),
    ];
    move_flag = false;
    array_foreach(o, try_step_path);
    if !move_flag {
        vis = [array_last(vis)];
        return step_path();
    }
    
    return [x - ox, y - oy];
}