-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TeleportService");
local Players = game:GetService("Players");
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
local Functions = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Functions");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 12
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1.FireAsync(p3, p4, ...) -- Line: 24
    -- upvalues: Functions (copy), EnumLibrary (copy)
    require(Functions[EnumLibrary:FromEnum(p4)])(...);
end;

function u1.FireSync(p5, ...) -- Line: 29
    task.spawn(p5.FireAsync, p5, ...);
end;

function u1._Init(u6) -- Line: 37
    -- upvalues: ReplicatedStorage (copy), EnumLibrary (copy)
    ReplicatedStorage.Remotes.Misc.TeleportFailed.OnClientEvent:Connect(function(p7) -- Line: 38
        -- upvalues: u6 (copy), EnumLibrary (ref)
        local v8 = {
            Text = "[SERVER] Teleport failed, please try again. Error: " .. tostring(p7),
            Color = Color3.fromRGB(255, 50, 50)
        };
        u6:FireAsync(EnumLibrary:ToEnum("SendChat"), v8);
    end);
    ReplicatedStorage.Remotes.Misc.Functions.OnClientEvent:Connect(function(...) -- Line: 47
        -- upvalues: u6 (copy)
        u6:FireAsync(...);
    end);
    ReplicatedStorage.Remotes.Misc.FunctionsUnreliable.OnClientEvent:Connect(function(...) -- Line: 51
        -- upvalues: u6 (copy)
        u6:FireAsync(...);
    end);
end;

return u1._new();