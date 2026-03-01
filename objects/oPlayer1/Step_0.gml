if !won {
    move(vk_right, 1, 0);
    move(vk_left, -1, 0);
    move(vk_up, 0, -1);
    move(vk_down, 0, 1);
} else {
    show_debug_message(-111);
    show_debug_message(frame_counter);
    show_debug_message(won_at);
   if(frame_counter - won_at >= 150) room_restart();
}

frame_counter++;