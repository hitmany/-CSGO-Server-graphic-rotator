#define PL_VERSION "0.4"

bool cvar_bBannersRandom;
Handle listBannersFile, g_hGraphicCvar, g_hRandomCvar;

public Plugin:myinfo =
{
    name = "Rotate server graphic banners",
    author = "HiTmAnY",
    description = "Rotates sv_server_graphic1 banners",
    version = PL_VERSION,
    url = "http://hitmany.net"
};

public void OnPluginStart()
{
    listBannersFile = CreateConVar("sm_graphics_file", "graphics.txt", "File to read the banners from.");
    g_hRandomCvar = CreateConVar("sm_graphics_random", "0", "Banners are changing in turns or randomly?\n0 - by rotation.");
    HookConVarChange(g_hRandomCvar, hookRandomCvarChange);
    cvar_bBannersRandom = GetConVarBool(g_hRandomCvar);
    g_hGraphicCvar = FindConVar("sv_server_graphic1");

    CreateConVar("graphicrotator_version", PL_VERSION, "Plugin version", FCVAR_PLUGIN | FCVAR_NOTIFY | FCVAR_DONTRECORD);
}

public void OnMapEnd()
{
    char sPath[PLATFORM_MAX_PATH], sFile[PLATFORM_MAX_PATH];

    GetConVarString(listBannersFile, sFile, sizeof(sFile));
    BuildPath(Path_SM, sPath, sizeof(sPath), "configs/%s", sFile);

    if (FileExists(sPath))
    {
        Handle h;
        if (FileToKeyValues(h = CreateKeyValues("Graphics"), sPath))
        {
            int amount_of_banners = KvGotoFirstSubKey(h);
            while (KvGotoNextKey(h))
                amount_of_banners++;

            if (amount_of_banners != 1)
            {
                CloseHandle(h);
                static current_banner;
                if (cvar_bBannersRandom)
                    current_banner = GetRandomInt(1, amount_of_banners);
                else if (++current_banner > amount_of_banners)
                    current_banner = 1;
                FileToKeyValues(h = CreateKeyValues("Graphics"), sPath);
                format(sPath, sizeof(sPath), "%03d", current_banner);
                KvJumpToKey(h, sPath);
            }

            KvGetString(h, "file", sPath, PLATFORM_MAX_PATH);
            SetConVarString(g_hGraphicCvar, sPath);

            CloseHandle(h);
        }
        else
        {
            LogError("Failed to load %s!", sPath);
        }
    }
    else
    {
        LogError("File not found: %s!", sPath);
    }
}

public void hookRandomCvarChange(Handle convar, const char[] oldValue, const char[] newValue)
{
    cvar_bBannersRandom = GetConVarBool(convar);
}
