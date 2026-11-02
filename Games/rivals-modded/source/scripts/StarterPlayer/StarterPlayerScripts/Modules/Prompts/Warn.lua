-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: Prompt (copy), u1 (copy)
    local v3 = Prompt.new(script.Name);
    local v4 = setmetatable(v3, u1);
    v4.CloseButton = v4.PromptFrame:WaitForChild("Close");
    v4.ConfirmButton = v4.PromptFrame:WaitForChild("Confirm");
    v4.TitleText = v4.PromptFrame:WaitForChild("Title");
    v4.DetailsFrame = v4.PromptFrame:WaitForChild("Details");
    v4.ReasonCustomBox = v4.DetailsFrame:WaitForChild("ReasonCustom"):WaitForChild("Input"):WaitForChild("Box");
    v4._ban_data = p2;
    v4:_Init();

    return v4;
end;

function u1.Confirm(p5) -- Line: 30
    -- upvalues: ReplicatedStorage (copy)
    local Text = p5.ReasonCustomBox.Text;

    if #Text < 5 or #Text > 100 then
        return;
    end;

    ReplicatedStorage.Remotes.Moderator.Warn:FireServer(p5._ban_data.Name, Text);
    task.defer(p5.CloseRequest, p5);
end;

function u1._Setup(p6) -- Line: 46
    p6.TitleText.Text = "@" .. p6._ban_data.Name;
end;

function u1._Init(u7) -- Line: 50
    -- upvalues: ButtonEffect (copy)
    u7.CloseButton.MouseButton1Click:Connect(function() -- Line: 51
        -- upvalues: u7 (copy)
        u7:CloseRequest();
    end);
    u7.ConfirmButton.MouseButton1Click:Connect(function() -- Line: 55
        -- upvalues: u7 (copy)
        u7:Confirm();
    end);
    u7:_Setup();
    ButtonEffect:Add(u7.CloseButton);
    ButtonEffect:Add(u7.ConfirmButton);
end;

return u1;