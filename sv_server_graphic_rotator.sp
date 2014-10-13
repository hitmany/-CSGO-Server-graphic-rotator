#include <sourcemod>

#define PL_VERSION    "0.1"

public Plugin:myinfo = 
{
    name = "Rotate server graphic banners",
    author = "HiTmAnY",
    description = "Rotates sv_server_graphic1 banners",
    version = PL_VERSION,
	url         = "http://hitmany.net"
};

new Handle:g_hBanners  = INVALID_HANDLE;
new Handle:g_hFile;
new current_banner = 0;
new amount_of_banners = 0;

public OnPluginStart()
{
	g_hFile = CreateConVar("sm_graphics_file",     "graphics.txt", "File to read the banners from.");
}

public OnMapEnd()
{
	current_banner++;
	if (current_banner > amount_of_banners)
	{
		current_banner = 1;
	}
	ParseBanners();
}

ParseBanners()
{

	new banner_foreach = 1;
	new String:bannerFile[64];
	if (g_hBanners)
		CloseHandle(g_hBanners);
	
	g_hBanners = CreateKeyValues("Graphics");
	
	decl String:sFile[256], String:sPath[256];
	GetConVarString(g_hFile, sFile, sizeof(sFile));
	BuildPath(Path_SM, sPath, sizeof(sPath), "configs/%s", sFile);
	
	if (!FileExists(sPath))
		SetFailState("File Not Found: %s", sPath);
	
	FileToKeyValues(g_hBanners, sPath);
	KvGotoFirstSubKey(g_hBanners);
	
	do
	{		
		if (current_banner == banner_foreach)
		{
			KvGetString(g_hBanners, "file", bannerFile, sizeof(bannerFile));
		}
		banner_foreach++;
	}
	while (KvGotoNextKey(g_hBanners));
	
	amount_of_banners = banner_foreach;
	ServerCommand("sv_server_graphic1 %s", bannerFile); 
}
