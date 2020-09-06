-- advanced-ztk

-------------------------------------- Print

print("StrixLua has been successfully loaded")

------------------------------------ Auto Update

local CURRENTVERSION = "1.3"
local LATESTVERSION = http.Get("https://raw.githubusercontent.com/ztkomaisbrabo/ztkhvh/master/AdvancedZtk.lua)
local function Update() 
    if CURRENTVERSION ~= LATESTVERSION then
        currentScript = file.Open(GetScriptName(), "w")
        currentScript:Write(http.Get("https://raw.githubusercontent.com/ztkomaisbrabo/ztkhvh/master/version"))
        currentScript:Close()
        LoadScript(GetScriptName())
    end
end
------------------------------------ Gui buttons etc

local StrixLua_TAB = gui.Tab(gui.Reference("Settings"), "strix.1", "Advanced-Ztk")


local StrixUpdate_TAB = gui.Tab(gui.Reference("Settings"), "strix.2", "Ztk-Update")

-------------- Update 1

local StrixLua_UPDATER_GBOX = gui.Groupbox(StrixUpdate_TAB, "Updater", 10, 10, 160, 0)


local StrixLua_CHANGELOG_GBOX = gui.Groupbox(StrixUpdate_TAB, "Changelog", 190, 10, 290, 0)

--------------------------------- Update versions


local StrixLua_CURRENTVERSION = gui.Text(StrixLua_UPDATER_GBOX, "Current version: v" .. CURRENTVERSION)

local StrixLua_LATESTVERSION = gui.Text(StrixLua_UPDATER_GBOX, "Latest version: v" .. LATESTVERSION)

local StrixLua_UPDATE = gui.Button(StrixLua_UPDATER_GBOX, "Update", Update)

local StrixLua_CHANGELOG_TEXT = gui.Text(StrixLua_CHANGELOG_GBOX, http.Get("https://raw.githubusercontent.com/ztkomaisbrabo/ztkhvh/master/changelog"))























-- main rage





local ref = gui.Reference("Ragebot");
local tab = gui.Tab(ref,"Extra","Extra")
local group = gui.Groupbox(tab,"Anti-Aim",16,16,296,300)
local group = gui.Groupbox(tab,"Manual Anti-Aim",325,16,296,300)


local gui_gref = gui.Reference("Ragebot", "Accuracy", "Weapon")
local gui_dtap = gui.Checkbox(gui_gref, "lua.dtap", "DoubleTap Fix", 0)
gui_dtap:SetDescription("Increases double tap accuracy and consistency");

local gui_gref = gui.Reference("Ragebot", "Extra", "Anti-Aim")
local gui_shotswitch = gui.Checkbox(gui_gref, "lua.shotswitch", "Switch Desync", 0)
gui_shotswitch:SetDescription("Change the side of desync after shooting");



























-- main misc

local ref = gui.Reference("Misc");
local tab = gui.Tab(ref,"Extra","Extra")

local group = gui.Groupbox(tab,"Miscellaneous",16,16,296,300)
local group = gui.Groupbox(tab,"Quick Switch's",17,226,296,300)
local group = gui.Groupbox(tab,"Troll",16,398,296,300)

local GROUP = gui.Groupbox(gui.Reference("Misc", "Enhancement"), "Auto-Buy", 328, 310, 299, 400);







-- main visuals






local ref = gui.Reference("Visuals");
local tab = gui.Tab(ref,"Extra","Extra")
local group = gui.Groupbox(tab,"Pulsation Colors",16,16,296,300)
local group = gui.Groupbox(tab,"Miscellaneous",325,16,296,300)
















-- ztk misc

local cache = {shot, dtap}

local function switch(var)
    if var == 1 then
        return 2
    else
        return 1
    end
end



callbacks.Register("Draw", function()
    if cache.shot then
        gui.SetValue("rbot.antiaim.fakeyawstyle", switch(gui.GetValue("rbot.antiaim.fakeyawstyle")))
        cache.shot = false
    end
end)

callbacks.Register("CreateMove", function(cmd)
    if cache.dtap then
        cmd.sidemove = 0
        cmd.forwardmove = 0
        cache.dtap = false
    end
end)




callbacks.Register("FireGameEvent", function(event)
if not entities.GetLocalPlayer() then return end
    if ( event:GetName() == 'weapon_fire' ) then

        local lp = client.GetLocalPlayerIndex()
        local int_shooter = event:GetInt('userid')
        local index_shooter = client.GetPlayerIndexByUserID(int_shooter)

        if ( index_shooter == lp) then
            if gui_shotswitch:GetValue() then
                cache.shot = true
            end
            if gui_dtap:GetValue() then
                cache.dtap = true
            end
        end
    end
end)






















-- manual anti-aim
local get_local = entities.GetLocalPlayer
local gui_set = gui.SetValue
local gui_get = gui.GetValue
local left_key = 0
local back_key = 0
local right_key = 0
local up_key = 0
local rage_ref = gui.Reference("Ragebot", "Extra", "Manual Anti-Aim")
local check_indicator = gui.Checkbox(rage_ref, "manual", "Enable", false)
local manual_left = gui.Keybox(rage_ref, "manual_left", "Left", 0)
local manual_right = gui.Keybox(rage_ref, "manual_right", "Right", 0)
local manual_back = gui.Keybox(rage_ref, "manual_back", "Back", 0)
local manual_up = gui.Keybox(rage_ref, "manual_up", "Front", 0)

local text_font = draw.CreateFont("Verdana", 20, 700)
local arrow_font = draw.CreateFont("Marlett", 35, 700)

local function main()
  if manual_left:GetValue() ~= 0 then
    if input.IsButtonPressed(manual_left:GetValue()) then
      left_key = left_key + 1
      back_key = 0
      right_key = 0
      up_key = 0
    end
  end

  if manual_back:GetValue() ~= 0 then
    if input.IsButtonPressed(manual_back:GetValue()) then
      back_key = back_key + 1
      left_key = 0
      right_key = 0
      up_key = 0
    end
  end

  if manual_right:GetValue() ~= 0 then
    if input.IsButtonPressed(manual_right:GetValue()) then
      right_key = right_key + 1
      left_key = 0
      back_key = 0
      up_key = 0
    end
  end

  if manual_up:GetValue() ~= 0 then
    if input.IsButtonPressed(manual_up:GetValue()) then
      up_key = up_key + 1
      left_key = 0
      back_key = 0
      right_key = 0
    end
  end
end

function CountCheck()
  if (left_key == 1) then
    back_key = 0
    right_key = 0
    up_key = 0
  elseif (back_key == 1) then
    left_key = 0
    right_key = 0
    up_key = 0
  elseif (right_key == 1)  then
    left_key = 0
    back_key = 0
    up_key = 0
  elseif (up_key == 1) then
    left_key = 0
    back_key = 0
    right_key = 0
  elseif (left_key == 2) then
    left_key = 0
    back_key = 0
    right_key = 0
    up_key = 0
  elseif (back_key == 2) then
    left_key = 0
    back_key = 0
    right_key = 0
    up_key = 0
  elseif (right_key == 2) then
    left_key = 0
    back_key = 0
    right_key = 0
    up_key = 0
  elseif (up_key == 2) then
    left_key = 0
    back_key = 0
    right_key = 0
    up_key = 0
  end
end

function SetLeft()
  gui_set("rbot.antiaim.yaw", 90)
end

function SetBack()
  gui_set("rbot.antiaim.yaw", 180)
end

function SetRight()
  gui_set("rbot.antiaim.yaw", -90)
end

function SetUp()
  gui_set("rbot.antiaim.yaw", 0)
end

function SetAuto()
  gui_set("rbot.antiaim.yaw", 180)
end

function draw_indicator()
  local active = check_indicator:GetValue()
  if active then
    local w, h = draw.GetScreenSize()
    if (left_key == 1) then
      SetLeft()
      draw.Color(85, 127, 177, 255)
      draw.SetFont(arrow_font)
      draw.TextShadow( w/2 - 60, h/2 - 16, "3")
    elseif (back_key == 1) then
      SetBack()
      draw.Color(85, 127, 177, 255)
      draw.SetFont(arrow_font)
      draw.TextShadow( w/2 - 17, h/2 + 33, "6")
    elseif (right_key == 1) then
      SetRight()
      draw.Color(85, 127, 177, 255)
      draw.SetFont(arrow_font)
      draw.TextShadow( w/2 + 30, h/2 - 16, "4")
    elseif (up_key == 1) then
      SetUp()
      draw.Color(85, 127, 177, 255)
      draw.SetFont(arrow_font)
      draw.TextShadow( w/2 - 17, h/2 + -66, "5")
    elseif ((left_key == 0) and (back_key == 0) and (right_key == 0) and (up_key == 0)) then
      SetAuto()
      draw.Color(85, 127, 177, 255)
      draw.SetFont(text_font)
      draw.TextShadow(15, h - 560, "freestand")
    end
  end
end

callbacks.Register("Draw", "main", main)
callbacks.Register("Draw", "CountCheck", CountCheck)
callbacks.Register("Draw", "draw_indicator", draw_indicator)






























-- Normal Freestand 

local YawJitter = 1
local aaRef = gui.Reference("Ragebot", "Extra", "Anti-Aim")
local aaIndicator = gui.Checkbox(aaRef, YawJitter, "Normal Freestand", false)

aaIndicator:SetDescription("No use with manual anti-aim and inverter");
function YawSwitch()
  local JitterActive = aaIndicator:GetValue()
  if JitterActive then
    if (YawJitter == 1) then
      gui.SetValue("rbot.antiaim.pitchstyle", 1)
      gui.SetValue("rbot.antiaim.yawstyle", 1)
      gui.SetValue("rbot.antiaim.yaw", -160)
      gui.SetValue("rbot.antiaim.lbyextend", true)
      gui.SetValue("rbot.antiaim.desync", 44)
      YawJitter = 2
    elseif (YawJitter == 2) then
      gui.SetValue("rbot.antiaim.fakeyawstyle", 1)
      gui.SetValue("rbot.antiaim.lbyextend", false)
      gui.SetValue("rbot.antiaim.desync", 58)
      YawJitter = 1
    end
  end
end

callbacks.Register("Draw", YawSwitch)



























-- Minimum Freestand Jittery

local YawJitter = 1
local aaRef = gui.Reference("Ragebot", "Extra", "Anti-Aim")
local aaIndicator = gui.Checkbox(aaRef, YawJitter, "Minimum Freestand Jittery", false)




aaIndicator:SetDescription("No use with manual anti-aim");


function YawSwitch()
  local JitterActive = aaIndicator:GetValue()
  if JitterActive then
    if (YawJitter == 1) then
      gui.SetValue("rbot.antiaim.fakeyawstyle", 1)
      gui.SetValue("rbot.antiaim.yaw", -160)
      gui.SetValue("misc.fakelag.factor", 10)
      gui.SetValue("misc.fakelag.type", 0)
      gui.SetValue("rbot.antiaim.pitchstyle", 1)
      gui.SetValue("rbot.antiaim.lbyextend", false)

      gui.SetValue("rbot.antiaim.desync", 44)

      YawJitter = 2
    elseif (YawJitter == 2) then
      gui.SetValue("rbot.antiaim.fakeyawstyle", 2)
      gui.SetValue("rbot.antiaim.yaw", 172)
      gui.SetValue("misc.fakelag.factor", 12)
      gui.SetValue("misc.fakelag.type", 0)
      gui.SetValue("rbot.antiaim.desync", 58)
      YawJitter = 1
    end
  end
end

callbacks.Register("Draw", YawSwitch)


























-- Maximum Freestand Jittery

local YawJitter = 1
local aaRef = gui.Reference("Ragebot", "Extra", "Anti-Aim")
local aaIndicator = gui.Checkbox(aaRef, YawJitter, "Maximum Freestand Jittery", false)




aaIndicator:SetDescription("No use with manual anti-aim and inverter");


function YawSwitch()
  local JitterActive = aaIndicator:GetValue()
  if JitterActive then
    if (YawJitter == 1) then
      gui.SetValue("rbot.antiaim.fakeyawstyle", 1)
      gui.SetValue("rbot.antiaim.yaw", -167)
      gui.SetValue("misc.fakelag.factor", 10)
      gui.SetValue("misc.fakelag.type", 0)
      gui.SetValue("rbot.antiaim.pitchstyle", 1)
      gui.SetValue("rbot.antiaim.lbyextend", true)
      gui.SetValue("rbot.antiaim.desync", 54)
      YawJitter = 2
    elseif (YawJitter == 2) then
      gui.SetValue("rbot.antiaim.fakeyawstyle", 2)
      gui.SetValue("rbot.antiaim.yaw", 177)
      gui.SetValue("misc.fakelag.factor", 12)
      gui.SetValue("misc.fakelag.type", 0)
      gui.SetValue("rbot.antiaim.desync", 58)
      YawJitter = 1
    end
  end
end

callbacks.Register("Draw", YawSwitch)





















-- Legit Anti-Aim Breaker
local YawJitter = 1
local aaRef = gui.Reference("Ragebot", "Extra", "Anti-Aim")
local aaIndicator = gui.Checkbox(aaRef, YawJitter, "Legit Anti-Aim Breaker", false)


aaIndicator:SetDescription("No use with manual anti-aim and inverter");


function YawSwitch()
  local JitterActive = aaIndicator:GetValue()
  if JitterActive then
    if (YawJitter == 1) then


      gui.SetValue("rbot.antiaim.fakeyawstyle", 1)

      gui.SetValue("rbot.antiaim.yawstyle", 1)


      gui.SetValue("rbot.antiaim.pitchstyle", 0)
      gui.SetValue("rbot.antiaim.yaw", 0)


      YawJitter = 2



    elseif (YawJitter == 2) then

      
     gui.SetValue("rbot.antiaim.fakeyawstyle", 2)




      YawJitter = 1 


    end
  end
end

callbacks.Register("Draw", YawSwitch)















































-- quick scout



local uid_to_idx = client.GetPlayerIndexByUserID;
local get_local_player = client.GetLocalPlayerIndex;
local in_action;
local equipped;
local ref = gui.Reference("Misc", "Extra", "Quick Switch's")
local quickswitch = gui.Checkbox(ref, 'lua_quick_switch', 'QuickSwitch Scout', 0);
quickswitch:SetDescription("Pull the knife after shot with scout");
local function on_weapon_fire( _event )
    if quickswitch:GetValue() then
    if ( _event:GetName( ) ~= 'weapon_fire' ) then
        return;
    end

    if (gui.GetValue("misc.fakelatency.enable")) then
        return;
    end

    local _local = get_local_player( );
    local _id = _event:GetInt('userid');

    if ( _local == uid_to_idx( _id ) ) then
        local _weapon = _event:GetString( 'weapon' );

        if ( _weapon == 'weapon_ssg08' ) then
            client.Command( 'slot3', true )
            flip = true;
        end
    end
end
end
client.AllowListener( 'weapon_fire' );
callbacks.Register( 'FireGameEvent', 'on_weapon_fire', on_weapon_fire );
local function on_item_equip( _event )
    if ( _event:GetName( ) ~= 'item_equip' ) then
        return;
    end

    local _local = get_local_player( );
    local _id = _event:GetInt( 'userid' );
    local _item =  _event:GetString( 'item' );

    if ( _local == uid_to_idx( _id ) ) then
        equipped = _item;
    end
end

client.AllowListener( 'item_equip' );
callbacks.Register( 'FireGameEvent', 'on_item_equip', on_item_equip );
function reset_tick( _cmd )
  if ( flip ) then
        if ( equipped ~= 'ssg08' ) then
            client.Command( "slot1", true )
            flip = false;
        end
    end
end

callbacks.Register( 'CreateMove', 'reset_tick', reset_tick );

































-- quick awp 


local uid_to_idx = client.GetPlayerIndexByUserID;
local get_local_player = client.GetLocalPlayerIndex;
local in_action;
local equipped;
local ref = gui.Reference("Misc", "Extra","Quick Switch's")

local quickswitch = gui.Checkbox(ref, 'lua_quick_switch', 'QuickSwitch Awp', 0);
quickswitch:SetDescription("Pull the knife after shot with awp");

local function on_weapon_fire( _event )
    if quickswitch:GetValue() then
    if ( _event:GetName( ) ~= 'weapon_fire' ) then
        return;
    end

    if (gui.GetValue("misc.fakelatency.enable")) then
        return;
    end

    local _local = get_local_player( );
    local _id = _event:GetInt('userid');

    if ( _local == uid_to_idx( _id ) ) then
        local _weapon = _event:GetString( 'weapon' );

        if ( _weapon == 'weapon_awp' ) then
            client.Command( 'slot3', true )
            flip = true;
        end
    end
end
end
client.AllowListener( 'weapon_fire' );
callbacks.Register( 'FireGameEvent', 'on_weapon_fire', on_weapon_fire );
local function on_item_equip( _event )
    if ( _event:GetName( ) ~= 'item_equip' ) then
        return;
    end

    local _local = get_local_player( );
    local _id = _event:GetInt( 'userid' );
    local _item =  _event:GetString( 'item' );

    if ( _local == uid_to_idx( _id ) ) then
        equipped = _item;
    end
end

client.AllowListener( 'item_equip' );
callbacks.Register( 'FireGameEvent', 'on_item_equip', on_item_equip );
function reset_tick( _cmd )
  if ( flip ) then
        if ( equipped ~= 'awp' ) then
            client.Command( "slot1", true )
            flip = false;
        end
    end
end
callbacks.Register( 'CreateMove', 'reset_tick', reset_tick );


























-- autobuy




local primaryWeapons = {
    { "None", nil, nil };
    { "AutoSniper", "scar20" };
    { "Scout", "ssg08" };
    { "AWP", "awp" };
    { "AUG | SG553", "aug" };
    { "AK-47 | M4A1", "ak47" };
};
local secondaryWeapons = {
    { "None", nil, nil };
    { "Dual Elites", "elite" };
    { "Desert Eagle | R8 Revolver", "deagle" };
    { "Five Seven | Tec 9", "tec9" };
    { "P250", "p250" };
};
local armors = {
    { "None", nil, nil };
    { "Kevlar Vest", "vest", nil };
    { "Kevlar Vest + Helmet", "vest", "vesthelm" };
};
local granades = {
    { "Off", nil, nil };
    { "Grenade", "hegrenade", nil };
    { "Flashbang", "flashbang", nil };
    { "Smoke Grenade", "smokegrenade", nil };
    { "Decoy Grenade", "decoy", nil };
    { "Molotov | Incindiary Grenade", "molotov", "incgrenade" };
};



local ENABLED = gui.Checkbox(GROUP, "autobuy.active", "Enable", false);
local PRIMARY_WEAPON = gui.Combobox(GROUP, "autobuy.primary", "Weapon 1", primaryWeapons[1][1], primaryWeapons[2][1], primaryWeapons[3][1], primaryWeapons[4][1], primaryWeapons[5][1], primaryWeapons[6][1]);
local SECONDARY_WEAPON = gui.Combobox(GROUP, "autobuy.secondary", "Weapon 2", secondaryWeapons[1][1], secondaryWeapons[2][1], secondaryWeapons[3][1], secondaryWeapons[4][1]);
local ARMOR = gui.Combobox(GROUP, "autobuy.armor", "Armor", armors[1][1], armors[2][1], armors[3][1]);
local GRENADE_SLOT1 = gui.Combobox(GROUP, "autobuy.grenade1", "Grenade 1", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
local GRENADE_SLOT2 = gui.Combobox(GROUP, "autobuy.grenade2", "Grenade 2", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
local GRENADE_SLOT3 = gui.Combobox(GROUP, "autobuy.grenade3", "Grenade 3", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
local GRENADE_SLOT4 = gui.Combobox(GROUP, "autobuy.grenade4", "Grenade 4", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
local TASER = gui.Checkbox(GROUP, "autobuy.taser", "Buy Zeus", true);
local DEFUSER = gui.Checkbox(GROUP, "autobuy.defuser", "Buy Defuse Kit", true);
gui.Text(GROUP, "");

local function buy(wat)
    if (wat == nil) then return end;
    if (printLogs) then
        print('Bought x1 ' .. wat);
    end;
    client.Command('buy "' .. wat .. '";', true);
end


local function buyTable(table)
    for i, j in pairs(table) do
        buy(j);
    end;
end

local function buyWeapon(selection, table)
    local selection = selection:GetValue();
    local weaponToBuy = table[selection + 1][2];
    buy(weaponToBuy);
end

local function buyGrenades(selections)
    for k, selection in pairs(selections) do
        local selection = selection:GetValue();
        local grenadeTable = granades[selection + 1];
        buyTable({ grenadeTable[2], grenadeTable[3] });
    end
end

callbacks.Register('FireGameEvent', function(e)
    if (ENABLED:GetValue() ~= true) then return end;
    local localPlayer = entities.GetLocalPlayer();
    local en = e:GetName();
    if (localPlayer == nil or en ~= "player_spawn") then return end;
    local userIndex = client.GetPlayerIndexByUserID(e:GetInt('userid'));
    local localPlayerIndex = localPlayer:GetIndex();
    if (userIndex ~= localPlayerIndex) then return end;
    buyWeapon(PRIMARY_WEAPON, primaryWeapons);
    buyWeapon(SECONDARY_WEAPON, secondaryWeapons);
    local armorSelected = ARMOR:GetValue();
    local armorTable = armors[armorSelected + 1];
    buyTable({ armorTable[2], armorTable[3] });
    if (DEFUSER:GetValue()) then
        buy('defuser');
    end
    if (TASER:GetValue()) then
        buy('taser');
    end
    buyGrenades({ GRENADE_SLOT1, GRENADE_SLOT2, GRENADE_SLOT3, GRENADE_SLOT4 });
end);

client.AllowListener("player_spawn");
























-- semirage




local TAB= gui.Reference("Misc", "Extra")
local GROUPBOX_MAIN=gui.Groupbox(TAB, "Semirage", 325,17,304,300)
local KEYBOX_QUICKSWITCH=gui.Keybox (GROUPBOX_MAIN, "rlswitch", "Quick Switch", 0)
KEYBOX_QUICKSWITCH:SetDescription("Switches between legitbot and ragebot")
local KEYBOX_INVERTER=gui.Keybox(GROUPBOX_MAIN, "inverter", "Desync Inverter", 0)
KEYBOX_INVERTER:SetDescription("Inverter for fakeyaw in ragebot ")
local KEYBOX_AWSWITCH=gui.Keybox(GROUPBOX_MAIN, "awswitch", "AutoWall Switch", 0)
KEYBOX_AWSWITCH:SetDescription("Turn autowall on and off")
local MULTIBOX_INDICATORS=gui.Multibox(GROUPBOX_MAIN, "Indicators")
local CHECKBOX_QUICKSWITCH = gui.Checkbox(MULTIBOX_INDICATORS, "switch", "Quickswitch", 0)
local CHECKBOX_AUTOWALLSWITCH = gui.Checkbox(MULTIBOX_INDICATORS, "autowswitch", "Autowall switch", 0)
local CHECKBOX_INVERTER = gui.Checkbox(MULTIBOX_INDICATORS, "dsncinverter", "Desync inverter", 0)
local rcol=gui.ColorPicker(CHECKBOX_QUICKSWITCH, "rcol_color", "Rage Indicator", 255, 25, 25, 255)
local lcol=gui.ColorPicker(CHECKBOX_QUICKSWITCH, "lcol_color", "Legit Indicator", 124, 176, 34, 255)
local aoff=gui.ColorPicker(CHECKBOX_AUTOWALLSWITCH, "aoff_color", "AW off Indicator", 255, 25, 25, 255)
local aon=gui.ColorPicker(CHECKBOX_AUTOWALLSWITCH, "aon_color", "AW on Indicator", 124, 176, 34, 255)
local aacol=gui.ColorPicker(CHECKBOX_INVERTER, "aacol_color", "Desync side Indicator", 28, 108, 204, 255)
local Font = draw.CreateFont("Verdana", 34, 700)
local screenW, screenH = draw.GetScreenSize()
function Indicators()
    draw.SetFont(Font)
    if CHECKBOX_QUICKSWITCH:GetValue() then
        if gui.GetValue("rbot.master") then
            draw.Color(rcol:GetValue())
            draw.TextShadow(10, screenH - 500, "Rage")
        else
            draw.Color(lcol:GetValue())
            draw.TextShadow(10, screenH - 500, "Legit")
        end
    end
    if CHECKBOX_AUTOWALLSWITCH:GetValue() then
        if awtggl then
            draw.Color(aon:GetValue())
            draw.TextShadow(10, screenH - 465, "AW")
        else
            draw.Color(aoff:GetValue())
            draw.TextShadow(10, screenH - 465, "AW")
        end
    end
    if CHECKBOX_INVERTER:GetValue() then
        if invrtr then
            draw.Color(aacol:GetValue())
            draw.TextShadow(10, screenH - 430, "Left")
        else
            draw.Color(aacol:GetValue())
            draw.TextShadow(10, screenH - 430, "Right")
        end
    end
end
callbacks.Register("Draw", "semiragehelper", Indicators)
function qswitch()
    if KEYBOX_QUICKSWITCH:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_QUICKSWITCH:GetValue()) then
            rltggl = not rltggl
        end
        if rltggl then
            gui.SetValue("rbot.master", false)
            gui.SetValue("lbot.master", true)
        else
            gui.SetValue("rbot.master", true)
            gui.SetValue("lbot.master", false)
        end
    end
end    
callbacks.Register("Draw", "semiragehelper", qswitch)
function awswitch()
    if KEYBOX_AWSWITCH:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_AWSWITCH:GetValue()) then
            awtggl = not awtggl
        end
        if awtggl then   
            gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.smg.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.scout.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.asniper.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.hpistol.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.lmg.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.pistol.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.shotgun.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.smg.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.scout.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.sniper.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.rifle.autowall", 1)
        else
            gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.smg.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.scout.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.asniper.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.hpistol.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.lmg.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.pistol.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.shotgun.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.smg.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.scout.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.sniper.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.rifle.autowall", 0)
        end
    end
end
callbacks.Register("Draw", "semiragehelper", awswitch)
function finverter()
    gui.SetValue("rbot.antiaim.base", [[0, "Desync"]])
    if KEYBOX_INVERTER:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_INVERTER:GetValue()) then
            invrtr = not invrtr
        end
        if invrtr then   
            gui.SetValue("rbot.antiaim.fakeyawstyle", 1)
        else
            gui.SetValue("rbot.antiaim.fakeyawstyle", 2)
        end
    end
end
callbacks.Register("Draw", "semiragehelper", finverter)


































































-- spectator list


local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 25, 660, 0, 0, 300, 60;
local shouldDrag = false;
local font = draw.CreateFont("Ubuntu", 15, 15);
local topbarSize = 20;
local svgData = http.Get( "https://media.discordapp.net/attachments/750844957442703421/751306841677496412/actually_looks_kinda_cool.png" );
local imgRGBA, imgWidth, imgHeight = common.DecodePNG( svgData );
local texture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );
local render = {};

render.outline = function( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    draw.OutlinedRect( x, y, x + w, y + h );
end
render.rect = function( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    --draw.FilledRect( x, y, x + w, y + h );
end
render.rect2 = function( x, y, w, h )
    draw.FilledRect( x, y, x + w, y + h );
end
render.gradient = function( x, y, w, h, col1, col2, is_vertical )
    render.rect( x, y, w, h, col1 );
    local r, g, b = col2[1], col2[2], col2[3];
    if is_vertical then
        for i = 1, h do
            local a = i / h * 255;
            render.rect( x, y + i, w, 1, { r, g, b, a } );
        end
    else
        for i = 1, w do
            local a = i / w * 255;
            render.rect( x + i, y, 1, h, { r, g, b, a } );
        end
    end
end

local function getspectators()
    local spectators = {};
    local lp = entities.GetLocalPlayer();
    if lp ~= nil then
      local players = entities.FindByClass("CCSPlayer");    
        for i = 1, #players do
            local players = players[i];
            if players ~= lp and players:GetHealth() <= 0 then
                local name = players:GetName();
                if players:GetPropEntity("m_hObserverTarget") ~= nil then
                    local playerindex = players:GetIndex();
                    if name ~= "GOTV" and playerindex ~= 1 then
                        local target = players:GetPropEntity("m_hObserverTarget");
                        if target:IsPlayer() then
                            local targetindex = target:GetIndex();
                            local myindex = client.GetLocalPlayerIndex();
                            if lp:IsAlive() then
                                if targetindex == myindex then
                                    
                                    table.insert(spectators, players)
                                end
                            end
                        end
                    end
                end
            end
        end
    end 
    return spectators;
end

local function drawspectators(spectators)
    local temp = false;
    for index, players in pairs(spectators) do
        
        if (temp) then
            render.gradient( x+9, (y + topbarSize + 5) + (index * 15), 198, 1, { 13, 14, 15, 255 }, {40, 30, 30, 255 }, false );
            
        end
        temp=true;
        draw.SetFont(font);
        draw.Color(255, 255, 255, 255);
        draw.Text(x + 15, (y + topbarSize + 9) + (index * 15), players:GetName())
      
    end
end

local function drawRectFill(r, g, b, a, x, y, w, h, texture)
    if (texture ~= nil) then
        draw.SetTexture(texture);
    else
        draw.SetTexture(texture);
    end
    draw.Color(r, g, b, a);
    draw.FilledRect(x, y, x + w, y + h);
end

local function drawGradientRectFill(col1, col2, x, y, w, h)
    drawRectFill(col1[1], col1[2], col1[3], col1[4], x, y, w, h);
    local r, g, b = col2[1], col2[2], col2[3];
    for i = 1, h do
        local a = i / h * col2[4];
        drawRectFill(r, g, b, a, x + 2, y + i, w - 2, 1);
    end
end

local function dragFeature()
    if input.IsButtonDown(1) then
        mouseX, mouseY = input.GetMousePos();
        if shouldDrag then
            x = mouseX - dx;
            y = mouseY - dy;
        end
        if mouseX >= x and mouseX <= x + w and mouseY >= y and mouseY <= y + 40 then
            shouldDrag = true;
            dx = mouseX - x;
            dy = mouseY - y;
        end
    else
        shouldDrag = false;
    end
end

local function drawOutline(r, g, b, a, x, y, w, h, howMany)
    for i = 1, howMany do
        draw.Color(r, g, b, a);
        draw.OutlinedRect(x - i, y - i, x + w + i, y + h + i);
    end
end

local function drawWindow(Keybinds)
    local tW, _ = draw.GetTextSize(keytext);
    local h2 = 5 + (Keybinds * 15);
    local h = h + (Keybinds * 15);
    
    drawRectFill(13, 14, 15, 250, x + 7, y + 20, 202, 20);

    draw.Color(255, 255, 255);
    draw.SetFont(font);
    local keytext = 'Spectators';
    
    draw.Text(x + ((55 - tW) / 2), y + 25, keytext)
    
    drawRectFill(25, 28, 31, 250, x + 7, y + 40, 200, h2);
    drawOutline(25, 28, 31, 255, x + 9, y + 40, 198, h2, 2);
    
    draw.Color(255, 255, 255);
    draw.SetTexture( texture );
    draw.FilledRect( x+10, y+22, x+25, y+37 );
    draw.SetTexture( texture );
    
end

callbacks.Register("Draw", function()
    if speclist:GetValue() == false then return end
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end

    draw.SetTexture( texture );
    local spectators = getspectators();
    drawWindow(#spectators);

    drawspectators(spectators);
    dragFeature();
end)
------------------------------------------------------------
--DrawUI
------------------------------------------------------------
function DrawUI()
speclist = gui.Checkbox(gui.Reference("Misc","Extra","Miscellaneous"),"speclist","Spectator List",0);
speclist:SetDescription("Shows a list of players watching you"); 
end
DrawUI();








local iLastTick = 0

callbacks.Register( "Draw", function()
    if globals.TickCount() > iLastTick then
        local playerList = entities.FindByClass( "CCSPlayer" )
        for i = 1, #playerList do
            if playerList[i]:GetPropEntity("m_hObserverTarget"):GetIndex() == entities.GetLocalPlayer():GetIndex() then
                gui.SetValue( "misc.Extra.speclist", true )
                return
            end
        end
        gui.SetValue( "misc.Extra.speclist", false )
    end
    iLastTick = globals.TickCount()
end )








-- FakeDuck Animation



local getLocal = function() return entities.GetLocalPlayer() end
local ref = gui.Reference("Visuals", "Extra", "Miscellaneous");
local whyamiwastingmytime = gui.Checkbox( ref, fuckmyass, "Fakeduck Animation", false )
whyamiwastingmytime:SetDescription("Show fakeduck animation in your hand");
local viewmodelZ = (client.GetConVar("viewmodel_offset_z"));
function yourmumsahoe()
if whyamiwastingmytime:GetValue() then
if getLocal() then
if getLocal():IsAlive() then
local shitthisisboring = gui.GetValue('rbot.antiaim.extra.fakecrouchkey')
local andsofuckinguseless = input.IsButtonDown( shitthisisboring )                                            
local yourmum = entities.GetLocalPlayer();
local tbagmodeengaged = yourmum:GetProp('m_flDuckAmount')            
if  andsofuckinguseless == true then
client.SetConVar("viewmodel_offset_z", viewmodelZ - (tbagmodeengaged*8), true)
else client.SetConVar("viewmodel_offset_z", viewmodelZ, true)
end end end end end                        
callbacks.Register("Draw", yourmumsahoe)















--HL Speed Indicator--
--by arpac - https://aimware.net/forum/thread-93805.html--
local ref_speed = gui.Reference("Visuals", "Extra", "Miscellaneous")
local speed_check = gui.Checkbox(ref_speed, "hl2.speed.indicator", "Speed Counter", false)
speed_check:SetDescription("Show your velocity");
 
local curspeed_color = gui.ColorPicker(speed_check, "hl2.speed.ind.color", 255,255,255,255)
local speed = 0
local last_onground_speed = 0
local last_flags = 0;

local fade_time = 0;
local old_onground_speed = 0;

    function testflag(set, flag)
      return set % (2*flag) >= flag
    end
    
function paint_traverse()
if speed_check:GetValue() then
   local x, y = draw.GetScreenSize()
   local centerX = x / 2
     if entities.FindByClass( "CBasePlayer" )[1] ~= nil then
    end;

    local font = draw.CreateFont( "Verdana", 30 );
  
   draw.SetFont( font );



   if entities.GetLocalPlayer() ~= nil then

       local Entity = entities.GetLocalPlayer();
       local Alive = Entity:IsAlive();
       local velocityX = Entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
       local velocityY = Entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
      
       local flags = Entity:GetPropInt( "m_fFlags" );
      
      
       local velocity = math.sqrt( velocityX^2 + velocityY^2 );
       local FinalVelocity = math.min( 9999, velocity ) + 0.2;
       if ( Alive == true ) then
         speed= math.floor(FinalVelocity) ;
        
        
       if(testflag(flags, 1) and not testflag(last_flags, 1)) then
       old_onground_speed = last_onground_speed;
       last_onground_speed = speed
       fade_time = 1;
       end
       last_flags = flags;
        
       else
         speed=0;
         last_onground_speed = 0;
       end
   end
    rw,rh =draw.GetTextSize(speed)
    
    if(fade_time > globals.FrameTime()) then
        fade_time = fade_time - globals.FrameTime();
    end
    
    local speed_delta = last_onground_speed - old_onground_speed;
    
    draw.Color(curspeed_color:GetValue());
    draw.Text(centerX -(rw/2), y - 170, speed);
    
    local r = 255;
    local g = 255;
    local b = 255;
    
    if(speed_delta > 0 and fade_time > 0.5) then
        r = 30
        g = 220
        b = 30
    end
    
    if(speed_delta < 0 and fade_time > 0.5) then
        r = 220
        g = 30
        b = 30
    end
    
    
    
    rw2,rh2 =draw.GetTextSize(last_onground_speed)
    draw.Color( r, g, b, 220 );
    draw.Text(centerX -(rw2/2), y - 200, last_onground_speed)

end
end

callbacks.Register("Draw", "paint_traverse", paint_traverse)
--End - HL Speed Indicator--
--End - LUA--


























-- Fake-lag valve

local YawJitter = 1
local aaRef = gui.Reference("Misc", "Enhancement", "Fakelag")
local aaIndicator = gui.Checkbox(aaRef, YawJitter, "Minimum Fakelag", false)

aaIndicator:SetDescription("Fakelag for valve matchmaking");
function YawSwitch()
  local JitterActive = aaIndicator:GetValue()
  if JitterActive then
    if (YawJitter == 1) then
      gui.SetValue("misc.fakelag.factor", 3)

      gui.SetValue("misc.fakelag.type", 1)

      YawJitter = 2
    elseif (YawJitter == 2) then
      gui.SetValue("misc.fakelag.factor", 5)

      gui.SetValue("misc.fakelag.type", 1)


      YawJitter = 1
    end
  end
end

callbacks.Register("Draw", YawSwitch)







-- chams 





local cb = gui.Checkbox( gui.Reference( "Visuals", "Extra", "Pulsation Colors" ), "esp.chams.ghost.pulsating.visible", "Pulsating Ghost", 0)
callbacks.Register( 'Draw', function()
if not cb:GetValue() then return end
local r, g, b = gui.GetValue("esp.chams.ghost.visible.clr")
local o = math.floor(math.sin((globals.RealTime()) * 6) * 68 + 112) - 40
gui.SetValue("esp.chams.ghost.visible.clr", r, g, b, o)
end)




local cb = gui.Checkbox( gui.Reference( "Visuals", "Extra", "Pulsation Colors" ), "esp.chams.ghost.pulsating.aaa", "Pulsating Arms", 0)
callbacks.Register( 'Draw', function()
if not cb:GetValue() then return end
local r, g, b = gui.GetValue("esp.chams.localarms.visible.clr")
local o = math.floor(math.sin((globals.RealTime()) * 6) * 68 + 112) - 40
gui.SetValue("esp.chams.localarms.visible.clr", r, g, b, o)
end)



local cb = gui.Checkbox( gui.Reference( "Visuals", "Extra", "Pulsation Colors" ), "esp.chams.ghost.pulsating.aaaaa", "Pulsating Weapon", 0)
callbacks.Register( 'Draw', function()
if not cb:GetValue() then return end
local r, g, b = gui.GetValue("esp.chams.localweapon.visible.clr")
local o = math.floor(math.sin((globals.RealTime()) * 6) * 68 + 112) - 40
gui.SetValue("esp.chams.localweapon.visible.clr", r, g, b, o)
end)




local cb = gui.Checkbox( gui.Reference( "Visuals", "Extra", "Pulsation Colors" ), "esp.chams.ghost.pulsating.aaaaa", "Pulsating Skeleton", 0)
callbacks.Register( 'Draw', function()
if not cb:GetValue() then return end
local r, g, b = gui.GetValue("esp.overlay.enemy.skeleton.clr")
local o = math.floor(math.sin((globals.RealTime()) * 6) * 68 + 112) - 40
gui.SetValue("esp.overlay.enemy.skeleton.clr", r, g, b, o)
end)



























-- legit visuals


--Recoil Crosshair by Cheeseot
local ButtonPosition = gui.Reference( "Visuals", "Extra", "Miscellaneous" );
local PunchCheckbox = gui.Checkbox( ButtonPosition, "lua_recoilcrosshair", "Recoil Crosshair", 0);
PunchCheckbox:SetDescription("Show your recoil, dont work with ragebot")
local recoilcolor = gui.ColorPicker(PunchCheckbox, "recoilcolor", "Recoil Crosshair Color", 255,255,255,255)


local function punch()

local rifle = 0;
local me = entities.GetLocalPlayer();
if me ~= nil and not gui.GetValue("rbot.master") then
    if me:IsAlive() then
    local scoped = me:GetProp("m_bIsScoped");
    if scoped == 256 then scoped = 0 end
    if scoped == 257 then scoped = 1 end
    local my_weapon = me:GetPropEntity("m_hActiveWeapon");
    if my_weapon ~=nil then
        local weapon_name = my_weapon:GetClass();
        local canDraw = 0;
        local snipercrosshair = 0;
        weapon_name = string.gsub(weapon_name, "CWeapon", "");
        if weapon_name == "Aug" or weapon_name == "SG556" then
            rifle = 1;
            else
            rifle = 0;
            end

        if scoped == 0 or (scoped == 1 and rifle == 1) then
            canDraw = 1;
            else
            canDraw = 0;
            end

        if weapon_name == "Taser" or weapon_name == "CKnife" then
            canDraw = 0;
            end

        if weapon_name == "AWP" or weapon_name == "SCAR20" or weapon_name == "G3SG1"  or weapon_name == "SSG08" then
            snipercrosshair = 1;
            end

    --Recoil Crosshair by Cheeseot

        if PunchCheckbox:GetValue() and canDraw == 1 then
            local punchAngleVec = me:GetPropVector("localdata", "m_Local", "m_aimPunchAngle");
            local punchAngleX, punchAngleY = punchAngleVec.x, punchAngleVec.y
            local w, h = draw.GetScreenSize();
            local x = w / 2;
            local y = h / 2;
            local fov = 90 --gui.GetValue("vis_view_fov");      polak pls add this back

            if fov == 0 then
                fov = 90;
                end
            if scoped == 1 and rifle == 1 then
                fov = 45;
                end
            
            local dx = w / fov;
            local dy = h / fov;
			
			local px = 0
			local py = 0
			
            if gui.GetValue("esp.other.norecoil") then
				px = x - (dx * punchAngleY)*1.2;
				py = y + (dy * punchAngleX)*2;
            else
				px = x - (dx * punchAngleY)*0.6;
				py = y + (dy * punchAngleX);
			end
            
            if px > x-0.5 and px < x then px = x end
            if px < x+0.5 and px > x then px = x end
            if py > y-0.5 and py < y then py = y end
            if py < y+0.5 and py > y then py = y end

			if IdleCheckbox:GetValue() then
            if px == x and py == y and snipercrosshair ~=1 then return; end
			end
				
            draw.Color(recoilcolor:GetValue());
            draw.FilledRect(px-3, py-1, px+3, py+1);
            draw.FilledRect(px-1, py-3, px+1, py+3);
            end
        end
    end
    end
end
callbacks.Register("Draw", "punch", punch);





-- defuse kit esp 
local iconData = [[<svg width="40" height="40">
  <title>Layer 1</title>
  <path fill="#ffffff" id="svg_1" d="m34.904,18.621c-0.307,0.154 -0.652,0.336 -1.016,0.288c-0.521,-0.071 -1.125,-0.601 -1.543,-0.858
  c-1.645,-1.011 -3.383,-1.828 -5.275,-2.246c-1.084,-0.239 -2.053,-0.188 -3.148,-0.146c-1.41,0.054 -2.785,0.381 -4.193,0.472
  c-0.803,0.052 -1.406,0.069 -2.143,-0.233c-0.271,-0.111 -0.557,-0.192 -0.834,-0.285c-0.176,-0.059 -0.334,-0.197 -0.438,-0.024
  c-0.107,0.178 -0.189,0.362 -0.35,0.494c-0.275,0.229 -0.34,0.193 -0.152,0.489c0.143,0.226 0.277,0.458 0.428,0.678
  c0.197,0.288 0.848,0.861 0.848,1.203c0,0.25 0.939,0.824 1.137,0.988c0.098,0.081 0.295,0.007 0.152,0.221c-0.051,0.077 -0.211,0.295 -0.326,0.238
  c-0.238,-0.12 -0.443,-0.29 -0.66,-0.448c0.154,0.643 0.371,1.3 0.453,1.956c0.127,0.998 0.213,1.997 0.482,2.969c0.5,1.806 1.383,3.528 2.639,4.925
  c0.594,0.657 1.262,1.241 1.982,1.756c0.311,0.222 0.99,0.563 1.027,1.006c0.027,0.299 0.053,0.66 -0.078,0.942c-0.066,0.139 -0.24,0.228 -0.283,0.378
  c-0.074,0.276 -0.045,0.32 -0.316,0.4c-0.174,0.051 -0.377,0.182 -0.543,0.211c-0.313,0.056 -0.619,-0.189 -0.867,-0.337c-0.768,-0.459 -1.496,-0.994 -2.176,-1.573
  c-2.447,-2.084 -4.336,-5.148 -4.676,-8.382c-0.156,-1.479 -0.352,-2.938 -0.535,-4.411c-0.035,-0.29 -0.281,-0.396 -0.428,-0.636
  c-0.213,-0.352 -0.406,-0.728 -0.645,-1.063c-0.371,-0.522 -0.881,-1.325 -1.467,-1.567c-0.686,-0.282 -1.357,-0.571 -2.051,-0.83
  c-0.441,-0.164 -0.797,-0.557 -1.156,-0.851c-1.475,-1.204 -2.945,-2.406 -4.416,-3.608c-0.144,-0.122 -0.226,-0.208 -0.337,-0.363
  c0.008,0.011 0.133,-0.389 0.182,-0.437c0.102,-0.103 0.262,-0.089 0.385,-0.043c0.732,0.281 1.465,0.562 2.197,0.841c0.959,0.367 1.92,0.735 2.879,1.103
  c0.688,0.263 0.863,0.254 0.947,1.024c0.045,0.4 0.637,0.374 0.871,0.117c0.041,-0.046 0.098,-0.299 0.166,-0.389c0.156,-0.204 0.311,-0.407 0.465,-0.611
  c0.266,-0.35 -0.133,-0.499 -0.41,-0.406c-0.27,0.09 -0.486,-0.012 -0.648,-0.225c-1.098,-1.45 -2.193,-2.9 -3.291,-4.35c-0.143,-0.188 -0.286,-0.376 -0.429,-0.564
  c-0.32,-0.423 0.207,-0.434 0.45,-0.434c0.123,0 0.287,0.174 0.383,0.24c0.353,0.247 0.708,0.495 1.062,0.742c0.871,0.607 1.742,1.216 2.613,1.825
  c0.281,0.195 0.561,0.39 0.84,0.585c0.09,0.063 0.395,0.135 0.42,0.171c0.459,0.638 0.918,1.276 1.373,1.916c0.199,0.278 0.412,0.517 0.646,0.767
  c0.164,0.177 0.707,0.226 0.959,0.303c0.717,0.214 1.432,0.421 2.166,0.558c0.705,0.132 1.523,-0.069 2.234,-0.128c1.404,-0.117 2.828,-0.108 4.234,-0.163
  c1.104,-0.042 2.324,-0.045 3.395,0.236c0.592,0.156 1.238,0.245 1.783,0.537c0.668,0.359 1.34,0.72 2.01,1.08c1.127,0.606 2.168,1.482 3.227,2.206
  c0.405,0.406 0.401,1.444 -0.205,1.746zm-15.109,-0.391c-0.203,-0.409 -0.369,-0.417 -0.801,-0.586c-0.262,-0.102 -0.668,-0.376 -0.961,-0.261
  c-0.301,0 -0.104,0.465 0.084,0.512c0.221,0.056 0.441,0.11 0.662,0.166c0.231,0.057 0.795,0.316 1.016,0.169zm-2.184,-0.219
  c-0.227,-0.076 -0.297,0.201 -0.146,0.352c0.264,0.264 0.799,0.448 1.125,0.638c0.189,0.111 0.709,0.315 0.563,-0.16c-0.361,-0.208 -0.727,-0.409 -1.092,-0.613
  c-0.151,-0.085 -0.286,-0.163 -0.45,-0.217zm2.659,-1.034c-0.137,-0.104 -0.322,-0.111 -0.488,-0.139c-0.391,-0.067 -0.781,-0.134 -1.172,-0.2
  c-0.209,0 -0.248,0.542 0,0.542c0.086,0.058 0.34,0.041 0.439,0.054c0.391,0.048 0.783,0.116 1.178,0.116c0.195,0 0.119,-0.285 0.043,-0.373z"/>
</svg>]]

local outlineData = [[<svg width="40" height="40">
  <title>Layer 1</title>
  <path id="svg_1" d="m22.661,34.3c-0.317,0 -0.59,-0.174 -0.81,-0.314l-0.119,-0.074c-0.749,-0.448 -1.495,-0.987 -2.216,-1.603
  c-2.667,-2.271 -4.454,-5.478 -4.779,-8.579c-0.118,-1.118 -0.259,-2.225 -0.399,-3.335l-0.135,-1.07c-0.009,-0.077 -0.05,-0.125 -0.157,-0.236
  c-0.074,-0.077 -0.157,-0.163 -0.229,-0.281c-0.072,-0.119 -0.141,-0.24 -0.211,-0.361c-0.134,-0.233 -0.268,-0.468 -0.422,-0.685l-0.127,-0.182
  c-0.324,-0.464 -0.768,-1.1 -1.209,-1.282l-0.511,-0.212c-0.508,-0.211 -1.013,-0.421 -1.53,-0.614c-0.383,-0.142 -0.7,-0.424 -0.979,-0.673
  c-0.088,-0.078 -0.175,-0.155 -0.262,-0.227l-4.416,-3.608c-0.167,-0.136 -0.266,-0.241 -0.392,-0.416c-0.066,-0.092 -0.075,-0.214 -0.022,-0.314
  c0,-0.001 0.001,-0.002 0.001,-0.003l0.032,-0.085c0.091,-0.251 0.132,-0.353 0.204,-0.423c0.163,-0.165 0.435,-0.209 0.701,-0.109l5.25,2.009
  c0.618,0.229 0.873,0.356 0.966,1.207c0.025,0.059 0.286,0.02 0.351,-0.053c-0.022,0.021 -0.01,-0.012 0.002,-0.05c0.04,-0.113 0.08,-0.23 0.146,-0.318l0.424,-0.558
  c-0.016,0.001 -0.027,0.004 -0.036,0.007c-0.095,0.032 -0.191,0.048 -0.285,0.048c-0.188,0 -0.46,-0.065 -0.697,-0.376l-3.72,-4.915
  c-0.207,-0.274 -0.177,-0.48 -0.115,-0.604c0.155,-0.311 0.593,-0.311 0.804,-0.311c0.198,0 0.356,0.131 0.484,0.237c0.025,0.021 0.049,0.041 0.068,0.055l4.519,3.154
  c0.033,0.018 0.105,0.04 0.169,0.061c0.159,0.053 0.255,0.085 0.324,0.184c0.457,0.636 0.917,1.274 1.372,1.915c0.182,0.255 0.38,0.479 0.621,0.736
  c0.066,0.058 0.369,0.119 0.514,0.148c0.12,0.024 0.231,0.048 0.314,0.073c0.717,0.214 1.422,0.417 2.133,0.55c0.468,0.088 0.994,0.013 1.507,-0.056
  c0.222,-0.03 0.439,-0.059 0.648,-0.076c0.942,-0.079 1.902,-0.102 2.832,-0.124c0.473,-0.011 0.945,-0.022 1.416,-0.041c0.319,-0.012 0.647,-0.021 0.979,-0.021
  c1.016,0 1.812,0.084 2.504,0.267c0.15,0.04 0.304,0.075 0.458,0.11c0.468,0.107 0.951,0.217 1.39,0.453l2.01,1.08c0.771,0.415 1.503,0.953 2.21,1.473
  c0.348,0.256 0.695,0.511 1.043,0.75c0.334,0.328 0.469,0.836 0.388,1.331c-0.07,0.427 -0.299,0.767 -0.629,0.931c-0.369,0.186 -0.753,0.375 -1.189,0.316
  c-0.458,-0.062 -0.912,-0.382 -1.313,-0.665c-0.125,-0.088 -0.242,-0.17 -0.347,-0.235c-1.816,-1.117 -3.511,-1.839 -5.183,-2.208
  c-0.549,-0.121 -1.104,-0.175 -1.8,-0.175c-0.37,0 -0.743,0.015 -1.131,0.03l-0.141,0.005c-0.739,0.028 -1.488,0.136 -2.213,0.24c-0.642,0.093 -1.307,0.188 -1.973,0.231
  c-0.156,0.01 -0.305,0.019 -0.448,0.024l0.618,0.102c0.16,0.022 0.36,0.051 0.534,0.183c0.151,0.165 0.26,0.449 0.158,0.673c-0.143,0.311 -0.587,0.243 -0.934,0.205
  c0.141,0.096 0.267,0.235 0.389,0.481c0.067,0.135 0.023,0.299 -0.102,0.383c-0.195,0.13 -0.513,0.101 -0.808,0.016c0.049,0.028 0.099,0.056 0.148,0.085
  c0.065,0.038 0.114,0.099 0.137,0.171c0.064,0.209 0.049,0.381 -0.047,0.511c-0.049,0.066 -0.163,0.177 -0.38,0.177c-0.114,0 -0.231,-0.031 -0.331,-0.068
  c0.008,0.014 0.015,0.029 0.022,0.046c0.073,0.185 -0.036,0.347 -0.077,0.408c-0.166,0.252 -0.346,0.381 -0.535,0.381c-0.046,0 -0.132,-0.02 -0.174,-0.041
  c-0.012,-0.006 -0.023,-0.012 -0.035,-0.018c0.105,0.398 0.207,0.807 0.259,1.219l0.066,0.541c0.099,0.828 0.193,1.61 0.408,2.385c0.509,1.837 1.398,3.498 2.573,4.804
  c0.56,0.62 1.21,1.196 1.934,1.712c0.055,0.039 0.122,0.082 0.195,0.129c0.386,0.249 0.915,0.589 0.957,1.096c0.034,0.365 0.053,0.753 -0.105,1.093
  c-0.053,0.111 -0.129,0.188 -0.191,0.251c-0.027,0.028 -0.068,0.07 -0.077,0.087l-0.021,0.086c-0.069,0.281 -0.153,0.414 -0.498,0.515c-0.063,0.019 -0.13,0.051 -0.198,0.082
  c-0.121,0.056 -0.246,0.113 -0.378,0.136c-0.049,0.012 -0.098,0.016 -0.146,0.016zm-18.32,-23.976c0.053,0.062 0.107,0.112 0.186,0.176l4.417,3.608
  c0.093,0.077 0.187,0.159 0.281,0.243c0.252,0.224 0.512,0.456 0.79,0.559c0.524,0.196 1.037,0.409 1.551,0.623l0.509,0.211c0.604,0.25 1.085,0.939 1.473,1.494l0.125,0.177
  c0.165,0.232 0.31,0.483 0.453,0.733c0.067,0.117 0.134,0.234 0.204,0.349c0.037,0.061 0.088,0.114 0.148,0.176c0.127,0.133 0.287,0.298 0.321,0.58l0.135,1.068
  c0.141,1.114 0.282,2.226 0.401,3.347c0.31,2.952 2.02,6.012 4.572,8.185c0.697,0.594 1.415,1.113 2.135,1.544l0.133,0.083c0.162,0.103 0.345,0.22 0.487,0.22l0.04,-0.003
  c0.057,-0.01 0.149,-0.052 0.231,-0.09c0.096,-0.044 0.191,-0.087 0.28,-0.113c0.045,-0.014 0.07,-0.022 0.084,-0.028c0,0 0,0 0,0c-0.012,0 -0.007,-0.025 0,-0.055l0.028,-0.108
  c0.046,-0.161 0.15,-0.267 0.226,-0.344c0.027,-0.027 0.068,-0.069 0.076,-0.086c0.094,-0.202 0.076,-0.499 0.05,-0.785c-0.018,-0.215 -0.435,-0.483 -0.685,-0.644
  c-0.082,-0.053 -0.157,-0.101 -0.218,-0.145c-0.758,-0.542 -1.441,-1.147 -2.031,-1.799c-1.237,-1.375 -2.172,-3.12 -2.705,-5.046
  c-0.227,-0.819 -0.328,-1.66 -0.425,-2.473l-0.065,-0.538c-0.055,-0.437 -0.176,-0.889 -0.293,-1.326c-0.054,-0.2 -0.107,-0.4 -0.154,-0.598
  c-0.03,-0.122 0.021,-0.25 0.125,-0.319c0.031,-0.021 0.065,-0.035 0.101,-0.043c-0.374,-0.29 -0.537,-0.487 -0.537,-0.707c-0.009,-0.131 -0.335,-0.495 -0.492,-0.669
  c-0.125,-0.14 -0.237,-0.267 -0.304,-0.364c-0.104,-0.151 -0.2,-0.308 -0.296,-0.465l-0.138,-0.222c-0.229,-0.362 -0.204,-0.554 0.104,-0.792l0.11,-0.087
  c0.084,-0.07 0.145,-0.176 0.215,-0.299l0.07,-0.12c0.155,-0.256 0.49,-0.237 0.697,-0.143c0.03,0.013 0.061,0.028 0.092,0.038l0.243,0.079c0.205,0.065 0.411,0.132 0.61,0.213
  c0.592,0.243 1.188,0.264 2.01,0.212c0.643,-0.042 1.295,-0.135 1.926,-0.226c0.74,-0.106 1.505,-0.216 2.275,-0.246l0.141,-0.005c0.396,-0.016 0.777,-0.03 1.155,-0.03
  c0.741,0 1.336,0.058 1.929,0.189c1.738,0.384 3.494,1.13 5.368,2.283c0.114,0.07 0.242,0.16 0.378,0.255c0.328,0.231 0.736,0.518 1.048,0.561
  c0.256,0.034 0.537,-0.106 0.807,-0.241c0.247,-0.123 0.316,-0.371 0.339,-0.509c0.049,-0.296 -0.026,-0.622 -0.178,-0.774c-0.311,-0.206 -0.663,-0.465 -1.017,-0.725
  c-0.691,-0.508 -1.405,-1.033 -2.139,-1.428l-2.01,-1.08c-0.368,-0.197 -0.811,-0.298 -1.24,-0.396c-0.161,-0.037 -0.321,-0.074 -0.477,-0.115
  c-0.642,-0.168 -1.389,-0.247 -2.352,-0.247c-0.324,0 -0.644,0.009 -0.955,0.021c-0.474,0.019 -0.949,0.03 -1.425,0.041c-0.92,0.021 -1.872,0.044 -2.796,0.121
  c-0.199,0.017 -0.407,0.045 -0.618,0.073c-0.574,0.077 -1.207,0.144 -1.697,0.051c-0.74,-0.138 -1.461,-0.346 -2.197,-0.565c-0.07,-0.021 -0.161,-0.04 -0.259,-0.059
  c-0.321,-0.065 -0.653,-0.133 -0.834,-0.328c-0.256,-0.273 -0.468,-0.514 -0.67,-0.796c-0.44,-0.62 -0.885,-1.237 -1.329,-1.854c-0.021,-0.007 -0.045,-0.015 -0.07,-0.023
  c-0.145,-0.049 -0.246,-0.085 -0.323,-0.139l-4.516,-3.155c-0.03,-0.02 -0.068,-0.051 -0.11,-0.086c-0.04,-0.032 -0.113,-0.093 -0.143,-0.105
  c-0.053,0.002 -0.096,0.005 -0.131,0.008l3.682,4.865c0.105,0.139 0.19,0.139 0.219,0.139c0.029,0 0.061,-0.006 0.095,-0.018c0.327,-0.105 0.716,0.01 0.843,0.267
  c0.053,0.107 0.111,0.329 -0.099,0.605l-0.466,0.612c-0.01,0.019 -0.04,0.104 -0.056,0.15c-0.038,0.11 -0.065,0.189 -0.124,0.255c-0.164,0.181 -0.429,0.291 -0.692,0.291
  c-0.381,0 -0.663,-0.23 -0.702,-0.572c-0.056,-0.517 -0.066,-0.521 -0.578,-0.71l-5.255,-2.011c-0.025,-0.01 -0.052,-0.015 -0.072,-0.015
  c0.011,0.001 -0.017,0.088 -0.045,0.164zm11.714,6.069c0.003,0.005 0.007,0.011 0.011,0.017l0.142,0.229c0.091,0.148 0.182,0.297 0.28,0.44c0.055,0.081 0.151,0.186 0.255,0.302
  c0.168,0.187 0.314,0.355 0.425,0.513c0.083,-0.123 0.218,-0.196 0.371,-0.196c0.013,0 0.039,0.003 0.067,0.007c-0.024,-0.082 -0.033,-0.164 -0.023,-0.237
  c0.026,-0.211 0.181,-0.359 0.393,-0.382c0.055,-0.017 0.114,-0.027 0.174,-0.03c-0.008,-0.048 -0.011,-0.093 -0.011,-0.13c0,-0.222 0.089,-0.408 0.227,-0.508
  c-0.31,-0.043 -0.596,-0.123 -0.892,-0.245c-0.184,-0.075 -0.375,-0.136 -0.565,-0.196l-0.25,-0.081c-0.048,-0.016 -0.096,-0.037 -0.142,-0.058l-0.006,0.011
  c-0.087,0.152 -0.185,0.324 -0.354,0.463l-0.102,0.081z"/>
</svg>]]

local iconRGBA, iconW, iconH = common.RasterizeSVG(iconData, 1)
local outlineRGBA, outlineW, outlineH = common.RasterizeSVG(outlineData, 1)
local iconTexture = draw.CreateTexture(iconRGBA, iconW, iconH)
local outlineTexture = draw.CreateTexture(outlineRGBA, outlineW, outlineH)

local shouldGetKits = 1
local kits = {}
local curtime = globals.CurTime()

local function getKits()
local lp = entities.GetLocalPlayer()
	if lp == nil then shouldGetKits = 0 return end
	if lp:GetTeamNumber() == 3 then	
		if lp:GetPropBool("m_bHasDefuser") == false then
      if curtime + 1 <= globals.CurTime() then
			curtime = globals.CurTime()
			kits = {}
        for i,v in ipairs(entities.FindByClass("CEconEntity")) do
          if v:GetName() == "CEconEntity" then
						table.insert(kits, v)
					end
				end
			end
            if shouldGetKits == 1 then
				kits = {}
        for i,v in ipairs(entities.FindByClass("CEconEntity")) do
            if v:GetName() == "CEconEntity" then 
						table.insert(kits, v)
					end
				shouldGetKits = 0
				end
			end
		else
		shouldGetKits = 0
		end
	else
	shouldGetKits = 0
	end
end

callbacks.Register("Draw",getKits)

local function events(event)
    if event:GetName() == "player_death" then
		local id = event:GetInt("userid")
		local ent = entities.GetByUserID(id)
		if ent ~= nil then
			if ent:GetTeamNumber() == 3 then
				shouldGetKits = 1
			end
		end
	end
	if event:GetName() == "player_disconnect" then
		shouldGetKits = 1
	end
	if event:GetName() == "item_pickup" then
		if event:GetString("item") == "defuser" then
			shouldGetKits = 1
		end
	end
	if event:GetName() == "round_officially_ended" then
		kits = {}
	end
end

callbacks.Register("FireGameEvent",events)

local function kitESP()
local lp = entities.GetLocalPlayer()
    if lp == nil then return end
    if lp:GetTeamNumber() == 3 then	
        if lp:GetPropBool("m_bHasDefuser") == false then
		local lpVec = lp:GetAbsOrigin()		
            for i,v in pairs(kits) do
                if v ~= nil then
                local kitVec = v:GetAbsOrigin()
                    local x, y = client.WorldToScreen(kitVec)
					if x ~= nil and y ~= nil then
                        local distance = vector.Distance(lpVec, kitVec)
						local resize = 40 / (distance / 1000)
						if resize > 40 then resize = 40 end
						if resize < 25 then resize = 25 end
						draw.Color(255,255,255,255)
						draw.SetTexture(iconTexture)
						draw.FilledRect(x - (resize / 2), y - (resize / 2), x + (resize / 2), y + (resize / 2))
						draw.SetTexture(outlineTexture)
						draw.FilledRect(x - (resize / 2), y - (resize / 2), x + (resize / 2), y + (resize / 2))
					end
				end
			end
		end
	end
end

callbacks.Register("Draw",kitESP)

client.AllowListener( "item_pickup" )
client.AllowListener( "player_death" )
client.AllowListener( "round_officially_ended" )
client.AllowListener( "player_disconnect" )























-------------------- Zeusbot
local zeusbot = gui.Checkbox(gui.Reference("Misc", "Extra", "Miscellaneous"), "enable_zeusbot_chkbox", "Zeusbot", 0)

zeusbot:SetDescription("Automatically zeus")
local function zeuslegit()
if not zeusbot:GetValue() or entities.GetLocalPlayer() == nil then 
return 
end

local Weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon") 
if Weapon == nil then 
return 
end

local CWeapon = Weapon:GetClass() 
local trige, trigaf, trighc = gui.GetValue("lbot.trg.enable"), gui.GetValue("lbot.trg.autofire"), gui.GetValue("lbot.trg.zeus.hitchance")

if trige ~= 1 and trigaf ~= 1 and trighc ~= gui.GetValue("rbot.accuracy.weapon.zeus.hitchance") then 
trige2, trigaf2, trighc2 = gui.GetValue("lbot.trg.enable"), gui.GetValue("lbot.trg.autofire"), gui.GetValue("lbot.trg.zeus.hitchance") 
end

if CWeapon == "CWeaponTaser" then 
gui.SetValue("lbot.trg.enable", 1) 
gui.SetValue("lbot.trg.autofire", 1) 
gui.SetValue("lbot.trg.zeus.hitchance", gui.GetValue("rbot.accuracy.weapon.zeus.hitchance"))
else 
gui.SetValue("lbot.trg.enable", trige2) 
gui.SetValue("lbot.trg.autofire", trigaf2) 
gui.SetValue("lbot.trg.zeus.hitchance", trighc2) 
end 
end

callbacks.Register("Draw", zeuslegit)




























-- headmove

local movement_ref = gui.Reference("MISC", "Extra", "Miscellaneous")

local sync_movement = gui.Checkbox(movement_ref, "sync_movement_0.", "Sync Head Movement", false)

local s_w, s_h = draw.GetScreenSize()

function syncMovement(cmd, pos)
    local world_forward = {vector.Subtract( pos,  {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z} )}
    local ang_LocalPlayer = {engine.GetViewAngles().x, engine.GetViewAngles().y, engine.GetViewAngles().z }
    
    cmd.forwardmove = ( ( (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[2]) + (math.cos(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 200 ) -- mine
    cmd.sidemove = ( ( (math.cos(math.rad(ang_LocalPlayer[2]) ) * -world_forward[2]) + (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 200 )
end

function is_movement_keys_down()
    return input.IsButtonDown( 87 ) or input.IsButtonDown( 65 ) or input.IsButtonDown( 83 ) or input.IsButtonDown( 68 ) or input.IsButtonDown( 32 )
end

function is_crouching(player)
    return player:GetProp('m_flDuckAmount') > 0.1
end



local is_synced = false

callbacks.Register("CreateMove", function(cmd)
    if not sync_movement:GetValue() then return end
    succ, err = pcall(function() is_movement_keys_down() is_synced = false end)
    if err or is_movement_keys_down() then return end
    
    local players = entities.FindByClass( "CCSPlayer" )
    
    for k, player in pairs(players) do
        local player_pos = {player:GetAbsOrigin().x, player:GetAbsOrigin().y, player:GetAbsOrigin().z}
        local distance = vector.Distance(player_pos, {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z})
        
        local z_dist = entities.GetLocalPlayer():GetAbsOrigin().z - player_pos[3]
        
        local d_min = 0
        local d_max = 0
        if not is_crouching(player) then
            d_min = 70
            d_max = 85
        else
            d_min = 50
            d_max = 64
        end
        if (distance > d_min and distance < d_max) and (z_dist > d_min and z_dist < d_max) then
            syncMovement(cmd, player_pos)
            is_synced = true
        else
            is_synced = false
        end
    end        
end)


callbacks.Register("Draw", function(cmd)
    if not sync_movement:GetValue() or not sync_movement_indicator:GetValue() then return end
    local main_font = draw.CreateFont("Verdana", sync_movement_indicator_size:GetValue());
    draw.SetFont(main_font)

    draw.Color(255,0,0)
    if is_synced then
        draw.Color(0,255,0)
        draw.Text(sync_movement_indicator_X:GetValue(),sync_movement_indicator_Y:GetValue(), "Synced")
    else
        draw.Text(sync_movement_indicator_X:GetValue(),sync_movement_indicator_Y:GetValue(), "Unsynced")
    end
    
end) 

-- vanilla knife

local list_knife = {"bayonet", "css", "flip", "gut", "karambit", "m9_bayonet", "tactical", "falchion", "survival_bowie", "butterfly", "push", "cord", "canis", "ursus", "gypsy_jackknife", "outdoor", "stiletto", "widowmaker", "skeleton"};
local ui_gb = gui.Groupbox(gui.Reference("Misc", "Extra"), "Vanilla Knife", 325, 345, 300); local ui_knife = gui.Combobox(ui_gb, "vanilla", "Knife Model", unpack(list_knife));
local ui_add = gui.Button(ui_gb, "Add to skinchanger", function() gui.Command(ui_knife:GetValue() == 0 and "skin.add weapon_bayonet" or "skin.add weapon_knife_" .. list_knife[(ui_knife:GetValue() + 1)]); end);



-- door spam by stacky

local KEYBOX = gui.Keybox(gui.Reference("Misc", "Extra", "Troll"), "misc.doorspam", "Door Spam Key", 0)
local switch = false

callbacks.Register( "CreateMove", function(cmd)
    if KEYBOX:GetValue() ~= 0 then
        if input.IsButtonDown(KEYBOX:GetValue()) then
            if switch then client.Command("+use", true)
            else client.Command("-use", true) end
            switch = not switch
        else
            if not switch then client.Command("-use", true) end
        end
    end
end )















-- Rainbow Hud by stacky

local REF = gui.Reference( "Visuals", "Extra", "Miscellaneous" )
local CHECKBOX = gui.Checkbox( REF, "rainbowhud.enable", "Rainbow Hud", false )
local SLIDER = gui.Slider( REF, "rainbowhud.interval", "Delay", 1, 0, 5, 0.05 )

local color = 1
local time = globals.CurTime()
local orig = client.GetConVar( "cl_hud_color" )

callbacks.Register( "Draw", function()
    if CHECKBOX:GetValue() then
        client.Command( "cl_hud_color " .. color, true )
        if globals.CurTime() - SLIDER:GetValue() >= time then
            color = color + 1
            time = globals.CurTime()
        end
        if color > 9 then color = 1 end
    end
end )

callbacks.Register( "Unload", function()
    client.Command( "cl_hud_color " .. orig, true )
end )






































-- BHop Hitchance by stacky

local SLIDER = gui.Slider( gui.Reference( "Misc", "Movement", "Jump" ), "hitchance", "Hit Chance for auto jump", 100, 0, 100 )
callbacks.Register( "CreateMove", function(cmd)
    if (gui.GetValue( "misc.autojump" ) ~= '"Off"' or bit.band(cmd.buttons, 2) == 0 or
        bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) == 0 or math.random(1, 100) >= SLIDER:GetValue()) then return end
    cmd.buttons = cmd.buttons - 2
end )






















local aspect_ratio_table = {};   
local REF = gui.Reference("MISC", "Enhancement")
local aspect_misc = gui.Groupbox(REF, "AspectRatio", 16, 712, 297)
local aspect_ratio_check = gui.Checkbox(aspect_misc, "aspect_ratio_check", "Enable", false);  
local aspect_ratio_reference = gui.Slider(aspect_misc, "aspect_ratio_reference", "Value", 100, 1, 199)
local function gcd(m, n)    while m ~= 0 do   m, n = math.fmod(n, m), m;  
end   
return n
end

local function set_aspect_ratio(aspect_ratio_multiplier)
local screen_width, screen_height = draw.GetScreenSize();   local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height;  
    if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then  aspectratio_value = 0;   end
        client.SetConVar( "r_aspectratio", tonumber(aspectratio_value), true);   end

local function on_aspect_ratio_changed()
local screen_width, screen_height = draw.GetScreenSize();
for i=1, 200 do   local i2=i*0.01;    i2 = 2 - i2;   local divisor = gcd(screen_width*i2, screen_height);    if screen_width*i2/divisor < 100 or i2 == 1 then   aspect_ratio_table[i] = screen_width*i2/divisor .. ":" .. screen_height/divisor;  end  end
local aspect_ratio = aspect_ratio_reference:GetValue()*0.01;  aspect_ratio = 2 - aspect_ratio;   set_aspect_ratio(aspect_ratio);   end
callbacks.Register('Draw', "Aspect Ratio" ,on_aspect_ratio_changed)
















