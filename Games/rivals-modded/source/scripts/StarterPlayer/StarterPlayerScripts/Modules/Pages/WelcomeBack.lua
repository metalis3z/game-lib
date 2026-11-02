-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 11
    -- upvalues: Page (copy), u1 (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.ClaimButton = v3.PageFrame:WaitForChild("Claim");
    v3.RewardsFrame = v3.PageFrame:WaitForChild("Rewards");
    v3.TitleText = v3.PageFrame:WaitForChild("Title");
    v3.HidePartyDisplay = true;
    v3:_Init();

    return v3;
end;

function u1.CloseRequest(p4, ...) -- Line: 29
    -- upvalues: ReplicatedStorage (copy), Page (copy)
    ReplicatedStorage.Remotes.Data.ClaimWelcomeBackGift:FireServer();
    Page.CloseRequest(p4, ...);
end;

function u1._Setup(p5) -- Line: 38
    -- upvalues: Players (copy), RewardSlot (copy)
    p5.TitleText.Text = "Welcome back, " .. Players.LocalPlayer.DisplayName .. "!";
    RewardSlot.new({
        Name = "Standard Weapon Crate",
        Quantity = 1
    }):SetParent(p5.RewardsFrame);
end;

function u1._Init(u6) -- Line: 43
    -- upvalues: ButtonEffect (copy)
    u6.ClaimButton.MouseButton1Click:Connect(function() -- Line: 44
        -- upvalues: u6 (copy)
        u6:CloseRequest();
    end);
    u6:_Setup();
    ButtonEffect:Add(u6.ClaimButton);
end;

return u1._new();