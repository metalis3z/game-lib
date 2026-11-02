local GameGUI = script.Parent.Parent;
local RoleSelector = GameGUI.RoleSelector;
local LocalPlayer = game.Players.LocalPlayer;


for _,Sound in pairs(script:GetChildren()) do
	game:GetService("ContentProvider"):Preload(Sound.SoundId)
end

game.ReplicatedStorage.Fade.OnClientEvent:connect(function()
	--GameGUI.BonusRoundSelect.Visible = false;
	game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0)
	for i = 1,30 do
		GameGUI.Fade.Transparency = GameGUI.Fade.Transparency - 1/30;
		game:GetService("RunService").RenderStepped:wait();
	end
end)

game.ReplicatedStorage.LoadingMap.OnClientEvent:connect(function(SpecialRound)
	--GameGUI.Waiting.Image = "http://www.roblox.com/asset/?id=304416585";
end)
local Colors = {
	["Innocent"] = Color3.new(0,1,0);
	["Sheriff"] = Color3.new(0,0,1);
	["Murderer"] = Color3.new(1,0,0);
	["Zombie"] = Color3.new(25/255, 172/255, 0);
	["Survivor"] = Color3.new(43/255,154/255,238/255);		
	["Red"] = Color3.new(217/255, 35/255, 35/255);
	["Blue"] = Color3.new(63/255, 176/255, 224/255);
	["Juggernaut"] = Color3.new(217/255, 35/255, 35/255);
	["Gladiator"] = Color3.new(63/255, 176/255, 224/255);
};
local Stop = {
	["Innocent"] = 13;
	["Sheriff"] = 14;
	["Murderer"] = 15;
};
local RoleIndexes = {
	["Classic"] = {"Innocent","Sheriff","Murderer"};
	["Infection"] = {"Survivor","Zombie"};
};

game.ReplicatedStorage.RoleSelect.OnClientEvent:connect(function(Role,Color,CodeName,LockFirstPerson,GameMode)
	--GameGUI.Waiting.Visible = false;
	for i = 1,30 do
		GameGUI.Fade.Transparency = GameGUI.Fade.Transparency + 1/30;
		game:GetService("RunService").RenderStepped:wait();
	end
	game.Players.LocalPlayer.PlayerGui:SetTopbarTransparency(0.5);
	if GameMode == "Classic" then
		RoleSelector.Chance.Text = "Your chance to be murderer: "
		spawn(function() RoleSelector.Chance.Text = "Your chance to be murderer: " .. game.ReplicatedStorage.GetChance:InvokeServer() .. "%";end);
	end;
	RoleSelector.Visible = true;
	
	if GameMode == "Classic" then
		local RoleIndex = RoleIndexes[GameMode] --{"Innocent","Sheriff","Murderer"};	
		for i = 1,Stop[Role] do
			local cRole = RoleIndex[((i-1)% #RoleIndex )+1];
			if i ~= Stop[Role] then
				script["Click"..((i-1)% #RoleIndex )+1]:Play();
			else
				script.Ding:Play();
			end;
			wait(0.04);
			RoleSelector.Role.Text = cRole;
			RoleSelector.Role.TextColor3 = Colors[cRole];
			wait(0.06);
		end;
		wait(2.5);
		
		if Role == "Murderer" or Role == "Sheriff" or Role == "Zombie" or Role == "Survivor" then
			RoleSelector.Title.Text = "You will receive your weapon in...";
			RoleSelector.Role.TextColor3 = Color3.new(1,1,1);
			for i = 1,10 do
				RoleSelector.Role.Text = 11-i
				if i == 3 then
					RoleSelector:TweenPosition(UDim2.new(0,0,0,25), "Out", "Quad", 1, false)
				end
				wait(1);
			end
			RoleSelector.Visible = false;
			GameGUI.CashBag.Visible = true;
		else
			RoleSelector.Title.Text = "Game starts in...";
			RoleSelector.Role.TextColor3 = Color3.new(1,1,1);
			for i = 1,10 do
				RoleSelector.Role.Text = 11-i
				if i == 3 then
					RoleSelector:TweenPosition(UDim2.new(0,0,0,25), "Out", "Quad", 1, false)
				end
				wait(1);
			end
		end;
	end
	
	if GameMode == "Dodgeball" then
		
		RoleSelector.Title.Text = "You are on the"
		RoleSelector.Role.Text = Role .. " Team";
		RoleSelector.Role.TextColor3 = Colors[Role]or Color3.new();
		wait(3);
		RoleSelector.Title.Text = "Game starts in...";
		RoleSelector:TweenPosition(UDim2.new(0,0,0,25), "Out", "Quad", 1, false)
		RoleSelector.Role.TextColor3 = Color3.new(1,1,1);
		for i = 1,5 do
			RoleSelector.Role.Text = 6-i
			wait(1);
		end

	elseif GameMode == "Infection" then
		
		RoleSelector.Title.Text = "Everyone is a"
		RoleSelector.Role.Text = "Survivor"
		RoleSelector.Role.TextColor3 = Colors["Survivor"];
		wait(3);
		RoleSelector.Title.Text = "Someone will be infected in...";
		RoleSelector:TweenPosition(UDim2.new(0,0,0,25), "Out", "Quad", 1, false)
		RoleSelector.Role.TextColor3 = Color3.new(1,1,1);
		for i = 1,5 do
			RoleSelector.Role.Text = 6-i
			wait(1);
		end
		
	elseif GameMode == "Massacre" then
		
		RoleSelector.Title.Text = "Everyone is a"
		RoleSelector.Role.Text = "Murderer"
		RoleSelector.Role.TextColor3 = Color3.new(1,0,0);
		wait(3);
		RoleSelector.Title.Text = "Massacre starts in...";
		RoleSelector:TweenPosition(UDim2.new(0,0,0,25), "Out", "Quad", 1, false)
		RoleSelector.Role.TextColor3 = Color3.new(1,1,1);
		for i = 1,5 do
			RoleSelector.Role.Text = 6-i
			wait(1);
		end
		
	elseif GameMode == "Juggernaut" then
		
		RoleSelector.Title.Text = "You are a"
		RoleSelector.Role.Text = Role;
		RoleSelector.Role.TextColor3 = Colors[Role];
		wait(3);
		RoleSelector.Title.Text = "Battle begins in...";
		RoleSelector:TweenPosition(UDim2.new(0,0,0,25), "Out", "Quad", 1, false)
		RoleSelector.Role.TextColor3 = Color3.new(1,1,1);
		for i = 1,5 do
			RoleSelector.Role.Text = 6-i
			wait(1);
		end
		
	end;

	RoleSelector.Visible = false;
	GameGUI.CashBag.Visible = true;
	
	if LockFirstPerson then game.Players.LocalPlayer.CameraMode = "LockFirstPerson"; end;
	GameGUI.YourCodeName.Image = require(game.ReplicatedStorage.CodeImages)[CodeName];
	GameGUI.YourCodeName.ImageColor3 = Color.Color;
	--GameGUI.YourCodeName.Visible = true;
	GameGUI.Weapon.Visible = (Role=="Murderer" or Role=="Sheriff");
	GameGUI.Weapon.Knife.Visible = (Role=="Murderer");
	GameGUI.Weapon.Gun.Visible = (Role=="Sheriff");
	GameGUI.Weapon.WeaponIcon.Image = (Role=="Murderer"and"http://www.roblox.com/asset/?id=148256623") 
									or(Role=="Sheriff"and"http://www.roblox.com/asset/?id=197518111")
									or"";
	
end)

game.ReplicatedStorage.RoundStart.OnClientEvent:connect(function(GameTimer)
	GameGUI.Timer.Text = GameTimer;
	while wait(1) do
		GameTimer = GameTimer - 1;
		GameGUI.Timer.Text = GameTimer;
	end
	
end);


repeat wait() until LocalPlayer.Character ~= nil;
wait();
LocalPlayer.CameraMode = "Classic";
LocalPlayer.CameraMinZoomDistance = 7;
wait(0.5);
LocalPlayer.CameraMinZoomDistance = 0.5;
game.StarterGui:SetCoreGuiEnabled("Health",false);
game.StarterGui:SetCoreGuiEnabled("PlayerList",false);
