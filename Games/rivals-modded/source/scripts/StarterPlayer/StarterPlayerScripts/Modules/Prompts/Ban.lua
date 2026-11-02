-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ModerationLibrary = require(ReplicatedStorage.Modules.ModerationLibrary);
local SettingsInfo = require(ReplicatedStorage.Modules.SettingsInfo);
require(ReplicatedStorage.Modules.BanLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local Dropdown = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings"):WaitForChild("Dropdown"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = { "Exploiting", "Exploiting - Movement Cheats", "Exploiting - Aim Cheats", "Exploiting - Vision Cheats", "Requesting Exploits", "Playing With Exploiters", "Fake Reporting", "Farming", "Abusing Minor Bugs", "Harassment / Hate Speech", "Ban Evasion", "Custom" };
local u2 = { "Permanent", "1 day", "3 days", "7 days", "14 days", "30 days", "90 days", "180 days", "365 days", "Custom" };
local u3 = setmetatable({}, Prompt);
u3.__index = u3;

function u3.new(p4) -- Line: 26
    -- upvalues: Prompt (copy), u3 (copy), Dropdown (copy), SettingsInfo (copy), u1 (copy), u2 (copy)
    local v5 = Prompt.new(script.Name);
    local v6 = setmetatable(v5, u3);
    v6.CloseButton = v6.PromptFrame:WaitForChild("Close");
    v6.ConfirmButton = v6.PromptFrame:WaitForChild("Confirm");
    v6.TitleText = v6.PromptFrame:WaitForChild("Title");
    v6.RestrictionNotice = v6.PromptFrame:WaitForChild("RestrictionNotice");
    v6.DetailsFrame = v6.PromptFrame:WaitForChild("Details");
    v6.ReasonFrame = v6.DetailsFrame:WaitForChild("Reason");
    v6.ReasonDropdownFrame = v6.ReasonFrame:WaitForChild("Dropdown");
    v6.ReasonCustomFrame = v6.DetailsFrame:WaitForChild("ReasonCustom");
    v6.ReasonCustomBox = v6.ReasonCustomFrame:WaitForChild("Input"):WaitForChild("Box");
    v6.DurationFrame = v6.DetailsFrame:WaitForChild("Duration");
    v6.DurationDropdownFrame = v6.DurationFrame:WaitForChild("Dropdown");
    v6.DurationCustomFrame = v6.DetailsFrame:WaitForChild("DurationCustom");
    v6.DurationCustomBox = v6.DurationCustomFrame:WaitForChild("Input"):WaitForChild("Box");
    v6.WarnFrame = v6.DetailsFrame:WaitForChild("Warn");
    v6.WarnContainer = v6.WarnFrame:WaitForChild("Container");
    v6.WarnButton = v6.WarnContainer:WaitForChild("Button");
    v6.WarnButtonEmpty = v6.WarnButton:WaitForChild("Empty");
    v6.WarnButtonFilled = v6.WarnButton:WaitForChild("Filled");
    v6.CasualLBsFrame = v6.DetailsFrame:WaitForChild("CasualLBs");
    v6.CasualLBsContainer = v6.CasualLBsFrame:WaitForChild("Container");
    v6.CasualLBsButton = v6.CasualLBsContainer:WaitForChild("Button");
    v6.CasualLBsButtonEmpty = v6.CasualLBsButton:WaitForChild("Empty");
    v6.CasualLBsButtonFilled = v6.CasualLBsButton:WaitForChild("Filled");
    v6.CompLBsFrame = v6.DetailsFrame:WaitForChild("CompLBs");
    v6.CompLBsContainer = v6.CompLBsFrame:WaitForChild("Container");
    v6.CompLBsButton = v6.CompLBsContainer:WaitForChild("Button");
    v6.CompLBsButtonEmpty = v6.CompLBsButton:WaitForChild("Empty");
    v6.CompLBsButtonFilled = v6.CompLBsButton:WaitForChild("Filled");
    v6.ReasonDropdown = Dropdown.new(SettingsInfo.new("", "", "", "", "", "Dropdown", u1[1], u1));
    v6.DurationDropdown = Dropdown.new(SettingsInfo.new("", "", "", "", "", "Dropdown", u2[1], u2));
    v6._ban_data = p4;
    v6:_Init();

    return v6;
end;

function u3.Confirm(p7) -- Line: 72
    -- upvalues: ModerationLibrary (copy), PlayerDataController (copy), ReplicatedStorage (copy)
    local v8;

    if p7.ReasonDropdown.Value == "Custom" then
        v8 = p7.ReasonCustomBox.Text;
    else
        v8 = p7.ReasonDropdown.Value;
    end;

    local v9;

    if p7.DurationDropdown.Value == "Custom" then
        v9 = tonumber(p7.DurationCustomBox.Text);
    elseif p7.DurationDropdown.Value == "Permanent" then
        v9 = -1;
    else
        local Value = p7.DurationDropdown.Value;
        local v10 = string.find(p7.DurationDropdown.Value, " ") - 1;
        local string_sub_ret = string.sub(Value, 1, v10);
        v9 = tonumber(string_sub_ret);
    end;

    if not v9 then
        return;
    end;

    if #v8 < 5 or #v8 > 100 then
        return;
    end;

    if ModerationLibrary:CanWarnTemplate(PlayerDataController:Get("PermissionsRoles")) then
        local _ = p7.WarnButtonFilled.Visible;
    end;

    local v11;

    if ModerationLibrary:CanRestrict(PlayerDataController:Get("PermissionsRoles")) then
        v11 = {};
        v11.RestrictedFromCasualLeaderboards = p7.CasualLBsButtonFilled.Visible or p7._ban_data.Restrictions and p7._ban_data.Restrictions.RestrictedFromCasualLeaderboards;
        v11.RestrictedFromCompetitiveLeaderboards = p7.CompLBsButtonFilled.Visible or p7._ban_data.Restrictions and p7._ban_data.Restrictions.RestrictedFromCompetitiveLeaderboards;
    else
        v11 = nil;
    end;

    ReplicatedStorage.Remotes.Moderator.Ban:FireServer(p7._ban_data.Name, v9, v8, p7.WarnButtonFilled.Visible, v11);
    task.defer(p7.CloseRequest, p7);
end;

function u3.Destroy(p12) -- Line: 102
    -- upvalues: Prompt (copy)
    p12.ReasonDropdown:Destroy();
    p12.DurationDropdown:Destroy();
    Prompt.Destroy(p12);
end;

function u3._Update(p13) -- Line: 112
    local Value = p13.DurationDropdown.Value;
    p13.ReasonCustomFrame.Visible = p13.ReasonDropdown.Value == "Custom";
    p13.DurationFrame.Visible = true;
    p13.DurationCustomFrame.Visible = Value == "Custom";
end;

function u3._FormatSettingSlot(p14, p15) -- Line: 121
    p15.SettingFrame.Size = UDim2.new(1, 0, 1, 0);
    p15.SettingFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
    p15.SettingFrame.SizeConstraint = Enum.SizeConstraint.RelativeXY;
    p15.ControlsFrame.Size = UDim2.new(1, 0, 1, 0);
    p15.ControlsFrame.SizeConstraint = Enum.SizeConstraint.RelativeXY;
    p15.DropdownContainer.Size = UDim2.new(1, 0, 1, 0);
    p15.Background.Visible = false;
    p15.DetailsResetButton.Size = UDim2.new(0, 0, 0, 0);
end;

function u3._Setup(p16) -- Line: 132
    -- upvalues: ModerationLibrary (copy), PlayerDataController (copy)
    p16.TitleText.Text = "@" .. p16._ban_data.Name;
    p16.ReasonDropdown.SettingFrame.Parent = p16.ReasonDropdownFrame;
    p16.DurationDropdown.SettingFrame.Parent = p16.DurationDropdownFrame;
    p16.WarnFrame.Visible = ModerationLibrary:CanWarnTemplate(PlayerDataController:Get("PermissionsRoles"));
    p16.CasualLBsFrame.Visible = ModerationLibrary:CanRestrict(PlayerDataController:Get("PermissionsRoles"));
    p16.CompLBsFrame.Visible = ModerationLibrary:CanRestrict(PlayerDataController:Get("PermissionsRoles"));
    p16.RestrictionNotice.Visible = ModerationLibrary:CanRestrict(PlayerDataController:Get("PermissionsRoles"));
end;

function u3._Init(u17) -- Line: 142
    -- upvalues: ButtonEffect (copy)
    u17.CloseButton.MouseButton1Click:Connect(function() -- Line: 143
        -- upvalues: u17 (copy)
        u17:CloseRequest();
    end);
    u17.ConfirmButton.MouseButton1Click:Connect(function() -- Line: 147
        -- upvalues: u17 (copy)
        u17:Confirm();
    end);
    u17.DurationCustomBox.FocusLost:Connect(function() -- Line: 151
        -- upvalues: u17 (copy)
        if u17.DurationCustomBox.Text ~= "" then
            local DurationCustomBox = u17.DurationCustomBox;
            local v18;

            if tonumber(u17.DurationCustomBox.Text) then
                local v19 = tonumber(u17.DurationCustomBox.Text);
                local math_floor_ret = math.floor(v19);
                v18 = math.clamp(math_floor_ret, 1, 999) or "";
            else
                v18 = "";
            end;

            DurationCustomBox.Text = v18;
        end;
    end);
    u17.ReasonDropdown.Replicate:Connect(function() -- Line: 157
        -- upvalues: u17 (copy)
        u17:_Update();
    end);
    u17.DurationDropdown.Replicate:Connect(function() -- Line: 161
        -- upvalues: u17 (copy)
        u17:_Update();
    end);
    u17.WarnButton.MouseButton1Click:Connect(function() -- Line: 165
        -- upvalues: u17 (copy)
        u17.WarnButtonFilled.Visible = not u17.WarnButtonFilled.Visible;
        u17.WarnButtonEmpty.Visible = not u17.WarnButtonFilled.Visible;
    end);
    u17.CasualLBsButton.MouseButton1Click:Connect(function() -- Line: 170
        -- upvalues: u17 (copy)
        u17.CasualLBsButtonFilled.Visible = not u17.CasualLBsButtonFilled.Visible;
        u17.CasualLBsButtonEmpty.Visible = not u17.CasualLBsButtonFilled.Visible;
    end);
    u17.CompLBsButton.MouseButton1Click:Connect(function() -- Line: 175
        -- upvalues: u17 (copy)
        u17.CompLBsButtonFilled.Visible = not u17.CompLBsButtonFilled.Visible;
        u17.CompLBsButtonEmpty.Visible = not u17.CompLBsButtonFilled.Visible;
    end);
    u17:_Setup();
    u17:_FormatSettingSlot(u17.ReasonDropdown);
    u17:_FormatSettingSlot(u17.DurationDropdown);
    u17:_Update();
    ButtonEffect:Add(u17.CloseButton);
    ButtonEffect:Add(u17.ConfirmButton);
    ButtonEffect:Add(u17.WarnButton);
    ButtonEffect:Add(u17.CasualLBsButton);
    ButtonEffect:Add(u17.CompLBsButton);
end;

return u3;