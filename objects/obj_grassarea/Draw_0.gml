/// @description

//its ok to be trans
gpu_set_alphatestenable(true);

//enable shader
shader_set(sdr_grass);

//uniforms to pass
shader_set_uniform_f(uni_time, current_time);
shader_set_uniform_f(uni_dist, 0.02 * grass_wind);
shader_set_uniform_f(uni_slow, 200 / grass_speed);
shader_set_uniform_f(uni_spd, wind_hsp);
shader_set_uniform_f(uni_patbool, grass_pattern);
shader_set_uniform_f(uni_pattern, 0.1/pattern_size);

// Submit
vertex_submit(vbuff_grass, pr_trianglelist, _texture);

shader_reset();
//transparency end
gpu_set_alphatestenable(false);

draw_text(10, 10, bbox_bottom - bbox_top)