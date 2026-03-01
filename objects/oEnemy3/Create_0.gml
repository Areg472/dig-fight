event_inherited();
move = function () {
    a = step_path();
    if a[0] < 0 image_xscale = 1;
    if a[0] > 0 image_xscale = -1;
    destroy_below();
}
move();

frame_counter = 0;