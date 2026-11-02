-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 12
    -- upvalues: Page (copy), u1 (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.LeaveButton = v3.PageFrame:WaitForChild("Leave");
    v3.LeaveButtonOnFrame = v3.LeaveButton:WaitForChild("On");
    v3.LeaveButtonCountdownFrame = v3.LeaveButton:WaitForChild("Countdown");
    v3.LeaveButtonCountdownText = v3.LeaveButtonCountdownFrame:WaitForChild("Title");
    v3._countdown_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.Open(p4, ...) -- Line: 32
    -- upvalues: Page (copy)
    Page.Open(p4, ...);
    task.spawn(p4._Countdown, p4);
end;

function u1._Countdown(p5) -- Line: 41
    p5._countdown_hash = p5._countdown_hash + 1;
    local _ = p5._countdown_hash;
    p5.LeaveButtonCountdownFrame.Visible = true;
    p5.LeaveButtonOnFrame.Visible = false;
    p5.LeaveButtonCountdownFrame.Visible = false;
    p5.LeaveButtonOnFrame.Visible = true;
end;

function u1._Init(u6) -- Line: 61
    -- upvalues: ReplicatedStorage (copy), ButtonEffect (copy)
    u6.CloseButton.MouseButton1Click:Connect(function() -- Line: 62
        -- upvalues: u6 (copy)
        u6:CloseRequest();
    end);
    u6.LeaveButton.MouseButton1Click:Connect(function() -- Line: 66
        -- upvalues: u6 (copy), ReplicatedStorage (ref)
        if u6.LeaveButtonOnFrame.Visible then
            ReplicatedStorage.Remotes.Duels.LeaveDuel:FireServer();
            u6:CloseRequest();
        end;
    end);
    ButtonEffect:Add(u6.CloseButton);
    ButtonEffect:Add(u6.LeaveButton);
end;

return u1._new();