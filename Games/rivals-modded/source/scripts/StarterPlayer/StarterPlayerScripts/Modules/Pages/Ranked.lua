-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local ParticipationPrize = require(script:WaitForChild("ParticipationPrize"));
local GloryPayout = require(script:WaitForChild("GloryPayout"));
local ELOShield = require(script:WaitForChild("ELOShield"));
local TopReward = require(script:WaitForChild("TopReward"));
local Countdown = require(script:WaitForChild("Countdown"));
local Locked = require(script:WaitForChild("Locked"));
local Header = require(script:WaitForChild("Header"));
local Queues = require(script:WaitForChild("Queues"));
local Rank = require(script:WaitForChild("Rank"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 19
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy), ParticipationPrize (copy), GloryPayout (copy), ELOShield (copy), TopReward (copy), Countdown (copy), Locked (copy), Header (copy), Queues (copy), Rank (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.UnlockedFrame = v3.PageFrame:WaitForChild("Unlocked");
    v3.CloseButton = v3.UnlockedFrame:WaitForChild("Close");
    v3.List = v3.UnlockedFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3.ParticipationPrize = ParticipationPrize.new(v3);
    v3.GloryPayout = GloryPayout.new(v3);
    v3.ELOShield = ELOShield.new(v3);
    v3.TopReward = TopReward.new(v3);
    v3.Countdown = Countdown.new(v3);
    v3.Locked = Locked.new(v3);
    v3.Header = Header.new(v3);
    v3.Queues = Queues.new(v3);
    v3.Rank = Rank.new(v3);
    v3:_Init();

    return v3;
end;

function u1.CloseRequest(p4) -- Line: 49
    p4.OpenPage:Fire("Matchmaking");
end;

function u1.Open(p5, ...) -- Line: 53
    -- upvalues: Page (copy)
    Page.Open(p5, ...);
    p5.ParticipationPrize:Open();
    p5.GloryPayout:Open();
    p5.ELOShield:Open();
    p5.TopReward:Open();
    p5.Countdown:Open();
    p5.Locked:Open();
    p5.Header:Open();
    p5.Queues:Open();
    p5.Rank:Open();
end;

function u1.Close(p6, ...) -- Line: 67
    -- upvalues: Page (copy)
    p6.ParticipationPrize:Close();
    p6.GloryPayout:Close();
    p6.TopReward:Close();
    p6.ELOShield:Close();
    p6.Countdown:Close();
    p6.Locked:Close();
    p6.Header:Close();
    p6.Queues:Close();
    p6.Rank:Close();
    Page.Close(p6, ...);
end;

function u1._UpdateList(p7) -- Line: 85
    p7.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p7.PageFrame.AbsoluteSize.Y * 0.125);
    p7.List.Position = UDim2.new(0.5, 9, 0, p7.PageFrame.AbsoluteSize.Y * 0.125);
    p7.List.Size = UDim2.new(0.85, 0, 0, p7.PageFrame.AbsoluteSize.Y * 0.75);
    p7.List.CanvasSize = UDim2.new(0, 0, 0, p7.Layout.AbsoluteContentSize.Y);
end;

function u1._Init(u8) -- Line: 92
    -- upvalues: ButtonEffect (copy)
    u8.CloseButton.MouseButton1Click:Connect(function() -- Line: 93
        -- upvalues: u8 (copy)
        u8:CloseRequest();
    end);
    u8.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 97
        -- upvalues: u8 (copy)
        u8:_UpdateList();
    end);
    u8.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 101
        -- upvalues: u8 (copy)
        u8:_UpdateList();
    end);
    u8:_UpdateList();
    ButtonEffect:Add(u8.CloseButton);
end;

return u1._new();