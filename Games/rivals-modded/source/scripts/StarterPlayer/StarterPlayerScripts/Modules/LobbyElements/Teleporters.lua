-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 9
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._ModelAdded(p4, p5) -- Line: 27
    -- upvalues: Players (copy)
    local From = p5:WaitForChild("From");
    local To = p5:WaitForChild("To");
    local u6 = 0;
    From.Touched:Connect(function(p7) -- Line: 32
        -- upvalues: u6 (ref), Players (ref), To (copy)
        if u6 < tick() and (p7 and (p7.AssemblyRootPart and (p7.AssemblyRootPart.Parent and Players:GetPlayerFromCharacter(p7.AssemblyRootPart.Parent) == Players.LocalPlayer))) then
            u6 = tick() + 1;
            p7.AssemblyRootPart.Parent.HumanoidRootPart.CFrame = CFrame.new(To.Position) * p7.AssemblyRootPart.Parent.HumanoidRootPart.CFrame.Rotation;
        end;
    end);
end;

function u1._Init(u8) -- Line: 40
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyTeleporter"):Connect(function(p9) -- Line: 41
        -- upvalues: u8 (copy)
        u8:_ModelAdded(p9);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyTeleporter")) do
        task.defer(u8._ModelAdded, u8, v);
    end;
end;

return u1._new();