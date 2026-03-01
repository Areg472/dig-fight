if triggered == -1 {
    if player_near(x, y + sprite_size, max_dist_to_player)
        triggered = step_counter;
} else if step_counter - triggered >= 3 * 60 {
    if player_near(x, y + sprite_size, max_dist_to_player)
        hit_player(step_counter);
    
    audio_play_sound(sExplosion, 0, false);
    
    destroy_around();
    instance_destroy();
} else {
    var anim_frame = ((step_counter - triggered) % 60) / 60;
    image_xscale = 1 + 0.5 * sin(2 * pi * anim_frame);
    image_yscale = 1 + 0.5 * -sin(2 * pi * anim_frame);
    if(anim_frame < 0.5) image_blend = c_red;
    else image_blend = c_white;
}

step_counter++;