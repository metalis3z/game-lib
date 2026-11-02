-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2, p3) -- Line: 12
    -- upvalues: Prompt (copy), u1 (copy)
    local v4 = typeof(p2) == "string";
    local v5 = "Argument 1 invalid, expected a string, got " .. tostring(p2);
    assert(v4, v5);
    local v6 = typeof(p3) == "string";
    local v7 = "Argument 2 invalid, expected a string, got " .. tostring(p3);
    assert(v6, v7);
    local v8 = Prompt.new(script.Name);
    local v9 = setmetatable(v8, u1);
    v9.CloseButton = v9.PromptFrame:WaitForChild("Close");
    v9.TitleText = v9.PromptFrame:WaitForChild("Title");
    v9.DescriptionText = v9.PromptFrame:WaitForChild("Description");
    v9._title = p2;
    v9._desc = p3;
    v9:_Init();

    return v9;
end;

function u1._Setup(p10) -- Line: 40
    -- upvalues: Utility (copy)
    p10.TitleText.Text = p10._title;
    p10.DescriptionText.Text = p10._desc;
    Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
end;

function u1._Init(u11) -- Line: 47
    -- upvalues: ButtonEffect (copy)
    u11.CloseButton.MouseButton1Click:Connect(function() -- Line: 48
        -- upvalues: u11 (copy)
        u11:CloseRequest();
    end);
    u11:_Setup();
    ButtonEffect:Add(u11.CloseButton);
end;

return u1;