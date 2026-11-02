-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent;
local l_Container_0 = l_Parent_0:WaitForChild("Container");
local l_CurrentRoundClient_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("CurrentRoundClient"));
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_Container_1 = l_Container_0:WaitForChild("PlayerList"):WaitForChild("Container");
local l_Teams_0 = l_Container_0:WaitForChild("Teams");
local l_Start_0 = l_Container_0:WaitForChild("PlayerList"):WaitForChild("Start");
local l_Close_0 = l_Container_0:WaitForChild("Title"):WaitForChild("Close");
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_DuelRound_0 = l_Parent_0:WaitForChild("DuelRound");
local l_DuelStart_0 = l_DuelRound_0:WaitForChild("Container"):WaitForChild("DuelStart");
local l_DuelDisplay_0 = l_DuelRound_0:WaitForChild("Container"):WaitForChild("DuelDisplay");
local l_Team1_0 = l_DuelDisplay_0:WaitForChild("Team1");
local l_Team2_0 = l_DuelDisplay_0:WaitForChild("Team2");
local l_Settings_0 = l_Container_0:WaitForChild("Settings");
local l_ListPlayer_0 = l_Container_1:WaitForChild("ListPlayer");
l_ListPlayer_0.Parent = script;
local l_TeamPlayer_0 = l_Teams_0.Team1.Container.Players:WaitForChild("TeamPlayer");
l_TeamPlayer_0.Parent = script;
local v17 = nil;
local l_RoundPlayer_0 = l_DuelDisplay_0:WaitForChild("Team1"):WaitForChild("RoundPlayer");
l_RoundPlayer_0.Parent = script;
local v19 = {
    Team1 = {}, 
    Team2 = {}
};
local v20 = {};
local v21 = {};
local v22 = l_Remotes_0:WaitForChild("CustomGames"):WaitForChild("CanStartDuels"):InvokeServer();
local v23 = {
    KnifeVsGun = "KnifeVsGun", 
    KnifeVsKnife = "KnifeVsKnife", 
    GunVsGun = "GunVsGun", 
    BothVsBoth = "BothVsBoth", 
    Custom = "Custom"
};
local l_KnifeVsGun_0 = v23.KnifeVsGun;
local v25 = {
    Both = "rbxassetid://18147380345", 
    Gun = "rbxassetid://197518111", 
    Knife = "rbxassetid://584555920"
};
local _ = function(v26) --[[ Line: 57 ]] --[[ Name: countTeamSize ]]
    local v27 = 0;
    for _, _ in v19[v26] do
        v27 = v27 + 1;
    end;
    return v27;
end;
local function v33(v31) --[[ Line: 65 ]] --[[ Name: UpdateWeaponsForMode ]]
    local l_v31_Attribute_0 = v31:GetAttribute("Team");
    if l_KnifeVsGun_0 == v23.KnifeVsGun then
        if l_v31_Attribute_0 == "Team1" then
            v31.Weapon.Icon.Image = v25.Knife;
        else
            v31.Weapon.Icon.Image = v25.Gun;
        end;
        v31.Knife:SetAttribute("Enabled", l_v31_Attribute_0 == "Team1");
        v31.Gun:SetAttribute("Enabled", l_v31_Attribute_0 == "Team2");
    elseif l_KnifeVsGun_0 == v23.KnifeVsKnife then
        v31.Weapon.Icon.Image = v25.Knife;
        v31.Knife:SetAttribute("Enabled", true);
        v31.Gun:SetAttribute("Enabled", false);
    elseif l_KnifeVsGun_0 == v23.GunVsGun then
        v31.Weapon.Icon.Image = v25.Gun;
        v31.Knife:SetAttribute("Enabled", false);
        v31.Gun:SetAttribute("Enabled", true);
    elseif l_KnifeVsGun_0 == v23.BothVsBoth then
        v31.Weapon.Icon.Image = v25.Both;
        v31.Knife:SetAttribute("Enabled", true);
        v31.Gun:SetAttribute("Enabled", true);
    end;
    v31.Weapon.Visible = l_KnifeVsGun_0 ~= v23.Custom;
    v31.Gun.Visible = l_KnifeVsGun_0 == v23.Custom;
    v31.Knife.Visible = l_KnifeVsGun_0 == v23.Custom;
end;
local function _(v34) --[[ Line: 100 ]] --[[ Name: GetPlayerIcon ]]
    local v35 = math.abs(v34.UserId);
    return game.Players:GetUserThumbnailAsync(v35, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100);
end;
local function v41() --[[ Line: 105 ]] --[[ Name: updateTeamFrames ]]
    for _, v38 in v19 do
        for v39, v40 in v38 do
            if v39.Parent == nil and v40 ~= nil then
                v40:Destroy();
                v38[v39] = nil;
            end;
        end;
    end;
end;
local function _(v42) --[[ Line: 116 ]] --[[ Name: removePlayerFromTeam ]]
    if v19.Team1[v42] then
        v19.Team1[v42]:Destroy();
    end;
    if v19.Team2[v42] then
        v19.Team2[v42]:Destroy();
    end;
    v19.Team1[v42] = nil;
    v19.Team2[v42] = nil;
end;
local _ = function() --[[ Line: 127 ]] --[[ Name: clearTeams ]]
    for _, v45 in game.Players:GetPlayers() do
        if v19.Team1[v45] then
            v19.Team1[v45]:Destroy();
        end;
        if v19.Team2[v45] then
            v19.Team2[v45]:Destroy();
        end;
        v19.Team1[v45] = nil;
        v19.Team2[v45] = nil;
    end;
end;
local function v53(v47, v48) --[[ Line: 133 ]] --[[ Name: addPlayerToTeam ]]
    if v19.Team1[v47] then
        v19.Team1[v47]:Destroy();
    end;
    if v19.Team2[v47] then
        v19.Team2[v47]:Destroy();
    end;
    v19.Team1[v47] = nil;
    v19.Team2[v47] = nil;
    local v49 = l_TeamPlayer_0:Clone();
    v49.TextLabel.Text = v47.Name;
    local l_ImageLabel_0 = v49.ImageLabel;
    local v51 = math.abs(v47.UserId);
    l_ImageLabel_0.Image = game.Players:GetUserThumbnailAsync(v51, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100);
    v49.ImageLabel.Button.Activated:Connect(function() --[[ Line: 140 ]]
        v49:Destroy();
        local l_v47_0 = v47;
        if v19.Team1[l_v47_0] then
            v19.Team1[l_v47_0]:Destroy();
        end;
        if v19.Team2[l_v47_0] then
            v19.Team2[l_v47_0]:Destroy();
        end;
        v19.Team1[l_v47_0] = nil;
        v19.Team2[l_v47_0] = nil;
    end);
    v49.LayoutOrder = time() * 100;
    v49:SetAttribute("Team", v48);
    v49.Knife:SetAttribute("Enabled", true);
    v49.Knife.Button.Activated:Connect(function() --[[ Line: 148 ]]
        if v49.Knife:GetAttribute("Enabled") then
            v49.Knife:SetAttribute("Enabled", false);
            v49.Knife.Icon.ImageColor3 = Color3.fromRGB(255, 0, 0);
            return;
        else
            v49.Knife:SetAttribute("Enabled", true);
            v49.Knife.Icon.ImageColor3 = Color3.fromRGB(0, 255, 0);
            return;
        end;
    end);
    v49.Gun:SetAttribute("Enabled", true);
    v49.Gun.Button.Activated:Connect(function() --[[ Line: 160 ]]
        if v49.Gun:GetAttribute("Enabled") then
            v49.Gun:SetAttribute("Enabled", false);
            v49.Gun.Icon.ImageColor3 = Color3.fromRGB(255, 0, 0);
            return;
        else
            v49.Gun:SetAttribute("Enabled", true);
            v49.Gun.Icon.ImageColor3 = Color3.fromRGB(0, 255, 0);
            return;
        end;
    end);
    v33(v49);
    v19[v48][v47] = v49;
    v49.Parent = l_Teams_0[v48].Container.Players;
    v41();
end;
local function v56() --[[ Line: 179 ]] --[[ Name: resetSelection ]]
    for _, v55 in v20 do
        v55.ImageLabel.UIStroke.Color = Color3.fromRGB(0, 0, 0);
    end;
end;
local function v64() --[[ Line: 185 ]] --[[ Name: updatePlayerList ]]
    task.wait();
    for _, v58 in game.Players:GetPlayers() do
        do
            if v20[v58] == nil then
                local v59 = l_ListPlayer_0:Clone();
                local l_ImageLabel_1 = v59.ImageLabel;
                local v61 = math.abs(v58.UserId);
                l_ImageLabel_1.Image = game.Players:GetUserThumbnailAsync(v61, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100);
                v59.TextLabel.Text = v58.Name;
                v59.LayoutOrder = time() * 100;
                v59.Button.Activated:Connect(function() --[[ Line: 195 ]]
                    if v17 == v58 then
                        v59.ImageLabel.UIStroke.Color = Color3.fromRGB(0, 0, 0);
                        v17 = nil;
                        return;
                    else
                        v56();
                        v17 = v58;
                        v59.ImageLabel.UIStroke.Color = Color3.fromRGB(50, 200, 50);
                        return;
                    end;
                end);
                v59.Parent = l_Container_1;
                v20[v58] = v59;
            end;
        end;
    end;
    for v62, v63 in v20 do
        if not v62:IsDescendantOf(game.Players) then
            if v63 then
                v63:Destroy();
            end;
            v20[v62] = nil;
        end;
    end;
end;
local v65 = nil;
local function v69() --[[ Line: 222 ]] --[[ Name: onPlayerDataUpdated ]]
    for v66, v67 in l_CurrentRoundClient_0.PlayerData do
        local v68 = v21[v66];
        if v68 and v67.Dead then
            v68.Dead.Visible = true;
            v68.ImageLabel.ImageColor3 = Color3.fromRGB(20, 20, 20);
        end;
    end;
end;
local function v91(v70) --[[ Line: 236 ]] --[[ Name: onDuelStarted ]]
    v21 = {};
    if v65 == nil then
        v65 = l_CurrentRoundClient_0.PlayerDataChanged.Event:Connect(v69);
    end;
    local v71 = v70.Team1[game.Players.LocalPlayer.Name] and "Team1" or "Team2";
    for v72, _ in v70[v71] do
        local l_FirstChild_0 = game.Players:FindFirstChild(v72);
        if l_FirstChild_0 and l_FirstChild_0 ~= game.Players.LocalPlayer and l_FirstChild_0.Character then
            local l_HumanoidRootPart_0 = l_FirstChild_0.Character:FindFirstChild("HumanoidRootPart");
            if l_HumanoidRootPart_0 then
                local v76 = script.TeamMate:Clone();
                v76.Enabled = true;
                v76.Parent = l_HumanoidRootPart_0;
            end;
        end;
    end;
    for _, v78 in l_Team1_0:GetChildren() do
        if v78:IsA("Frame") then
            v78:Destroy();
        end;
    end;
    for _, v80 in l_Team2_0:GetChildren() do
        if v80:IsA("Frame") then
            v80:Destroy();
        end;
    end;
    for v81, v82 in v70 do
        for v83, v84 in v82 do
            local l_FirstChild_1 = game.Players:FindFirstChild(v83);
            if l_FirstChild_1 then
                local v86 = l_RoundPlayer_0:Clone();
                v86.Name = v83;
                v86.PlayerName.Text = v83;
                local l_ImageLabel_2 = v86.ImageLabel;
                local v88 = math.abs(l_FirstChild_1.UserId);
                l_ImageLabel_2.Image = game.Players:GetUserThumbnailAsync(v88, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100);
                v86.Weapons.Knife.Visible = v84.Knife == true;
                v86.Weapons.Gun.Visible = v84.Gun == true;
                v86.Parent = v81 == "Team1" and l_Team1_0 or l_Team2_0;
                v21[v83] = v86;
            end;
        end;
    end;
    l_DuelRound_0.Visible = true;
    l_DuelStart_0.Visible = true;
    l_DuelDisplay_0.Visible = true;
    local v89 = os.clock();
    while os.clock() - v89 < 10 do
        local v90 = math.ceil(os.clock() - v89);
        l_DuelStart_0.Timer.Text = 10 - v90 + 1;
        task.wait();
    end;
    l_DuelStart_0.Visible = false;
end;
local function v97() --[[ Line: 310 ]] --[[ Name: onDuelSubmitted ]]
    local v92 = {
        Team1 = {}, 
        Team2 = {}
    };
    for v93, v94 in v19.Team1 do
        v92.Team1[v93.Name] = {
            Knife = v94.Knife:GetAttribute("Enabled"), 
            Gun = v94.Gun:GetAttribute("Enabled")
        };
    end;
    for v95, v96 in v19.Team2 do
        v92.Team2[v95.Name] = {
            Knife = v96.Knife:GetAttribute("Enabled"), 
            Gun = v96.Gun:GetAttribute("Enabled")
        };
    end;
    l_Container_0.Visible = false;
    l_Remotes_0.CustomGames.SubmitDuel:FireServer(v92);
end;
l_Close_0.ImageButton.Activated:Connect(function() --[[ Line: 333 ]]
    l_Container_0.Visible = false;
end);
if v22 then
    for _, v99 in l_Settings_0:GetChildren() do
        if v99:IsA("Frame") then
            v99.Button.Activated:Connect(function() --[[ Line: 344 ]]
                l_KnifeVsGun_0 = v99.Name;
                for _, v101 in l_Settings_0:GetChildren() do
                    if v101:IsA("Frame") then
                        v101.Button.Style = v101 == v99 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
                    end;
                end;
                for _, v103 in v19 do
                    for _, v105 in v103 do
                        v33(v105);
                    end;
                end;
            end);
        end;
    end;
    l_Start_0.ImageButton.Activated:Connect(v97);
    l_Teams_0.Team1.Container.InputBegan:Connect(function(v106) --[[ Line: 363 ]]
        if v106.UserInputType ~= Enum.UserInputType.MouseButton1 and v106.UserInputType ~= Enum.UserInputType.Touch then
            return;
        else
            if v17 and v17:IsDescendantOf(game.Players) then
                local v107 = 0;
                for _, _ in v19.Team1 do
                    v107 = v107 + 1;
                end;
                if v107 < 4 then
                    v53(v17, "Team1");
                    v56();
                    v17 = nil;
                end;
            end;
            return;
        end;
    end);
    l_Teams_0.Team2.Container.InputBegan:Connect(function(v110) --[[ Line: 375 ]]
        if v110.UserInputType ~= Enum.UserInputType.MouseButton1 and v110.UserInputType ~= Enum.UserInputType.Touch then
            return;
        else
            if v17 and v17:IsDescendantOf(game.Players) then
                local v111 = 0;
                for _, _ in v19.Team2 do
                    v111 = v111 + 1;
                end;
                if v111 < 4 then
                    v53(v17, "Team2");
                    v56();
                    v17 = nil;
                end;
            end;
            return;
        end;
    end);
    for _, v115 in l_Container_1:GetChildren() do
        if v115:IsA("Frame") then
            v115:Destroy();
        end;
    end;
    for _, v117 in l_Teams_0.Team1.Container.Players:GetChildren() do
        if v117:IsA("Frame") then
            v117:Destroy();
        end;
    end;
    for _, v119 in l_Teams_0.Team2.Container.Players:GetChildren() do
        if v119:IsA("Frame") then
            v119:Destroy();
        end;
    end;
    v64();
    game.Players.PlayerAdded:Connect(function() --[[ Line: 406 ]]
        v64();
        v41();
    end);
    game.Players.PlayerRemoving:Connect(function() --[[ Line: 410 ]]
        v64();
        v41();
    end);
end;
l_DuelRound_0.Visible = false;
l_Remotes_0.CustomGames.DuelKill.OnClientEvent:Connect(function(_, _, _) --[[ Line: 419 ]]

end);
l_Remotes_0.Gameplay.RoundEndFade.OnClientEvent:Connect(function() --[[ Line: 423 ]]
    l_DuelRound_0.Visible = false;
end);
l_Remotes_0:WaitForChild("CustomGames"):WaitForChild("DuelStarted").OnClientEvent:Connect(v91);
l_WindowService_0:RegisterFrame(l_Container_0, "DuelSetup");