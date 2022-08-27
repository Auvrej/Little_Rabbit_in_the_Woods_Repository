_moveleft=keyboard_check(vk_left);
_moveright=keyboard_check(vk_right);
_movedown=keyboard_check(vk_down);
_moveup=keyboard_check(vk_up);
vx=(_moveright-_moveleft)*_mspeed;
vy=(_movedown-_moveup)*_mspeed;
_dvxy=(_moveright-_moveleft)*(0.6*_mspeed);
_dvyx=(_movedown-_moveup)*(0.6*_mspeed);
if((vx!=0)||(vy!=0) ){
	if(vx!=0&&vy!=0){
		x+=_dvxy;
		y+=_dvyx;
	}else{
		x+=vx;
		y+=vy;
	}
}

if((vx!=0)||(vy!=0)){
	_mystate=_playerstate.walking;
	if((vx==0)&&(vy>0)){_mydirection=0}
	if((vx<0)&&(vy>=0)){_mydirection=1}
	if((vx<0)&&(vy<0)){_mydirection=2}
	if((vx==0)&&(vy<0)){_mydirection=3}
	if((vx>0)&&(vy<0)){_mydirection=4}
	if((vx>0)&&(vy>=0)){_mydirection=5}
}else{_mystate=_playerstate.idle} 
sprite_index=_playerspr[_mystate][_mydirection];
	