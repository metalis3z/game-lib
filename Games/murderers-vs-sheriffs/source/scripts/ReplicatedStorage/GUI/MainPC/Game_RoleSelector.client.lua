-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Game_0 = script.Parent:WaitForChild("Game");
local l_RoleSelector_0 = l_Game_0:WaitForChild("RoleSelector");
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
for _, v4 in script:GetChildren() do
    game:GetService("ContentProvider"):Preload(v4.SoundId);
end;
local l_Item_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync")).Item;
local v6 = TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false);
local _ = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
local l_TweenService_0 = game:GetService("TweenService");
local v9 = nil;
local l_Target3_0 = l_Game_0:WaitForChild("Target3");
local v11 = {
    Innocent = Color3.new(0, 1, 0), 
    Sheriff = Color3.new(0, 0, 1), 
    Murderer = Color3.new(1, 0, 0.0156863), 
    Zombie = Color3.new(0.09803921568627451, 0.6745098039215687, 0), 
    Survivor = Color3.new(0.16862745098039217, 0.6039215686274509, 0.9333333333333333), 
    Freezer = Color3.fromRGB(150, 220, 250), 
    Runner = Color3.fromRGB(0, 200, 100), 
    Red = Color3.new(0.8509803921568627, 0.13725490196078433, 0.13725490196078433), 
    Blue = Color3.new(0.24705882352941178, 0.6901960784313725, 0.8784313725490196), 
    Juggernaut = Color3.new(0.8509803921568627, 0.13725490196078433, 0.13725490196078433), 
	Gladiator = Color3.new(0.24705882352941178, 0.6901960784313725, 0.8784313725490196),
	BlueTeam = Color3.new(0, 0, 1), 
	RedTeam = Color3.new(1,0,0)
};
local v12 = {
    Innocent = 13, 
    Sheriff = 14, 
    Murderer = 15, 
    Freezer = 13, 
	Runner = 14,
	Blue = 13,
	Red = 13,
};
local v13 = {
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
local function _(v14) --[[ Line: 49 ]] --[[ Name: GetImage ]]
    if _G.Cache[v14] ~= nil then
        return _G.Cache[v14];
    else
        local v15 = (tonumber(v14) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v14 or v14) .. "&bust=" .. math.random(1, 10000);
        _G.Cache[v14] = v15;
        return v15;
    end;
end;
local _ = function(v17) --[[ Line: 61 ]] --[[ Name: PlayTweens ]]
    for _, v19 in pairs(v17) do
        v19:Play();
    end;
end;
local function onGameplayFade()
    local v21 = {
        l_TweenService_0:Create(l_Game_0.Fade, v6, {
            BackgroundTransparency = 0
        })
    };
    for _, v23 in pairs(v21) do
        v23:Play();
    end;
end;
local function onMapLoading() 
    l_Game_0.Waiting.Image = "http://www.roblox.com/asset/?id=304416585";
end;
local function updateAssassinTarget(Target, TargetUserID, Knife, Gun)
	if Target ~= nil and TargetUserID ~= nil and Knife ~= nil then
		local l_UserThumbnailAsync_0 = game.Players:GetUserThumbnailAsync(math.abs(tonumber(TargetUserID)), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180);
		l_Target3_0.Target.PlayerIcon.Image = l_UserThumbnailAsync_0;
		l_Target3_0.TargetName.Text = Target;
		local l_Icon_0 = l_Target3_0.Knife.Icon;
		local l_Image_0 = l_Item_0[Knife].Image;
		local v33;
		if _G.Cache[l_Image_0] ~= nil then
			v33 = _G.Cache[l_Image_0];
		else
			local v34 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
			_G.Cache[l_Image_0] = v34;
			v33 = v34;
		end;
		l_Icon_0.Image = v33;
		l_Icon_0 = l_Target3_0.Gun.Icon;
		l_Image_0 = l_Item_0[Gun].Image;
		if _G.Cache[l_Image_0] ~= nil then
			v33 = _G.Cache[l_Image_0];
		else
			local v35 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
			_G.Cache[l_Image_0] = v35;
			v33 = v35;
		end;
		l_Icon_0.Image = v33;
		l_Target3_0.Visible = true;
		return;
	else
		l_Target3_0.Visible = false;
		return;
	end;
end;
local function onAssassinTargetChanged(v37, v38, v39, v40) 
    local l_Target3_1 = l_Game_0.Target3;
    if v37 ~= v9 then
        v9 = v37;
        l_Target3_1.NewTarget.Visible = true;
        task.spawn(function()
            wait(1);
            l_Target3_1.NewTarget.Visible = false;
        end);
    end;
	updateAssassinTarget(v37, v40, v38, v39);
end;
local function unfadeGameplay() 
    l_Game_0:WaitForChild("Waiting").Visible = false;
    local v43 = {
        l_TweenService_0:Create(l_Game_0:WaitForChild("Fade"), v6, {
            BackgroundTransparency = 1
        })
    };
    for _, v45 in pairs(v43) do
        v45:Play();
    end;
end;
local function onVictoryScreenShown()
    l_Game_0.Target3.Visible = false;
end;
local function v63(Role, Color, CodeName, LockFirstPerson, GameMode, TargetName, TargetUserID, Knife, Gun)
	unfadeGameplay();
	wait(0.3);
	if GameMode == "Classic" then
		l_RoleSelector_0.Chance.Text = "Your chance to be murderer: ";
		task.spawn(function()
			l_RoleSelector_0.Chance.Text = "Your chance to be murderer: " .. game.ReplicatedStorage.Remotes.Extras.GetChance:InvokeServer() .. "%";
		end);
	end;
	l_RoleSelector_0.Visible = true;
	if GameMode == "Classic" or GameMode == "FreezeTag" then
		local v57 = v13[GameMode];
		for v58 = 1, v12[Role] do
			local v59 = v57[(v58 - 1) % #v57 + 1];
			if v58 ~= v12[Role] then
				script["Click" .. (v58 - 1) % #v57 + 1]:Play();
			else
				script.Ding:Play();
			end;
			wait(0.04);
			l_RoleSelector_0.Role.Text = v59;
			l_RoleSelector_0.Role.TextColor3 = v11[v59];
			wait(0.06);
		end;
		wait(2.5);
		if Role == "Murderer" or Role == "Sheriff" or Role == "Zombie" or Role == "Survivor" or Role == "Freezer" then
			l_RoleSelector_0.Title.Text = "You will receive your weapon in...";
			l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
			for v60 = 1, 10 do
				l_RoleSelector_0.Role.Text = 11 - v60;
				if v60 == 3 then
					l_RoleSelector_0:TweenPosition(UDim2.new(0.5, -150, 0, 25), "Out", "Quad", 1, false);
				end;
				wait(1);
			end;
			l_RoleSelector_0.Visible = false;
		else
			l_RoleSelector_0.Title.Text = "Game starts in...";
			l_RoleSelector_0.Role.TextColor3 = Color3.new(1, 1, 1);
			for v61 = 1, 10 do
				l_RoleSelector_0.Role.Text = 11 - v61;
				if v61 == 3 then
					l_RoleSelector_0:TweenPosition(UDim2.new(0.5, -150, 0, 25), "Out", "Quad", 1, false);
				end;
				wait(1);
			end;
		end;
	elseif GameMode == "Assassin" then
		l_RoleSelector_0.Visible = false;
		updateAssassinTarget(TargetName, TargetUserID, Knife, Gun);
		v9 = TargetName;
		for v62 = 1, 10 do
			l_Target3_0.Timer.Text = "Game starts in... " .. 11 - v62;
			wait(1);
		end;
		l_Target3_0.Timer.Visible = false;
	--[[elseif GameMode == "Infection" then

		l_RoleSelector_0.Title.Text = "Everyone is a"
		l_RoleSelector_0.Role.Text = "Survivor"
		l_RoleSelector_0.Role.TextColor3 = v11["Survivor"];
		wait(3);
		l_RoleSelector_0.Title.Text = "Someone will be infected in...";
		l_RoleSelector_0:TweenPosition(UDim2.new(0.5,-150,0,25), "Out", "Quad", 1, false)
		l_RoleSelector_0.Role.TextColor3 = Color3.new(1,1,1);
		for i = 1,5 do
			l_RoleSelector_0.Role.Text = 6-i
			wait(1);
		end]]
	end;
	l_RoleSelector_0.Visible = false;
	if LockFirstPerson then
		game.Players.LocalPlayer.CameraMode = "LockFirstPerson";
		l_Game_0.YourCodeName.Image = require(game.ReplicatedStorage.CodeImages)[CodeName];
		l_Game_0.YourCodeName.ImageColor3 = Color.Color;
		l_Game_0.YourCodeName.Visible = true;
	end;
	l_Game_0.Weapon.Murderer.Visible = game:GetService("UserInputService").TouchEnabled and Role == "Murderer";
	l_Game_0.Weapon.Sheriff.Visible = game:GetService("UserInputService").TouchEnabled and Role == "Sheriff";
	if GameMode == "ScaryMode" and Role == "Innocent" and game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled then
		l_Game_0.Crouch.Visible = true;
	end;
end;
l_Remotes_0.Gameplay:WaitForChild("RoleSelect").OnClientEvent:Connect(v63);
l_Remotes_0.Gameplay:WaitForChild("ChangeTarget").OnClientEvent:Connect(onAssassinTargetChanged);


l_Remotes_0:WaitForChild("Gameplay"):WaitForChild("Fade").OnClientEvent:Connect(onGameplayFade);
l_Remotes_0.Gameplay:WaitForChild("LoadingMap").OnClientEvent:Connect(onMapLoading);
l_Remotes_0.Gameplay:WaitForChild("ShowRoleSelect").OnClientEvent:Connect(unfadeGameplay);
l_Remotes_0.Gameplay:WaitForChild("ShowRoleSelectNew").OnClientEvent:Connect(unfadeGameplay);
l_Remotes_0.Gameplay:WaitForChild("VictoryScreen").OnClientEvent:Connect(onVictoryScreenShown);

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