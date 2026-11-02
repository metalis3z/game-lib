-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local FinisherPlayer = require(script:WaitForChild("FinisherPlayer"));
local EmotePlayer = require(script:WaitForChild("EmotePlayer"));
local UnlockModel = require(script:WaitForChild("UnlockModel"));
local EquipmentScenes = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("EquipmentScenes");
local u1 = { "Default", "Green Screen", "Pink Screen", "Blue Screen" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 18
    -- upvalues: u2 (copy), EquipmentScenes (copy), EventLibrary (copy), FinisherPlayer (copy), EmotePlayer (copy), UnlockModel (copy)
    local v4 = setmetatable({}, u2);
    v4.Equipment = p3;
    v4.Model = (EquipmentScenes:FindFirstChild(EventLibrary.LOBBY_VISUALS_PROFILE) or EquipmentScenes:WaitForChild("Default")):Clone();
    v4.FinisherPlayer = FinisherPlayer.new(v4);
    v4.EmotePlayer = EmotePlayer.new(v4);
    v4.UnlockModel = UnlockModel.new(v4);
    v4._backgrounds_folder = v4.Model:WaitForChild("Backgrounds");
    v4._hide_career_folder = v4._backgrounds_folder:WaitForChild("Default"):WaitForChild("HideCareer");
    v4._backgrounds = {};
    v4._dof = Instance.new("DepthOfFieldEffect");
    v4:_Init();

    return v4;
end;

function u2.GetCFrame(p5) -- Line: 41
    return p5.Model.Primary.CFrame;
end;

function u2.GetHumanoidCFrame(p6) -- Line: 45
    return p6.FinisherPlayer:GetHumanoidCFrame();
end;

function u2.OnOpen(p7, ...) -- Line: 49
    p7.Model.Parent = p7.Equipment.IsOpen and workspace or nil;
    p7:_UpdateDOF();
    p7.UnlockModel:OnOpen(...);
end;

function u2.OnCustomizingStateChanged(p8, ...) -- Line: 56
    p8.FinisherPlayer:OnCustomizingStateChanged(...);
    p8.EmotePlayer:OnCustomizingStateChanged(...);
end;

function u2.OnStateChanged(p9, ...) -- Line: 61
    p9.FinisherPlayer:OnStateChanged(...);
    p9.EmotePlayer:OnStateChanged(...);
    p9.UnlockModel:OnStateChanged(...);
end;

function u2._UpdateDOF(p10) -- Line: 71
    -- upvalues: Lighting (copy)
    local _dof = p10._dof;
    local v11;

    if p10.Equipment.IsOpen and p10.Equipment:IsOpenEffectDone() ~= p10.Equipment.Camera:IsClosing() then
        v11 = Lighting or nil;
    else
        v11 = nil;
    end;

    _dof.Parent = v11;
end;

function u2._UpdateCareerFolder(p12) -- Line: 75
    local v13 = p12.Equipment:IsCareerPageOpen();
    local CustomizingType = p12.Equipment:GetCustomizingType();
    local v14;

    if v13 or (CustomizingType == "Finisher" and true or CustomizingType == "Emote") then
        v14 = nil;
    else
        v14 = p12._backgrounds.Default or nil;
    end;

    p12._hide_career_folder.Parent = v14;
end;

function u2._UpdateBackgroundFolder(p15) -- Line: 83
    -- upvalues: PlayerDataController (copy)
    local Setting = PlayerDataController:GetSetting("Equipment Background");

    for i, v in pairs(p15._backgrounds) do
        local v16;

        if i == Setting then
            v16 = p15._backgrounds_folder or nil;
        else
            v16 = nil;
        end;

        v.Parent = v16;
    end;
end;

function u2._Setup(p17) -- Line: 91
    -- upvalues: u1 (copy)
    for _, v in pairs(u1) do
        p17._backgrounds[v] = p17._backgrounds_folder:WaitForChild(v);
    end;

    p17._dof.FarIntensity = 0.75;
    p17._dof.FocusDistance = 0.05;
    p17._dof.InFocusRadius = 15;
    p17._dof.NearIntensity = 0;
    p17._dof.Name = "Equipment";
end;

function u2._Init(u18) -- Line: 103
    -- upvalues: PlayerDataController (copy)
    u18.Equipment.CareerPageOpened:Connect(function() -- Line: 104
        -- upvalues: u18 (copy)
        u18:_UpdateCareerFolder();
    end);
    u18.Equipment.CustomizingChanged:Connect(function() -- Line: 108
        -- upvalues: u18 (copy)
        u18:_UpdateCareerFolder();
    end);
    u18.Equipment.FinishedOpenEffect:Connect(function() -- Line: 112
        -- upvalues: u18 (copy)
        u18:_UpdateDOF();
    end);
    PlayerDataController:GetSettingChangedSignal("Equipment Background"):Connect(function() -- Line: 116
        -- upvalues: u18 (copy)
        u18:_UpdateBackgroundFolder();
    end);
    u18:_Setup();
    u18:_UpdateCareerFolder();
    u18:_UpdateBackgroundFolder();
end;

return u2;