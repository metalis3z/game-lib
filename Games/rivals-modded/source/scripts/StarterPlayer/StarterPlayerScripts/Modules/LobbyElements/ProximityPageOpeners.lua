-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 12
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._PartAdded(p4, u5) -- Line: 30
    -- upvalues: Pages (copy), Players (copy), Utility (copy)
    local Attribute = u5:GetAttribute("PageName");
    local u6 = false;
    u5.Touched:Connect(function(p7) -- Line: 34
        -- upvalues: u6 (ref), Pages (ref), Players (ref), Attribute (copy), Utility (ref), u5 (copy)
        if u6 or (Pages.PageSystem.CurrentPage or not (p7.AssemblyRootPart and (p7.AssemblyRootPart.Parent and Players:GetPlayerFromCharacter(p7.AssemblyRootPart.Parent) == Players.LocalPlayer))) then
            return;
        end;

        u6 = true;
        Pages.PageSystem:OpenPage(Attribute, true);

        while p7:IsDescendantOf(workspace) and Utility:IsWithinPart(u5, p7.Position, Vector3.new(1, 1, 1) * math.max(p7.Size.X, p7.Size.Y, p7.Size.Z) * 5) do
            wait(0.1);
        end;

        u6 = false;

        if Pages.PageSystem.CurrentPage and Pages.PageSystem.CurrentPage.Name == Attribute then
            Pages.PageSystem:CloseCurrentPage();
        end;
    end);
end;

function u1._Init(u8) -- Line: 54
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("ProximityPageOpener"):Connect(function(p9) -- Line: 55
        -- upvalues: u8 (copy)
        u8:_PartAdded(p9);
    end);

    for _, v in pairs(CollectionService:GetTagged("ProximityPageOpener")) do
        task.defer(u8._PartAdded, u8, v);
    end;
end;

return u1._new();