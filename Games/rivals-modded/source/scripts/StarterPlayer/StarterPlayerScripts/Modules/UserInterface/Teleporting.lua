-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TeleportService = game:GetService("TeleportService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local GlowyBackground = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"));
local ChickenFooter = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ChickenFooter"));
require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local TeleportingGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TeleportingGui");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 17
    -- upvalues: u1 (copy), Signal (copy), TeleportingGui (copy), ChickenFooter (copy), GlowyBackground (copy)
    local v2 = setmetatable({}, u1);
    v2.EnabledChanged = Signal.new();
    v2.Enabled = nil;
    v2.GUI = TeleportingGui:Clone();
    v2.Frame = v2.GUI:WaitForChild("Teleporting");
    v2.Container = v2.Frame:WaitForChild("Container");
    v2.Dots = v2.Container:WaitForChild("Waiting"):WaitForChild("Dots");
    v2._enabled_hash = 0;
    v2._blur = Instance.new("BlurEffect");
    v2._chicken_footer = ChickenFooter.new();
    v2._glowy_background = GlowyBackground.new("Teleporting");
    v2:_Init();

    return v2;
end;

function u1.Enable(p3, p4) -- Line: 43
    if p4 == p3.Enabled then
        return;
    end;

    p3.Enabled = p4;
    p3.EnabledChanged:Fire();
    p3._enabled_hash = p3._enabled_hash + 1;
    task.spawn(p3._Update, p3);
end;

function u1._Update(u5) -- Line: 58
    -- upvalues: Utility (copy)
    local _enabled_hash = u5._enabled_hash;
    u5.Container.Visible = u5.Enabled;
    u5._glowy_background:SetEnabled(u5.Enabled);

    if u5.Enabled then
        u5.Dots:AddTag("UILoadingDots");
        u5._chicken_footer:Show();
        u5._chicken_footer:EnableTimer();
        u5._chicken_footer:EnableFunFacts();
        u5._chicken_footer:SetStatus("Teleporting");
    else
        u5.Dots:RemoveTag("UILoadingDots");
        u5._chicken_footer:Hide();
    end;

    local _ = u5.Enabled;
    local _ = u5.Enabled;
    local u6 = u5.Enabled and 0 or 56;
    local u7 = u5.Enabled and 56 or 0;
    Utility:RenderstepForLoop(0, 100, 4, function(p8) -- Line: 80
        -- upvalues: _enabled_hash (copy), u5 (copy), u6 (copy), u7 (copy)
        if _enabled_hash ~= u5._enabled_hash then
            return true;
        end;

        u5._blur.Size = u6 + (u7 - u6) * (1 - (1 - p8 / 100) ^ 3);
    end);
end;

function u1._Setup(p9) -- Line: 91
    -- upvalues: Lighting (copy), Players (copy)
    p9._blur.Size = 0;
    p9._blur.Name = "Teleporting";
    p9._blur.Parent = Lighting;
    p9._chicken_footer:SetParent(p9.Frame);
    p9._glowy_background:SetParent(p9.Frame);
    p9.GUI.Parent = Players.LocalPlayer.PlayerGui;
end;

function u1._Init(u10) -- Line: 102
    -- upvalues: TeleportService (copy), ReplicatedStorage (copy)
    u10.EnabledChanged:Connect(function() -- Line: 103
        -- upvalues: u10 (copy), TeleportService (ref)
        if u10.Enabled then
            TeleportService:SetTeleportGui(u10.GUI);
        end;
    end);
    ReplicatedStorage.Remotes.Misc.Teleporting.OnClientEvent:Connect(function(p11) -- Line: 109
        -- upvalues: u10 (copy)
        u10:Enable(p11);
    end);
    u10:_Setup();
    u10:Enable(false);
end;

return u1._new();