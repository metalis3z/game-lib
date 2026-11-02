-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TeleportService = game:GetService("TeleportService");
local Players = game:GetService("Players");
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 12
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._default_settings_cooldown = 0;
    v2:_Init();

    return v2;
end;

function u1.GetMobileButtonSetting(p3, p4, p5, p6, u7) -- Line: 26
    -- upvalues: PlayerDataController (copy)
    local function get(p8) -- Line: 27
        -- upvalues: u7 (copy), PlayerDataController (ref)
        if u7 and u7[p8] ~= nil then
            return u7[p8];
        end;

        return PlayerDataController:GetSetting(p8);
    end;

    local v9;

    if p6 then
        v9 = "MobileButton " .. p4 .. " " .. p6;
    else
        v9 = nil;
    end;

    if v9 and PlayerDataController:GetSetting("MobileButton " .. p4 .. " Override") then
        if u7 and u7[v9] ~= nil then
            return u7[v9];
        end;

        return PlayerDataController:GetSetting(v9);
    end;

    if not p5 then
        return nil;
    end;

    if u7 and u7[p5] ~= nil then
        return u7[p5];
    end;

    return PlayerDataController:GetSetting(p5);
end;

function u1.SwitchSettingsProfile(p10, p11) -- Line: 39
    -- upvalues: ReplicatedStorage (copy)
    local v12 = typeof(p11) == "number";
    assert(v12);
    ReplicatedStorage.Remotes.Data.SwitchSettingsProfile:FireServer(p11);
end;

function u1.ChangeSetting(p13, p14, p15) -- Line: 44
    p13:ChangeSettings({
        { p14, p15 }
    });
end;

function u1.ChangeSettings(p16, p17) -- Line: 48
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Data.ChangeSettings:FireServer(p17);
end;

function u1.DefaultSettings(p18, p19) -- Line: 52
    -- upvalues: ReplicatedStorage (copy)
    if tick() < p18._default_settings_cooldown then
        return;
    end;

    p18._default_settings_cooldown = tick() + 1;
    ReplicatedStorage.Remotes.Data.DefaultSettings:FireServer(p19);
end;

function u1._ResetHUDSetting(p20) -- Line: 65
    -- upvalues: TeleportService (copy)
    if TeleportService:GetTeleportSetting("DontResetHUDSetting") then
        return;
    end;

    TeleportService:SetTeleportSetting("DontResetHUDSetting", true);
    p20:ChangeSetting("Hide HUD", false);
end;

function u1._Init(p21) -- Line: 74
    task.defer(p21._ResetHUDSetting, p21);
end;

return u1._new();