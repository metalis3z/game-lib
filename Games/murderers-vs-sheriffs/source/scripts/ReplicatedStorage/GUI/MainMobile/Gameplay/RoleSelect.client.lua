local l_FadeModule_0 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("FadeModule"));
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Parent_0 = script.Parent.Parent;
local _ = l_Parent_0.Parent;
local l_Lobby_0 = l_Parent_0:WaitForChild("Lobby");
local _ = l_Lobby_0:WaitForChild("Dock");
local _ = l_Lobby_0:WaitForChild("Screens");
local _ = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_Game_0 = l_Parent_0:WaitForChild("Game");
local l_RoleSelector_0 = l_Game_0:WaitForChild("RoleSelector");
for _, v11 in pairs(script:GetChildren()) do
    game:GetService("ContentProvider"):Preload(v11.SoundId);
end;
local function _(v12)
    if _G.Cache[v12] ~= nil then
        return _G.Cache[v12];
    else
        local v13 = (tonumber(v12) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v12 or v12) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[v12] = v13;
        return v13;
    end;
end;
local l_Weapons_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync")).Weapons;
game.ReplicatedStorage.Remotes.Gameplay.Fade.OnClientEvent:connect(function(v16)
    l_Lobby_0.Screens.Waiting.Scoreboard.Visible = false;
    if not v16[l_LocalPlayer_0.Name] then
        return;
    else
        game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0);
        for _ = 1, 30 do
            l_Lobby_0.Fade.Transparency = l_Lobby_0.Fade.Transparency - 0.03333333333333333;
            game:GetService("RunService").RenderStepped:wait();
        end;
        l_Game_0.Visible = true;
        l_GuiService_0.TouchControlsEnabled = true;
        return;
    end;
end);
game.ReplicatedStorage.Remotes.Gameplay.LoadingMap.OnClientEvent:connect(function(v18)
    if v18 == "Classic" or v18 == "ScaryMode" or v18 ~= "Assassin" then

    end;
end);
local v19 = {
    Innocent = Color3.new(0, 1, 0), 
    Sheriff = Color3.new(0, 0, 1), 
    Murderer = Color3.new(1, 0, 0), 
    Zombie = Color3.new(0.09803921568627451, 0.6745098039215687, 0), 
    Survivor = Color3.new(0.16862745098039217, 0.6039215686274509, 0.9333333333333333), 
    Red = Color3.new(0.8509803921568627, 0.13725490196078433, 0.13725490196078433), 
    Blue = Color3.new(0.24705882352941178, 0.6901960784313725, 0.8784313725490196), 
    Juggernaut = Color3.new(0.8509803921568627, 0.13725490196078433, 0.13725490196078433), 
    Gladiator = Color3.new(0.24705882352941178, 0.6901960784313725, 0.8784313725490196), 
    Freezer = Color3.fromRGB(150, 220, 250), 
	Runner = Color3.fromRGB(0, 200, 100),
	BlueTeam = Color3.new(0, 0, 1), 
	RedTeam = Color3.new(1,0,0)
};
local function v31(v20, v21, v22, v23)
    local l_AssassinTarget_0 = l_Game_0.AssassinTarget;
    if v20 ~= nil and v21 ~= nil and v22 ~= nil then
        local l_UserThumbnailAsync_0 = game.Players:GetUserThumbnailAsync(math.abs(v21), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180);
        l_AssassinTarget_0.Target.PlayerIcon.Image = l_UserThumbnailAsync_0;
        l_AssassinTarget_0.TargetName.Text = v20;
        local l_Icon_0 = l_AssassinTarget_0.Knife.Icon;
        local l_Image_0 = l_Weapons_0[v22].Image;
        local v28;
        if _G.Cache[l_Image_0] ~= nil then
            v28 = _G.Cache[l_Image_0];
        else
            local v29 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
            _G.Cache[l_Image_0] = v29;
            v28 = v29;
        end;
        l_Icon_0.Image = v28;
        l_Icon_0 = l_AssassinTarget_0.Gun.Icon;
        l_Image_0 = l_Weapons_0[v23].Image;
        if _G.Cache[l_Image_0] ~= nil then
            v28 = _G.Cache[l_Image_0];
        else
            local v30 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
            _G.Cache[l_Image_0] = v30;
            v28 = v30;
        end;
        l_Icon_0.Image = v28;
        l_AssassinTarget_0.Visible = true;
        return;
    else
        l_AssassinTarget_0.Visible = false;
        return;
    end;
end;
local v32 = {
    Classic = {
        "Innocent", 
        "Sheriff", 
        "Murderer"
    }, 
    Infection = {
        "Survivor", 
        "Zombie"
    }, 
    FreezeTag = {
        "Freezer", 
        "Runner"
	},
	SnowballFight = { "Blue", "Red" }
};
local v33 = {
    Innocent = 13, 
    Sheriff = 14, 
    Murderer = 15, 
    Freezer = 13, 
	Runner = 14,
	Blue = 13,
	Red = 13
};
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local function v36()
    l_Lobby_0.LeaderBar.Visible = false;
    l_Lobby_0.GameBar.Visible = true;
    local v35 = TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false);
    game:GetService("TweenService"):Create(l_Lobby_0.Fade, v35, {
        BackgroundTransparency = 1
    }):Play();
end;
l_Remotes_0.Gameplay.ShowRoleSelect.OnClientEvent:Connect(v36);
l_Remotes_0.Gameplay.ShowRoleSelectNew.OnClientEvent:Connect(v36);
local v37 = nil;
l_Remotes_0.Gameplay.RoleSelect.OnClientEvent:connect(function(v38, _, _, v41, v42, v43, v44, v45, v46)
	if v42 == "SnowballFight" then
		return
	end
	local v47 = v32[v42];
    l_Lobby_0.LeaderBar.Visible = false;
    l_Lobby_0.GameBar.Visible = true;
    for _ = 1, 30 do
        l_Lobby_0.Fade.Transparency = l_Lobby_0.Fade.Transparency + 0.03333333333333333;
        game:GetService("RunService").RenderStepped:wait();
    end;
    game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0.5);
    if v42 == "ScaryMode" then
        if v38 == "Innocent" then
            l_Game_0.Crouch.Visible = true;
        end;
        return;
    else
        l_RoleSelector_0.Visible = true;
        if v42 == "Classic" or v42 == "FreezeTag" then
            for v49 = 1, v33[v38] do
                local v50 = v47[(v49 - 1) % #v47 + 1];
                if v49 ~= v33[v38] then
                    script[v50]:Play();
                else
                    script.Ding:Play();
                end;
                wait(0.04);
                l_RoleSelector_0.Role.Text = v50;
                l_RoleSelector_0.Role.TextColor3 = v19[v50];
                wait(0.06);
            end;
            wait(2.5);
            if v38 == "Innocent" or v38 == "Runner" then
                l_RoleSelector_0.Title.Text = "Game starts in...";
                l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
                for v51 = 1, 10 do
                    l_RoleSelector_0.Role.Text = 11 - v51;
                    if v51 == 3 then
                        l_RoleSelector_0:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Quad", 1, false);
                    end;
                    wait(1);
                end;
                l_RoleSelector_0.Visible = false;
            else
                l_RoleSelector_0.Title.Text = "You will receive your weapon in...";
                l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
                for v52 = 1, 10 do
                    l_RoleSelector_0.Role.Text = 11 - v52;
                    if v52 == 3 then
                        l_RoleSelector_0:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Quad", 1, false);
                    end;
                    wait(1);
                end;
                l_RoleSelector_0.Visible = false;
            end;
            if v38 ~= "Innocent" then
                l_Game_0.Weapons[v38].Visible = true;
            end;
            if v38 == "Murderer" then
                --l_Game_0.Perk.Visible = true;
              --  l_Game_0.Throw.Visible = true;
            end;
        elseif v42 == "Infection" then
            l_RoleSelector_0.Title.Text = "Everyone is a";
            l_RoleSelector_0.Role.Text = "Survivor";
            l_RoleSelector_0.Role.TextColor3 = v19.Survivor;
            wait(3);
            l_RoleSelector_0.Title.Text = "Someone will be infected in...";
            l_RoleSelector_0:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Quad", 1, false);
            l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
            for v53 = 1, 5 do
                l_RoleSelector_0.Role.Text = 6 - v53;
                wait(1);
            end;
            l_RoleSelector_0.Visible = false;
        elseif v42 == "Assassin" then
            l_RoleSelector_0.Visible = false;
            local l_AssassinTarget_1 = l_Game_0.AssassinTarget;
            v31(v43, v46, v44, v45);
            v37 = v43;
            for v55 = 1, 10 do
                l_AssassinTarget_1.Timer.Text = 11 - v55;
                wait(1);
            end;
            l_AssassinTarget_1.TimerTitle.Visible = false;
            l_AssassinTarget_1.Timer.Visible = false;
        end;
        if v41 then
            l_LocalPlayer_0.CameraMode = "LockFirstPerson";
        end;
        return;
    end;
end);
local function v45()
	l_FadeModule_0.DeathFlash();
end
	
game.ReplicatedStorage.Remotes.Gameplay.SpecialXPEvent.OnClientEvent:connect(function(Text)
	local XPText = script.Parent.XPText:Clone();
	XPText.Text = Text;
	XPText.Parent = l_Game_0;
	XPText.Visible = true
	game.Debris:AddItem(XPText,4);
end)
game.ReplicatedStorage.Remotes.Gameplay.ChangeTarget.OnClientEvent:connect(function(v56, v57, v58, v59)
    local l_AssassinTarget_2 = l_Game_0.AssassinTarget;
    if v37 ~= v56 then
        v37 = v56;
        l_AssassinTarget_2.NewTarget.Visible = true;
        task.spawn(function()
            wait(1);
            l_AssassinTarget_2.NewTarget.Visible = false;
        end);
    end;
    v31(v56, v59, v57, v58);
end);
game.ReplicatedStorage.Remotes.Gameplay.VictoryScreen.OnClientEvent:connect(function()
    l_Game_0.AssassinTarget.Visible = false;
end);
_G.LockTarget = nil;
l_LocalPlayer_0.CameraMode = Enum.CameraMode.Classic;
l_LocalPlayer_0.CameraMinZoomDistance = 7;
wait(0.5);
l_LocalPlayer_0.CameraMinZoomDistance = 0.5;
game.Players.LocalPlayer.Character.Humanoid.Died:connect(function()
    game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic;
end);

local v56 = nil;
repeat
	task.wait();
	v56 = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid");
until v56 ~= nil;
v56.Died:Connect(v45);

--// Focer Roles //--
local Constants = require(game.ReplicatedStorage.Constants)
local ChancePassUI = l_RoleSelector_0.ChancePass

local MurdererButton = ChancePassUI.Murderer
local SheriffButton = ChancePassUI.Sheriff

local ButtonModule = require(game.ReplicatedStorage.ClientServices.Button)
ButtonModule.createButton(MurdererButton)
ButtonModule.createButton(SheriffButton)

MurdererButton.Button.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Remotes.Shop.PurchaseProduct:FireServer("Murderer", "Gameplay")
end)

SheriffButton.Button.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Remotes.Shop.PurchaseProduct:FireServer("Sheriff", "Gameplay")
end)