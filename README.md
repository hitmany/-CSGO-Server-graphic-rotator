###Description:

This is a simple plugin based on sv_server_graphic1 cvar. For rotating your graphics banners.
Since CSGO update 1.34.3.0,1.34.4.0 added convar sv_server_graphic1 which allows the server to specify a 360x60 px image file (must be 16k or smaller) in /csgo/ that will be displayed in the spectator view. Supports PNG transparency. 
Plugin changes the banners after a map change. Banners change in turns.

[Screenshot. What is the graphics banners?](http://steamcommunity.com/id/hitmany/screenshot/38603820179363848)

###Cvars:

#####sm_graphics_file 
Default "graphics.txt".
File to read the banners names from. Useful if you're running multiple servers from one installation, and want to use different banners per server.

#####sm_graphics_random
Default "0".
Banners are changing in turns or randomly? 0 - by rotation, 1 - randomly.

###Note:

You must remove sv_server_graphic1 cvar from your server configs.
Plugin enables the banner after **first** map change.

By default the plugin reads the banners names from **configs/graphics.txt**, which has this format:
```javascript
"Graphics"
{
	"1"
	{
		"file"		"banner.png"
	}
	"2"
	{
		"file"		"steamgroup.png"
	}
}
```
