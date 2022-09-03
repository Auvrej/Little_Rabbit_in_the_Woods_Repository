//keep player in bounds
x = clamp(x, (20 + _mspeed), room_width - (20 + _mspeed));
y = clamp(y, (20 + _mspeed), room_height - (20 + _mspeed));

//change speed dynamically
if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_down)) {image_index = 0};
_mspeed = ((0.99 * sin(pi/2 * image_index)) + 1) * 4;


//store keypresses
_moveleft = keyboard_check(vk_left);
_moveright = keyboard_check(vk_right);
_movedown = keyboard_check(vk_down);
_moveup = keyboard_check(vk_up);
//store velocity variables
vx = (_moveright-_moveleft) * _mspeed;
vy = (_movedown-_moveup) * _mspeed;
_dvxy = (_moveright-_moveleft) * (0.7*_mspeed);
_dvyx = (_movedown-_moveup) * (0.7 * _mspeed);
//check if moving and update position
if((vx != 0) || (vy != 0)){
	//animate faster when moving
	image_speed = 2;
	//if diagonal
	if(vx != 0 && vy != 0){
		x += _dvxy;
		y += _dvyx;
	}else{
		x += vx;
		y += vy;
	}
//change back to the slower speed if idle
}else{image_speed = 1};

//check if moving and update state and direction
if((vx != 0)||(vy != 0)){
	_mystate = _playerstate.walking;
	if((vx == 0) && (vy > 0)){_mydirection = 0}
	if((vx > 0) && (vy >= 0)){_mydirection = 1}
	if((vx > 0) && (vy < 0)){_mydirection = 2}
	if((vx == 0) && (vy < 0)){_mydirection = 3}
	if((vx < 0) && (vy < 0)){_mydirection = 4}
	if((vx < 0) && (vy >= 0)){_mydirection = 5}
}else{_mystate = _playerstate.idle}
//change sprite based on state and direction
sprite_index = _playerspr[_mystate][_mydirection];

if(vx != 0 && vy != 0){
	if (place_meeting(x + vx, y, obj_collisionbox)){
		x -= _dvxy};
	if (place_meeting(x, y + vy, obj_collisionbox)){
		y -= _dvyx};
}else{
	if (place_meeting(x + vx, y, obj_collisionbox)){
		x -= vx};
	if (place_meeting(x, y + vy, obj_collisionbox)){
		y -= vy};
}
