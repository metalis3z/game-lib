-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
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

function u1.Confirm(p5) -- Line: 29
    -- upvalues: ReplicatedStorage (copy)
    local success, result = pcall(ReplicatedStorage.Remotes.Moderator.PardonRedFlags.InvokeServer, ReplicatedStorage.Remotes.Moderator.PardonRedFlags, p5._ban_data.Name);
    local v6 = "";

    for i, v in pairs(success and result and result or {}) do
        v6 = v6 .. v .. (i < #result and "\n" or "");
    end;

    p5.OpenPrompt:Fire("ErrorMessage", success and v6 ~= "" and "Success!" or "Whoops!", success and v6 ~= "" and "Successfully pardoned this player\'s red flags:\n" .. v6 or (success and v6 == "" and "This player has no red flags!" or "Failed to pardon this player\'s red flags, please try again!"));
end;

function u1._Setup(p7) -- Line: 48
    p7.TitleText.Text = "Pardon " .. p7._ban_data.Name;
end;

function u1._Init(u8) -- Line: 52
    -- upvalues: ButtonEffect (copy)
    u8.CloseButton.MouseButton1Click:Connect(function() -- Line: 53
        -- upvalues: u8 (copy)
        u8:CloseRequest();
    end);
    u8.ConfirmButton.MouseButton1Click:Connect(function() -- Line: 57
        -- upvalues: u8 (copy)
        u8:Confirm();
    end);
    u8:_Setup();
    ButtonEffect:Add(u8.CloseButton);
    ButtonEffect:Add(u8.ConfirmButton);
end;

return u1;