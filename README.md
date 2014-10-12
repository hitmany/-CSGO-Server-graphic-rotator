[SIZE="3"][B]Description:[/B][/SIZE]

This is a simple plugin based on sv_server_graphic1 cvar. For rotate your graphics banners.
Since CSGO update 1.34.3.0,1.34.4.0 added convar sv_server_graphic1 which allows the server to specify a 360x60 px image file (must be 16k or smaller) in /csgo/ that will display in the spectator view. Supports PNG transparency. 
Plugin changes the banners after a map change. Banners change in turn.

[SIZE="3"][B]Cvars:[/B][/SIZE]

[B]sm_graphics_file[/B] (def "graphics.txt")
File to read the banners names from. Useful if you're running multiple servers from one installation, and want to use different banners per server.

[SIZE="3"][B]Note:[/B][/SIZE]

You must remove sv_server_graphic1 cvar from your server configs.

By default the plugin reads the banners names from configs/graphics.txt, which has this format:
[CODE]
"Graphics"
{
	"1"
	{
		"file"		"banner.png"
	}
}
[/CODE]
