-- <- Init -> --
local Module = {
	CurrentSession = {
		Players = {};
		TimePast = 0;
		CurrentMap = nil;
		LastSurvivorAlive = nil;
	};
	IntermissionTimePast = 0
}

-- <- Services -> --
local Client = game:GetService('ReplicatedStorage');
local RunService = game:GetService('RunService');
local Players = game:GetService('Players');

-- <- Modules -> --
local Mode = require(Client.Modules.Gamemodes:FindFirstChild(workspace:GetAttribute('ServerType')))
local Initializer = require(Client.Initializer);
local Config = require(script.Configuration)
local Network = Initializer.Modules.Network;
local Util = Initializer.Modules.Util;
local RoundNetwork = Initializer.Modules.RoundNetwork;
local Actors = Initializer.Modules.Actors;
local Maps = Initializer.Modules.Maps;
local sounds = require(game.ReplicatedStorage.Modules.Sounds)
local MapVoting = Initializer.Modules.MapVoting;

-- <- Private Variables -> --
local IsStudio = RunService:IsStudio();

local RoundTimer = Client:FindFirstChild('RoundTimer');

local NormalTime = Config.RoundsInfos.BaseTime
local LobbyTime = Config.LobbyInfos.BaseTime
local LMSTime = Config.RoundsInfos.LMSTime
local NoLoad = false

-- <- Functions -> --
function Reset()
	table.clear(Module.CurrentSession.Players);
	--
	Module.IntermissionTimePast = 0 
	Module.CurrentSession.TimePast = 0
	Module.CurrentSession.CurrentMap = nil
	Module.CurrentSession.LastSurvivorAlive = nil
end

function Module:Done(WhoWon: string)
	if not workspace.Map.Ingame:FindFirstChild('Map') then
		Reset()
		--
		for Index, Value in Players:GetChildren() do
			if not Value:FindFirstChild('leaderstats') or not Value:GetAttribute('Loaded') then
				continue
			end
			--
			local Table = {
				Instance = Value;
				KillerChance = Value:FindFirstChild('leaderstats'):FindFirstChild('KillerChance')
			}
			--
			table.insert(Module.CurrentSession.Players, Table)			
		end
		--
		pcall(function()
			Mode.Init(Module.CurrentSession)
		end)
		--
		Network:FireAllClientConnection('HandleGamemode', 'Init', workspace:GetAttribute('ServerType'), Module.CurrentSession)
		--
		task.wait(.25)
		--
		local MapToMake = 'random'
		--
		if workspace:GetAttribute('MapVotingEnabled') == true then
			MapToMake = MapVoting:GetMostVotedMapName()
		end
		--
		local CreatedMap = Maps:CreateMap(MapToMake)
		--
		Module.CurrentSession.CurrentMap = CreatedMap
		Module:RoundTime()
	else 
		RoundTimer.Value = 'Wait.'
		sounds:StopTheme("eternalFight",0.8,false)
		sounds:StopTheme("eternalFightplead",0,false)
		sounds:StopTheme("eternalFightcreation",0,false)
		sounds:StopTheme("eternalFightgasharpoon",0,false)
		sounds:StopTheme("eternalFightcupcakes",0,false)
		sounds:StopTheme("eternalFightvanity",0,false)
		sounds:StopTheme("eternalFightvipjason",0,false)
		sounds:StopTheme("eternalFightcust",0,false)
		Network:FireAllClientConnection('PlayWinnerCutscene', 'REMOTE_EVENT', WhoWon, Actors.CurrentActors) -- Handle player win thing ig ?
		--
		Network:FireAllClientConnection('HandleGamemode', 'Destroy', workspace:GetAttribute('ServerType'), Module.CurrentSession)
		--
		for Index, Value in Module.CurrentSession.Players do 
			pcall(function()
				Actors:CleanupActorFromPlayer(Value.Instance)
				--
				Value.Instance:LoadCharacter()
			end)
		end
		--
		Reset()
		--
		Module:LobbyTime()
		--		
		workspace.Map.Ingame:FindFirstChild('Map'):Destroy()
	end
end

function Module:RoundTime()
	RoundTimer:SetAttribute('TimeLeft', NormalTime)
	RoundTimer.Value = Config.RoundsInfos.Text
	--
	spawn(function()
		while task.wait(1) do 
			if RoundTimer:GetAttribute('TimeLeft') == 0 or Module.CurrentSession.TimePast >= NormalTime then
				Module:Done('Survivors')
				break
			end			
			if workspace:GetAttribute('NoTimer') == true then
				repeat task.wait(1)
					--
				until workspace:GetAttribute('NoTimer') == false
			end
			--
			local KillerCount = #workspace.Players.Killers:GetChildren()
			local SurvivorCount = #workspace.Players.Survivors:GetChildren()
			--
			if SurvivorCount == 1 then
				Network:FireAllClientConnection('LastSurvivor', 'REMOTE_EVENT')
				RoundTimer:SetAttribute('TimeLeft', LMSTime)
				if KillerCount > 1 then
					for _, i in pairs(game.Workspace.Players.Killers:GetChildren()) do
						local ie = game.Players:GetPlayerFromCharacter(i)
						Util:RevealPlayerAuraTo(ie, game.Workspace.Players.Survivors:FindFirstChildWhichIsA("Humanoid",true).Parent, 10);
					end
					sounds:PlayTheme("eternalFight",{Name = "eternalFight",Priority = 9999999999,TweenTime = 0,Volume = 1,TimePosition = 0})
				else
					local i = game.Workspace.Players.Killers:FindFirstChildWhichIsA("Humanoid",true).Parent
					local ie = game.Players:GetPlayerFromCharacter(i)
					local v = game.Workspace.Players.Survivors:FindFirstChildWhichIsA("Humanoid",true).Parent
					Util:RevealPlayerAuraTo(ie, v, 10);
					if i.Name == "c00lkidd" and v.Name == "007n7" then
						sounds:PlayTheme("eternalFightplead",{Name = "eternalFightplead",Priority = 9999999999,TweenTime = 0,Volume = 1,TimePosition = 0})
					elseif i.Name == "1x1x1x1" and v.Name == "Shedletsky" then
						sounds:PlayTheme("eternalFightcreation",{Name = "eternalFightcreation",Priority = 9999999999,TweenTime = 0,Volume = 1,TimePosition = 0})
					elseif i:GetAttribute("SkinName") == "GasharpoonJohnDoe" then
						sounds:PlayTheme("eternalFightgasharpoon",{Name = "eternalFightgasharpoon",Priority = 9999999999,TweenTime = 0,Volume = 1,TimePosition = 0})
					elseif i:GetAttribute("SkinName") == "CupcakesC00l" then
						sounds:PlayTheme("eternalFightcupcakes",{Name = "eternalFightcupcakes",Priority = 9999999999,TweenTime = 0,Volume = 1,TimePosition = 0})
					elseif i:GetAttribute("SkinName") == "VanityJason" then
						sounds:PlayTheme("eternalFightvanity",{Name = "eternalFightvanity",Priority = 9999999999,TweenTime = 0,Volume = 1,TimePosition = 0})
					elseif i:GetAttribute("SkinName") == "VIPJason" then
						sounds:PlayTheme("eternalFightvipjason",{Name = "eternalFightvipjason",Priority = 9999999999,TweenTime = 0,Volume = 1,TimePosition = 0})
					else
						sounds:PlayTheme("eternalFight",{Name = "eternalFight",Priority = 9999999999,TweenTime = 0,Volume = 1,TimePosition = 0})
					end
				end
			end
			--
			if KillerCount <= 0 then -- JUST NO KILLERS ?
				Module:Done('Survivors')
				for _, i in pairs(game.Workspace.Players.Killers:GetChildren()) do
					local ie = game.Players:GetPlayerFromCharacter(i)
					Util:RevealPlayerAuraTo(ie, game.Workspace.Players.Survivors:FindFirstChildWhichIsA("Humanoid",true).Parent, 5);
				end
				break
			elseif SurvivorCount <= 0 then -- DID HE KILL EVERYONE ?
				Module:Done('Killers')
				break
			end
			--
			Module.CurrentSession.TimePast += 1
			--
			RoundTimer:SetAttribute('TimeLeft', RoundTimer:GetAttribute('TimeLeft') - 1)
		end
	end)
end

function Module:LobbyTime()
	if IsStudio and not Config.Infos.RunInStudio then 
		RoundTimer.Value = 'In studio, not running..'
		RoundTimer:SetAttribute('TimeLeft', 999999)
		--
		return
	end
	--
	RoundTimer:SetAttribute('TimeLeft', LobbyTime)
	--
	spawn(function() -- Don't remove else it will yield and just break.
		if NoLoad then
			return
		end
		--
		while task.wait(1) do
			if #game.Players:GetPlayers() < 2 then 
				if not IsStudio then
					RoundTimer.Value = 'Not enough players to start...'
					continue
				end
			end
			if #game.Players:GetPlayers() == 2 then
				
			end
			RoundTimer.Value = Config.LobbyInfos.Text
			--
			if Module.IntermissionTimePast == 20 and workspace:GetAttribute('MapVotingEnabled') == true then
				MapVoting:Destroy()
				MapVoting:StartVote()
				--
				task.wait(1)
			end
			--
			if workspace:GetAttribute('NoTimer') == true then
				repeat task.wait(1)
					--
				until workspace:GetAttribute('NoTimer') == false
			end
			--
			if RoundTimer:GetAttribute('TimeLeft') == 0 or Module.IntermissionTimePast >= LobbyTime then
				Module:Done()
				break
			end
			--
			Module.IntermissionTimePast += 1
			RoundTimer:SetAttribute('TimeLeft', RoundTimer:GetAttribute('TimeLeft') - 1)
		end
	end)
end

function Module.Start()
	Module:LobbyTime()
end

-- <- Return -> --
return Module