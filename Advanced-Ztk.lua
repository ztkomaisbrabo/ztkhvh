
local meta = {
    version = 1.4,
    name = "Advanced-Ztk",
    git_source = "https://raw.githubusercontent.com/ztkomaisbrabo/ztkhvh/master/Advanced-Ztk.lua",
    git_version = "https://raw.githubusercontent.com/ztkomaisbrabo/ztkhvh/master/version"
}


local function update()
    if tonumber(http.Get(meta.git_version)) > meta.version then
        print("[Advanced-Ztk-Logs] New version available, updating..")
        local current_script = file.Open(GetScriptName(), "w")
        current_script:Write(http.Get(meta.git_source))
        current_script:Close()
        LoadScript(GetScriptName())
        print("[Advanced-Ztk-Logs] Successfully updated.")
    end
end

update()




-- principal

local ref = gui.Reference("Misc");
local tab = gui.Tab(ref,"Extra","Ztk")
local group = gui.Groupbox(tab,"Miscellaneous",16,16,296,300)
local group = gui.Groupbox(tab,"Anti-Aim",325,16,296,300)
local GROUP = gui.Groupbox(gui.Reference("Misc", "Enhancement"), "Auto-Buy", 328, 310, 299, 400);





local ref = gui.Reference("Ragebot");
local tab = gui.Tab(ref,"Extra","Extra")
local group = gui.Groupbox(tab,"Anti-Aim",16,16,296,300)
local group = gui.Groupbox(tab,"Manual Anti-Aim",325,16,296,300)


local tab = gui.Tab(gui.Reference("Settings"), string.lower(meta.name) .. ".tab", meta.name)
local versiontext = gui.Text(tab, "Ztk v" .. meta.version)
versiontext:SetPosY(500)
versiontext:SetPosX(570)


-- misc
local gui_gref = gui.Reference("Ragebot", "Accuracy", "Weapon")
local gui_dtap = gui.Checkbox(gui_gref, "lua.dtap", "DoubleTap Fix", 0)
gui_dtap:SetDescription("Increases double tap accuracy and consistency");
local gui_gref = gui.Reference("Ragebot", "Ztk", "Anti-Aim")
local gui_shotswitch = gui.Checkbox(gui_gref, "lua.shotswitch", "SwitchDesync", 0)
gui_shotswitch:SetDescription("Change the side of desync after shooting");
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

















-- Manual AA & Indicators BY FROG
local get_local = entities.GetLocalPlayer
local gui_set = gui.SetValue
local gui_get = gui.GetValue
local left_key = 0
local back_key = 0
local right_key = 0
local up_key = 0
local rage_ref = gui.Reference("Ragebot", "Extra", "Manual Anti-Aim")
local check_indicator = gui.Checkbox(rage_ref, "manual", "Activate", false)
local manual_left = gui.Keybox(rage_ref, "manual_left", "Left", 0)
local manual_right = gui.Keybox(rage_ref, "manual_right", "Right", 0)
local manual_back = gui.Keybox(rage_ref, "manual_back", "Back", 0)
local manual_up = gui.Keybox(rage_ref, "manual_up", "Front", 0)

-- Fonts
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












-- tipo 1 

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







-- tipo test

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









-- tipo 2

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





















-- tipo 3
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








-- quick



local uid_to_idx = client.GetPlayerIndexByUserID;
local get_local_player = client.GetLocalPlayerIndex;
local in_action;
local equipped;
local ref = gui.Reference("Misc", "General","Extra")
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






local uid_to_idx = client.GetPlayerIndexByUserID;
local get_local_player = client.GetLocalPlayerIndex;
local in_action;
local equipped;
local ref = gui.Reference("Misc", "General","Extra")

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



















local TAB= gui.Reference("Misc", "Ztk")
local GROUPBOX_MAIN=gui.Groupbox(TAB, "Semirage", 16,400,296,300)
local KEYBOX_QUICKSWITCH=gui.Keybox (GROUPBOX_MAIN, "rlswitch", "Quickswitch", 0)
KEYBOX_QUICKSWITCH:SetDescription("Switches between legitbot and ragebot")
local KEYBOX_INVERTER=gui.Keybox(GROUPBOX_MAIN, "inverter", "Inverter", 0)
KEYBOX_INVERTER:SetDescription("This only works for ragebot")
local KEYBOX_AWSWITCH=gui.Keybox(GROUPBOX_MAIN, "awswitch", "AutoWall", 0)
KEYBOX_AWSWITCH:SetDescription("Turn autwall on and off")
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
speclist = gui.Checkbox(gui.Reference("Misc","Ztk","Miscellaneous"),"speclist","Spectator List",0);
speclist:SetDescription("Shows a list of players watching you"); 
end
DrawUI();








local iLastTick = 0

callbacks.Register( "Draw", function()
    if globals.TickCount() > iLastTick then
        local playerList = entities.FindByClass( "CCSPlayer" )
        for i = 1, #playerList do
            if playerList[i]:GetPropEntity("m_hObserverTarget"):GetIndex() == entities.GetLocalPlayer():GetIndex() then
                gui.SetValue( "misc.Extra.speclistt", true )
                return
            end
        end
        gui.SetValue( "misc.Extra.speclist", false )
    end
    iLastTick = globals.TickCount()
end )








-- fake duck animacao maluca



local getLocal = function() return entities.GetLocalPlayer() end
local ref = gui.Reference("Visuals", "Local", "Camera");
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









-- tipo 4
local YawJitter = 1
local aaRef = gui.Reference("Misc", "Enhancement", "Fakelag")
local aaIndicator = gui.Checkbox(aaRef, YawJitter, "Valve Matchmaking", false)

aaIndicator:SetDescription("Fakelag in valve matchmaking");
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








