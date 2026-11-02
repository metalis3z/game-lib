-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TeleportService_0 = game:GetService("TeleportService");
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_RequestTeleport_0 = game.ReplicatedStorage.Remotes.Extras.RequestTeleport;
local v3 = require(game.ReplicatedStorage.Modules.FriendsModule);
local l_Parent_0 = script.Parent;
local l_Modes_0 = l_Parent_0:WaitForChild("Container"):WaitForChild("Modes");
local l_TeleportInfo_0 = l_Parent_0.TeleportInfo;
local l_Overlay_0 = l_Parent_0.Overlay;
local l_ModeFrame_0 = script:WaitForChild("ModeFrame");
local l_ModeOverlay_0 = script:WaitForChild("ModeOverlay");
local l_ListItem_0 = l_ModeOverlay_0:WaitForChild("ModeInfo"):WaitForChild("ModeList"):WaitForChild("ListItem");
l_ListItem_0.Parent = script;
local l_GameModes_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync")).GameModes;
local function _(v12) --[[ Line: 29 ]] --[[ Name: getPlayerCount ]]
    return l_GameModes_0[v12].PlayerCount;
end;
local _ = function(_) --[[ Line: 33 ]] --[[ Name: getFriendsPlayingMode ]]
    return 0;
end;
local function v27(v16) --[[ Line: 37 ]] --[[ Name: updateFrame ]]
    local l_Name_0 = v16.Name;
    local l_Info_0 = v16.Info;
    local v19 = 0;
    local l_v3_FriendsOnline_0 = v3:GetFriendsOnline();
    local l_PlaceID_0 = l_GameModes_0[l_Name_0].PlaceID;
    for _, v23 in l_v3_FriendsOnline_0 do
        if v23.PlaceId == l_PlaceID_0 then
            v19 = v19 + 1;
        end;
    end;
    local v24 = v19 .. " " .. (v19 == 1 and "Friend" or "Friends") .. " " .. "Online";
    l_Info_0.PlayerCount.Visible = l_GameModes_0[l_Name_0].PlayerCount > 0;
    l_Info_0.FriendsPlaying.Visible = v19 > 0;
    l_Info_0.FriendsPlaying.TextLabel.Text = v24;
    local l_Popular_0 = l_Info_0.Popular;
    local v26 = false;
    if l_Name_0 == "Standard" then
        v26 = false;
        if l_Info_0.PlayerCount.Visible == false then
            v26 = l_Info_0.FriendsPlaying.Visible == false;
        end;
    end;
    l_Popular_0.Visible = v26;
    l_Popular_0 = l_Overlay_0.Container:FindFirstChild(l_Name_0);
    l_Popular_0.FriendsPlaying.Visible = v19 > 0;
    l_Popular_0.FriendsPlaying.TextLabel.Text = v24;
    l_Popular_0.Actions.Friends.Visible = v19 > 0;
end;
local function v38() --[[ Line: 68 ]] --[[ Name: setupModes ]]
    for v28, v29 in l_GameModes_0 do
        if not v29.Hidden then
            local v30 = l_ModeFrame_0:Clone();
            v30.Name = v28;
            v30.Info.ModeName.TextLabel.Text = v29.DisplayName;
            v30.Info.ModeIcon.ImageLabel.Image = v29.Image;
            v30.Info.ModeIcon.Limited.Visible = v29.LimitedTime == true;
            v30.LayoutOrder = v29.Order;
            local v31 = l_ModeOverlay_0:Clone();
            v31.ModeName.Text = v29.DisplayName;
            v31.ModeInfo.ModeIcon.ImageLabel.Image = v29.Image;
            for v32, v33 in v29.Description do
                local v34 = l_ListItem_0:Clone();
                v34.Text = v33;
                v34.LayoutOrder = v32;
                v34.Parent = v31.ModeInfo.ModeList;
            end;
            v31.Name = v28;
            v31.Parent = l_Overlay_0.Container;
            v27(v30);
            v30.Info.ModeIcon.CurrentServer.Visible = v29.PlaceID == game.PlaceId;
            v30.Button.Activated:Connect(function() --[[ Line: 98 ]]
                if not l_Overlay_0.Visible then
                    for _, v36 in l_Overlay_0.Container:GetChildren() do
                        if v36:IsA("Frame") and v36.Name ~= "Close" then
                            v36.Visible = v36 == v31;
                        end;
                    end;
                    l_Overlay_0.Visible = true;
                end;
            end);
            v31.Actions.Play.Activated:Connect(function() --[[ Line: 110 ]]
                local _ = v29.PlaceID;
                l_TeleportInfo_0.Visible = true;
                l_RequestTeleport_0:InvokeServer(v28);
            end);
            v31.Actions.Friends.Activated:Connect(function() --[[ Line: 116 ]]
                l_WindowService_0:ToggleFrame("FriendsOnline");
            end);
            v30.Parent = l_Modes_0;
        end;
    end;
end;
l_TeleportService_0.TeleportInitFailed:Connect(function() --[[ Line: 124 ]]
    l_TeleportInfo_0.Visible = false;
end);
l_Overlay_0.Close.Button.Activated:Connect(function() --[[ Line: 128 ]]
    l_Overlay_0.Visible = false;
end);
l_WindowService_0:RegisterFrame(l_Parent_0, "ModeBrowser", function() --[[ Line: 132 ]]
    for _, v40 in l_Modes_0:GetChildren() do
        if v40:IsA("Frame") then
            local _ = v40.Name;
            v27(v40);
        end;
    end;
end);
l_Parent_0:WaitForChild("Container"):WaitForChild("Title"):WaitForChild("Close"):WaitForChild("Button").Activated:Connect(function() --[[ Line: 144 ]]
    l_Parent_0.Visible = false;
end);
local _ = os.clock();
v38();
task.spawn(function() --[[ Line: 154 ]]
    while true do
        task.wait(10);
        for _, v44 in l_Modes_0:GetChildren() do
            if v44:IsA("Frame") then
                v27(v44);
            end;
        end;
    end;
end);