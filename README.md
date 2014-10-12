###Description:

This is a simple plugin based on sv_server_graphic1 cvar. For rotate your graphics banners. Since CSGO update 1.34.3.0,1.34.4.0 added convar sv_server_graphic1 which allows the server to specify a 360x60 px image file (must be 16k or smaller) in /csgo/ that will display in the spectator view. Supports PNG transparency. Plugin changes the banners after a map change. Banners change in turn.

###Cvars:

#####sm_graphics_file
File to read the banners names from. Useful if you're running multiple servers from one installation, and want to use different banners per server.

###Note:

You must remove sv_server_graphic1 cvar from your server configs.

By default the plugin reads the banners names from configs/graphics.txt, which has this format:
```javascript
"Graphics"
{
	"1"
	{
    	"file" "banner.png"
    }
}
```
