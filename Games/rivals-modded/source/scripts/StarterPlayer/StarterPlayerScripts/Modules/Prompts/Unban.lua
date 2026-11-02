-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: Prompt (copy), u1 (copy)
    local v3 = Prompt.new(script.Name);
    local v4 = setmetatable(v3, u1);
    v4.CloseButton = v4.PromptFrame:WaitForChild("Close");
    v4.ConfirmButton = v4.PromptFrame:WaitForChild("Confirm");
    v4.TitleText = v4.PromptFrame:WaitForChild("Title");
    v4._ban_data = p2;
    v4:_Init();

    return v4;
end;

function u1._Setup(p5) -- Line: 35
    p5.TitleText.Text = "Unban " .. p5._ban_data.Name;
end;

function u1._Init(u6) -- Line: 39
    -- upvalues: ReplicatedStorage (copy), RunService (copy), ButtonEffect (copy)
    u6.CloseButton.MouseButton1Click:Connect(function() -- Line: 40
        -- upvalues: u6 (copy)
        u6:CloseRequest();
    end);
    u6.ConfirmButton.MouseButton1Click:Connect(function() -- Line: 44
        -- upvalues: ReplicatedStorage (ref), u6 (copy), RunService (ref)
        ReplicatedStorage.Remotes.Moderator.Unban:FireServer(u6._ban_data.Name);
        RunService.Heartbeat:Wait();
        u6:CloseRequest();
    end);
    u6:_Setup();
    ButtonEffect:Add(u6.CloseButton);
    ButtonEffect:Add(u6.ConfirmButton);
end;

return u1;