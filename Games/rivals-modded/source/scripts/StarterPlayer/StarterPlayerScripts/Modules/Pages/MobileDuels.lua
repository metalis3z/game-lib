-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 10
    -- upvalues: Page (copy), u1 (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.ButtonsFrame = v3.PageFrame:WaitForChild("Buttons");
    v3.CloseButton = v3.ButtonsFrame:WaitForChild("Close");
    v3.TeleportButton = v3.ButtonsFrame:WaitForChild("Teleport");
    v3:_Init();

    return v3;
end;

function u1._Init(u4) -- Line: 32
    -- upvalues: ReplicatedStorage (copy), ButtonEffect (copy)
    u4.CloseButton.MouseButton1Click:Connect(function() -- Line: 33
        -- upvalues: u4 (copy)
        u4:CloseRequest();
    end);
    u4.TeleportButton.MouseButton1Click:Connect(function() -- Line: 37
        -- upvalues: ReplicatedStorage (ref), u4 (copy)
        ReplicatedStorage.Remotes.Misc.MobileDuelsTeleport:FireServer();
        u4:CloseRequest();
    end);
    ButtonEffect:Add(u4.CloseButton);
    ButtonEffect:Add(u4.TeleportButton);
end;

return u1._new();