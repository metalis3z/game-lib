-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Teleporting = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"));
local GlowyBackground = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"));
local ChickenFooter = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ChickenFooter"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Shutdown = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("Shutdown");
local u1 = {
    [Enum.CloseReason.Unknown] = "Unknown shutdown",
    [Enum.CloseReason.RobloxMaintenance] = "Roblox maintenance",
    [Enum.CloseReason.OutOfMemory] = "The server ran out of memory",
    [Enum.CloseReason.ServerEmpty] = "The server is now empty",
    [Enum.CloseReason.DeveloperUpdate] = "Migrating to new servers",
    [Enum.CloseReason.DeveloperShutdown] = "Shutdown by the developers"
};
local u2 = {};
u2.__index = u2;

function u2._new() -- Line: 26
    -- upvalues: u2 (copy), Signal (copy)
    local v3 = setmetatable({}, u2);
    v3.EnabledChanged = Signal.new();
    v3.Enabled = nil;
    v3:_Init();

    return v3;
end;

function u2.Enable(p4, p5) -- Line: 42
    -- upvalues: UILibrary (copy), Teleporting (copy), Shutdown (copy), Players (copy), RunService (copy), u1 (copy), ChickenFooter (copy), GlowyBackground (copy), Utility (copy)
    p4.Enabled = true;
    p4.EnabledChanged:Fire();
    UILibrary.MainGui.Enabled = false;
    Teleporting.GUI.Parent = nil;
    local u6 = Shutdown:Clone();
    u6.Parent = Players.LocalPlayer.PlayerGui;
    local u7 = tick();
    RunService.RenderStepped:Connect(function(p8) -- Line: 54
        -- upvalues: u6 (copy), u7 (copy)
        local Icon = u6.MainFrame.Container.Icon;
        local Rotation = Icon.Rotation;
        local v9 = (tick() - u7) * 2 % 6.283185307179586;
        Icon.Rotation = Rotation + (math.sin(v9) + 1) * p8 * 300;
    end);
    local v10 = u1[p5] or (p5 and p5.Name or "");
    local v11 = ChickenFooter.new();
    v11:SetStatus("Server Restart");
    v11:SetMessage((v10 == "" and "" or v10 .. " — ") .. "Hang tight while I find a new server for you!");
    v11:SetPicture("Sensei");
    v11:EnableTimer();
    v11:SetParent(u6.MainFrame);
    local Shutdown2 = GlowyBackground.new("Shutdown");
    Shutdown2:SetParent(u6.MainFrame);
    Shutdown2:SetEnabled(true);
    Utility:RenderstepForLoop(0, 100, 1, function(p12) -- Line: 70
        -- upvalues: u6 (copy)
        u6.MainFrame.Container.Icon.ImageTransparency = (1 - p12 / 100) ^ 5;
    end);
end;

function u2._Init(p13) -- Line: 81
end;

return u2._new();