-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local Parent = script.Parent;
local Events = script.Parent.Parent:WaitForChild("Events");
local BuildAction = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuildAction");
local DialogController = require(Parent:WaitForChild("DialogController"));
local Builds = PlayerGui:WaitForChild("Builds");
local container = Builds:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local closeButton = wrapper:WaitForChild("titleBar"):WaitForChild("closeButton");
local list = wrapper:WaitForChild("list");
local saveButton = wrapper:WaitForChild("saveButton");
local emptyLabel = list:WaitForChild("emptyLabel");
local rowTemplate = list:WaitForChild("rowTemplate");

for _, child in list:GetChildren() do
    if child:IsA("Frame") and child ~= rowTemplate then
        child:Destroy();
    end;
end;

local v1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(container, v1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(container, v1, {
    GroupTransparency = 1
});
local u4 = {
    IsOpen = false
};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = false;

local function clearConnections() -- Line: 45
    -- upvalues: u5 (copy)
    for _, v in u5 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u5);
end;

local function clearRows() -- Line: 50
    -- upvalues: u6 (copy), u7 (copy)
    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);

    for _, v in u7 do
        v:Destroy();
    end;

    table.clear(u7);
end;

local function formatMeta(p9) -- Line: 57
    local v10 = p9.partCount or 0;

    return v10 .. (v10 == 1 and " part" or " parts");
end;

local function addRow(u11) -- Line: 62
    -- upvalues: rowTemplate (copy), u7 (copy), list (copy), u6 (copy), u4 (copy)
    local v12 = rowTemplate:Clone();
    v12.Name = "build_" .. tostring(u11.id);
    v12.Visible = true;
    v12.LayoutOrder = #u7 + 1;
    v12.content.textBlock.buildName.Text = u11.name or "Build";
    local v13 = u11.partCount or 0;
    v12.content.textBlock.meta.Text = v13 .. (v13 == 1 and " part" or " parts");
    v12.Parent = list;
    u7[#u7 + 1] = v12;
    u6[#u6 + 1] = v12.loadButton.Activated:Connect(function() -- Line: 71
        -- upvalues: u4 (ref), u11 (copy)
        u4.Load(u11);
    end);
    u6[#u6 + 1] = v12.deleteButton.Activated:Connect(function() -- Line: 74
        -- upvalues: u4 (ref), u11 (copy)
        u4.Delete(u11);
    end);
    u6[#u6 + 1] = v12.updateButton.Activated:Connect(function() -- Line: 77
        -- upvalues: u4 (ref), u11 (copy)
        u4.Update(u11);
    end);
end;

function u4.Refresh() -- Line: 82
    -- upvalues: clearRows (copy), emptyLabel (copy), BuildAction (copy), u4 (copy), addRow (copy)
    clearRows();
    emptyLabel.Visible = true;
    emptyLabel.Text = "Loading...";
    local success, result = pcall(function() -- Line: 86
        -- upvalues: BuildAction (ref)
        return BuildAction:InvokeServer("List");
    end);

    if not u4.IsOpen then
        return;
    end;

    if not success or (type(result) ~= "table" or not result.success) then
        emptyLabel.Visible = true;
        emptyLabel.Text = type(result) == "table" and (result.reason or "Couldn\'t load builds.") or "Couldn\'t load builds.";

        return;
    end;

    local v14 = result.builds or {};

    if #v14 == 0 then
        emptyLabel.Visible = true;
        emptyLabel.Text = "No saved builds yet.";

        return;
    end;

    emptyLabel.Visible = false;

    for _, v in ipairs(v14) do
        addRow(v);
    end;
end;

function u4.Save() -- Line: 103
    -- upvalues: u8 (ref), DialogController (copy), Events (copy), BuildAction (copy), u4 (copy)
    if u8 then
        return;
    end;

    local u15 = DialogController.PromptInputDialog({
        Title = "Save Build",
        Description = "Name your build.",
        PlaceholderText = "Build name",
        YesText = "Save",
        NoText = "Cancel"
    });

    if type(u15) ~= "string" or u15:gsub("%s", "") == "" then
        return;
    end;

    u8 = true;
    Events.Notify:Fire("Saving build...");
    local success, result = pcall(function() -- Line: 115
        -- upvalues: BuildAction (ref), u15 (copy)
        return BuildAction:InvokeServer("Save", u15);
    end);
    u8 = false;

    if success and (type(result) == "table" and result.success) then
        if result.build then
            u15 = result.build.name or u15;
        end;

        Events.Notify:Fire("✅ Saved <b>" .. u15 .. "</b>.");

        if u4.IsOpen then
            u4.Refresh();
        end;
    else
        Events.Notify:Fire("❌ " .. (type(result) == "table" and (result.reason or "Couldn\'t save build.") or "Couldn\'t save build."));
    end;
end;

function u4.Load(u16) -- Line: 125
    -- upvalues: u8 (ref), DialogController (copy), Events (copy), BuildAction (copy)
    if u8 then
        return;
    end;

    if not DialogController.PromptDialog({
        Title = "Load build?",
        YesText = "Load",
        NoText = "Cancel",
        Description = "This will clear your current build and load <b>" .. (u16.name or "this build") .. "</b> in its place."
    }) then
        return;
    end;

    u8 = true;
    Events.Notify:Fire("Loading build...");
    local success, result = pcall(function() -- Line: 136
        -- upvalues: BuildAction (ref), u16 (copy)
        return BuildAction:InvokeServer("Load", u16.id);
    end);
    u8 = false;

    if success and (type(result) == "table" and result.success) then
        Events.Notify:Fire("✅ Loaded <b>" .. (u16.name or "build") .. "</b>.");

        return;
    end;

    Events.Notify:Fire("❌ " .. (type(result) == "table" and (result.reason or "Couldn\'t load build.") or "Couldn\'t load build."));
end;

function u4.Delete(u17) -- Line: 145
    -- upvalues: u8 (ref), DialogController (copy), BuildAction (copy), Events (copy), u4 (copy)
    if u8 then
        return;
    end;

    if not DialogController.PromptDialog({
        Title = "Delete build?",
        YesText = "Delete",
        NoText = "Cancel",
        Description = "Delete <b>" .. (u17.name or "this build") .. "</b>? This cannot be undone."
    }) then
        return;
    end;

    u8 = true;
    local success, result = pcall(function() -- Line: 155
        -- upvalues: BuildAction (ref), u17 (copy)
        return BuildAction:InvokeServer("Delete", u17.id);
    end);
    u8 = false;

    if success and (type(result) == "table" and result.success) then
        Events.Notify:Fire("✅ Deleted <b>" .. (u17.name or "build") .. "</b>.");

        if u4.IsOpen then
            u4.Refresh();
        end;
    else
        Events.Notify:Fire("❌ " .. (type(result) == "table" and (result.reason or "Couldn\'t delete build.") or "Couldn\'t delete build."));
    end;
end;

function u4.Update(u18) -- Line: 165
    -- upvalues: u8 (ref), DialogController (copy), Events (copy), BuildAction (copy), u4 (copy)
    if u8 then
        return;
    end;

    if not DialogController.PromptDialog({
        Title = "Overwrite build?",
        YesText = "Overwrite",
        NoText = "Cancel",
        Description = "Overwrite <b>" .. (u18.name or "this build") .. "</b> with your current build? The saved version will be replaced."
    }) then
        return;
    end;

    u8 = true;
    Events.Notify:Fire("Updating build...");
    local success, result = pcall(function() -- Line: 176
        -- upvalues: BuildAction (ref), u18 (copy)
        return BuildAction:InvokeServer("Update", u18.id);
    end);
    u8 = false;

    if success and (type(result) == "table" and result.success) then
        Events.Notify:Fire("✅ Updated <b>" .. (u18.name or "build") .. "</b>.");

        if u4.IsOpen then
            u4.Refresh();
        end;
    else
        Events.Notify:Fire("❌ " .. (type(result) == "table" and (result.reason or "Couldn\'t update build.") or "Couldn\'t update build."));
    end;
end;

function u4.Open(p19) -- Line: 186
    -- upvalues: u4 (copy), Events (copy), Builds (copy), container (copy), u2 (copy), u5 (copy), closeButton (copy), saveButton (copy)
    if u4.IsOpen then
        if p19 then
            u4.Close();
        end;

        return;
    end;

    u4.IsOpen = true;
    Events.InterfaceAction:Fire("Add", script.Name, u4.Close);
    Builds.Enabled = true;
    container.GroupTransparency = 1;
    u2:Play();
    table.insert(u5, closeButton.Activated:Connect(function() -- Line: 198
        -- upvalues: u4 (ref)
        u4.Close();
    end));
    table.insert(u5, saveButton.Activated:Connect(function() -- Line: 199
        -- upvalues: u4 (ref)
        u4.Save();
    end));
    task.spawn(u4.Refresh);
end;

function u4.Close(p20) -- Line: 204
    -- upvalues: u4 (copy), Events (copy), u5 (copy), u3 (copy), Builds (copy), clearRows (copy)
    if not u4.IsOpen then
        return;
    end;

    u4.IsOpen = false;
    Events.InterfaceAction:Fire("Remove", script.Name);

    for _, v in u5 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u5);
    u3:Play();
    u3.Completed:Once(function() -- Line: 210
        -- upvalues: u4 (ref), Builds (ref), clearRows (ref)
        if u4.IsOpen ~= true then
            Builds.Enabled = false;
            clearRows();
        end;
    end);
end;

Builds.Enabled = false;

return u4;