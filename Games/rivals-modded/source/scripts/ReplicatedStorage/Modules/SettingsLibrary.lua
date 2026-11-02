-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.PermissionsLibrary);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local SettingsInfo = require(ReplicatedStorage.Modules.SettingsInfo);
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
local u1 = { "Shoot", "Aim", "Reload", "Inspect", "QuickMelee", "QuickUtility", "Divider", "WalkForward", "WalkBackward", "WalkLeftward", "WalkRightward", "Jump", "Sprint", "Crouch", "Slide", "Divider", "EquipPrimary", "EquipSecondary", "EquipMelee", "EquipUtility", "EquipNext", "EquipLast", "Divider", "UseEmote", "Divider", "SwitchCameraPOV", "Ping", "OpenPlayerList", "SwitchItems", "LeaveDuel", "SpectateExit", "SpectateNext", "SpectateLast", "HideHUD" };
local u2 = {
    HOTKEYS_GUIDE = u1,
    DEPENDENCIES = {
        ["Camera Sensitivity X"] = { "Camera Sensitivity", "any" },
        ["Camera Sensitivity Y"] = { "Camera Sensitivity", "any" },
        ["Camera Sensitivity ADS"] = { "Camera Sensitivity", "any" },
        ["Camera Sensitivity Scoped"] = { "Camera Sensitivity", "any" },
        ["Camera Inverted X"] = { "Camera Sensitivity", "any" },
        ["Camera Inverted Y"] = { "Camera Sensitivity", "any" },
        ["Camera FOV Effects"] = { "Camera FOV", "any" },
        ["Camera Zoom Effects"] = { "Camera FOV", "any" },
        ["Camera Zoom Effects Scoped"] = { "Camera FOV", "any" },
        ["Auto Shoot Reaction Time"] = { "Auto Shoot", "Custom" },
        ["Aim Assist Strength"] = { "Aim Assist", "Custom" },
        ["Music Volume"] = { "Master Volume", "any" },
        ["Other Volume"] = { "Master Volume", "any" },
        ["Finisher Volume"] = { "Master Volume", "any" },
        ["Emote Volume"] = { "Master Volume", "any" },
        ["Mute Finishers From Others"] = { "Finisher Volume", "any" },
        ["Mute Emotes From Others"] = { "Emote Volume", "any" },
        ["Keep Quick Attack Window"] = { "Keep Quick Attack Enabled", true },
        ["Double Tap Shoot Window"] = { "Double Tap Shoot", true },
        ["Damage Numbers Color"] = { "Damage Numbers", true },
        ["Damage Numbers Critical Color"] = { "Damage Numbers", true },
        ["Hotbar Display"] = { "Gameplay HUD Preset", "Custom" },
        ["Equipped Weapon Display"] = { "Gameplay HUD Preset", "Custom" },
        ["Keybinds Interface"] = { "Gameplay HUD Preset", "Custom" },
        ["Health Bar Display"] = { "Gameplay HUD Preset", "Custom" },
        ["Spectators Display"] = { "Gameplay HUD Preset", "Custom" },
        ["Equipped Weapon Icon"] = { "Equipped Weapon Display", "Disabled", nil, true },
        ["Equipped Weapon Ammo"] = { "Equipped Weapon Display", "Disabled", nil, true },
        ["Hotbar Slot Ammo"] = { "Hotbar Display", "Disabled", nil, true },
        ["Damage Flashing Color Base"] = { "Damage Flashing", "Disabled", nil, true },
        ["Damage Flashing Color Flash"] = { "Damage Flashing", "Disabled", nil, true }
    },
    STAFF_SETTINGS = { "Staff Team Visuals", "Staff Team Tools Disabled", "Staff Team Server Logs", "Staff Team Hidden Spectator", "Staff Team Tools Disabled Leads" },
    NUM_PROFILES = 3,
    Info = {},
    Order = {},
    OrderBySections = {}
};

function u2.DoesExist(p3, p4) -- Line: 47
    -- upvalues: u2 (copy)
    return u2.Info[p4] or ((p4 == "Audio Visualizers" or p4 == "Player Hitboxes") and true or p4 == "ViewModel Shaking");
end;

function u2.GenerateCrosshairAppearance(p5, u6, u7, p8) -- Line: 56
    -- upvalues: EnumLibrary (copy)
    local v9 = {};

    local function get(p10) -- Line: 59
        -- upvalues: u7 (copy), u6 (copy)
        if u7 and u7[p10] ~= nil then
            return u7[p10];
        end;

        return u6:GetSetting(p10);
    end;

    local v11;

    if u7 and u7["Crosshair Disabled"] ~= nil then
        v11 = u7["Crosshair Disabled"];
    else
        v11 = u6:GetSetting("Crosshair Disabled");
    end;

    if v11 then
        v9.IsDisabled = true;
    else
        local v12;

        if u7 and u7["Crosshair Bars Enabled"] ~= nil then
            v12 = u7["Crosshair Bars Enabled"];
        else
            v12 = u6:GetSetting("Crosshair Bars Enabled");
        end;

        local v13 = not v12;
        local v14;

        if u7 and u7["Crosshair Dot Enabled"] ~= nil then
            v14 = u7["Crosshair Dot Enabled"];
        else
            v14 = u6:GetSetting("Crosshair Dot Enabled");
        end;

        local v15 = not v14;
        local v16;

        if u7 and u7["Crosshair Circle Enabled"] ~= nil then
            v16 = u7["Crosshair Circle Enabled"];
        else
            v16 = u6:GetSetting("Crosshair Circle Enabled");
        end;

        local v17 = not v16;
        local v18;

        if u7 and u7["Crosshair Outline Enabled"] ~= nil then
            v18 = u7["Crosshair Outline Enabled"];
        else
            v18 = u6:GetSetting("Crosshair Outline Enabled");
        end;

        local v19 = not v18;
        local v20;

        if u7 and u7["Crosshair Scoped Red Dot"] ~= nil then
            v20 = u7["Crosshair Scoped Red Dot"];
        else
            v20 = u6:GetSetting("Crosshair Scoped Red Dot");
        end;

        v9.IsDisabled = nil;
        local v21;

        if u7 and u7["Crosshair Static"] ~= nil then
            v21 = u7["Crosshair Static"];
        else
            v21 = u6:GetSetting("Crosshair Static");
        end;

        v9.IsStatic = v21 or nil;
        local v22;

        if u7 and u7["Crosshair Rotation"] ~= nil then
            v22 = u7["Crosshair Rotation"];
        else
            v22 = u6:GetSetting("Crosshair Rotation");
        end;

        v9.Rotation = v22;
        local v23;

        if u7 and u7["Crosshair Scale"] ~= nil then
            v23 = u7["Crosshair Scale"];
        else
            v23 = u6:GetSetting("Crosshair Scale");
        end;

        v9.Scale = v23;
        local v24;

        if u7 and u7["Crosshair Show While Aiming"] ~= nil then
            v24 = u7["Crosshair Show While Aiming"];
        else
            v24 = u6:GetSetting("Crosshair Show While Aiming");
        end;

        v9.ShowWhileAiming = v24 or nil;
        local v25;

        if u7 and u7["Crosshair Show While Inspecting"] ~= nil then
            v25 = u7["Crosshair Show While Inspecting"];
        else
            v25 = u6:GetSetting("Crosshair Show While Inspecting");
        end;

        v9.ShowWhileInspecting = v25 or nil;
        local v26;

        if u7 and u7["Crosshair Override Shotgun"] ~= nil then
            v26 = u7["Crosshair Override Shotgun"];
        else
            v26 = u6:GetSetting("Crosshair Override Shotgun");
        end;

        v9.Override = v26 or nil;
        v9.BarsDisabled = v13 or nil;
        local v27;

        if v13 then
            v27 = nil;
        else
            local v28;

            if u7 and u7["Crosshair Bars Top Enabled"] ~= nil then
                v28 = u7["Crosshair Bars Top Enabled"];
            else
                v28 = u6:GetSetting("Crosshair Bars Top Enabled");
            end;

            v27 = not v28 or nil;
        end;

        v9.BarsTopDisabled = v27;
        local v29;

        if v13 then
            v29 = nil;
        else
            local v30;

            if u7 and u7["Crosshair Bars Bottom Enabled"] ~= nil then
                v30 = u7["Crosshair Bars Bottom Enabled"];
            else
                v30 = u6:GetSetting("Crosshair Bars Bottom Enabled");
            end;

            v29 = not v30 or nil;
        end;

        v9.BarsBottomDisabled = v29;
        local v31;

        if v13 then
            v31 = nil;
        else
            local v32;

            if u7 and u7["Crosshair Bars Right Enabled"] ~= nil then
                v32 = u7["Crosshair Bars Right Enabled"];
            else
                v32 = u6:GetSetting("Crosshair Bars Right Enabled");
            end;

            v31 = not v32 or nil;
        end;

        v9.BarsRightDisabled = v31;
        local v33;

        if v13 then
            v33 = nil;
        else
            local v34;

            if u7 and u7["Crosshair Bars Left Enabled"] ~= nil then
                v34 = u7["Crosshair Bars Left Enabled"];
            else
                v34 = u6:GetSetting("Crosshair Bars Left Enabled");
            end;

            v33 = not v34 or nil;
        end;

        v9.BarsLeftDisabled = v33;
        local v35;

        if v13 then
            v35 = nil;
        elseif u7 and u7["Crosshair Bars Spacing"] ~= nil then
            v35 = u7["Crosshair Bars Spacing"];
        else
            v35 = u6:GetSetting("Crosshair Bars Spacing");
        end;

        v9.BarsSpacing = v35;
        local v36;

        if v13 then
            v36 = nil;
        elseif u7 and u7["Crosshair Bars Length"] ~= nil then
            v36 = u7["Crosshair Bars Length"];
        else
            v36 = u6:GetSetting("Crosshair Bars Length");
        end;

        v9.BarsLength = v36;
        local v37;

        if v13 then
            v37 = nil;
        elseif u7 and u7["Crosshair Bars Thickness"] ~= nil then
            v37 = u7["Crosshair Bars Thickness"];
        else
            v37 = u6:GetSetting("Crosshair Bars Thickness");
        end;

        v9.BarsThickness = v37;
        local v38;

        if v13 then
            v38 = nil;
        elseif u7 and u7["Crosshair Bars Transparency"] ~= nil then
            v38 = u7["Crosshair Bars Transparency"];
        else
            v38 = u6:GetSetting("Crosshair Bars Transparency");
        end;

        v9.BarsTransparency = v38;
        local v39;

        if v13 then
            v39 = nil;
        elseif u7 and u7["Crosshair Bars Color"] ~= nil then
            v39 = u7["Crosshair Bars Color"];
        else
            v39 = u6:GetSetting("Crosshair Bars Color");
        end;

        v9.BarsColor = v39;
        local v40;

        if v13 then
            v40 = nil;
        elseif u7 and u7["Crosshair Bars Shape"] ~= nil then
            v40 = u7["Crosshair Bars Shape"];
        else
            v40 = u6:GetSetting("Crosshair Bars Shape");
        end;

        v9.BarsShape = v40;
        v9.DotDisabled = v15 or nil;
        local v41;

        if v15 then
            v41 = nil;
        elseif u7 and u7["Crosshair Dot Thickness"] ~= nil then
            v41 = u7["Crosshair Dot Thickness"];
        else
            v41 = u6:GetSetting("Crosshair Dot Thickness");
        end;

        v9.DotThickness = v41;
        local v42;

        if v15 then
            v42 = nil;
        elseif u7 and u7["Crosshair Dot Transparency"] ~= nil then
            v42 = u7["Crosshair Dot Transparency"];
        else
            v42 = u6:GetSetting("Crosshair Dot Transparency");
        end;

        v9.DotTransparency = v42;
        local v43;

        if v15 then
            v43 = nil;
        elseif u7 and u7["Crosshair Dot Color"] ~= nil then
            v43 = u7["Crosshair Dot Color"];
        else
            v43 = u6:GetSetting("Crosshair Dot Color");
        end;

        v9.DotColor = v43;
        local v44;

        if v15 then
            v44 = nil;
        elseif u7 and u7["Crosshair Dot Shape"] ~= nil then
            v44 = u7["Crosshair Dot Shape"];
        else
            v44 = u6:GetSetting("Crosshair Dot Shape");
        end;

        v9.DotShape = v44;
        v9.CircleDisabled = v17 or nil;
        local v45;

        if v17 then
            v45 = nil;
        elseif u7 and u7["Crosshair Circle Color"] ~= nil then
            v45 = u7["Crosshair Circle Color"];
        else
            v45 = u6:GetSetting("Crosshair Circle Color");
        end;

        v9.CircleColor = v45;
        local v46;

        if v17 then
            v46 = nil;
        elseif u7 and u7["Crosshair Circle Size"] ~= nil then
            v46 = u7["Crosshair Circle Size"];
        else
            v46 = u6:GetSetting("Crosshair Circle Size");
        end;

        v9.CircleSize = v46;
        local v47;

        if v17 then
            v47 = nil;
        elseif u7 and u7["Crosshair Circle Thickness"] ~= nil then
            v47 = u7["Crosshair Circle Thickness"];
        else
            v47 = u6:GetSetting("Crosshair Circle Thickness");
        end;

        v9.CircleThickness = v47;
        local v48;

        if v17 then
            v48 = nil;
        elseif u7 and u7["Crosshair Circle Transparency"] ~= nil then
            v48 = u7["Crosshair Circle Transparency"];
        else
            v48 = u6:GetSetting("Crosshair Circle Transparency");
        end;

        v9.CircleTransparency = v48;
        local v49;

        if v17 then
            v49 = nil;
        elseif u7 and u7["Crosshair Circle Shape"] ~= nil then
            v49 = u7["Crosshair Circle Shape"];
        else
            v49 = u6:GetSetting("Crosshair Circle Shape");
        end;

        v9.CircleShape = v49;
        v9.OutlineDisabled = v19 or nil;
        local v50;

        if v19 then
            v50 = nil;
        elseif u7 and u7["Crosshair Outline Thickness"] ~= nil then
            v50 = u7["Crosshair Outline Thickness"];
        else
            v50 = u6:GetSetting("Crosshair Outline Thickness");
        end;

        v9.OutlineThickness = v50;
        local v51;

        if v19 then
            v51 = nil;
        elseif u7 and u7["Crosshair Outline Transparency"] ~= nil then
            v51 = u7["Crosshair Outline Transparency"];
        else
            v51 = u6:GetSetting("Crosshair Outline Transparency");
        end;

        v9.OutlineTransparency = v51;
        local v52;

        if v19 then
            v52 = nil;
        elseif u7 and u7["Crosshair Outline Color"] ~= nil then
            v52 = u7["Crosshair Outline Color"];
        else
            v52 = u6:GetSetting("Crosshair Outline Color");
        end;

        v9.OutlineColor = v52;
        local v53;

        if v19 then
            v53 = nil;
        elseif u7 and u7["Crosshair Outline Type"] ~= nil then
            v53 = u7["Crosshair Outline Type"];
        else
            v53 = u6:GetSetting("Crosshair Outline Type");
        end;

        v9.OutlineType = v53;
    end;

    local v54;

    if u7 and u7["Crosshair Hitmarker Enabled"] ~= nil then
        v54 = u7["Crosshair Hitmarker Enabled"];
    else
        v54 = u6:GetSetting("Crosshair Hitmarker Enabled");
    end;

    if v54 then
        v9.HitmarkerDisabled = nil;
        local v55;

        if u7 and u7["Crosshair Hitmarker Scale"] ~= nil then
            v55 = u7["Crosshair Hitmarker Scale"];
        else
            v55 = u6:GetSetting("Crosshair Hitmarker Scale");
        end;

        v9.HitmarkerScale = v55;
        local v56;

        if u7 and u7["Crosshair Hitmarker Rotation"] ~= nil then
            v56 = u7["Crosshair Hitmarker Rotation"];
        else
            v56 = u6:GetSetting("Crosshair Hitmarker Rotation");
        end;

        v9.HitmarkerRotation = v56;
        local v57;

        if u7 and u7["Crosshair Hitmarker Transparency"] ~= nil then
            v57 = u7["Crosshair Hitmarker Transparency"];
        else
            v57 = u6:GetSetting("Crosshair Hitmarker Transparency");
        end;

        v9.HitmarkerTransparency = v57;
        local v58;

        if u7 and u7["Crosshair Hitmarker Color"] ~= nil then
            v58 = u7["Crosshair Hitmarker Color"];
        else
            v58 = u6:GetSetting("Crosshair Hitmarker Color");
        end;

        v9.HitmarkerColor = v58;
        local v59;

        if u7 and u7["Crosshair Hitmarker Transparency Crit"] ~= nil then
            v59 = u7["Crosshair Hitmarker Transparency Crit"];
        else
            v59 = u6:GetSetting("Crosshair Hitmarker Transparency Crit");
        end;

        v9.HitmarkerTransparencyCrit = v59;
        local v60;

        if u7 and u7["Crosshair Hitmarker Color Crit"] ~= nil then
            v60 = u7["Crosshair Hitmarker Color Crit"];
        else
            v60 = u6:GetSetting("Crosshair Hitmarker Color Crit");
        end;

        v9.HitmarkerColorCrit = v60;
    else
        v9.HitmarkerDisabled = true;
    end;

    local v61;

    if u7 and u7["Crosshair Scoped Bars"] ~= nil then
        v61 = u7["Crosshair Scoped Bars"];
    else
        v61 = u6:GetSetting("Crosshair Scoped Bars");
    end;

    local v62;

    if u7 and u7["Crosshair Scoped Red Dot"] ~= nil then
        v62 = u7["Crosshair Scoped Red Dot"];
    else
        v62 = u6:GetSetting("Crosshair Scoped Red Dot");
    end;

    v9.ScopedDisabled = nil;
    v9.ScopedBarsDisabled = not v61 or nil;
    v9.ScopedRedDotDisabled = not v62 or nil;
    local v63;

    if u7 and u7["Crosshair Scoped Red Dot Color"] ~= nil then
        v63 = u7["Crosshair Scoped Red Dot Color"];
    else
        v63 = u6:GetSetting("Crosshair Scoped Red Dot Color");
    end;

    v9.ScopedRedDotColor = v63;

    if p8 then
        v9 = {};

        for i, v in pairs(v9) do
            v9[EnumLibrary:ToEnum(i)] = v;
        end;
    end;

    return v9;
end;

function u2.DecodeCrosshairAppearance(p64, p65) -- Line: 154
    -- upvalues: EnumLibrary (copy)
    local v66 = {};

    for i, v in pairs(p65) do
        v66[EnumLibrary:FromEnum(i)] = v;
    end;

    return v66;
end;

local function add_setting(...) -- Line: 164
    -- upvalues: SettingsInfo (copy), u2 (copy)
    local v67 = SettingsInfo.new(...);
    local v68;

    if v67.Type == "Divider" then
        v68 = nil;
    else
        v68 = v67;
    end;

    u2.Info[v67.Name] = v68;
    table.insert(u2.Order, v67);
    u2.OrderBySections[v67.Section] = u2.OrderBySections[v67.Section] or {};
    table.insert(u2.OrderBySections[v67.Section], v67);
end;

local function add_hotkey_setting(p69, p70) -- Line: 173
    -- upvalues: InputLibrary (copy), add_setting (copy)
    local v71 = InputLibrary.Inputs[p69];

    for i, v in pairs(InputLibrary.HOTKEY_FORMATS) do
        local v72 = i;

        for i2, v2 in pairs(v) do
            local v73 = v71.InputEnums[v72] and v71.InputEnums[v72][i2];
            add_setting("Hotkeys", string.format(v2, p69), v71.DisplayName, "", "", "Hotkey", v73 and v73.Name or "nil");
        end;
    end;
end;

local function add_divider(p74, p75, p76) -- Line: 185
    -- upvalues: add_setting (copy)
    add_setting(p74, p74 .. " - " .. p75, p75, p76 or "", "", "Divider");
end;

add_setting("Video", "Video - Performance", "Performance", "", "", "Divider");
add_setting(
    "Video",
    "Shadows Disabled",
    "Optimized Lighting",
    "rbxassetid://17521723349",
    "Disables shadows which may increase performance but causes the game to look brighter. If you turn this off, you will need to restart your game",
    "Toggle",
    false
);
add_setting(
    "Video",
    "Textures Disabled",
    "Optimized Textures",
    "rbxassetid://17521723467",
    "Deletes most textures & materials which may increase performance but causes the game to lack detail. If you turn this off, you will need to restart your game",
    "Toggle",
    false
);
add_setting(
    "Video",
    "Wraps Disabled",
    "Optimized Wraps",
    "rbxassetid://17593458822",
    "Hides weapon wraps which may increase performance. You\'ll still be able to see your own wraps",
    "Toggle",
    false
);
add_setting("Video", "Video - Camera", "Camera", "", "", "Divider");
add_setting(
    "Video",
    "Camera Sensitivity",
    "Sensitivity",
    "rbxassetid://17548980857",
    "Change how fast your camera rotates",
    "Slider",
    1,
    0.05,
    4,
    20,
    true
);
add_setting(
    "Video",
    "Camera Sensitivity ADS",
    "While Aiming",
    "rbxassetid://17516823433",
    "Multiplies your camera sensitivity while aiming with non-scoped weapons",
    "Slider",
    0.5,
    0.05,
    2,
    20,
    true
);
add_setting(
    "Video",
    "Camera Sensitivity Scoped",
    "While Scoped",
    "rbxassetid://87834608236137",
    "Multiplies your camera sensitivity while aiming with scoped weapons specifically",
    "Slider",
    0.5,
    0.05,
    2,
    20,
    true
);
add_setting(
    "Video",
    "Camera Sensitivity X",
    "Horizontal",
    "rbxassetid://85286504432350",
    "[Advanced] Specifically change your left & right sensitivity",
    "Slider",
    1,
    0.05,
    4,
    20,
    true
);
add_setting(
    "Video",
    "Camera Sensitivity Y",
    "Vertical",
    "rbxassetid://72795034348521",
    "[Advanced] Specifically change your up & down sensitivity",
    "Slider",
    1,
    0.05,
    4,
    20,
    true
);
add_setting(
    "Video",
    "Camera Inverted X",
    "Inverted X",
    "rbxassetid://85286504432350",
    "[Advanced] Inverts your camera\'s left & right movements",
    "Toggle",
    false
);
add_setting(
    "Video",
    "Camera Inverted Y",
    "Inverted Y",
    "rbxassetid://72795034348521",
    "[Advanced] Inverts your camera\'s up & down movements",
    "Toggle",
    false
);
add_setting(
    "Video",
    "Camera FOV",
    "Field Of View",
    "rbxassetid://130564359100743",
    "Changes how much of the world your camera is able to see",
    "Slider",
    80,
    30,
    120,
    1
);
add_setting(
    "Video",
    "Camera FOV Effects",
    "Gameplay Effects",
    "rbxassetid://17513821002",
    "Enables gameplay-related field of view effects from things such as sprinting",
    "Toggle",
    true
);
add_setting(
    "Video",
    "Camera Zoom Effects",
    "Non-Scoped Weapons",
    "rbxassetid://17516823433",
    "Changes the strength of field of view effects from things like aiming & charging for non-scoped weapons",
    "Slider",
    1,
    0,
    1,
    20,
    true
);
add_setting(
    "Video",
    "Camera Zoom Effects Scoped",
    "Scoped Weapons",
    "rbxassetid://87834608236137",
    "Changes the strength of field of view effects for aiming with scoped weapons specifically",
    "Slider",
    1,
    0,
    1,
    20,
    true
);
add_setting(
    "Video",
    "Camera Shake",
    "Camera Shake",
    "rbxassetid://18404346057",
    "Enables effects such as recoil, explosions, etc",
    "Toggle",
    true
);
add_setting("Video", "Video - Interface", "Interface", "", "", "Divider");
add_setting(
    "Video",
    "Hide HUD",
    "Hide HUD",
    "rbxassetid://126633805196326",
    "Turns off most user interface elements, possibly allowing you to get cleaner footage. This setting can also be bound to a hotkey for Controller and Mouse & Keyboard",
    "Toggle",
    false
);
add_setting(
    "Video",
    "Hide Tasks In Duels",
    "Hide Side Tasks",
    "rbxassetid://17632205556",
    "Hides your tasks interface on the left side of your screen once the duel\'s round begins",
    "Toggle",
    false
);
add_setting(
    "Video",
    "Padded HUD",
    "Padded HUD",
    "rbxassetid://118715309480493",
    "Shrinks the HUD to add more space around the edges of your screen. Great for playing on a TV or large monitor",
    "Dropdown",
    "Using Controller",
    { "Always On", "Using Controller", "Disabled" }
);
add_setting(
    "Video",
    "PlayerList Leaderstat",
    "Lobby Data",
    "rbxassetid://17898066959",
    "Change what kind of data the player list & player nametags display. This setting can also be changed by clicking on the icon in the top right of the player list",
    "Dropdown",
    "Win Streak",
    { "Win Streak", "Level", "Current ELO" }
);
add_setting("Video", "Video - Graphics", "Graphics", "", "", "Divider");
add_setting(
    "Video",
    "ViewModel Highlight",
    "Weapon Inking",
    "rbxassetid://17611932430",
    "Adds a subtle outline around your weapons. This effect may cause weird artifacts for transparent weapons and/or wraps that have a glass look to them",
    "Toggle",
    true
);
add_setting(
    "Video",
    "Aiming Hides Muzzle Flashes",
    "Hide Muzzle Flashes",
    "rbxassetid://125628882498996",
    "Hides muzzle flash effects while aiming with a weapon. Helps reduce visual obstructions with certain weapon skins",
    "Toggle",
    false
);
add_setting(
    "Video",
    "Equipment Background",
    "Weapons Background",
    "rbxassetid://17898066959",
    "Changes the 3D background of the Weapons page. Great for making thumbnails of certain weapons, skins, wraps, etc",
    "Dropdown",
    "Default",
    { "Default", "Green Screen", "Blue Screen", "Pink Screen" }
);
add_setting("Video", "Video - Accessibility", "Accessibility", "", "", "Divider");
add_setting(
    "Video",
    "Damage Flashing",
    "Damage Flashing",
    "rbxassetid://107944065079684",
    "Plays a bright flashing effect every time something takes damage. Turn this off if you are sensitive to flashing lights",
    "Dropdown",
    "Enabled",
    { "Enabled", "Outline", "Disabled" }
);
add_setting(
    "Video",
    "Damage Flashing Color Base",
    "Base Color",
    "rbxassetid://107944065079684",
    "Change the base color of the damage flashing effect",
    "Color",
    "#ff3232"
);
add_setting(
    "Video",
    "Damage Flashing Color Flash",
    "Flash Color",
    "rbxassetid://107944065079684",
    "Change the flash color of the damage flashing effect",
    "Color",
    "#ffffff"
);
add_setting(
    "Video",
    "Accessible Flashes",
    "Dark Blinds",
    "rbxassetid://17814211801",
    "Makes flashbang blinds dark instead of bright. Turn this on if you are sensitive to flashing lights",
    "Toggle",
    false
);
add_setting(
    "Audio",
    "Master Volume",
    "Master Volume",
    "rbxassetid://17506383011",
    "Changes the volume of everything",
    "Slider",
    0.5,
    0,
    2,
    20,
    true
);
add_setting(
    "Audio",
    "Music Volume",
    "Music Volume",
    "rbxassetid://136271678394092",
    "Changes the volume of just the music. Music made by @BSlickMusic",
    "Slider",
    1,
    0,
    2,
    20,
    true
);
add_setting(
    "Audio",
    "Finisher Volume",
    "Finisher Volume",
    "rbxassetid://77965589200390",
    "Changes the volume of just finishers, which are effects that play on elimination",
    "Slider",
    1,
    0,
    2,
    20,
    true
);
add_setting(
    "Audio",
    "Mute Finishers From Others",
    "Mute Other Finishers",
    "rbxassetid://138903494625319",
    "Mutes finishers that are from other players unless you\'re currently spectating them",
    "Toggle",
    false
);
add_setting(
    "Audio",
    "Emote Volume",
    "Emote Volume",
    "rbxassetid://130882808226687",
    "Changes the volume of just emotes",
    "Slider",
    1,
    0,
    2,
    20,
    true
);
add_setting(
    "Audio",
    "Mute Emotes From Others",
    "Mute Other Emotes",
    "rbxassetid://138903494625319",
    "Mutes emotes that are from other players unless you\'re currently spectating them",
    "Toggle",
    false
);
add_setting(
    "Audio",
    "Other Volume",
    "SFX Volume",
    "rbxassetid://125628882498996",
    "Changes the volume of basically everything else",
    "Slider",
    1,
    0,
    2,
    20,
    true
);
add_setting("Game", "Game - Gameplay", "Gameplay", "", "", "Divider");
add_setting(
    "Game",
    "Damage Numbers",
    "Damage Numbers",
    "rbxassetid://18404346057",
    "Displays the damage you deal to others",
    "Toggle",
    true
);
add_setting(
    "Game",
    "Damage Numbers Color",
    "Color",
    "rbxassetid://18404346057",
    "Change the color of normal damage",
    "Color",
    "#ffffff"
);
add_setting(
    "Game",
    "Damage Numbers Critical Color",
    "Critical Color",
    "rbxassetid://18404346057",
    "Change the color of critical damage",
    "Color",
    "#ff3232"
);
add_setting(
    "Game",
    "Pings",
    "Signals",
    "rbxassetid://17269776216",
    "Allows you to see signal callouts from teammates. You can signal your teammates using a Controller or Mouse & Keyboard by pressing a specific hotkey. This hotkey can be changed at any time",
    "Toggle",
    true
);
add_setting(
    "Game",
    "Hide Teammate Icons",
    "Hide Teammate Display",
    "rbxassetid://17704137194",
    "Hides teammate icons & health bars in duels",
    "Toggle",
    false
);
add_setting(
    "Game",
    "ViewModel Aiming",
    "Aiming Animation",
    "rbxassetid://17516823433",
    "[Advanced] Turn this off to disable your aiming animations for all non-scoped weapons. This should help remove any negative impact on gameplay from using larger skins",
    "Toggle",
    true
);
add_setting(
    "Game",
    "Projectile Smoothing",
    "Smooth Projectiles",
    "rbxassetid://111780605198345",
    "[Advanced] Smoothens the motion of projectiles to provide a more visually appealing experience. Turn this off for a snappier & more visually accurate experience with projectile weapons",
    "Toggle",
    true
);
add_setting("Game", "Game - Interface", "Interface", "", "", "Divider");
add_setting(
    "Game",
    "Pick Weapons List",
    "Weapon Picker",
    "rbxassetid://17539215512",
    "Changes the look of the weapon picker interface in duels & the shooting range",
    "Dropdown",
    "Grid",
    { "Grid", "List" }
);
add_setting(
    "Game",
    "Gameplay HUD Preset",
    "Gameplay HUD",
    "rbxassetid://17898066959",
    "An easy way of trying out a new gameplay HUD format! Choose between the default look, a left handed mode, the classic RIVALS layout, or a centered version that works great for vertical content creation",
    "Dropdown",
    "Default",
    { "Default", "Left Handed", "Legacy", "Centered", "Custom", "Disabled" }
);
add_setting(
    "Game",
    "Hotbar Display",
    "Hotbar Display",
    "rbxassetid://13188242287",
    "[Advanced] Choose whether you want all of your weapons to be displayed on the bottom right, where they usually go, or in the bottom left, where the health bar usually sits. Not available for touch controls",
    "Dropdown",
    "Bottom Right",
    { "Bottom Left", "Bottom Right", "Bottom Center", "Disabled" }
);
add_setting(
    "Game",
    "Hotbar Slot Ammo",
    "Show Weapon Ammo",
    "rbxassetid://16539130428",
    "Displays your weapon\'s ammo on the hotbar to see from a quick glance. Does not affect touch buttons",
    "Toggle",
    true
);
add_setting(
    "Game",
    "Equipped Weapon Display",
    "Equipped Display",
    "rbxassetid://116467133898357",
    "[Advanced] Choose whether you want your equipped weapon\'s ammo & information to be displayed on the bottom left, where the health bar usually sits, or in the bottom right, where the hotbar usually sits",
    "Dropdown",
    "Bottom Right",
    { "Bottom Left", "Bottom Right", "Legacy", "Disabled" }
);
add_setting(
    "Game",
    "Equipped Weapon Icon",
    "Show Weapon Icon",
    "rbxassetid://17611932430",
    "[Advanced] Choose whether or not your Equipped Display shows the icon of your weapon. This should probably be turned off if you put your Equipped Display next to your Hotbar",
    "Toggle",
    false
);
add_setting(
    "Game",
    "Equipped Weapon Ammo",
    "Show Weapon Ammo",
    "rbxassetid://16539130428",
    "[Advanced] Choose whether or not your Equipped Display shows the ammo of your weapon",
    "Toggle",
    false
);
add_setting(
    "Game",
    "Keybinds Interface",
    "Keybinds Display",
    "rbxassetid://133555125764102",
    "[Advanced] Choose whether you want situational keybinds to appear on the bottom left, where the health bar usually sits, or in the bottom right, where the hotbar usually sits",
    "Dropdown",
    "Bottom Right",
    { "Bottom Left", "Bottom Right", "Disabled" }
);
add_setting(
    "Game",
    "Health Bar Display",
    "Health Display",
    "rbxassetid://102193196101741",
    "[Advanced] Choose whether you want your health bar to appear on the bottom left, where it usually goes, or in the bottom right, where the hotbar usually sits",
    "Dropdown",
    "Bottom Left",
    { "Bottom Left", "Bottom Right", "Bottom Center", "Disabled" }
);
add_setting(
    "Game",
    "Spectators Display",
    "Spectators Display",
    "rbxassetid://77908042044589",
    "[Advanced] Choose whether you want the spectators visual to appear on the bottom left, where it usually goes, or in the bottom right, where the hotbar usually sits",
    "Dropdown",
    "Bottom Left",
    { "Bottom Left", "Bottom Right", "Bottom Center", "Disabled" }
);
add_setting("Game", "Game - Controls", "Controls", "", "", "Divider");
add_setting(
    "Game",
    "Toggle Aim",
    "Toggle Aim",
    "rbxassetid://17513805525",
    "Doesn\'t affect Touch Controls",
    "Toggle",
    false
);
add_setting(
    "Game",
    "Toggle Crouch",
    "Toggle Crouch",
    "rbxassetid://17513805623",
    "Doesn\'t affect Touch Controls",
    "Toggle",
    false
);
add_setting(
    "Game",
    "Toggle Sprint",
    "Toggle Sprint",
    "rbxassetid://17513821002",
    "Doesn\'t affect Touch Controls",
    "Toggle",
    false
);
add_setting(
    "Game",
    "Auto Sprint",
    "Auto Sprint",
    "rbxassetid://17513821002",
    "Automatically sprint while moving instead of having to use the sprint button. Doesn\'t affect Touch Controls",
    "Toggle",
    true
);
add_setting(
    "Game",
    "Easy Slide",
    "Easy Slide",
    "rbxassetid://17524267716",
    "While turned on, you can easily slide by sprinting & then crouching. If you turn this off, you should bind a hotkey to your dedicated Slide button. Doesn\'t affect Touch Controls",
    "Toggle",
    true
);
add_setting(
    "Game",
    "Easy Quick Attack",
    "Easy Quick Attack",
    "rbxassetid://16828140099",
    "Quick melee & quick utility will automatically use abilities if necessary, such as automatically dashing with the Scythe",
    "Toggle",
    true
);
add_setting(
    "Game",
    "Keep Quick Attack Enabled",
    "Quick Attack Keeping",
    "rbxassetid://17225650859",
    "[Advanced] Allows you to keep your weapon after quick attacking by holding down the Quick Attack button",
    "Toggle",
    true
);
add_setting(
    "Game",
    "Keep Quick Attack Window",
    "Keep Window",
    "rbxassetid://17225650859",
    "[Advanced] How long, in seconds, you need to hold the Quick Attack button for you to keep your weapon out. If you set this to 0 seconds, you will always keep your weapon after quick attacking",
    "Slider",
    0.25,
    0,
    1,
    20
);
add_setting(
    "Game",
    "Scroll Equip",
    "Scroll Equip",
    "rbxassetid://88012714630436",
    "Allows you to scroll up & down with your mouse wheel to switch weapons. Only available for Mouse & Keyboard",
    "Toggle",
    true
);
add_setting("Game", "Game - Handicaps", "Handicaps", "", "", "Divider");
add_setting(
    "Game",
    "Aim Assist",
    "Aim Assist",
    "rbxassetid://139269442808394",
    "While aiming with a weapon, your camera will be pulled in the direction of nearby enemies. Only available for Touch Controls & Controller",
    "Dropdown",
    "Custom",
    { "Custom", "Disabled" }
);
add_setting(
    "Game",
    "Aim Assist Strength",
    "Pull Strength",
    "rbxassetid://139269442808394",
    "Change how strong your aim assist pulls your camera",
    "Slider",
    0.5,
    0,
    1,
    20,
    true
);
add_setting(
    "Game",
    "Auto Shoot",
    "Auto Shoot",
    "rbxassetid://122696559841523",
    "Weapons will automatically attack enemies if your crosshair lines up with their body. In competitive modes, such as Ranked, this setting is forced to be Dynamic. Dynamic mode makes it so that your Auto Shoot\'s reaction time changes based on the weapon you use to ensure fair gameplay. Only available for Touch Controls & Controller",
    "Dropdown",
    "Custom",
    { "Custom", "Dynamic", "Disabled" }
);
add_setting(
    "Game",
    "Auto Shoot Reaction Time",
    "Reaction Time",
    "rbxassetid://122696559841523",
    "The delay, in milliseconds, that your auto shoot will trigger after your crosshair lines up with an enemy",
    "Slider",
    25,
    25,
    125,
    1
);
add_setting(
    "Game",
    "Third Person Access",
    "Third Person Camera",
    "rbxassetid://138606382770333",
    "Allows you to change your camera\'s point of view from first person to third person. Only available for Touch Controls",
    "Dropdown",
    "Touch Controls",
    { "Touch Controls" }
);
add_setting("Game", "Game - Accessibility", "Accessibility", "", "", "Divider");
add_setting(
    "Game",
    "Gamepad Deadzone",
    "Joystick Deadzone",
    "rbxassetid://110291144710849",
    "[Advanced] Helps fix joystick drifting while playing with a Controller. Gradually increase this number until you no longer experience stick drift",
    "Slider",
    0.25,
    0,
    0.95,
    20,
    true
);
add_setting(
    "Game",
    "Control Scheme",
    "Control Scheme",
    "rbxassetid://81276179444570",
    "[Advanced] Use this setting to force the game to respect your desired control scheme",
    "Dropdown",
    "Automatic",
    { "Automatic", "Mouse & Keyboard", "Touch Buttons", "Controller" }
);
add_setting("Crosshair", "Crosshair - Crosshair", "Crosshair", "", "", "Divider");
add_setting(
    "Crosshair",
    "Crosshair Disabled",
    "Disabled",
    "rbxassetid://139575687490912",
    "Makes the crosshair invisible",
    "Toggle",
    false
);
add_setting(
    "Crosshair",
    "Crosshair Scale",
    "Scale",
    "rbxassetid://115388073389430",
    "Make your crosshair big or small",
    "Slider",
    1,
    0,
    4,
    20,
    true
);
add_setting(
    "Crosshair",
    "Crosshair Rotation",
    "Rotation",
    "rbxassetid://103847676236765",
    "0 or 45 recommended",
    "Slider",
    0,
    0,
    360,
    1
);
add_setting(
    "Crosshair",
    "Crosshair Static",
    "Static",
    "rbxassetid://17516823433",
    "Turns off all crosshair effects",
    "Toggle",
    false
);
add_setting(
    "Crosshair",
    "Crosshair Show While Aiming",
    "Show While Aiming",
    "rbxassetid://122558543480189",
    "Keeps your crosshair visible while aiming",
    "Toggle",
    false
);
add_setting(
    "Crosshair",
    "Crosshair Show While Inspecting",
    "Show While Inspecting",
    "rbxassetid://17513805400",
    "Keeps your crosshair visible while inspecting",
    "Toggle",
    false
);
add_setting(
    "Crosshair",
    "Crosshair Override Shotgun",
    "Override Specials",
    "rbxassetid://119489313346738",
    "Allows you to use your custom crosshair for Shotgun, Shorty, etc",
    "Toggle",
    false
);
add_setting(
    "Crosshair",
    "Crosshair Bars Enabled",
    "Bars Enabled",
    "rbxassetid://17516823503",
    "",
    "Toggle",
    true
);
add_setting("Crosshair", "Crosshair Bars Color", "Color", "rbxassetid://17516823503", "", "Color", "#ffffff");
add_setting(
    "Crosshair",
    "Crosshair Bars Spacing",
    "Spacing",
    "rbxassetid://17516823503",
    "",
    "Slider",
    16,
    0,
    64,
    1
);
add_setting(
    "Crosshair",
    "Crosshair Bars Length",
    "Length",
    "rbxassetid://17516823503",
    "",
    "Slider",
    6,
    0,
    32,
    1
);
add_setting(
    "Crosshair",
    "Crosshair Bars Thickness",
    "Thickness",
    "rbxassetid://17516823503",
    "",
    "Slider",
    2,
    0,
    32,
    1
);
add_setting(
    "Crosshair",
    "Crosshair Bars Transparency",
    "Transparency",
    "rbxassetid://17516823503",
    "",
    "Slider",
    0,
    0,
    1,
    20,
    true
);
add_setting(
    "Crosshair",
    "Crosshair Bars Shape",
    "Shape",
    "rbxassetid://17516823503",
    "",
    "Dropdown",
    "Sharp",
    { "Sharp", "Round" }
);
add_setting(
    "Crosshair",
    "Crosshair Bars Top Enabled",
    "Top Enabled",
    "rbxassetid://17564352694",
    "",
    "Toggle",
    true
);
add_setting(
    "Crosshair",
    "Crosshair Bars Bottom Enabled",
    "Bottom Enabled",
    "rbxassetid://17564352775",
    "",
    "Toggle",
    true
);
add_setting(
    "Crosshair",
    "Crosshair Bars Right Enabled",
    "Right Enabled",
    "rbxassetid://17564352879",
    "",
    "Toggle",
    true
);
add_setting(
    "Crosshair",
    "Crosshair Bars Left Enabled",
    "Left Enabled",
    "rbxassetid://17564353047",
    "",
    "Toggle",
    true
);
add_setting(
    "Crosshair",
    "Crosshair Dot Enabled",
    "Dot Enabled",
    "rbxassetid://17516823599",
    "",
    "Toggle",
    true
);
add_setting("Crosshair", "Crosshair Dot Color", "Color", "rbxassetid://17516823599", "", "Color", "#ffffff");
add_setting(
    "Crosshair",
    "Crosshair Dot Thickness",
    "Thickness",
    "rbxassetid://17516823599",
    "",
    "Slider",
    2,
    0,
    16,
    1
);
add_setting(
    "Crosshair",
    "Crosshair Dot Transparency",
    "Transparency",
    "rbxassetid://17516823599",
    "",
    "Slider",
    0,
    0,
    1,
    20,
    true
);
add_setting(
    "Crosshair",
    "Crosshair Dot Shape",
    "Shape",
    "rbxassetid://17516823599",
    "",
    "Dropdown",
    "Sharp",
    { "Sharp", "Round" }
);
add_setting(
    "Crosshair",
    "Crosshair Circle Enabled",
    "Circle Enabled",
    "rbxassetid://96264839713061",
    "",
    "Toggle",
    false
);
add_setting(
    "Crosshair",
    "Crosshair Circle Color",
    "Color",
    "rbxassetid://96264839713061",
    "",
    "Color",
    "#ffffff"
);
add_setting(
    "Crosshair",
    "Crosshair Circle Size",
    "Size",
    "rbxassetid://96264839713061",
    "",
    "Slider",
    16,
    0,
    64,
    1
);
add_setting(
    "Crosshair",
    "Crosshair Circle Thickness",
    "Thickness",
    "rbxassetid://96264839713061",
    "",
    "Slider",
    2,
    0,
    16,
    1
);
add_setting(
    "Crosshair",
    "Crosshair Circle Transparency",
    "Transparency",
    "rbxassetid://96264839713061",
    "",
    "Slider",
    0,
    0,
    1,
    20,
    true
);
add_setting(
    "Crosshair",
    "Crosshair Circle Shape",
    "Shape",
    "rbxassetid://96264839713061",
    "",
    "Dropdown",
    "Circle",
    { "Circle", "Round", "Sharp" }
);
add_setting(
    "Crosshair",
    "Crosshair Outline Enabled",
    "Outline Enabled",
    "rbxassetid://17516823683",
    "",
    "Toggle",
    false
);
add_setting(
    "Crosshair",
    "Crosshair Outline Color",
    "Color",
    "rbxassetid://17516823683",
    "",
    "Color",
    "#000000"
);
add_setting(
    "Crosshair",
    "Crosshair Outline Thickness",
    "Thickness",
    "rbxassetid://17516823683",
    "",
    "Slider",
    1,
    0,
    16,
    1
);
add_setting(
    "Crosshair",
    "Crosshair Outline Transparency",
    "Transparency",
    "rbxassetid://17516823683",
    "",
    "Slider",
    0,
    0,
    1,
    20,
    true
);
add_setting(
    "Crosshair",
    "Crosshair Outline Type",
    "Type",
    "rbxassetid://17516823683",
    "",
    "Dropdown",
    "Miter",
    { "Miter", "Round", "Bevel" }
);
add_setting("Crosshair", "Crosshair - Hitmarker", "Hitmarker", "", "", "Divider");
add_setting(
    "Crosshair",
    "Crosshair Hitmarker Enabled",
    "Enabled",
    "rbxassetid://93990674888427",
    "",
    "Toggle",
    true
);
add_setting(
    "Crosshair",
    "Crosshair Hitmarker Scale",
    "Scale",
    "rbxassetid://115388073389430",
    "Make your hitmarker big or small",
    "Slider",
    1,
    0,
    4,
    20,
    true
);
add_setting(
    "Crosshair",
    "Crosshair Hitmarker Rotation",
    "Rotation",
    "rbxassetid://103847676236765",
    "0 or 45 recommended",
    "Slider",
    0,
    0,
    360,
    1
);
add_setting(
    "Crosshair",
    "Crosshair Hitmarker Transparency",
    "Transparency",
    "rbxassetid://91180498372634",
    "",
    "Slider",
    0,
    0,
    1,
    20,
    true
);
add_setting(
    "Crosshair",
    "Crosshair Hitmarker Color",
    "Color",
    "rbxassetid://93990674888427",
    "",
    "Color",
    "#ffffff"
);
add_setting(
    "Crosshair",
    "Crosshair Hitmarker Transparency Crit",
    "Critical Transparency",
    "rbxassetid://91180498372634",
    "",
    "Slider",
    0,
    0,
    1,
    20,
    true
);
add_setting(
    "Crosshair",
    "Crosshair Hitmarker Color Crit",
    "Critical Color",
    "rbxassetid://93990674888427",
    "",
    "Color",
    "#ff3232"
);
add_setting("Crosshair", "Crosshair - Scoped", "Scoped", "", "", "Divider");
add_setting(
    "Crosshair",
    "Crosshair Scoped Bars",
    "Bars Enabled",
    "rbxassetid://87834608236137",
    "Turn this off to hide the bars while aiming with a scoped weapon",
    "Toggle",
    true
);
add_setting(
    "Crosshair",
    "Crosshair Scoped Red Dot",
    "Dot Enabled",
    "rbxassetid://87834608236137",
    "Turn this off to hide the red dot while aiming with a scoped weapon",
    "Toggle",
    true
);
add_setting(
    "Crosshair",
    "Crosshair Scoped Red Dot Color",
    "Color",
    "rbxassetid://93990674888427",
    "Change the color of the red dot that scoped weapons display",
    "Color",
    "#ff3232"
);
add_setting(
    "Account",
    "Bounty Rewards Disabled",
    "Disable Bounty Rewards",
    "rbxassetid://133391928250838",
    "Prevents players from farming your charm, wrap, etc. We recommend keeping this setting off as much as possible",
    "Toggle",
    false
);
add_setting(
    "Account",
    "Staff Team Visuals",
    "Hide Team Visuals",
    "rbxassetid://95626460059631",
    "Hides your NG logo from showing up next to your name in the player list",
    "Toggle",
    false
);
add_setting(
    "Account",
    "Staff Team Tools Disabled",
    "Hide Team Tools",
    "rbxassetid://95626460059631",
    "Hides certain team tools that may be available to you from showing up in the topbar UI so that you can screenshare & record your gameplay without leaking anything",
    "Toggle",
    false
);
add_setting(
    "Account",
    "Staff Team Tools Disabled Leads",
    "Hide Team Lead Tools",
    "rbxassetid://95626460059631",
    "Hides team tools that only team leads can see. If you\'re not a team lead, this setting won\'t do anything",
    "Toggle",
    false
);
add_setting(
    "Account",
    "Staff Team Server Logs",
    "Hide Error Logs",
    "rbxassetid://95626460059631",
    "Prevents server error logs from showing up in the chat window",
    "Toggle",
    false
);
add_setting(
    "Account",
    "Staff Team Hidden Spectator",
    "Secret Spectator",
    "rbxassetid://95626460059631",
    "Hides you from the total spectators counter while spectating a duel that you\'re not a part of",
    "Toggle",
    false
);
add_setting("Account", "Account - Notifications", "Notifications", "", "", "Divider");
add_setting(
    "Account",
    "Notifications Delivery",
    "Delivery Mode",
    "rbxassetid://96509180790493",
    "Change the way you receive notifications. Change this to \"Lobby\" if you prefer notifications to wait until you finish a duel. Change this to \"Muted\" if you want notifications to go straight into your Inbox",
    "Dropdown",
    "Instant",
    { "Instant", "Lobby", "Muted" }
);
add_setting("Account", "Account - Privacy", "Privacy", "", "", "Divider");
add_setting(
    "Account",
    "Challenge Requests",
    "Challenge Requests",
    "rbxassetid://18525954682",
    "Allows players to send you 1v1 requests",
    "Dropdown",
    "Everyone",
    { "Everyone", "Friends", "Nobody" }
);
add_setting(
    "Account",
    "Party Invites",
    "Party Invites",
    "rbxassetid://118031781381166",
    "Allows players to send you invites to their party",
    "Dropdown",
    "Everyone",
    { "Everyone", "Friends", "Nobody" }
);
add_setting(
    "Account",
    "Receive Gifts",
    "Receive Gifts",
    "rbxassetid://127400882945494",
    "Allows you to receive gifts from other players",
    "Toggle",
    true
);
add_setting(
    "Touch",
    "Left Handed Touch Controls",
    "Left Handed Mode",
    "rbxassetid://98211826458757",
    "[Advanced] Mirrors the \"Joystick\" & the \"Double Tap To Attack\" hitboxes to better suit left handed players. Does not affect touch buttons",
    "Toggle",
    false
);
add_setting(
    "Touch",
    "Opaque Buttons While Scoped",
    "Opaque Buttons",
    "rbxassetid://87834608236137",
    "Turning this on makes all of your touch buttons opaque while scoped to help with visibility",
    "Toggle",
    true
);
add_setting(
    "Touch",
    "Mobile Buttons Transparency",
    "Buttons Transparency",
    "rbxassetid://129678163029799",
    "Changes the transparency of all of your touch buttons",
    "Slider",
    0.5,
    0,
    1,
    20,
    true
);
add_setting(
    "Touch",
    "Camera Mobile Button Sinking",
    "Buttons Camera Sinking",
    "rbxassetid://96518177763762",
    "[Advanced] While turned on, you can use a touch button and pan your camera at the same time",
    "Toggle",
    true
);
add_setting(
    "Touch",
    "Touch Button Ammo",
    "Show Weapon Ammo",
    "rbxassetid://16539130428",
    "Displays your weapon\'s ammo on the respective touch buttons to see from a quick glance",
    "Toggle",
    true
);
(function() -- Line: 342, Name: setup_hotkeys
    -- upvalues: CONSTANTS (copy), u2 (copy), add_hotkey_setting (copy)
    for i = CONSTANTS.MAX_EQUIPPABLE_EMOTES, 1, -1 do
        local HOTKEYS_GUIDE = u2.HOTKEYS_GUIDE;
        local v77 = table.find(u2.HOTKEYS_GUIDE, "UseEmote") + 1;
        table.insert(HOTKEYS_GUIDE, v77, "UseEmote" .. i);
        local _ = i;
    end;

    for _, v in pairs(u2.HOTKEYS_GUIDE) do
        if v ~= "Divider" then
            add_hotkey_setting(v);
        end;
    end;
end)();
(function() -- Line: 358, Name: setup_touch
    -- upvalues: InputLibrary (copy), u1 (copy), add_setting (copy)
    local v78 = {};

    for i in pairs(InputLibrary.MobileButtons) do
        table.insert(v78, i);
    end;

    table.sort(v78, function(p79, p80) -- Line: 367
        -- upvalues: u1 (ref), InputLibrary (ref)
        return (table.find(u1, InputLibrary.MobileButtons[p79].InputName) or (1 / 0)) < (table.find(u1, InputLibrary.MobileButtons[p80].InputName) or (1 / 0));
    end);

    for _, v in pairs(v78) do
        local v81 = InputLibrary.MobileButtons[v];
        local DisplayName = InputLibrary.Inputs[v81.InputName].DisplayName;
        local v82 = "MobileButton " .. v;
        add_setting("Touch", "Touch" .. " - " .. DisplayName, DisplayName, v81.Image or "", "", "Divider");

        if v == "mobile_crouch" then
            add_setting(
                "Touch",
                "Easy Slide Mobile",
                "Easy Slide",
                "rbxassetid://17674207175",
                "[Advanced] While turned on, your Crouch button turns into a Slide button while sprinting. If you turn this off, you should enable the dedicated Slide button in your settings. Only available for Touch Controls",
                "Toggle",
                true
            );
        elseif v == "mobile_jump" then
            add_setting(
                "Touch",
                "Auto Jump",
                "Auto Jump",
                "rbxassetid://18436038478",
                "Automatically jump near ledges & walls. Only available for Touch Controls",
                "Toggle",
                true
            );
        elseif v == "mobile_shoot" then
            add_setting(
                "Touch",
                "Double Tap Shoot",
                "Double Tap To Attack",
                "rbxassetid://101488932151631",
                "While turned on, you can double tap the right half of your screen to attack",
                "Toggle",
                true
            );
            add_setting(
                "Touch",
                "Double Tap Shoot Window",
                "Double Tap Window",
                "rbxassetid://101488932151631",
                "[Advanced] How much time, in seconds, you have to tap again to start shooting",
                "Slider",
                0.25,
                0,
                1,
                20
            );
        end;

        add_setting("Touch", v82 .. " Enabled", "Enabled", "rbxassetid://77908042044589", "Allows you to turn this specific button on/off" .. (v == "mobile_slide" and ". Enabling this dedicated Slide button will override your Crouch button\'s Easy Slide setting" or ""), "Toggle", v81.DefaultVisibility);
        add_setting("Touch", v82 .. " Override", "Custom", "rbxassetid://14641612286", "[Advanced] Turn this on to enable custom settings for this button specifically. This will override any global setting from above", "Toggle", false);
        add_setting("Touch", v82 .. " Transparency", "Transparency", "rbxassetid://129678163029799", "[Advanced] Change the transparency of this button specifically", "Slider", 0.5, 0, 1, 20, true);
        add_setting("Touch", v82 .. " Camera Sinking", "Camera Sinking", "rbxassetid://96518177763762", "[Advanced] While turned on, you can use pan your camera while using this button specifically at the same time", "Toggle", true);
    end;
end)();
(function() -- Line: 399, Name: setup_dependencies
    -- upvalues: InputLibrary (copy), u2 (copy)
    for i, _ in pairs(InputLibrary.MobileButtons) do
        local v83 = "MobileButton " .. i;
        local _ = v83 .. " Enabled";
        local v84 = v83 .. " Override";

        for _, v in pairs({ "Transparency", "Camera Sinking" }) do
            u2.DEPENDENCIES[v83 .. " " .. v] = { v84, true };
        end;
    end;

    for _, v in pairs({ "Bars", "Dot", "Circle", "Outline", "Hitmarker" }) do
        local v85 = "Crosshair " .. v;
        local v86 = v85 .. " Enabled";
        local v87 = #v + 10;

        for _, v2 in pairs(u2.Order) do
            if v2.Name ~= v86 and string.sub(v2.Name, 1, v87) == v85 then
                u2.DEPENDENCIES[v2.Name] = { v86, true };
            end;
        end;
    end;

    u2.DEPENDENCIES["Crosshair Scoped Red Dot Color"] = { "Crosshair Scoped Red Dot", true };

    for _, v in pairs(u2.Order) do
        if not (u2.DEPENDENCIES[v.Name] or (v.Name == "Crosshair Disabled" or (v.Name == "Crosshair - Crosshair" or (v.Name == "Crosshair - Hitmarker" or (v.Name == "Crosshair - Scoped" or (string.sub(v.Name, 1, 20) == "Crosshair Hitmarker " or (string.sub(v.Name, 1, 17) == "Crosshair Scoped " or string.sub(v.Name, 1, 10) ~= "Crosshair "))))))) then
            u2.DEPENDENCIES[v.Name] = { "Crosshair Disabled", false };
        end;
    end;
end)();

return u2;