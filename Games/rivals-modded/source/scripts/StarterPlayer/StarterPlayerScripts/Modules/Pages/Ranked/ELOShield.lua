-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("ELOShield");
    v3.Title = v3.Frame:WaitForChild("Title");
    v3.LeftIcon = v3.Title:WaitForChild("Left");
    v3.RightIcon = v3.Title:WaitForChild("Right");
    v3:_Init();

    return v3;
end;

function u1.Open(p4) -- Line: 28
    p4:_Update();
end;

function u1.Close(p5) -- Line: 32
end;

function u1._UpdateIcons(p6) -- Line: 40
    p6.LeftIcon.Position = UDim2.new(0.5, -p6.Title.TextBounds.X / 2, 0.5, 0);
    p6.RightIcon.Position = UDim2.new(0.5, p6.Title.TextBounds.X / 2, 0.5, 0);
end;

function u1._Update(p7) -- Line: 45
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy)
    local v8 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v8 then
        v8 = v8.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    end;

    if v8 then
        v8 = v8.ELOShieldsRemaining > 0;
    end;

    p7.Frame.Visible = v8;
    p7:_UpdateIcons();
end;

function u1._Init(u9) -- Line: 53
    u9.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 54
        -- upvalues: u9 (copy)
        u9:_UpdateIcons();
    end);
    u9:_UpdateIcons();
end;

return u1;