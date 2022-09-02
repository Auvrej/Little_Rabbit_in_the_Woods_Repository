/// @description Vertex Buffer

_sprite = spr_flora;
_frames = sprite_get_number(_sprite);
_texture = sprite_get_texture(_sprite, 0);
_width = sprite_get_width(_sprite);
_height = sprite_get_height(_sprite);

//grass
_grass_count = 80;

color = c_white;
alpha = 1;

//3D
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);

//vertex format
vertex_format_begin();

vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_color();

_format = vertex_format_end();

//vertex buffer start
vbuff_grass = vertex_create_buffer();

vertex_begin(vbuff_grass, _format);

repeat (_grass_count) {
	// Grass coordinates
	var _x1 = irandom_range(bbox_left, bbox_right);
	var _y1 = irandom_range(bbox_top, bbox_bottom);
	var _x2 = _x1 + _width;
	var _y2 = _y1 + _height;
	
	var _depth = -_y2;
	
	// Texture coordinates
	var _frame = irandom(_frames - 1);
	var _uvs = sprite_get_uvs(_sprite, _frame);
	
	//align to pixel grid
	var _atpx = _x1 + (_width * _uvs[6]);
	var _atpy = _y1 + (_height * _uvs[7]);
	
	// Triangle 1
	vertex_position_3d(vbuff_grass, _x1, _y1, _depth);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[1]);
	vertex_color(vbuff_grass, color, alpha);
	
	vertex_position_3d(vbuff_grass, _atpx , _y1, _depth);
	vertex_texcoord(vbuff_grass, _uvs[2], _uvs[1]);
	vertex_color(vbuff_grass, color, alpha);
	
	vertex_position_3d(vbuff_grass, _x1, _atpy, _depth);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[3]);
	vertex_color(vbuff_grass, color, alpha);
	
	// Triangle 2
	vertex_position_3d(vbuff_grass, _atpx, _y1, _depth);
	vertex_texcoord(vbuff_grass, _uvs[2], _uvs[1]);
	vertex_color(vbuff_grass, color, alpha);
	
	vertex_position_3d(vbuff_grass, _x1, _atpy, _depth);
	vertex_texcoord(vbuff_grass, _uvs[0], _uvs[3]);
	vertex_color(vbuff_grass, color, alpha);
	
	vertex_position_3d(vbuff_grass, _atpx, _atpy, _depth);
	vertex_texcoord(vbuff_grass, _uvs[2], _uvs[3]);
	vertex_color(vbuff_grass, color, alpha);
}

vertex_end(vbuff_grass);
vertex_freeze(vbuff_grass);