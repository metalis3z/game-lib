-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local StaticViewModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel.StaticViewModel);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 12
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._ModelAdded(p4, p5) -- Line: 30
    -- upvalues: SeasonLibrary (copy), StaticViewModel (copy)
    local TopPlayerRewardSkinName = SeasonLibrary.CurrentSeason.TopPlayerRewardSkinName;
    p5:WaitForChild("NeonCone").Transparency = not TopPlayerRewardSkinName and 1 or p5:WaitForChild("NeonCone").Transparency;
    local Neon = p5:WaitForChild("Neon");
    local v6;

    if TopPlayerRewardSkinName then
        v6 = Enum.Material.Neon;
    else
        v6 = Enum.Material.SmoothPlastic;
    end;

    Neon.Material = v6;

    if not TopPlayerRewardSkinName then
        return;
    end;

    local v7 = StaticViewModel.new(TopPlayerRewardSkinName);
    v7:ScaleTo(3.25);
    v7:PivotTo(p5:WaitForChild("Preview").CFrame);
    v7:SetParent(p5:WaitForChild("Preview"));
end;

function u1._Init(u8) -- Line: 46
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyTopPlayerReward"):Connect(function(p9) -- Line: 47
        -- upvalues: u8 (copy)
        u8:_ModelAdded(p9);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyTopPlayerReward")) do
        task.defer(u8._ModelAdded, u8, v);
    end;
end;

return u1._new();