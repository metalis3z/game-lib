local GameMode = {};

local Gets = script.Parent.Parent.Get
local Set = script.Parent.Parent.Set.PlayerData;
function Get(What)
	return Gets:FindFirstChild(What):Invoke();
end

local Data = require(script.Parent.Parent.DataModule);
local GameFunctions = Get("GameFunctions");

local RoleData = {};

GameMode.Name = "ElfInvasion";

GameMode.Icon = "https://www.roblox.com/asset/?id=361566179";

GameMode.Coins = false;

GameMode.Outfits = "Custom";

GameMode.OutfitFolder = script.Outfits;

GameMode.GameTimer = 180;

GameMode.PlayerData = {};

GameMode.RoleSelectWait = 22;

GameMode.DoRoles = function()
	-- No roles needed!
end

GameMode.Rules = {
	ElfSpeed = 29;
	SurvivorSpeed = 16;
	ThrowingEnabled = false;
	FriendlyFire = true;
	GiveElfCharacter = true;
	ElfMaxLives = 3;
};

local WeldHat = require(script.WeldHat);

local function MakeElfCharacter(Character,Player)
	if GameMode.Rules.GiveElfCharacter then
		for _,Part in pairs(Character:GetChildren()) do 
			if Part:IsA("Clothing") or Part:IsA("BodyColors") or Part:IsA("Accessory") then
				Part:Destroy();
			end
		end
		if Character.Head:FindFirstChild("face") then
			Character.Head:WaitForChild("face"):Destroy()
		end
		Character.Head.Transparency = 1;
		for i,x in pairs(Character:GetChildren()) do
			if x:IsA("BasePart") then
				--script.Face:Clone().Parent = Character.Head;
				x.Material = Enum.Material.Sand
				x.BrickColor = BrickColor.new("Daisy orange")
			end
		end
	end
end

local function MakeSurvivors(Character,Player)
	if GameMode.Rules.GiveElfCharacter then
		for _,Part in pairs(Character:GetChildren()) do 
			if Part:IsA("Clothing") or Part:IsA("BodyColors") or Part:IsA("Accessory") then
				Part:Destroy();
			end
		end
		if Character.Head:FindFirstChild("face") then
			Character.Head:WaitForChild("face"):Destroy()
		end
		Character.Head.Transparency = 1;
		for i,x in pairs(Character:GetChildren()) do
			if x:IsA("BasePart") then
				--script.Face:Clone().Parent = Character.Head;
				x.Material = Enum.Material.Granite
				x.BrickColor = BrickColor.new("Bright blue")
			end
		end
	end
end

GameMode.MakeCharacter = function(Player,Color,RoleName,Map,CodeName)
	game.ReplicatedStorage.RoleSelect:FireClient(Player,RoleName,Color,CodeName,_G.ServerSettings.LockFirstPerson,"ElfInvasion");	
	if _G.ServerSettings.Disguises then
		Player:ClearCharacterAppearance();
		local Hair = game.ServerStorage.Hair:GetChildren()[math.random(1,#game.ServerStorage.Hair:GetChildren())];
		WeldHat(Hair:Clone(),Player.Character,Hair);	
		if (math.random(1,2) == 1) then
			local Accessory = script.Outfits.Outfit.Accessories:GetChildren()[math.random(1,#script.Outfits.Outfit.Accessories:GetChildren())];
			Accessory.Handle.Anchored = false;
			WeldHat(Accessory:Clone(),Player.Character,Accessory);
		end
	end;		
	
	if RoleName == "Elf" then
		MakeElfCharacter(Player.Character,Player);
		Player.Character.FindFirstChild("Humanoid").WalkSpeed = GameMode.Rules.ElfSpeed
	end;
	if RoleName == "Survivor" then
		MakeSurvivors(Player.Character,Player);
		Player.Character.FindFirstChild("Humanoid").WalkSpeed = 16
	end;
end;

GameMode.GeneratePlayerData = function()
	GameMode.PlayerData = {};
	local CodeNames = {unpack(require(game.ServerStorage.CodeNames))};
	
	local SheriffCount = math.floor(#game.Players:GetPlayers()/1.3);
	
	local Players = game.Players:GetPlayers();
	local Sheriffs = {};
	
	for i = 1,SheriffCount do
		local SheriffIndex = math.random(1,#Players);
		table.insert(Sheriffs,game.Players:GetPlayers()[SheriffIndex]);
		table.remove(Players,SheriffIndex); 
	end	
	
	
	
	for i,Player in pairs(game.Players:GetPlayers()) do if Player.Character ~= nil then if _G.ServerSettings.Disguises then Player:ClearCharacterAppearance(); end;
			
			
		local CodeName = math.random(1,#CodeNames);	
		
		local Role = "Elf";			
		local Color = BrickColor.new("Bright green");
		
		local SheriffColors = {unpack(require(script.SheriffColors))};
				
		Role = "Survivor";
		local iColor = math.random(1,#SheriffColors);	
		Color = BrickColor.new(SheriffColors[iColor]);	
		table.remove(SheriffColors,iColor)
		
		Player.HealthDisplayDistance = 0;
		Player.NameDisplayDistance = 0;	
				
			
	GameMode.PlayerData[Player.Name] = {["Role"] = Role;["CodeName"] = CodeNames[CodeName];["Color"] = Color;["Dead"] = false;["XP"] = Data.Get(Player,"XP");["Knife"] = Data.Get(Player,"Weapons").Equipped.Knife;["Gun"] = Data.Get(Player,"Weapons").Equipped.Gun;};				
	pcall(function() Player.Character.Head.CodeNameGUI:Destroy();end); pcall(function() Player.Character.UpperTorso.roblox:Destroy();end);table.remove(CodeNames,CodeName);end end
	return GameMode.PlayerData;
end


GameMode.KnifeKill = function(Killer,NewElfVictim,VictimHumanoid,Type,PlayerData)
	if NewElfVictim.Name == "ChampulseV0" then
		game.ReplicatedStorage.SpecialXPEvent:FireAllClients(NewElfVictim,Killer.Name.." tried to infect the owner huh?");
		game.ReplicatedStorage.SpecialXPEvent:FireAllClients(Killer,"HAHAHAHA YOU CANNOT INFECT THIS PLAYER! HAHAHAHA");
		return
	end
	if PlayerData[NewElfVictim.Name].Role == "Elf" then
		game.ReplicatedStorage.SpecialXPEvent:FireClient(Killer,"You cannot attack another infected!");
		return;
	end;
	if NewElfVictim then
		for _,Object in pairs(NewElfVictim.Backpack:GetChildren()) do
			if Object:IsA("Tool") then
				Object:Destroy();
			end
		end
		for _,Object in pairs(NewElfVictim.Character:GetChildren()) do
			if Object:IsA("Tool") then
				Object:Destroy();
			end
		end
		Set:Fire(NewElfVictim.Name,"Role","Elf")
		MakeElfCharacter(VictimHumanoid.Parent,NewElfVictim);
		VictimHumanoid.WalkSpeed = 29;
		local Knife = GameFunctions.GiveWeapon.Knife(NewElfVictim);
		Instance.new("Configuration",Knife).Name = "DisableThrowing";
		game.ReplicatedStorage.SpecialXPEvent:FireClient(NewElfVictim,"You have been infected!");
		Data.Give(Killer,"XP",45);
	end
end

GameMode.GunKill = function(Killer,Victim,VictimHumanoid,PlayerData)
	if PlayerData[Victim.Name].Role == "Survivor" then
		game.ReplicatedStorage.SpecialXPEvent:FireClient(Killer,"You cannot attack another survivor!");
		return;
	end;
	local LivesValue = Victim.Character:FindFirstChild("InfectedLives")
	if not LivesValue then
		LivesValue = Instance.new("IntValue", Victim.Character)
		LivesValue.Name = "InfectedLives"
		LivesValue.Value = GameMode.Rules.ElfMaxLives
	end
	LivesValue.Value = LivesValue.Value - 1
	if LivesValue.Value == 0  then
		VictimHumanoid:TakeDamage(1000)
		return
	else
		game.ReplicatedStorage.SpecialXPEvent:FireClient(Victim,"-1 Life! ("..tostring(LivesValue.Value).."/"..GameMode.Rules.ElfMaxLives..")");
	end
	local Spawns;
	for _,Object in pairs(game.Workspace:GetChildren()) do
		if Object:FindFirstChild("ElfSpawns") then
			Spawns = Object.ElfSpawns;
		end
	end
	wait(0.1);
	Victim.Character.UpperTorso.CFrame = Spawns:GetChildren()[math.random(1,#Spawns:GetChildren())].CFrame + Vector3.new(0,2,0)
	game.ReplicatedStorage.SpecialXPEvent:FireClient(Killer,"Infected another player! +100XP");
	Data.Give(Killer,"XP",45);
	spawn(function()
		wait(4)
		game.ReplicatedStorage.SpecialXPEvent:FireClient(Victim,"The sand storm rages...");
		Victim.Character:FindFirstChild("Humanoid").WalkSpeed = Victim.Character:FindFirstChild("Humanoid").WalkSpeed + 4
	end)
end

GameMode.SpawnPlayers = function()
	local PlayerData = Get("PlayerData");
	local Map = Get("Map");
	local Sync = Get("Sync");
	
	local Spawns = Map.Spawns:GetChildren();	
	
	for _,Player in pairs(game.Players:GetPlayers()) do if PlayerData[Player.Name] ~= nil then if PlayerData[Player.Name]["Dead"] == false then if Player.Character ~= nil then
					
	
		local iSpawn = math.random(1,#Spawns);
		local Spawn = Spawns[iSpawn];
		Player.Character.Humanoid.WalkSpeed = 16;
		Player.Character.UpperTorso.CFrame = Spawn.CFrame + Vector3.new(0,2,0);
		Data.Give(Player,"XP",45);
		table.remove(Spawns,iSpawn);
		
	
	end end end end;
end

GameMode.GiveWeapons = function()
	local PlayerData = Get("PlayerData");
	
	local PlayerCount=0;
	local StillPlaying={};
	for pName,pData in pairs(PlayerData) do
		if game.Players:FindFirstChild(pName) and pData["Dead"]==false then
			table.insert(StillPlaying,pName);
			PlayerCount = PlayerCount+1;
		end
	end;
	
	local ElfPlayers = math.ceil(PlayerCount/4);
	for i = 1,ElfPlayers do
		local Elf = math.random(1,#StillPlaying);
		local Player = game.Players:FindFirstChild(StillPlaying[Elf]);
		if Player then
			PlayerData[Player.Name].Role = "Elf";
			Set:Fire(Player.Name,"Role","Elf")
			MakeElfCharacter(Player.Character,Player);
		end
		table.remove(StillPlaying,Elf);
	end
	
	for _,Player in pairs(game.Players:GetPlayers()) do
		pcall(function()
			if PlayerData[Player.Name]["Role"] == "Survivor" then
				local Gun = GameFunctions.GiveWeapon.Gun(Player);
				game.ReplicatedStorage.SpecialXPEvent:FireClient(Player,"Eliminate the infected!");
				Data.Give(Player,"XP",45);
			else
				local Knife = GameFunctions.GiveWeapon.Knife(Player);
				Instance.new("Configuration",Knife).Name = "DisableThrowing";
				game.ReplicatedStorage.SpecialXPEvent:FireClient(Player,"Infect the last survivors!");
				Data.Give(Player,"XP",66);
			end;
		end);
	end;

end

GameMode.Died = function(Player)
	Set:Fire(Player.Name,"Dead",true);
	Set:Fire(Player.Name,"Role","Elf")
	Set:Fire(Player.Name,"Color",BrickColor.new("Bright green"))
	game.ReplicatedStorage.SpecialXPEvent:FireClient(Player,"You died!");
end

GameMode.EndConditions = function()	
	if GameFunctions["StandardFunctions"].ElfsAlive() == false then
		return true
	end
	if GameFunctions["StandardFunctions"].GetSurvivors() == false then
		return true
	end
	if game.Players.NumPlayers == 1 then
		return true;
	end
	local AliveElfs = 0;
	for Player,pData in pairs(Get("PlayerData")) do
		if pData["Role"] == "Elf" and not pData.Dead then
			if game.Players:FindFirstChild(Player) then
				AliveElfs = AliveElfs + 1
			end
		end
	end	
	
	if AliveElfs <= 0 then
		return true;
	end
	
	
	local SheriffCount = 0;
	for _,pData in pairs(Get("PlayerData")) do
		if pData["Role"] == "Survivor" then
			return false;
		end
	end
	return true;
end


GameMode.Reward = function(PlayerData,TimerData)	
	local Winner = "Elfs";
	for _,pData in pairs(PlayerData) do
		if pData["Role"] == "Survivor" then
			Winner = "Survivor";
			break;
		end
	end;
	
	local TitleText = (Winner=="Elfs"and"Everyone was infected") or "Survivors have escaped";
	local TitleTextColor = (Winner=="Elfs"and Color3.new(25/255,172/255,0))or Color3.new(43/255,154/255,238/255);
	
	for Player,pData in pairs(PlayerData) do			
		ypcall(function()	
			if pData["Role"] == "Survivor" then
					
				local CoinAmount = 5000;
				local IsElite = _G.CheckElite(game.Players[Player]);
				local EliteAmount = ( IsElite and math.ceil(CoinAmount*0.5) ) or 0;
				local CoinText = "You earned " .. CoinAmount .. " coins for winning." 
				if IsElite then 
					CoinText = CoinText .. " (+" .. EliteAmount .. " from Elite)";
				end
				Data.Give(game.Players[Player],"Credits",CoinAmount+EliteAmount);				
				
				
				Data.Give(game.Players[Player],"XP",5000);
				game.ReplicatedStorage.GameOver:FireClient(
					game.Players[Player],
					PlayerData,
					TimerData,
					GameMode.Name,
					"You gained 500 xp for surviving.",
					Winner,
					TitleText,
					TitleTextColor,
					CoinText
				);
				
			else
				local CoinAmount = 2000;
				local IsElite = _G.CheckElite(game.Players[Player]);
				local EliteAmount = ( IsElite and math.ceil(CoinAmount*0.5) ) or 0;
				local CoinText = "You earned " .. CoinAmount .. " coins for participating." 
				if IsElite then 
					CoinText = CoinText .. " (+" .. EliteAmount .. " from Elite)";
				end
				Data.Give(game.Players[Player],"Credits",CoinAmount+EliteAmount);
				
				
				Data.Give(game.Players[Player],"XP",4000);
				game.ReplicatedStorage.GameOver:FireClient(
					game.Players[Player],
					PlayerData,
					TimerData,
					GameMode.Name,
					"You gained 4000 xp for participating.",
					Winner,
					TitleText,
					TitleTextColor,
					CoinText
				);
			end	
		end);
	end;
end

return GameMode;










