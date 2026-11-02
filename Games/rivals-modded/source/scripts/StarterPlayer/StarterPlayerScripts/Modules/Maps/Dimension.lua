-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local ClientMap = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientDuel.ClientMap);
local u1 = setmetatable({}, ClientMap);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: ClientMap (copy), u1 (copy)
    local v2 = ClientMap.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Entrance = v3.Model:WaitForChild("Portals"):WaitForChild("Entrance"):WaitForChild("Hitbox");
    v3.Exit = v3.Model:WaitForChild("Portals"):WaitForChild("Exit"):WaitForChild("Hitbox");
    v3._teleport_cooldown = 0;
    v3:_Init();

    return v3;
end;

function u1._Init(u4) -- Line: 34
    -- upvalues: Players (copy), FighterController (copy), Utility (copy)
    u4.Entrance.Touched:Connect(function(p5) -- Line: 35
        -- upvalues: u4 (copy), Players (ref), FighterController (ref), Utility (ref)
        if tick() < u4._teleport_cooldown then
            return;
        end;

        if p5.Parent ~= Players.LocalPlayer.Character then
            return;
        end;

        if not (FighterController.LocalFighter and FighterController.LocalFighter:IsAlive()) then
            return;
        end;

        u4._teleport_cooldown = tick() + 1;
        FighterController.LocalFighter.Entity:WarpTo(u4.Exit.CFrame);
        Utility:CreateSound("rbxassetid://86785771664692", 0.5, 1 + 0.1 * math.random(), u4.Entrance, true, 10);
        Utility:CreateSound("rbxassetid://81610952487049", 1, 1 + 0.1 * math.random(), u4.Exit, true, 10);
    end);
end;

return u1;