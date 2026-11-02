-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("HttpService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u2 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Controllers.ControlsController);
local u3 = {
    MouseWheel = "MouseWheel",
    MouseButton1 = "MB1",
    MouseButton2 = "MB2",
    MouseButton3 = "MB3",
    LeftControl = "LCtrl",
    RightControl = "RCtrl",
    LeftShift = "LShift",
    RightShift = "RShift",
    Zero = "0",
    Tab = "Tab",
    LeftAlt = "LAlt",
    RAlt = "RAlt",
    Space = "Space",
    Up = "⬆",
    Down = "⬇",
    Left = "⬅",
    Right = "➡"
};
local u4 = { "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Zero" };
local u5 = {
    MouseKeyboard = { "Hotkey MouseKeyboard%s1", "Hotkey MouseKeyboard%s2" },
    Gamepad = { "Hotkey Gamepad%s1", "Hotkey Gamepad%s2" }
};
local u6 = {
    Short = {
        Base = "rbxassetid://16491694294",
        Pressed = "rbxassetid://16491693602",
        DisplayString = nil
    },
    Long = {
        Base = "rbxassetid://16491693870",
        Pressed = "rbxassetid://16491693385",
        DisplayString = nil
    },
    MB1 = {
        Base = "rbxassetid://13194849055",
        Pressed = "rbxassetid://13194848851",
        DisplayString = ""
    },
    MB2 = {
        Base = "rbxassetid://13194848725",
        Pressed = "rbxassetid://13194848539",
        DisplayString = ""
    },
    MB3 = {
        Base = "rbxassetid://115443077181302",
        Pressed = "rbxassetid://121057755614364",
        DisplayString = ""
    }
};
local u7 = {
    HOTKEY_FORMATS = u5,
    Inputs = {},
    ItemInputs = {},
    ItemInputTypeToName = {},
    MobileButtons = {},
    MobileInputNameToItemIndex = {}
};

function u7.GetInputName(p8, p9) -- Line: 42
    -- upvalues: u7 (copy)
    for i in pairs(u7.Inputs) do
        if p8:InputIs(i, p9) then
            return i;
        end;
    end;
end;

function u7.GetInputs(p10, p11, p12) -- Line: 52
    -- upvalues: u7 (copy), u5 (copy), u2 (copy), Utility (copy), u1 (copy)
    local v13 = u7.Inputs[p11];

    if v13 then
        if not v13.IsHotkey then
            return v13.InputEnums[p12 or u2.CurrentControls];
        end;

        local v14 = {};

        for _, v in pairs(u5[p12 or u2.CurrentControls] or {}) do
            local string_format_ret = string.format(v, p11);
            table.insert(v14, Utility:GetInputEnumFromName(u1:GetSetting(string_format_ret)));
        end;

        return v14;
    end;
end;

function u7.GetInputIcons(p15, u16, u17) -- Line: 75
    -- upvalues: UserInputService (copy), u6 (copy)
    local success, result = pcall(function() -- Line: 76
        -- upvalues: UserInputService (ref), u16 (copy), u17 (copy)
        return UserInputService:GetImageForKeyCode(Enum[u16][u17]);
    end);

    if success and result ~= "" then
        return result, result, "";
    end;

    local InputString = p15:GetInputString(u16, u17);
    local v18 = u6[InputString] or u6[utf8.len(InputString) == 1 and "Short" or "Long"];

    return v18.Base, v18.Pressed, v18.DisplayString or InputString;
end;

function u7.GetInputString(p19, p20, p21) -- Line: 91
    -- upvalues: u3 (copy), u4 (copy), UserInputService (copy)
    local v22 = u3[p21];

    if v22 then
        return v22;
    end;

    local table_find_ret = table.find(u4, p21);

    if table_find_ret then
        return tostring(table_find_ret);
    end;

    local success, result = pcall(UserInputService.GetStringForKeyCode, UserInputService, Enum[p20][p21]);

    if not success or utf8.len(result) == 0 then
        return p21;
    end;

    if #result > 6 and string.sub(result, 1, 6) == "Button" then
        return string.sub(result, 7);
    end;

    if #result > 4 and string.sub(result, 1, 4) == "DPad" then
        return string.sub(result, 5);
    end;

    return result;
end;

function u7.GetInputIconsByInputName(p23, p24, p25) -- Line: 116
    -- upvalues: u6 (copy)
    local v26 = p23:FindFirstEnum(p24, p25);

    if v26 then
        return p23:GetInputIcons(tostring(v26.EnumType), v26.Name);
    end;

    return u6.Short.Base, u6.Short.Pressed, "";
end;

function u7.FindFirstEnum(p27, p28, p29) -- Line: 127
    local Inputs = p27:GetInputs(p28, p29);

    if Inputs then
        Inputs = Inputs[1];
    end;

    return Inputs;
end;

function u7.InputIs(p30, p31, p32) -- Line: 134
    -- upvalues: u7 (copy)
    local v33 = u7.Inputs[p32];
    local Inputs = p30:GetInputs(p32);

    if p31 == p32 or v33 and v33.MobileInputName == p31 then
        Inputs = true;
    elseif Inputs then
        Inputs = table.find(Inputs, p31.KeyCode) or table.find(Inputs, p31.UserInputType);
    end;

    return Inputs;
end;

function u7.IsInputDown(p34, p35, p36) -- Line: 142
    -- upvalues: u2 (copy)
    if u2:IsInputDown(p35) then
        return true;
    end;

    for _, v in pairs(p34:GetInputs(p35) or {}) do
        if not (p36 and table.find(p36, v)) and u2:IsInputDown(v) then
            return true;
        end;
    end;
end;

local function add_input(p37, p38, p39, p40, p41, p42, p43, p44) -- Line: 158
    -- upvalues: u7 (copy)
    local v45 = {
        MobileInputName = nil,
        IsItemInput = p37 or false,
        IsHotkey = p38 or false,
        InputName = p39,
        StartName = "Start" .. p39 .. "ing",
        FinishName = "Finish" .. p39 .. "ing",
        DisplayName = p40,
        Image = p41,
        InputEnums = {
            MouseKeyboard = p42 or {},
            Gamepad = p43 or {},
            Touch = {},
            VR = p44 or {}
        }
    };
    u7.Inputs[p39] = v45;

    if p37 then
        table.insert(u7.ItemInputs, p39);
        u7.ItemInputTypeToName[v45.StartName] = p39;
        u7.ItemInputTypeToName[v45.FinishName] = p39;
    end;
end;

add_input(true, true, "Inspect", "Inspect", "rbxassetid://17513805400", { Enum.KeyCode.V }, { Enum.KeyCode.DPadDown }, nil);
add_input(true, true, "Shoot", "Attack", "rbxassetid://17513805027", { Enum.UserInputType.MouseButton1 }, { Enum.KeyCode.ButtonR2 }, { Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2 });
add_input(true, true, "Aim", "Ability", "rbxassetid://17513805525", { Enum.UserInputType.MouseButton2, Enum.KeyCode.E }, { Enum.KeyCode.ButtonL2 }, { Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL1 });
add_input(true, true, "Reload", "Reload", "rbxassetid://17513813485", { Enum.KeyCode.R }, { Enum.KeyCode.ButtonX }, { Enum.KeyCode.ButtonY });
add_input(true, true, "Sprint", "Sprint", "rbxassetid://17513821002", { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift }, { Enum.KeyCode.ButtonL3 }, { Enum.KeyCode.ButtonL3 });
add_input(nil, true, "Crouch", "Crouch", "rbxassetid://17513805623", { Enum.KeyCode.LeftControl, Enum.KeyCode.C }, { Enum.KeyCode.ButtonB }, { Enum.KeyCode.ButtonB });
add_input(nil, true, "Slide", "Slide", "rbxassetid://17524267716", nil, nil, nil);
add_input(nil, true, "SwitchCameraPOV", "Camera", "rbxassetid://17548980857", { Enum.KeyCode.B }, { Enum.KeyCode.DPadUp }, nil);
add_input(nil, true, "EquipPrimary", "Equip Primary", "rbxassetid://17539215512", { Enum.KeyCode.One }, nil, nil);
add_input(nil, true, "EquipSecondary", "Equip Secondary", "rbxassetid://17539215639", { Enum.KeyCode.Two }, nil, nil);
add_input(nil, true, "EquipMelee", "Equip Melee", "rbxassetid://17539235478", { Enum.KeyCode.Three }, nil, nil);
add_input(nil, true, "EquipUtility", "Equip Utility", "rbxassetid://17539235638", { Enum.KeyCode.Four }, nil, nil);
add_input(nil, true, "EquipLast", "Equip Previous Weapon", "rbxassetid://17513804864", nil, { Enum.KeyCode.ButtonL1 }, nil);
add_input(nil, true, "EquipNext", "Equip Next Weapon", "rbxassetid://17513804705", nil, { Enum.KeyCode.ButtonR1 }, { Enum.KeyCode.ButtonX });
add_input(nil, true, "Jump", "Jump", "rbxassetid://17513836637", { Enum.KeyCode.Space }, { Enum.KeyCode.ButtonA }, { Enum.KeyCode.ButtonA });
add_input(nil, true, "QuickMelee", "Quick Melee", "rbxassetid://17506296977", { Enum.KeyCode.F }, { Enum.KeyCode.ButtonR3 }, nil);
add_input(nil, true, "QuickUtility", "Quick Utility", "rbxassetid://17513805716", { Enum.KeyCode.G }, { Enum.KeyCode.ButtonY }, nil);
add_input(nil, true, "Ping", "Signal", "rbxassetid://17269776216", { Enum.UserInputType.MouseButton3 }, nil, nil);
add_input(nil, true, "OpenPlayerList", "Open Scoreboard", "rbxassetid://17513827700", { Enum.KeyCode.Tab, Enum.KeyCode.LeftAlt }, { Enum.KeyCode.DPadLeft }, nil);
add_input(nil, true, "SpectateLast", "Spectate Previous Player", "rbxassetid://77908042044589", { Enum.UserInputType.MouseButton1 }, nil, nil);
add_input(nil, true, "SpectateNext", "Spectate Next Player", "rbxassetid://77908042044589", { Enum.UserInputType.MouseButton2 }, { Enum.KeyCode.DPadRight }, nil);
add_input(nil, true, "SpectateExit", "Stop Spectating", "rbxassetid://77908042044589", { Enum.KeyCode.M }, { Enum.KeyCode.DPadDown }, nil);
add_input(nil, true, "SwitchItems", "Switch Weapons", "rbxassetid://13667080363", { Enum.KeyCode.M }, { Enum.KeyCode.DPadDown }, nil);
add_input(nil, true, "LeaveDuel", "Leave Duel", "rbxassetid://17498605048", { Enum.KeyCode.M }, { Enum.KeyCode.DPadDown }, nil);
add_input(nil, true, "UseEmote", "Emote", "rbxassetid://82983645557125", { Enum.KeyCode.T }, { Enum.KeyCode.DPadRight }, nil);
add_input(nil, true, "HideHUD", "Hide HUD", "rbxassetid://126633805196326", nil, nil, nil);
add_input(nil, true, "WalkForward", "Walk Forward", "rbxassetid://102807333252186", { Enum.KeyCode.W, Enum.KeyCode.Up }, nil, nil);
add_input(nil, true, "WalkBackward", "Walk Backward", "rbxassetid://92032489827936", { Enum.KeyCode.S, Enum.KeyCode.Down }, nil, nil);
add_input(nil, true, "WalkLeftward", "Strafe Left", "rbxassetid://107466029361522", { Enum.KeyCode.A }, nil, nil);
add_input(nil, true, "WalkRightward", "Strafe Right", "rbxassetid://118121732524898", { Enum.KeyCode.D }, nil, nil);

for i = 1, CONSTANTS.MAX_EQUIPPABLE_EMOTES do
    add_input(nil, true, "UseEmote" .. i, "Quick Emote " .. i, "rbxassetid://82983645557125", nil, nil, nil);
    local _ = i;
end;

add_input(nil, nil, "LeanLeft", "Lean Left", "rbxassetid://17513844569", nil, nil, nil);
add_input(nil, nil, "LeanRight", "Lean Right", "rbxassetid://17513844569", nil, nil, nil);
add_input(nil, nil, "UICancelAction", "UI Cancel Action", "rbxassetid://17136633629", { Enum.KeyCode.Backspace, Enum.KeyCode.Escape }, { Enum.KeyCode.ButtonB }, nil);
add_input(nil, nil, "UIPrimaryAction", "UI Primary Action", "rbxassetid://17136633629", nil, { Enum.KeyCode.ButtonX }, nil);
add_input(nil, nil, "UISecondaryAction", "UI Secondary Action", "rbxassetid://17136633629", nil, { Enum.KeyCode.ButtonY }, nil);
add_input(nil, nil, "UITertiaryAction", "UI Tertiary Action", "rbxassetid://17136633629", nil, { Enum.KeyCode.ButtonL1 }, nil);
add_input(nil, nil, "UIQuaternaryAction", "UI Quaternary Action", "rbxassetid://17136633629", nil, { Enum.KeyCode.ButtonR1 }, nil);
add_input(nil, nil, "UIOpenPage1", "UI Open Page 1", "rbxassetid://17136633629", nil, { Enum.KeyCode.DPadLeft }, nil);
add_input(nil, nil, "UIOpenPage2", "UI Open Page 2", "rbxassetid://17136633629", nil, { Enum.KeyCode.DPadDown }, nil);
add_input(nil, nil, "UIOpenPage3", "UI Open Page 3", "rbxassetid://17136633629", nil, { Enum.KeyCode.DPadRight }, nil);
add_input(nil, nil, "UIOpenPage4", "UI Open Page 4", "rbxassetid://17136633629", nil, { Enum.KeyCode.DPadUp }, nil);

local function add_mobile_button(p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57) -- Line: 233
    -- upvalues: u7 (copy)
    local v58 = {
        IsCoreInput = p46 or false,
        InputName = p49,
        Image = p50 or "rbxassetid://13695061446",
        DefaultVisibility = not p47,
        DefaultPosition = p51,
        DefaultSize = p52,
        AlwaysVisible = p53,
        AlwaysToggle = p54,
        VisibleWhileSpectatingForeignDuel = p56,
        HideIfDead = not p55
    };

    for i, v in pairs(p57 or {}) do
        v58[i] = v;
    end;

    u7.MobileButtons[p48] = v58;
    u7.Inputs[p49].MobileInputName = p48;

    if v58.ItemIndex then
        u7.MobileInputNameToItemIndex[p48] = v58.ItemIndex;
    end;
end;

add_mobile_button(nil, nil, "mobile_aim", "Aim", "rbxassetid://13774376480", UDim2.new(1, -90, 1, -185), UDim2.new(0, 70, 0, 70));
add_mobile_button(nil, nil, "mobile_shoot", "Shoot", "rbxassetid://13774376715", UDim2.new(1, -160, 1, -150), UDim2.new(0, 70, 0, 70));
add_mobile_button(nil, nil, "mobile_reload", "Reload", "rbxassetid://13774376638", UDim2.new(1, -230, 1, -130), UDim2.new(0, 50, 0, 50));
add_mobile_button(nil, nil, "mobile_inspect", "Inspect", "rbxassetid://13774376564", UDim2.new(0, 90, 0, 80), UDim2.new(0, 40, 0, 40));
add_mobile_button(nil, nil, "mobile_quickmelee", "QuickMelee", "rbxassetid://13814923695", UDim2.new(1, -85, 0, 100), UDim2.new(0, 30, 0, 30), true, nil, nil, nil, {
    QuickAttackType = "Melee"
});
add_mobile_button(nil, nil, "mobile_quickutility", "QuickUtility", "rbxassetid://16600936252", UDim2.new(1, -40, 0, 100), UDim2.new(0, 30, 0, 30), true, nil, nil, nil, {
    QuickAttackType = "Utility"
});
add_mobile_button(true, nil, "mobile_crouch", "Crouch", "rbxassetid://13814923555", UDim2.new(1, -185, 1, -75), UDim2.new(0, 70, 0, 70), true, true);
add_mobile_button(true, true, "mobile_slide", "Slide", "rbxassetid://17674207175", UDim2.new(1, -270, 1, -75), UDim2.new(0, 70, 0, 70), true);
add_mobile_button(true, nil, "mobile_jump", "Jump", "rbxassetid://13774392305", UDim2.new(1, -90, 1, -90), UDim2.new(0, 80, 0, 80), true);
add_mobile_button(true, nil, "mobile_switchcamerapov", "SwitchCameraPOV", "rbxassetid://137766393325923", UDim2.new(0, 40, 0, 80), UDim2.new(0, 40, 0, 40), true, nil, true, true);
add_mobile_button(nil, nil, "mobile_openplayerlist", "OpenPlayerList", "rbxassetid://17319839617", UDim2.new(0, 140, 0, 80), UDim2.new(0, 40, 0, 40), true, nil, true, true);
add_mobile_button(nil, nil, "mobile_equipprimary", "EquipPrimary", "rbxassetid://124117259408457", UDim2.new(1, -175, 0, 60), UDim2.new(0, 40, 0, 40), true, nil, nil, nil, {
    ItemIndex = 1
});
add_mobile_button(nil, nil, "mobile_equipsecondary", "EquipSecondary", "rbxassetid://87384533585497", UDim2.new(1, -130, 0, 60), UDim2.new(0, 40, 0, 40), true, nil, nil, nil, {
    ItemIndex = 2
});
add_mobile_button(nil, nil, "mobile_equipmelee", "EquipMelee", "rbxassetid://124237418792068", UDim2.new(1, -85, 0, 60), UDim2.new(0, 40, 0, 40), true, nil, nil, nil, {
    ItemIndex = 3
});
add_mobile_button(nil, nil, "mobile_equiputility", "EquipUtility", "rbxassetid://112565014737738", UDim2.new(1, -40, 0, 60), UDim2.new(0, 40, 0, 40), true, nil, nil, nil, {
    ItemIndex = 4
});
add_mobile_button(nil, nil, "mobile_useemote", "UseEmote", "rbxassetid://137981590006803", UDim2.new(0, 190, 0, 80), UDim2.new(0, 40, 0, 40), true);

return u7;