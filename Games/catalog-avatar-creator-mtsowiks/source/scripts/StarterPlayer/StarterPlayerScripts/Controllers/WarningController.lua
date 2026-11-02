-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Modules = require(script.Parent.Parent:WaitForChild("Modules"));
local ThemeController = require(Modules.Controllers.ThemeController);
local Warning = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Warning");
local backdrop = Warning:WaitForChild("backdrop");
local container = Warning:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local reasonCard = wrapper:WaitForChild("reasonCard");
local continueButton = wrapper:WaitForChild("footer"):WaitForChild("continueButton");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local ShowWarning = Remotes:WaitForChild("ShowWarning");
local AcknowledgeWarning = Remotes:WaitForChild("AcknowledgeWarning");
Warning.Enabled = false;
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(container, u1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(container, u1, {
    GroupTransparency = 1
});
local u4 = TweenService:Create(backdrop, u1, {
    BackgroundTransparency = 0.35
});
local u5 = TweenService:Create(backdrop, u1, {
    BackgroundTransparency = 1
});
local u6 = {
    IsOpen = false
};
local u7 = Color3.fromRGB(61, 63, 69);
local u8 = Color3.fromRGB(51, 95, 255);
local u9 = {
    System = "Our systems detected a possibly inappropriate avatar.",
    Moderator = "A moderator has issued you a warning."
};
local u10 = nil;
local u11 = false;
local u12 = false;
local u13 = nil;

local function startCountdown() -- Line: 57
    -- upvalues: u12 (ref), u13 (ref), continueButton (copy), ThemeController (copy), u7 (copy), TweenService (copy), u1 (copy), u8 (copy)
    u12 = false;

    if u13 then
        pcall(task.cancel, u13);
    end;

    continueButton.BackgroundColor3 = ThemeController.GetColor(u7);
    u13 = task.spawn(function() -- Line: 63
        -- upvalues: continueButton (ref), TweenService (ref), u1 (ref), ThemeController (ref), u8 (ref), u12 (ref)
        for i = 5, 1, -1 do
            continueButton.label.Text = "I Understand (" .. i .. ")";
            task.wait(1);
        end;

        continueButton.label.Text = "I Understand";
        TweenService:Create(continueButton, u1, {
            BackgroundColor3 = ThemeController.GetColor(u8)
        }):Play();
        u12 = true;
    end);
end;

local function display(p14) -- Line: 74
    -- upvalues: u10 (ref), u9 (copy), wrapper (copy), reasonCard (copy), startCountdown (copy), u6 (copy), container (copy), backdrop (copy), Warning (copy), u2 (copy), u4 (copy)
    if typeof(p14) ~= "table" or typeof(p14.Id) ~= "string" then
        return;
    end;

    u10 = p14.Id;
    local Message = p14.Message;
    local v15 = (typeof(Message) ~= "string" or #Message == 0) and (u9[p14.Source] or "A moderator has issued you a warning.") or Message;
    wrapper.message.Text = v15;
    reasonCard.reasonValue.Text = tostring(p14.Reason);
    startCountdown();

    if not u6.IsOpen then
        u6.IsOpen = true;
        container.GroupTransparency = 1;
        backdrop.BackgroundTransparency = 1;
        Warning.Enabled = true;
        u2:Play();
        u4:Play();
    end;
end;

local function close() -- Line: 96
    -- upvalues: u6 (copy), u10 (ref), u12 (ref), u13 (ref), u3 (copy), u5 (copy), Warning (copy)
    if not u6.IsOpen then
        return;
    end;

    u6.IsOpen = false;
    u10 = nil;
    u12 = false;

    if u13 then
        pcall(task.cancel, u13);
        u13 = nil;
    end;

    u3:Play();
    u5:Play();
    u3.Completed:Once(function() -- Line: 107
        -- upvalues: u6 (ref), Warning (ref)
        if u6.IsOpen ~= true then
            Warning.Enabled = false;
        end;
    end);
end;

continueButton.Activated:Connect(function() -- Line: 114
    -- upvalues: u12 (ref), u11 (ref), u10 (ref), AcknowledgeWarning (copy), display (copy), close (copy)
    if not u12 or (u11 or not u10) then
        return;
    end;

    u11 = true;
    local success, result = pcall(function() -- Line: 117
        -- upvalues: AcknowledgeWarning (ref), u10 (ref)
        return AcknowledgeWarning:InvokeServer(u10);
    end);
    u11 = false;

    if success and typeof(result) == "table" then
        display(result);

        return;
    end;

    close();
end);
ShowWarning.OnClientEvent:Connect(display);
task.spawn(function() -- Line: 132
    -- upvalues: AcknowledgeWarning (copy), display (copy)
    local success, result = pcall(function() -- Line: 133
        -- upvalues: AcknowledgeWarning (ref)
        return AcknowledgeWarning:InvokeServer(nil);
    end);

    if success and typeof(result) == "table" then
        display(result);
    end;
end);

return u6;