randomize();

_sprite = spr_flora;
_frames = sprite_get_number(_sprite) - 1;
_texture = sprite_get_texture(_sprite, 0);
_width = sprite_get_width(_sprite);
_height = sprite_get_height(_sprite);

//grass
_grass_count = (1 * ((bbox_right - bbox_left) * (bbox_bottom - bbox_top) / 1024)) / ((y * 2)/ room_height);

color = c_white;
alpha = 1;

//variables to tweak
grass_wind = 0.3; //amplitude of the grass swaying
grass_speed = 0.8; //Speed of the grass animation
wind_hsp = 0.1; //Extra horizontal speed of the wind >> Positive: Rightwards, Negative: Leftwards
grass_pattern = true; //Whether the grass should sway in a pattern
pattern_size = 2; //Sway pattern size

//the uniforms to grab
uni_time = shader_get_uniform(sdr_grass, "time");
uni_dist = shader_get_uniform(sdr_grass, "wave_dist");
uni_slow = shader_get_uniform(sdr_grass, "slow");
uni_spd = shader_get_uniform(sdr_grass, "wind_spd");
uni_patbool = shader_get_uniform(sdr_grass, "patbool");
uni_pattern = shader_get_uniform(sdr_grass, "pattern");

//3D
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);

//vertex format
vertex_format_begin();

//gpu accept 3D position
vertex_format_add_position_3d();

//gpu accept coordinates on the texture page
vertex_format_add_texcoord();
//xy/uv
vertex_format_add_custom(vertex_type_float2, vertex_usage_texcoord);
vertex_format_add_custom(vertex_type_float2, vertex_usage_texcoord);
//room pos
vertex_format_add_custom(vertex_type_float2, vertex_usage_texcoord);

//gpu accept color
vertex_format_add_color();
//vertex format ID = _format
_format = vertex_format_end();

//vertex buffer start
vbuff_grass = vertex_create_buffer();

vertex_begin(vbuff_grass, _format);

repeat (_grass_count) {
	// Grass coordinates + alignment
	var _spacing = 4 * 4;
	var _x1 = floor((irandom_range(bbox_left, bbox_right)) / _spacing) * _spacing;
	var _y1 = floor((irandom_range(bbox_top, bbox_bottom)) / _spacing) * _spacing;
	
	// Texture coordinates
	var _frame = irandom(_frames - 1);
	var _uvs = sprite_get_uvs(_sprite, _frame);
	
	//align to pixel grid
	var _atpx = _x1 + (_width * _uvs[6]);
	var _atpy = _y1 + (_height * _uvs[7]);
	
	//depth
	var _depth = -_atpy + 16;
	
	//center coordinate
	var xx = _atpx / 2;
	var yy = _atpy / 2;
	
	// Triangle 1
	vertex_position_3d(vbuff_grass, _x1, _y1, _depth);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[1]);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[1]);
	vertex_texcoord(vbuff_grass, _uvs[2] - _uvs[0], _uvs[3] - _uvs[1]);
	vertex_texcoord(vbuff_grass, xx, yy);
	vertex_color(vbuff_grass, color, alpha);
	
	vertex_position_3d(vbuff_grass, _atpx , _y1, _depth);
	vertex_texcoord(vbuff_grass, _uvs[2], _uvs[1]);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[1]);
	vertex_texcoord(vbuff_grass, _uvs[2] - _uvs[0], _uvs[3] - _uvs[1]);
	vertex_texcoord(vbuff_grass, xx, yy);
	vertex_color(vbuff_grass, color, alpha);
	
	vertex_position_3d(vbuff_grass, _x1, _atpy, _depth);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[3]);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[1]);
	vertex_texcoord(vbuff_grass, _uvs[2] - _uvs[0], _uvs[3] - _uvs[1]);
	vertex_texcoord(vbuff_grass, xx, yy);
	vertex_color(vbuff_grass, color, alpha);
	
	// Triangle 2
	vertex_position_3d(vbuff_grass, _atpx, _y1, _depth);
	vertex_texcoord(vbuff_grass, _uvs[2], _uvs[1]);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[1]);
	vertex_texcoord(vbuff_grass, _uvs[2] - _uvs[0], _uvs[3] - _uvs[1]);
	vertex_texcoord(vbuff_grass, xx, yy);
	vertex_color(vbuff_grass, color, alpha);
	
	vertex_position_3d(vbuff_grass, _x1, _atpy, _depth);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[3]);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[1]);
	vertex_texcoord(vbuff_grass, _uvs[2] - _uvs[0], _uvs[3] - _uvs[1]);
	vertex_texcoord(vbuff_grass, xx, yy);
	vertex_color(vbuff_grass, color, alpha);
	
	vertex_position_3d(vbuff_grass, _atpx, _atpy, _depth);
	vertex_texcoord(vbuff_grass, _uvs[2], _uvs[3]);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[1]);
	vertex_texcoord(vbuff_grass, _uvs[2] - _uvs[0], _uvs[3] - _uvs[1]);
	vertex_texcoord(vbuff_grass, xx, yy);
	vertex_color(vbuff_grass, color, alpha);
}

vertex_end(vbuff_grass);
vertex_freeze(vbuff_grass);