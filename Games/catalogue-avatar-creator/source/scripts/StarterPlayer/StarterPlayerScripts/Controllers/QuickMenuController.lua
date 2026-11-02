-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("StarterGui");
local Players = game:GetService("Players");
local Icon = require(ReplicatedStorage:WaitForChild("Icon"));
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local CommandsController = require(script.Parent.CommandsController);
local RemoveItemsController = require(script.Parent.RemoveItemsController);
local StatisticsController = require(script.Parent.StatisticsController);
local BuildsController = require(script.Parent.BuildsController);
local LocalPlayer = Players.LocalPlayer;
local Events = script.Parent.Parent.Events;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local LikeAction = Remotes:WaitForChild("LikeAction");
local BuildAction = Remotes:WaitForChild("BuildAction");
local GetFlag = Remotes:WaitForChild("GetFlag");
local v1 = {};
local u2 = 0;
local u3 = nil;

local function formatLikeLabel(p4) -- Line: 26
    return " ❤️ Like Count: " .. tostring(p4);
end;

local function refreshLikeCount() -- Line: 30
    -- upvalues: LikeAction (copy), LocalPlayer (copy), u2 (ref), u3 (ref)
    task.spawn(function() -- Line: 31
        -- upvalues: LikeAction (ref), LocalPlayer (ref), u2 (ref), u3 (ref)
        local success, result = pcall(function() -- Line: 32
            -- upvalues: LikeAction (ref), LocalPlayer (ref)
            return LikeAction:InvokeServer("GetLikes", LocalPlayer);
        end);

        if success and result ~= nil then
            u2 = result;

            if u3 then
                u3:setLabel(" ❤️ Like Count: " .. tostring(u2));
            end;
        end;
    end);
end;

local u5 = Icon.new():setCaption("Quick Menu"):setImage("rbxassetid://111675536085503"):setImageScale(0.85):setOrder(999):align("Right"):bindToggleKey(Enum.KeyCode.M);
u3 = Icon.new():setLabel(" ❤️ Like Count: " .. tostring(0)):joinDropdown(u5):lock():modifyTheme({
    { "PaddingLeft", "Size", UDim2.fromOffset(8, 0) },
    { "PaddingRight", "Size", UDim2.fromOffset(8, 0) },
    { "IconOverlay", "BackgroundTransparency", 1 },
    { "IconOverlay", "BackgroundTransparency", 1, "Viewing" },
    { "ClickRegion", "Active", false }
});
local u6 = Icon.new():setLabel(""):oneClick():joinDropdown(u5):lock():modifyTheme({
    { "Widget", "MinimumHeight", 7 },
    { "Widget", "DesiredWidth", 0 },
    { "IconButton", "BackgroundTransparency", 1 },
    { "PaddingLeft", "Size", UDim2.fromOffset(6, 0) },
    { "PaddingRight", "Size", UDim2.fromOffset(6, 0) },
    { "IconOverlay", "BackgroundTransparency", 1 },
    { "IconOverlay", "BackgroundTransparency", 1, "Viewing" },
    { "ClickRegion", "Active", false }
});
task.defer(function() -- Line: 84
    -- upvalues: u6 (copy), ThemeController (copy)
    local v7 = u6:getInstance("Widget");

    if v7 then
        local Frame = Instance.new("Frame");
        Frame.Name = "DividerLine";
        Frame.Size = UDim2.new(1, -12, 0, 1);
        Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(255, 255, 255));
        Frame.BackgroundTransparency = 0.8;
        Frame.BorderSizePixel = 0;
        Frame.Parent = v7;
    end;
end);
Icon.new():setLabel("Commands"):oneClick():joinDropdown(u5):modifyTheme({
    { "PaddingLeft", "Size", UDim2.fromOffset(8, 0) },
    { "PaddingRight", "Size", UDim2.fromOffset(8, 0) }
}):bindEvent("deselected", function() -- Line: 107
    -- upvalues: u5 (copy), CommandsController (copy)
    u5:deselect();
    CommandsController.Open(true);
end);
Icon.new():setLabel("Statistics"):oneClick():joinDropdown(u5):modifyTheme({
    { "PaddingLeft", "Size", UDim2.fromOffset(8, 0) },
    { "PaddingRight", "Size", UDim2.fromOffset(8, 0) }
}):bindEvent("deselected", function() -- Line: 118
    -- upvalues: u5 (copy), StatisticsController (copy)
    u5:deselect();
    StatisticsController.Open(true);
end);
Icon.new():setLabel("Remove Items"):oneClick():joinDropdown(u5):modifyTheme({
    { "PaddingLeft", "Size", UDim2.fromOffset(8, 0) },
    { "PaddingRight", "Size", UDim2.fromOffset(8, 0) }
}):bindEvent("deselected", function() -- Line: 129
    -- upvalues: u5 (copy), RemoveItemsController (copy)
    u5:deselect();
    RemoveItemsController.Open(true);
end);
task.spawn(function() -- Line: 138
    -- upvalues: BuildAction (copy), Icon (copy), u5 (copy), BuildsController (copy)
    local success, result = pcall(function() -- Line: 139
        -- upvalues: BuildAction (ref)
        return BuildAction:InvokeServer("CanManage");
    end);

    if success and result == true then
        Icon.new():setLabel("Builds"):oneClick():joinDropdown(u5):modifyTheme({
            { "PaddingLeft", "Size", UDim2.fromOffset(8, 0) },
            { "PaddingRight", "Size", UDim2.fromOffset(8, 0) }
        }):bindEvent("deselected", function() -- Line: 147
            -- upvalues: u5 (ref), BuildsController (ref)
            u5:deselect();
            BuildsController.Open(true);
        end);
    end;
end);
task.spawn(function() -- Line: 156
    -- upvalues: GetFlag (copy), Icon (copy), u5 (copy), ReplicatedStorage (copy)
    local v8, v9, v10 = pcall(function() -- Line: 157
        -- upvalues: GetFlag (ref)
        return GetFlag:InvokeServer("IsAdministrator");
    end);

    if v8 and (v9 == true and v10 == true) then
        Icon.new():setLabel("Cmdr"):oneClick():joinDropdown(u5):modifyTheme({
            { "PaddingLeft", "Size", UDim2.fromOffset(8, 0) },
            { "PaddingRight", "Size", UDim2.fromOffset(8, 0) }
        }):bindEvent("deselected", function() -- Line: 165
            -- upvalues: u5 (ref), ReplicatedStorage (ref)
            u5:deselect();
            require(ReplicatedStorage:WaitForChild("CmdrClient")):Show();
        end);
    end;
end);
Icon.new():setLabel("Unhide All Players"):oneClick():joinDropdown(u5):modifyTheme({
    { "PaddingLeft", "Size", UDim2.fromOffset(8, 0) },
    { "PaddingRight", "Size", UDim2.fromOffset(8, 0) }
}):bindEvent("deselected", function() -- Line: 178
    -- upvalues: u5 (copy), Players (copy), LocalPlayer (copy), Events (copy)
    u5:deselect();
    local v11 = 0;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer and v:GetAttribute("isHidden") then
            v:SetAttribute("isHidden", nil);

            if v.Character then
                v.Character.Parent = workspace;
            end;

            v11 = v11 + 1;
        end;
    end;

    if v11 > 0 then
        Events.Notify:Fire("✅ Unhid <b>" .. v11 .. "</b> player" .. (v11 == 1 and "" or "s") .. ".");

        return;
    end;

    Events.Notify:Fire("ℹ️ No hidden players to unhide.");
end);
local u12 = false;
local u13 = Icon.new():setLabel("Hide UI"):oneClick():joinDropdown(u5):modifyTheme({
    { "PaddingLeft", "Size", UDim2.fromOffset(8, 0) },
    { "PaddingRight", "Size", UDim2.fromOffset(8, 0) }
});
u13:bindEvent("deselected", function() -- Line: 204
    -- upvalues: u5 (copy), u12 (ref), Events (copy), u13 (copy)
    u5:deselect();
    u12 = not u12;

    if not u12 then
        Events.SetButtonsVisible:Fire("All");
        u13:setLabel("Hide UI");

        return;
    end;

    Events.InterfaceAction:Fire("CloseOthers");
    Events.SetButtonsVisible:Fire({});
    u13:setLabel("Show UI");
end);
u5:modifyTheme({ { "Dropdown", "MaxIcons", 9 } });
u5:bindEvent("selected", function() -- Line: 222
    -- upvalues: LikeAction (copy), LocalPlayer (copy), u2 (ref), u3 (ref)
    task.spawn(function() -- Line: 31
        -- upvalues: LikeAction (ref), LocalPlayer (ref), u2 (ref), u3 (ref)
        local success, result = pcall(function() -- Line: 32
            -- upvalues: LikeAction (ref), LocalPlayer (ref)
            return LikeAction:InvokeServer("GetLikes", LocalPlayer);
        end);

        if success and result ~= nil then
            u2 = result;

            if u3 then
                u3:setLabel(" ❤️ Like Count: " .. tostring(u2));
            end;
        end;
    end);
end);
task.spawn(function() -- Line: 31
    -- upvalues: LikeAction (copy), LocalPlayer (copy), u2 (ref), u3 (ref)
    local success, result = pcall(function() -- Line: 32
        -- upvalues: LikeAction (ref), LocalPlayer (ref)
        return LikeAction:InvokeServer("GetLikes", LocalPlayer);
    end);

    if success and result ~= nil then
        u2 = result;

        if u3 then
            u3:setLabel(" ❤️ Like Count: " .. tostring(u2));
        end;
    end;
end);
v1.Icon = u5;

return v1;