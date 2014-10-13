#include <sourcemod>

#define PL_VERSION    "0.2"

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
new Handle:g_hRandomBanner;

new current_banner = 0;
new amount_of_banners;
new String:bannerFile[64];

public OnPluginStart()
{
	g_hFile = 		  CreateConVar("sm_graphics_file",     "graphics.txt", "File to read the banners from.");
	g_hRandomBanner = CreateConVar("sm_graphics_random",   "0", "Banners are changing in turns or randomly? (0 - by rotation)");
}

public OnMapEnd()
{
	countBanners();
	
	if (GetConVarBool(g_hRandomBanner))
	{
		current_banner = GetRandomInt(1, amount_of_banners);
	}
	else
	{
		if (current_banner > amount_of_banners)
		{
			current_banner = 1;
		}
		
		current_banner++;
	}
	
	ParseBanners();
}

countBanners()
{
	amount_of_banners = 0;
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
		amount_of_banners++;
	}
	while (KvGotoNextKey(g_hBanners));
}

ParseBanners()
{

	new banner_foreach = 1;
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
