_moveleft = 0;
_moveright = 0;
_movedown = 0;
_moveup = 0;
_mspeed = 5;
vx = 0;
vy = 0;
_mystate = _playerstate.idle;
_mydirection = 0;


_playerspr[_playerstate.idle][0] = spr_player_s;
_playerspr[_playerstate.idle][1] = spr_player_s;
_playerspr[_playerstate.idle][2] = spr_player_n;
_playerspr[_playerstate.idle][3] = spr_player_n;
_playerspr[_playerstate.idle][4] = spr_player_n;
_playerspr[_playerstate.idle][5] = spr_player_s;
_playerspr[_playerstate.walking][0] = spr_player_s;
_playerspr[_playerstate.walking][1] = spr_player_se;
_playerspr[_playerstate.walking][2] = spr_player_ne;
_playerspr[_playerstate.walking][3] = spr_player_n;
_playerspr[_playerstate.walking][4] = spr_player_nw;
_playerspr[_playerstate.walking][5] = spr_player_sw;
/*
_playerspr[_playerstate.idle][0]=spr_playertemp_idle_s
_playerspr[_playerstate.idle][1]=spr_playertemp_idle_sw
_playerspr[_playerstate.idle][2]=spr_playertemp_idle_nw
_playerspr[_playerstate.idle][3]=spr_playertemp_idle_n
_playerspr[_playerstate.idle][4]=spr_playertemp_idle_ne
_playerspr[_playerstate.idle][5]=spr_playertemp_idle_se
_playerspr[_playerstate.walking][0]=spr_playertemp_move_s
_playerspr[_playerstate.walking][1]=spr_playertemp_move_sw
_playerspr[_playerstate.walking][2]=spr_playertemp_move_nw
_playerspr[_playerstate.walking][3]=spr_playertemp_move_n
_playerspr[_playerstate.walking][4]=spr_playertemp_move_ne
_playerspr[_playerstate.walking][5]=spr_playertemp_move_se