-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Signal = require(ReplicatedStorage.Modules.Signal);
local Prompts = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("Prompts");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 12
    -- upvalues: u1 (copy), Signal (copy), Prompts (copy)
    local v3 = typeof(p2) == "string";
    local v4 = "Argument 1 invalid, expected a string, got " .. tostring(p2);
    assert(v3, v4);
    local v5 = setmetatable({}, u1);
    v5.Closed = Signal.new();
    v5.OpenPrompt = Signal.new();
    v5.PromptFrame = Prompts:WaitForChild(p2):Clone();
    v5._destroyed = false;
    v5._connections = {};
    v5._destroy_these = {};
    v5:_Init();

    return v5;
end;

function u1.GetDefaultElement(p6) -- Line: 35
    return p6.CloseButton or nil;
end;

function u1.CloseRequest(p7) -- Line: 39
    p7.Closed:Fire();
end;

function u1.Open(p8, p9) -- Line: 44
    local v10 = typeof(p9) == "Instance";
    local v11 = "Argument 1 invalid, expected an Instance, got " .. tostring(p9);
    assert(v10, v11);
    p8.PromptFrame.Parent = p9;
    p8.PromptFrame.Position = UDim2.new(0.5, 0, 0.625, 0);
    p8.PromptFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Back", 0.25, true);
end;

function u1.Destroy(p12) -- Line: 52
    if p12._destroyed then
        return;
    end;

    p12._destroyed = true;

    for _, v in pairs(p12._destroy_these) do
        v:Destroy();
    end;

    p12._destroy_these = {};

    for _, v in pairs(p12._connections) do
        v:Disconnect();
    end;

    p12._connections = {};
    p12.PromptFrame:Destroy();
    p12.Closed:Destroy();
    p12.OpenPrompt:Destroy();
end;

function u1._Init(p13) -- Line: 80
end;

return u1;