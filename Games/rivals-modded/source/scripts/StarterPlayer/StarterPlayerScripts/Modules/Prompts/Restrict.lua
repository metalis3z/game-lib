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
    v4.CasualLBsFrame = v4.PromptFrame:WaitForChild("CasualLBs");
    v4.CasualLBsButton = v4.CasualLBsFrame:WaitForChild("Button");
    v4.CasualLBsButtonEmpty = v4.CasualLBsButton:WaitForChild("Empty");
    v4.CasualLBsButtonFilled = v4.CasualLBsButton:WaitForChild("Filled");
    v4.CompLBsFrame = v4.PromptFrame:WaitForChild("CompLBs");
    v4.CompLBsButton = v4.CompLBsFrame:WaitForChild("Button");
    v4.CompLBsButtonEmpty = v4.CompLBsButton:WaitForChild("Empty");
    v4.CompLBsButtonFilled = v4.CompLBsButton:WaitForChild("Filled");
    v4._ban_data = p2;
    v4:_Init();

    return v4;
end;

function u1.Confirm(p5) -- Line: 36
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Moderator.Restrict:FireServer(p5._ban_data.Name, {
        RestrictedFromCasualLeaderboards = p5.CasualLBsButtonFilled.Visible,
        RestrictedFromCompetitiveLeaderboards = p5.CompLBsButtonFilled.Visible
    });
    task.defer(p5.CloseRequest, p5);
end;

function u1._Setup(p6) -- Line: 50
    p6.TitleText.Text = "@" .. p6._ban_data.Name;
    p6.CasualLBsButtonFilled.Visible = p6._ban_data.Restrictions and p6._ban_data.Restrictions.RestrictedFromCasualLeaderboards;
    p6.CasualLBsButtonEmpty.Visible = not p6.CasualLBsButtonFilled.Visible;
    p6.CompLBsButtonFilled.Visible = p6._ban_data.Restrictions and p6._ban_data.Restrictions.RestrictedFromCompetitiveLeaderboards;
    p6.CompLBsButtonEmpty.Visible = not p6.CompLBsButtonFilled.Visible;
end;

function u1._Init(u7) -- Line: 58
    -- upvalues: ButtonEffect (copy)
    u7.CloseButton.MouseButton1Click:Connect(function() -- Line: 59
        -- upvalues: u7 (copy)
        u7:CloseRequest();
    end);
    u7.ConfirmButton.MouseButton1Click:Connect(function() -- Line: 63
        -- upvalues: u7 (copy)
        u7:Confirm();
    end);
    u7.CasualLBsButton.MouseButton1Click:Connect(function() -- Line: 67
        -- upvalues: u7 (copy)
        u7.CasualLBsButtonEmpty.Visible = not u7.CasualLBsButtonEmpty.Visible;
        u7.CasualLBsButtonFilled.Visible = not u7.CasualLBsButtonEmpty.Visible;
    end);
    u7.CompLBsButton.MouseButton1Click:Connect(function() -- Line: 72
        -- upvalues: u7 (copy)
        u7.CompLBsButtonEmpty.Visible = not u7.CompLBsButtonEmpty.Visible;
        u7.CompLBsButtonFilled.Visible = not u7.CompLBsButtonEmpty.Visible;
    end);
    u7:_Setup();
    ButtonEffect:Add(u7.CloseButton);
    ButtonEffect:Add(u7.ConfirmButton);
    ButtonEffect:Add(u7.CasualLBsButton);
    ButtonEffect:Add(u7.CompLBsButton);
end;

return u1;