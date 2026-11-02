-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SettingsInfo = require(ReplicatedStorage.Modules.SettingsInfo);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local Settings = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings");
local u1 = {
    { "QueueName", "Dropdown", "Gamemode", "rbxassetid://77802568386086", "Changes the gameplay, map pool, & more" },
    { "MapPool", "Dropdown", "Map Pool", "rbxassetid://83261934303870", "Change how the map pool is determined" },
    { "MapPoolGamemode", "Dropdown", "By Gamemode", "rbxassetid://14641612286", "You probably don\'t need to edit this" },
    { "MapPoolSpecific", "Dropdown", "Specific Map", "rbxassetid://14641612286", "Choose the specific map you want" },
    { "InfinitePlayersPerTeam", "Toggle", "Infinite Players", "rbxassetid://16782323002", "The private server owner has to manually start this duel" },
    { "PlayersPerTeam", "Slider", "Players Per Team", "rbxassetid://105821004981978", "Turn on Infinite Players if you have a big party" },
    { "UnlimitedTime", "Toggle", "Unlimited Time", "rbxassetid://18195730712", "The timer won\'t end while playing this duel" },
    { "CanSelfQueue", "Toggle", "Play Solo", "rbxassetid://17738769051", "Allows you to play this duel by yourself" },
    { "DisableOOB", "Toggle", "Out of Bounds", "rbxassetid://89987125943326", "Go out of bounds in any map" }
};
local u2 = setmetatable({}, Page);
u2.__index = u2;

function u2._new() -- Line: 27
    -- upvalues: Page (copy), u2 (copy)
    local v3 = Page.new(script.Name);
    local v4 = setmetatable(v3, u2);
    v4.CloseButton = v4.PageFrame:WaitForChild("Close");
    v4.List = v4.PageFrame:WaitForChild("List");
    v4.Container = v4.List:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.HeaderFrame = v4.Container:WaitForChild("Header");
    v4.HeaderTitle = v4.HeaderFrame:WaitForChild("Title");
    v4._client_queue_pad = nil;
    v4._setting_objects = {};
    v4._connections = {};
    v4:_Init();

    return v4;
end;

function u2.SetQueuePad(u5, p6) -- Line: 50
    for _, v in pairs(u5._connections) do
        v:Disconnect();
    end;

    u5._connections = {};
    u5._client_queue_pad = p6;

    if not u5._client_queue_pad then
        return;
    end;

    u5.HeaderTitle.Text = p6:Get("Model").Name;

    for _, v in pairs(u5._setting_objects) do
        v.RegenerateSettingsInfo();
    end;

    local function update() -- Line: 68
        -- upvalues: u5 (copy)
        for i, v in pairs(u5._setting_objects) do
            local v7 = u5._client_queue_pad:Get(i);

            if v7 == nil then
                v7 = v.SettingObject.SettingsInfo.DefaultValue;
            end;

            v.SettingObject:SetValue(v7, true, true);
        end;
    end;

    table.insert(u5._connections, u5._client_queue_pad.Activity:Connect(update));
    update();
end;

function u2.Close(p8, ...) -- Line: 81
    -- upvalues: Page (copy)
    p8:SetQueuePad(nil);
    Page.Close(p8, ...);
end;

function u2._GetSettingsInfoValueParams(p9, p10) -- Line: 90
    -- upvalues: Players (copy), DuelLibrary (copy)
    if p10 == "InfinitePlayersPerTeam" or (p10 == "UnlimitedTime" or (p10 == "CanSelfQueue" or p10 == "DisableOOB")) then
        return false, nil;
    end;

    if p10 == "PlayersPerTeam" then
        local v11 = p9._client_queue_pad and p9._client_queue_pad:Get("QueueName");

        if v11 then
            v11 = p9._client_queue_pad:GetMatchmakingQueueInfoFromQueueName(v11);
        end;

        return v11 and v11.PlayersPerTeam or 1, 1, p9._client_queue_pad and p9._client_queue_pad:GetMaxPlayersPerTeam() or 1, 1;
    end;

    if p10 == "QueueName" then
        local v12 = p9._client_queue_pad and (p9._client_queue_pad:GetDuelLogics(Players.LocalPlayer) or { "???" }) or { "???" };
        local v13 = p9._client_queue_pad and p9._client_queue_pad:Get("OriginalQueueName");

        if v13 then
            v13 = DuelLibrary.MatchmakingQueues[v13];
        end;

        if v13 then
            v13 = v13.TitleName or v13.DisplayName;
        end;

        if not (v13 and (table.find(v12, v13) and v13)) then
            v13 = v12[1];
        end;

        return v13, v12;
    end;

    if p10 == "MapPool" then
        return "By Gamemode", { "Unrestricted", "By Gamemode", "Specific Map" };
    end;

    if p10 == "MapPoolGamemode" then
        local v14 = p9._client_queue_pad and (p9._client_queue_pad:GetMapPools(Players.LocalPlayer) or { "???" }) or { "???" };
        local v15 = p9._client_queue_pad and p9._client_queue_pad:Get("QueueName");

        if v15 then
            v15 = p9._client_queue_pad:GetMatchmakingQueueInfoFromQueueName(v15);
        end;

        return v15 and (v15.DisplayName and table.find(v14, v15.DisplayName)) and v15.DisplayName or v14[1], v14;
    end;

    if p10 == "MapPoolSpecific" then
        local v16 = p9._client_queue_pad and p9._client_queue_pad:GetSortedMapNames() or { "???" };

        return v16[1], v16;
    end;

    assert(false, p10);
end;

function u2._Setup(u17) -- Line: 125
    -- upvalues: u1 (copy), Settings (copy), SettingsInfo (copy), ReplicatedStorage (copy)
    for i, v in pairs(u1) do
        local table_unpack_ret, u18, u19, u20, u21 = table.unpack(v);

        local function regenerate_settings_info() -- Line: 130
            -- upvalues: SettingsInfo (ref), u19 (copy), u20 (copy), u21 (copy), u18 (copy), u17 (copy), table_unpack_ret (copy)
            return SettingsInfo.new("", "", u19, u20, u21, u18, u17:_GetSettingsInfoValueParams(table_unpack_ret));
        end;

        local u22 = require(Settings[u18]).new(regenerate_settings_info());
        u22.SettingFrame.LayoutOrder = i;
        u22.SettingFrame.Parent = u17.Container;
        u22.Replicate:Connect(function() -- Line: 138
            -- upvalues: u17 (copy), ReplicatedStorage (ref), table_unpack_ret (copy), u22 (copy)
            if u17._client_queue_pad then
                ReplicatedStorage.Remotes.PrivateServer.EditQueuePad:FireServer(u17._client_queue_pad:Get("ObjectID"), table_unpack_ret, u22.Value);
            end;
        end);
        u17._setting_objects[table_unpack_ret] = {
            SettingObject = u22,

            RegenerateSettingsInfo = function() -- Line: 146, Name: RegenerateSettingsInfo
                -- upvalues: u22 (copy), regenerate_settings_info (copy)
                u22:SetSettingsInfo(regenerate_settings_info());
            end
        };
    end;

    u17._setting_objects.MapPool.SettingObject:Scale(0.95);
    u17._setting_objects.MapPoolGamemode.SettingObject:Scale(0.9);
    u17._setting_objects.MapPoolSpecific.SettingObject:Scale(0.9);
    u17._setting_objects.InfinitePlayersPerTeam.SettingObject:Scale(0.95);
    u17._setting_objects.PlayersPerTeam.SettingObject:Scale(0.9);

    local function update_dependencies() -- Line: 158
        -- upvalues: u17 (copy)
        u17._setting_objects.PlayersPerTeam.SettingObject.SettingFrame.Visible = not u17._setting_objects.InfinitePlayersPerTeam.SettingObject.Value;
        u17._setting_objects.MapPoolGamemode.SettingObject.SettingFrame.Visible = u17._setting_objects.MapPool.SettingObject.Value == "By Gamemode";
        u17._setting_objects.MapPoolSpecific.SettingObject.SettingFrame.Visible = u17._setting_objects.MapPool.SettingObject.Value == "Specific Map";
    end;

    u17._setting_objects.InfinitePlayersPerTeam.SettingObject.Changed:Connect(update_dependencies);
    u17._setting_objects.MapPool.SettingObject.Changed:Connect(update_dependencies);
    update_dependencies();
    u17._setting_objects.QueueName.SettingObject.Changed:Connect(function() -- Line: 168
        -- upvalues: u17 (copy)
        u17._setting_objects.PlayersPerTeam.RegenerateSettingsInfo();
        u17._setting_objects.MapPoolGamemode.RegenerateSettingsInfo();
    end);
end;

function u2._Init(u23) -- Line: 174
    -- upvalues: ButtonEffect (copy)
    u23.CloseButton.MouseButton1Click:Connect(function() -- Line: 175
        -- upvalues: u23 (copy)
        u23:CloseRequest();
    end);
    u23.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 179
        -- upvalues: u23 (copy)
        u23.List.CanvasSize = UDim2.new(0, 0, 0, u23.Layout.AbsoluteContentSize.Y);
        u23.List.Active = u23.Layout.AbsoluteContentSize.Y >= u23.List.AbsoluteSize.Y;
    end);
    u23:_Setup();
    ButtonEffect:Add(u23.CloseButton);
end;

return u2._new();