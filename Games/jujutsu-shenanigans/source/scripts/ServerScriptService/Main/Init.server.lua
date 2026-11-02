workspace.Folder:Destroy()

--// Services \\--

local Players = game:GetService('Players')
local DataService = game:GetService('DataStoreService')
local RS = game:GetService('ReplicatedStorage')
local SvSt = game:GetService('ServerStorage')
local Http = game:GetService('HttpService')
local IS = game:GetService('InsertService')
local RNS = game:GetService('RunService')
local Debris = game:GetService('Debris')
local StarterPlayerService = game:GetService('StarterPlayer')
local TpS = game:GetService('TeleportService')
local MsgS = game:GetService('MessagingService')
local MarketplaceService = game:GetService('MarketplaceService')
local AvatarEdit = game:GetService('AvatarEditorService')



--// Assets \\--

local Assets = SvSt.Assets

local Animations = Assets.Animations


local EmotesFolder = RS.Assets.Emotes



--// Replicated Modules \\--

local RpModules = RS.Modules

local AnimationEvents = require(RpModules.AnimationEvents)



--// Server Modules \\--

local SvModules = SvSt.Modules

local AnimationService = require(SvModules.AnimationService)
local Knockback = require(SvModules.BodymoverService)
local iFramesService = require(SvModules.iFramesService)
local SpawnAnims = require(SvModules.SpawnAnims)
local PlayerClass = require(SvModules.PlayerClass)
local WeaponsHandler = require(SvModules.WeaponsHandler)



--// DataStores \\--

local DataStore = DataService:GetDataStore('DataStore')
local AdminCharBypasses = DataService:GetDataStore("BypassPlayers")
local AdminsDatabase = DataService:GetDataStore("Admins")

local MoneyDatastore = DataService:GetOrderedDataStore('Money')
local TotalKillsDatastore = DataService:GetOrderedDataStore('TotalKillsDatastore')
local MonthlyKillsDatastore = DataService:GetOrderedDataStore('MonthlyKillsDatastore')
local DonationsDatastore = DataService:GetOrderedDataStore('DonationsDatastore')
local TotalDonationsDatastore = DataService:GetOrderedDataStore('TotalDonationsDatastore')


local playerClasses = {}




--// Bindables \\--

local Bindables = SvSt.Bindables

local CosmeticsBindable = Bindables.Cosmetics



--// Remotes \\--

local Remotes = RS.Remotes


local ComunicatorComms = Remotes.Comunicator

local ComSet = ComunicatorComms.Set
local ComGet = ComunicatorComms.Get


local MovesetHandler = Remotes.MovesetHandler



--// Server Modules \\--

local SvModules = SvSt.Modules

local StunHandler = require(SvModules.StunHandler)
local MovesetHandlerModule = require(SvModules.MovesetHandler)
local RagdollHandler = require(SvModules.RagdollHandler)
local CollisionsModule = require(SvModules.CollisionsModule)



--// Variables \\--

local StarterPlayerFolder = script.StarterPlayer


local PS_OwnerId = game.PrivateServerOwnerId
local AnimationsTable = {}
local AccessoryCache = {}
local Kills = {}

for _, Animation in Assets.Animations:GetDescendants() do
	if Animation:IsA('Animation') then
		table.insert(AnimationsTable, Animation.AnimationId)
	end
end

local Movesets = {}
for _,v in SvSt.Movesets:GetChildren() do
	Movesets[v.Name] = {
		isAdmin = v:GetAttribute('Admin') == true,
		isEA = v:GetAttribute('Early_Access') == true,
		order = v:GetAttribute('Order') or 0,
		icon = v:GetAttribute('Icon') or 0,
		overpowered = v:GetAttribute('Overpowered') == true
	}
end

shared.Movesets = Movesets


local FirstOnLBValues = {}
local FirstOnLB = {}

task.spawn(function()
	pcall(function()
		local TotalK = TotalKillsDatastore:GetSortedAsync(false, 1):GetCurrentPage()[1]
		if TotalK then
			FirstOnLB['TotalKills'] = tonumber(TotalK.key)
			FirstOnLBValues['TotalKills'] = tonumber(TotalK.value)
		end
		local MonthK = MonthlyKillsDatastore:GetSortedAsync(false, 1):GetCurrentPage()[1]
		if MonthK then
			FirstOnLB['MonthlyKills'] = tonumber(MonthK.key)
			FirstOnLBValues['MonthlyKills'] = tonumber(MonthK.value)
		end

		local TotalD = TotalDonationsDatastore:GetSortedAsync(false, 1):GetCurrentPage()[1]
		if TotalD then
			FirstOnLB['TotalDonated'] = tonumber(TotalD.key)
			FirstOnLBValues['TotalDonated'] = tonumber(TotalD.value)
		end
		local MonthD = DonationsDatastore:GetSortedAsync(false, 1):GetCurrentPage()[1]
		if MonthD then
			FirstOnLB['MonthlyDonated'] = tonumber(MonthD.key)
			FirstOnLBValues['MonthlyDonated'] = tonumber(MonthD.value)
		end
	end)
end)


local Passes = {
	['More Emote Slots' ] = 13600173502;
	['Second Emote Page'] = 13600173502;
	[        'PS+'      ] = 13600173502;
	['Awakening Outfit' ] = 13600173502;
	[   'Early Access'  ] = 13600173502;
}
local Products = {
	[  'Random Emote'  ] = 13600173502;
	['Random Emote x5' ] = 13600173502;
	['Random Emote x10'] = 984791665;
}

local DonationsProducts = {
	Small   = 13600173502;
	Normal  = 13600173502;
	Big     = 13600173502;
	VeryBig = 13600173502;
	Huge    = 13600173502;
    Mega    = 13600173502;
}



--// Functions \\--

local function Comma(amount)
	while true do
		local k
		amount, k = string.gsub(amount, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k == 0) then
			break
		end
	end
	return amount
end

local updateFunctions = {
	TotalKills = function()
		local TotalKills = TotalKillsDatastore:GetSortedAsync(false, 10)
		local Page = TotalKills:GetCurrentPage()

		for Rank, Data in Page do
			if tonumber(Data.key) <= 0 or Data.value == 0 then continue end
			
			local Name = Players:GetNameFromUserIdAsync(tonumber(Data.key))
			local Player = Players:GetPlayerByUserId(Data.key)

			if Rank == 1 then
				if Player then
					ComSet:FireClient(Player, 'GiveAdminChar')
				end
				
				FirstOnLB['TotalKills'] = Data.key
				
				local Holder = workspace.Map.Map.Core.Leaderboard.SurfaceGui.Frame.Player
				Holder.PlayerName.Text = Name
				Holder.Kills.Text = Comma(Data.value) --..'KILLS'
				Holder.Icon.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
				
				--Holder.Parent.Visible = true
			else
				local Holder = workspace.Map.Map.Core.Leaderboard.SurfaceGui.Frame.Idk[tostring(Rank)]
				
				Holder.PlayerName.Text = Name
				Holder.Kills.Text = Comma(Data.value) --..'KILLS'
				Holder.Icon.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)

				--Holder.Parent.Visible = true
			end
		end
	end,
	
	MonthlyKills = function()
		local MonthlyKills = MonthlyKillsDatastore:GetSortedAsync(false, 10)
		local Page = MonthlyKills:GetCurrentPage()

		for Rank, Data in Page do
			if tonumber(Data.key) <= 0 or Data.value == 0 then continue end
			
			local Name = Players:GetNameFromUserIdAsync(tonumber(Data.key))

			if Rank == 1 then
				FirstOnLB['MonthlyKills'] = Data.key
				
				local Holder = workspace.Map.Map.Core.Leaderboard2.SurfaceGui.Frame.Player
				Holder.PlayerName.Text = Name
				Holder.Kills.Text = Comma(Data.value)
				Holder.Icon.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
			else
				local Holder = workspace.Map.Map.Core.Leaderboard2.SurfaceGui.Frame.Idk[tostring(Rank)]
				Holder.PlayerName.Text = Name
				Holder.Kills.Text = Comma(Data.value)
				Holder.Icon.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
			end
		end
	end,
	
	
	
	--[[TotalDonated = function()
		local TotalDonations = TotalDonationsDatastore:GetSortedAsync(false, 11)
		local Page = TotalDonations:GetCurrentPage()
		
		local Leaderboard = workspace.Miscellaneous.Donations
		
		for Rank, Data in Page do
			if tonumber(Data.key) <= 0 or Data.value == 0 then continue end
			
			local Name = Players:GetNameFromUserIdAsync(tonumber(Data.key))

			if Rank == 1 then
				FirstOnLB['TotalDonated'] = Data.key
				
				local Holder = Leaderboard.a.SurfaceGui.Holder.All.BigMain.KillFrame.TextLabel

				Holder.Text = '<font color="rgb(255, 219, 38)" size="30">#1</font> '..Name
				Holder.TextLabel.Text = '<font color="rgb(255, 219, 38)" size="50"> '..Comma(Data.value)..'</font>'

				Holder.ImageLabel.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
				Holder.ImageLabel.ImageLabel.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
				
				Holder.Parent.Visible = true
			else
				local Holder = Leaderboard.a.SurfaceGui.Holder.All.Main[tostring(Rank)].TextLabel

				Holder.Text = '<font color="rgb(255, 255, 255)" size="30">#'..Rank..'</font> '..Name
				Holder.TextLabel.Text = '<font color="rgb(255, 255, 255)" size="50"> '..Comma(Data.value)..'</font>'

				Holder.ImageLabel.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
				Holder.ImageLabel.ImageLabel.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
				
				Holder.Parent.Visible = true
			end
		end
	end,
	
	MonthlyDonated = function()
		local MonthlyDonated = DonationsDatastore:GetSortedAsync(false, 16)
		local Page = MonthlyDonated:GetCurrentPage()

		local Leaderboard = workspace.Miscellaneous.Donations

		for Rank, Data in Page do
			if tonumber(Data.key) <= 0 or Data.value == 0 then continue end
			
			local Name = Players:GetNameFromUserIdAsync(tonumber(Data.key))

			if Rank == 1 then
				FirstOnLB['MonthlyDonated'] = Data.key
				
				local Holder = Leaderboard.a.SurfaceGui.Holder.Monthly.BigMain.KillFrame.TextLabel

				Holder.Text = '<font color="rgb(255, 219, 38)" size="30">#1</font> '..Name
				Holder.TextLabel.Text = '<font color="rgb(255, 219, 38)" size="50"> '..Comma(Data.value)..'</font>'

				Holder.ImageLabel.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
				Holder.ImageLabel.ImageLabel.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
				
				Holder.Parent.Visible = true
			else
				local Holder = Leaderboard.a.SurfaceGui.Holder.Monthly.Main[tostring(Rank)].TextLabel

				Holder.Text = '<font color="rgb(255, 255, 255)" size="30">#'..Rank..'</font> '..Name
				Holder.TextLabel.Text = '<font color="rgb(255, 255, 255)" size="50"> '..Comma(Data.value)..'</font>'

				Holder.ImageLabel.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
				Holder.ImageLabel.ImageLabel.Image = Players:GetUserThumbnailAsync(tonumber(Data.key), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
				
				Holder.Parent.Visible = true
			end
		end
	end,]]
}

local function SpinEmoteFunc(Player: Player, Bulk: boolean?)
	local emotePool = {}
	for i,v in ipairs(EmotesFolder:GetChildren()) do
		emotePool[i] = v.Name
	end

	for _,v in playerClasses[Player.UserId].OwnedEmotes do
		for i,v2 in ipairs(EmotesFolder:GetChildren()) do
			if emotePool[i] == v then
				emotePool[i] = nil
				
				break
			end
		end
	end
	
	if emotePool == 0 then return end

	local tableSize = 1
	local possibleNumbers = {}
	for i,_ in emotePool do
		table.insert(possibleNumbers, i)
		tableSize += 1
	end
	
	
	local newEmote = emotePool[possibleNumbers[math.random(1, tableSize)]]
	
	table.insert(playerClasses[Player.UserId].OwnedEmotes, newEmote)


	if Bulk ~= true then
		Remotes.Emotes.Set:FireClient(Player, 'UpdateOwnedEmotes', { OwnedEmotes = playerClasses[Player.UserId].OwnedEmotes; })
	end
end

local function isAdmin(Player: Player)
	return Player.UserId == game.CreatorId or AdminsDatabase:GetAsync(Player.UserId) == true
end

local function hasAccessToAdminMovesets(Player: Player)
	local userId = Player.UserId
	
	return FirstOnLB.TotalDonated == userId or FirstOnLB.MonthlyDonated == userId or AdminCharBypasses:GetAsync(userId) == true
end

local function HumanoidDied(Player: Player)
	if not Player.Character then return end
	
	local Character = Player.Character
	local Humanoid: Humanoid = Character.Humanoid

	Player.Commands.InfiniteAwk.Value = false
	
	if not Character:HasTag('DontDoDieFunction') then
		if Humanoid.BreakJointsOnDeath then
			for _,Val: ObjectValue in Character.Motor6D:GetChildren() do
				local Part: BasePart = Val.Value.Part1

				Part.AssemblyLinearVelocity = Vector3.new(math.random(0, 360), math.random(0, 360), math.random(0, 360))
				Part.AssemblyAngularVelocity = Vector3.new(math.random(0, 360), math.random(0, 360), math.random(0, 360))

				Val.Value:Destroy()
			end

			Character.Motor6D:Destroy()

			StunHandler:Stun(Character, 5)
		else
			Character:AddTag('CantRagdollCancel')

			RagdollHandler.ragdoll(Humanoid, 5)
		end
	end


	if Character:HasTag('Awakened') then
		Player.AwakeningProgress.Value = 0
	end


	iFramesService:RemoveAlliFrames(Character)
	
	task.delay(Players.RespawnTime, function()
		Player:LoadCharacter()
	end)
end

local ComunicatorFunctions = {
	destroyAmbient = function(_, Params)
		local Container: Model = Params.Container
		local State: boolean = Params.State
		
		if not Container then return end
		
		if State == true then
			Container:AddTag('Destroyed')
			
			for _, Part: Part in Container:GetDescendants() do
				if Part:IsA('Part') or Part:IsA('MeshPart') then
					Part.Transparency = 1
					Part.CanCollide = false
					Part.CanQuery = false
				end
			end
			
		else
			Container:RemoveTag('Destroyed')
			
			for _, Part: Part in Container:GetDescendants() do
				if Part:IsA('Part') or Part:IsA('MeshPart') then
					Part.Transparency = 0
					Part.CanCollide = true
					Part.CanQuery = true
				end
			end
		end
	end,
	
	replicationLoaded = function(Player)
		Remotes.Replicate.Set:FireClient(Player, 'preloadanims', AnimationsTable)
	end,
	
	IsPSOwner = function(Player: Player)
		return (Player.UserId == game.PrivateServerOwnerId or RNS:IsStudio() or isAdmin(Player)) == true -- MarketplaceService:UserOwnsGamePassAsync(Player.UserId, Passes["PS+"]))
	end,
	
	ResetCharacter = function(Player: Player)
		if not Player.Character or not Player.Character.Parent then return end
		
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		
		local DamagedLog: ObjectValue = Character:FindFirstChild('DamagedLog')
		local DamagerLog: ObjectValue = Character:FindFirstChild('DamagerLog')
		
		if Character:HasTag('Stunned') then
			ComSet:FireClient(Player, 'SendNotification', { Title = 'NOTIFICATION'; Text = "YOU CAN'T RESET YOUR CHARACTER RIGHT NOW"; })
			
		elseif DamagedLog or DamagerLog then
			local TimeUntilReset = 0
			if DamagedLog then
				TimeUntilReset = DamagedLog.TimeRemaining.Value
			end

			if DamagerLog then
				if DamagerLog.TimeRemaining.Value > TimeUntilReset then
					TimeUntilReset = DamagerLog.TimeRemaining.Value
				end
			end

			ComSet:FireClient(Player, 'SendNotification', { Title = 'NOTIFICATION'; Text = 'WAIT '..tostring(math.round(TimeUntilReset))..' SECONDS BEFORE RESETTING'; })
			
		else
			Humanoid.Health = 0
		end
	end,
	
	GetCF = function(Player: Player, Params: { any })
		if Params.Obj then
			return Params.Obj.CFrame
		else
			return nil
		end
	end,
	
	SetAwkOutfit = function(Player: Player, Params: { any })
		if not MarketplaceService:UserOwnsGamePassAsync(Player.UserId, Passes["Awakening Outfit"]) then return end
		
		for _,v in Params.Movesets do
			playerClasses[Player.UserId].AwakeningOutfits[v] = Params.OutfitId
		end
	end,
	
	ApplyOutfit = function(Player: Player, Params: { any })
		Params.Hum:ApplyDescription(Players:GetHumanoidDescriptionFromOutfitId(Params.Id))
	end,
	
	SaveButtonsPos = function(Player: Player, Positions)
		playerClasses[Player.UserId].ButtonPositions = Positions
	end,
	
	GetButtonsPos = function(Player: Player)
		return playerClasses[Player.UserId].ButtonPositions
	end,
	
	Ban = function(Player: Player)
		Players:BanAsync({ UserIds = { Player.UserId }; ApplyToUniverse = true; Duration = -1; DisplayReason = 'You have been banned for using exploits.'; PrivateReason = 'Exploits'; ExcludeAltAccounts = false; })
	end,
	
	JoinDuels = function(Player: Player)
		TpS:Teleport(18877818488, Player)
	end,
	
	GetKillsForEmote = function(Player: Player)
		return playerClasses[Player.UserId].KillsForEmote
	end,
	
	CheckAdminChar = function(Player: Player)
		local userId = Player.UserId
		
		if isAdmin(Player) == true or hasAccessToAdminMovesets(Player) == true then
			return true
		else
			return false
		end
	end,
	
	GetCharServerCF = function(Player: Player, OtherCharName: Model)
		local OtherChar = workspace.Live:FindFirstChild(OtherCharName)
		if OtherChar then
			return OtherChar.HumanoidRootPart.CFrame
		end
	end,
	
	Kick = function(Player: Player, Params: { any })
		Player:Kick(Params.Msg)
	end,
	
	SetConfig = function(Player: Player, Params)
		Player.Configuration[Params.CN].Value = Params.V
	end,
	
	SetMoveset = function(Player: Player, MovesetName)
		local MovesetFolder = SvSt.Movesets:FindFirstChild(MovesetName)
		if not MovesetFolder then return end
		
		if Player:HasTag('MovesetCD') then return end
		Player:AddTag('MovesetCD')
		task.delay(2, function()
			Player:RemoveTag('MovesetCD')
		end)
		
		local userId = Player.UserId
		
		if -- Checks if the moveset selected is admins only
			Movesets[MovesetName].isAdmin == true and
			not isAdmin(Player) and
			not hasAccessToAdminMovesets(Player)
		then
			return
		end
		
		if
			Movesets[MovesetName].isEA == true and 
			not MarketplaceService:UserOwnsGamePassAsync(userId, Passes["Early Access"]) 
		then
			MarketplaceService:PromptGamePassPurchase(Player, Passes["Early Access"]) 
			
			return
		end
		
		
		local DamagerLog = Player.Character:FindFirstChild('DamagerLog')
		local DamagedLog = Player.Character:FindFirstChild('DamagedLog')
		
		if MovesetName ~= Player.Configuration.Moveset.Value and ((not DamagerLog or (DamagerLog and DamagerLog.Value:FindFirstChild('Dummy'))) and not DamagedLog or (DamagedLog and DamagedLog.Value:FindFirstChild('Dummy'))) then
			if MovesetName == 'KJ' then
				ComSet:FireClient(Player, 'SendNotification', { Title = 'NOTIFICATION'; Text = 'Character based on KJ\'s Final Ride & KJ Kills Day \n Credits to Kilojoule & Stealth'; })
			end
			
			Player.AwakeningProgress.Value = 0
			Player.Configuration.Moveset.Value = MovesetName
			Player:LoadCharacter()
		end
	end,
	
	SpinEmote = function(Player: Player, Bulk: boolean)
		local money = Player:WaitForChild("leaderstats").Hidden.Money
		
		money.Value = money.Value - 250
		
		SpinEmoteFunc(Player, Bulk)
	end,
	
	GetOwnedEmotes = function(Player: Player)
		if not playerClasses[Player.UserId] then
			repeat 
				task.wait()
			until playerClasses[Player.UserId] ~= nil
		end
		
		return playerClasses[Player.UserId].OwnedEmotes
	end,
	
	SetEmote = function(Player: Player, Params)
		if not table.find(playerClasses[Player.UserId].OwnedEmotes, Params.EmoteName) then return false end
		
		if Params.Page == 'Emotes' then
			Player.Emotes[Params.Slot].Value = Params.EmoteName
		else
			Player.Emotes2[Params.Slot].Value = Params.EmoteName
		end
		
		return true
	end,
	
	PlayEmote = function(Player: Player, AnimationName)
		local Character = Player.Character
		
		if Character:HasTag("Stunned") or not Character:FindFirstChild("HumanoidRootPart") or not table.find(playerClasses[Player.UserId].OwnedEmotes, AnimationName) then return false end
		
		local Humanoid: Humanoid = Character.Humanoid
		local Anim: Animation = EmotesFolder[AnimationName]
		
		AnimationService:stopAnimation(Character, Anim)
		
		if require(SvModules.Emotes)[AnimationName] ~= nil then
			require(SvModules.Emotes)[AnimationName](Player, Anim)
		else
			local Track: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)

			AnimationService:playAnimation(Character, Anim)
			Character:SetAttribute('DefaultRunSpeed', Anim:GetAttribute('WalkSpeed'))
			Character:SetAttribute('DefaultWalkSpeed', Anim:GetAttribute('WalkSpeed'))
			Character:SetAttribute('DefaultJumpPower', Anim:GetAttribute('JumpPower'))

			Humanoid.WalkSpeed = Anim:GetAttribute('WalkSpeed')
			Humanoid.JumpPower = Anim:GetAttribute('JumpPower')
			if Anim:HasTag('NAR') then
				Humanoid.AutoRotate = false
			end


			local c
			c = Track.Stopped:Connect(function()
				c:Disconnect()

				Character:SetAttribute('DefaultRunSpeed', 25)
				Character:SetAttribute('DefaultWalkSpeed', 16)
				Character:SetAttribute('DefaultJumpPower', 50)
				Humanoid.AutoRotate = true
			end)
		end
	end,
	
	TriggerSeath = function(Player: Player)
		local Character = Player.Character
		
		if Character:HasTag('Stunned') then return end
		
		local Sword: Model = Character.Sword
		
		WeaponsHandler:TriggerSeath(Character)
	end,
	
	IsOwner = function(Player: Player, IsOwner: boolean)
		Player:SetAttribute('IsOwner', IsOwner)
	end,
}



local function AddStarterPlayer(Player: Player)
	if not Player then return end
	
	local userId = Player.UserId
	local playerClass = playerClasses[userId]

	for _, Object in StarterPlayerFolder:GetChildren() do
		Object:Clone().Parent = Player
	end
	
	Player:SetAttribute('Characters', Http:JSONEncode(Movesets))
	
	Player.Chatted:Connect(function(msg)
		local CommandSplit = msg:split('/')
		local isCommand = CommandSplit[1] == '' and CommandSplit[2] ~= ''
		
		if isCommand == true then
			if isAdmin(Player) ~= true then return end
			
			local SplittedMsg = msg:split(' ')
			
			if SplittedMsg[1] == '/kick' then
				local EnemyPlayer = Players:FindFirstChild(msg:gsub('/kick ', ''))
				if EnemyPlayer then
					if EnemyPlayer == Player then return end

					EnemyPlayer:Kick('You were kicked from the experience.')
				end

			elseif SplittedMsg[1] == '/ban' then
				local EnemyUserId = SplittedMsg[2]
				local BanTime = SplittedMsg[3]
				local CanBan = pcall(function()
					BanTime = tonumber(SplittedMsg[3])
					EnemyUserId = tonumber(EnemyUserId)
					Players:GetNameFromUserIdAsync(tonumber(EnemyUserId))
				end)

				if CanBan == true and (BanTime == -1 or BanTime > 0) and EnemyUserId ~= userId then
					Players:BanAsync({ UserIds = { EnemyUserId }; ApplyToUniverse = true; Duration = BanTime; DisplayReason = 'You have been banned for using exploits.'; PrivateReason = 'Exploits'; ExcludeAltAccounts = false; })
				end
			elseif SplittedMsg[1] == '/freeze' then
				local EnemyPlayer: Player? = Players:FindFirstChild(msg:gsub('/freeze ', ''))
				if EnemyPlayer then
					if EnemyPlayer == Player then return end

					local EnemyCharacter = EnemyPlayer.Character
					if EnemyCharacter then
						local EnemyHumRP: BasePart = EnemyCharacter:FindFirstChild('HumanoidRootPart')
						if EnemyHumRP then
							if EnemyCharacter:HasTag('Freezed') then
								EnemyCharacter:RemoveTag('Freezed')

								EnemyHumRP.Anchored = false
							else
								local FreezeConnection: RBXScriptConnection

								EnemyCharacter:AddTag('Freezed')
								EnemyHumRP.Anchored = true
								FreezeConnection = EnemyHumRP:GetPropertyChangedSignal('Anchored'):Connect(function()
									if EnemyCharacter:HasTag('Freezed') then
										EnemyHumRP.Anchored = true
									else
										FreezeConnection:Disconnect()
									end
								end)
							end
						end
					end
				end

			elseif SplittedMsg[1] == '/globalmute' then
				local EnemyPlayer: Player? = Players:FindFirstChild(msg:gsub('/globalmute ', ''))
				if EnemyPlayer then
					if EnemyPlayer == Player then return end

					if EnemyPlayer:HasTag('Muted') then
						EnemyPlayer:RemoveTag('Muted')
						ComSet:FireClient(EnemyPlayer, 'Unmute')
					else
						EnemyPlayer:AddTag('Muted')
						ComSet:FireClient(EnemyPlayer, 'Mute')
					end
				end

			elseif SplittedMsg[1] == '/announcement' then
				local Msg = msg:gsub('/announcement ', '')

				MsgS:PublishAsync('GlobalAnnouncement', Msg)

			elseif SplittedMsg[1] == '/addmove' then
				if not SplittedMsg[2] or not SplittedMsg[3] then return end

				local Move
				for _, Tool: Tool in SvSt.Movesets:GetDescendants() do
					if Tool:IsA('Tool') then
						if Tool.Name:lower() == msg:gsub(SplittedMsg[1]..' '..SplittedMsg[2]..' ', ''):lower() then
							Move = Tool

							break
						end
					end
				end

				if Move then
					local InputPlayer = Players:FindFirstChild(SplittedMsg[2])
					if InputPlayer then
						local MoveTool = Move:Clone()
						MoveTool.Parent = InputPlayer.Moveset
						MoveTool:SetAttribute('Index', #InputPlayer.Moveset:GetChildren())

						MovesetHandler:FireClient(InputPlayer)
						
					elseif SplittedMsg[2]:lower() == 'me' then
						local MoveTool = Move:Clone()
						MoveTool.Parent = Player.Moveset
						MoveTool:SetAttribute('Index', #Player.Moveset:GetChildren())

						MovesetHandler:FireClient(Player)
						
					elseif SplittedMsg[2]:lower() == 'all' then
						for _, Player2 in Players:GetPlayers() do
							local MoveTool = Move:Clone()
							MoveTool.Parent = Player2.Moveset
							MoveTool:SetAttribute('Index', #Player2.Moveset:GetChildren())

							MovesetHandler:FireClient(Player2)
						end
					end
				end

			elseif SplittedMsg[1] == '/delmove' then
				if not SplittedMsg[2] or not SplittedMsg[3] then return end



				local InputPlayer = Players:FindFirstChild(SplittedMsg[2])
				local Table
				if InputPlayer then
					Table = { InputPlayer }

				elseif SplittedMsg[2]:lower() == 'all' then
					Table = Players:GetPlayers()

				end

				for _, Player2 in Table do
					local Move
					for _, Tool: Tool in SvSt.Movesets:GetDescendants() do
						if Tool:IsA('Tool') then
							if Tool.Name:lower() == msg:gsub(SplittedMsg[1]..' '..SplittedMsg[2]..' ', ''):lower() then
								Move = Tool

								break
							end
						end
					end

					if Move then
						local LastIndex = Move:GetAttribute('Index')
						Move:Destroy()

						for _,v in Player2.Moveset:GetChildren() do
							if v:GetAttribute('Index') > LastIndex then
								v:SetAttribute('Index', v:GetAttribute('Index') - 1)
							end
						end

						MovesetHandler:FireClient(Player2)
					end

				end
				
			elseif SplittedMsg[1] == '/giveadmin' or SplittedMsg[1] == '/removeadmin' then
				if Player.UserId ~= game.CreatorId then return end
				
				local goalUserId = SplittedMsg[2]
				local canProceed = pcall(function()
					goalUserId = tonumber(goalUserId)
					Players:GetNameFromUserIdAsync(goalUserId)
				end)

				if canProceed == true and goalUserId ~= game.CreatorId then
					local goalState = false
					if SplittedMsg[1] == '/giveadmin' then
						goalState = true
					end
					
					AdminsDatabase:SetAsync(goalUserId, goalState)
				end
				
			elseif SplittedMsg[1] == '/giveEAchar' or SplittedMsg[1] == '/removegiveEAchar' then
				local goalUserId = SplittedMsg[2]
				local canProceed = pcall(function()
					goalUserId = tonumber(goalUserId)
					Players:GetNameFromUserIdAsync(goalUserId)
				end)

				if canProceed == true and goalUserId ~= game.CreatorId and goalUserId ~= Player.UserId then
					local goalState = false
					if SplittedMsg[1] == '/giveEAchar' then
						goalState = true
					end

					AdminCharBypasses:SetAsync(goalUserId, goalState)

					local goalPlayer = Players:GetPlayerByUserId(goalUserId)
					if goalPlayer then
						if goalState == true then
							ComSet:FireClient(goalPlayer, 'GiveEarlyAccessChar')
						else
							ComSet:FireClient(goalPlayer, 'RemoveEarlyAccessChar')
						end
					end
				end
			elseif SplittedMsg[1] == '/giveadminchar' or SplittedMsg[1] == '/removeadminchar' then
				local goalUserId = SplittedMsg[2]
				local canProceed = pcall(function()
					goalUserId = tonumber(goalUserId)
					Players:GetNameFromUserIdAsync(goalUserId)
				end)

				if canProceed == true and goalUserId ~= game.CreatorId and goalUserId ~= Player.UserId then
					local goalState = false
					if SplittedMsg[1] == '/giveadminchar' then
						goalState = true
					end
					
					AdminCharBypasses:SetAsync(goalUserId, goalState)
					
					local goalPlayer = Players:GetPlayerByUserId(goalUserId)
					if goalPlayer then
						if goalState == true then
							ComSet:FireClient(goalPlayer, 'GiveAdminChar')
						else
							ComSet:FireClient(goalPlayer, 'RemoveAdminChar')
						end
					end
				end
				
			end
		end
	end)
	
	
	
	task.spawn(function()
		Kills[userId] = {
			Total = TotalKillsDatastore:GetAsync(userId),
			Money = MoneyDatastore:GetAsync(userId),
			Monthly = MonthlyKillsDatastore:GetAsync(userId)
		}
		
		
		
		Player.leaderstats.Hidden['Total Kills'].Value = Kills[userId].Total
		Player.leaderstats.Kills.Value = Kills[userId].Monthly
		Player.leaderstats.Hidden.Money.Value = Kills[userId].Money
		
		Player.leaderstats.Hidden.Money:GetPropertyChangedSignal('Value'):Connect(function()
			Kills[userId].Money = Player.leaderstats.Hidden.Money.Value
		end)
		
		Player.leaderstats.Hidden['Total Kills']:GetPropertyChangedSignal('Value'):Connect(function()
			Kills[userId].Total = Player.leaderstats.Hidden['Total Kills'].Value
			Kills[userId].Monthly = Player.leaderstats.Hidden['Total Kills'].Value
		end)
	end)
	
	
	for _, Config in Player.Configuration:GetChildren() do
		Config.Value = playerClass[Config.Name]
		Config:GetPropertyChangedSignal('Value'):Connect(function()
			playerClass[Config.Name] = Config.Value
		end)
	end
	
	local MovesetValue: StringValue = Player.Configuration.Moveset
	if not Movesets[MovesetValue.Value] then
		MovesetValue.Value = 'Honored One'
	end
	
	for _, Emote in Player.Emotes:GetChildren() do
		Emote.Value = playerClass.Emotes[Emote.Name]
		Emote:GetPropertyChangedSignal('Value'):Connect(function()
			playerClass.Emotes[Emote.Name] = Emote.Value
		end)
	end
	
	for _, Emote in Player.Emotes2:GetChildren() do
		Emote.Value = playerClass.Emotes2[Emote.Name]
		Emote:GetPropertyChangedSignal('Value'):Connect(function()
			playerClass.Emotes2[Emote.Name] = Emote.Value
		end)
	end
	
	
	local loadedData = Instance.new('BoolValue')
	loadedData.Name = 'LoadedData'
	loadedData.Value = true
	loadedData.Parent = Player
end

local function PlayerAdded(Player: Player)
	if Player:GetAttribute('Added') == true then return end
	Player:SetAttribute('Added', true)
	
	local userId = Player.UserId

	Player:SetAttribute('Streak', 0)
	
	
	local data
	local success, emsg = pcall(function()
		data = DataStore:GetAsync(userId)
	end)
	
	if not success then
		warn(Player.Name .. '\'s data was not loaded: ' .. emsg)
	end
	
	
	local playerClass = nil
	if data == nil then
		playerClass = PlayerClass.new(Player)
	else
		playerClass = PlayerClass.new(Player, Http:JSONDecode(data))
	end

	if playerClass == nil then
		Player:Kick("Your data could not be loaded, please rejoin. \n If this keeps happening, please, contact a staff member.")
		
		return	
	end
	
	playerClasses[userId] = playerClass
	
	AddStarterPlayer(Player)
	
	Player:SetAttribute('Loaded', true)
	
	local Character = Player.Character
	if Character then
		CharacterAdded(Character)
	end
	
	Player.CharacterAdded:Connect(CharacterAdded)
	
	
	if Player.UserId == game.PrivateServerOwnerId or RNS:IsStudio() or isAdmin(Player) == true then
		shared.giveCommands(Player)
	    end

if(isAdmin(Player)) then
	for _,v in EmotesFolder:GetChildren() do
		if not table.find(playerClass.OwnedEmotes, v.Name) then
			table.insert(playerClass.OwnedEmotes, v.Name)
			end
		end
	end
end

function CharacterAdded(Character: Model)
	repeat task.wait() until Character:IsDescendantOf(workspace)

	Character.Parent = workspace.Live
	
	
	local Player = Players:GetPlayerFromCharacter(Character)
	if not Player then 
		if Character then
			Character:Destroy()
		end
		
		return
	end
	
	
	local userId = Player.UserId
	
	local Humanoid: Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
	local Animator: Animator = Humanoid:FindFirstChild('Animator') or Humanoid:WaitForChild('Animator', 10)
	local Head: BasePart     = Character:FindFirstChild('Head') or Character:WaitForChild('Head', 10)
	local HumRP: BasePart    = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)
	
	local Died = false
	
	
	
	-- Spawn Handler
	
	iFramesService:AddAlliFrames(Character)
	AnimationService:loadAnimations(Character)

	if Humanoid.MoveDirection.Magnitude == 0 and SpawnAnims[Player.Configuration.Moveset.Value] ~= nil then
		SpawnAnims[Player.Configuration.Moveset.Value](Player)

		Humanoid:GetPropertyChangedSignal('MoveDirection'):Once(function()
			if Humanoid.MoveDirection.Magnitude ~= 0 then
				AnimationService:stopAll(Character)
			end
		end)
	end
	
	
	
	-- Appareance Handler

	if userId > 0 then
		local HumanoidDescription = Players:GetHumanoidDescriptionFromUserId(Player.UserId)
		if HumanoidDescription then
			Humanoid:ApplyDescription(HumanoidDescription)
		end
		
		local PlayersModel = game.Players:GetCharacterAppearanceAsync(userId)
		if PlayersModel then
			local Face = PlayersModel:FindFirstChild('face')
			if Face then
				Face.Parent = Character.Head
			end
		end
	end
	
	Remotes.Replicate.Set:FireAllClients('WhiteAura', { Time = 5; Plr = Player; Light = false; })
	task.delay(3, function()
		iFramesService:RemoveAlliFrames(Character)
	end)
	
	
	
	--[[if #playerClasses[userId].OwnedEmotes < #EmotesFolder:GetChildren() then
		if playerClasses[userId].KillsForEmote == 0 then
			--ComSet:FireClient(Player, 'CanSpinEmote')
		else
			--ComSet:FireClient(Player, 'ChangeKillForEmote', playerClasses[userId].KillsForEmote)
		end
	end]]
	
	
	
	-- Check Admin Moveset
	
	if Player:GetAttribute('CheckedAdmin') ~= true then
		Player:SetAttribute('CheckedAdmin', true)
		
		task.spawn(function()
			local MostTotalDonated = TotalDonationsDatastore:GetSortedAsync(false, 1):GetCurrentPage()[1]
			local MostMonthlyDonated = DonationsDatastore:GetSortedAsync(false, 1):GetCurrentPage()[1]
			
			if MostTotalDonated and MostMonthlyDonated then
				MostTotalDonated = MostTotalDonated.key
				MostMonthlyDonated = MostMonthlyDonated.key
				
				if userId == tonumber(MostTotalDonated) or userId == tonumber(MostMonthlyDonated) then
					ComSet:FireClient(Player, 'GiveAdminChar')
				end
			end

		end)
	end
	
	
	
	-- Humanoid 
	
	Humanoid.Died:Once(function()
		if Died == false then
			Died = true

			HumanoidDied(Player)
		end
	end)
	
	Humanoid:GetPropertyChangedSignal('Health'):Connect(function()
		if Humanoid.Health <= 0 then
			if Died == false then
				Died = true

				HumanoidDied(Player)
			end
		end
	end)
	
	HumRP:GetPropertyChangedSignal('Parent'):Connect(function()
		if Died == false and HumRP.Position.Y <= workspace.FallenPartsDestroyHeight then
			Died = true
			
			HumanoidDied(Player)
		end
	end)
	
	Humanoid.DisplayName = Player.DisplayName
	
	
	
	-- Moveset
	
	MovesetHandlerModule:AddBaseMoveset(Player, Player.Configuration.Moveset.Value)
	
	
	
	-- Anim Loader

	AnimationService:loadAnimations(Character)


	
	-- Collisions Handler --
	
	CollisionsModule:SetCollisionGroup(Character, 'Players')
	
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	
	
	
	-- Console Things --
	
	local isOnConsole = ComGet:InvokeClient(Player, { Func = 'IsOnConsole'; })
	if isOnConsole == true then
		local LockOnScript = script.ConsoleOnly.LockOn:Clone()
		LockOnScript.Parent = Character
		LockOnScript.Enabled = true
	end
	
	
	
	-- HumRP Handler --
	
	HumRP:GetPropertyChangedSignal('Anchored'):Connect(function()
		HumRP.RootJoint.C0 = StarterPlayerService.StarterCharacter.HumanoidRootPart.RootJoint.C0
		HumRP.RootJoint.C1 = StarterPlayerService.StarterCharacter.HumanoidRootPart.RootJoint.C1
	end)
	
	
	-- Cosmetics --
	
	for Type, Table: { string } in playerClasses[userId].Cosmetics do
		for _, Name in Table do
			CosmeticsBindable:Fire(Player, { Type = Type; State = true; Name = Name; })
		end
	end
end

local function SaveData(userId, playerClass)
	DataStore:UpdateAsync(userId, function()
		return Http:JSONEncode(playerClass or playerClasses[userId])
	end)
	
	if Kills[userId] ~= nil then
		local totalKills =  Kills[userId].Total
		local monthlyKills = Kills[userId].Monthly
		local Money = Kills[userId].Money
		
		
		if totalKills ~= nil then
			TotalKillsDatastore:SetAsync(userId, totalKills)
		end
		
		if monthlyKills ~= nil then
			MonthlyKillsDatastore:SetAsync(userId, monthlyKills)
		end
		
		if Money ~= nil then
			MoneyDatastore:SetAsync(userId, Money)
		end
	end

	
	Kills[userId] = nil
	playerClasses[userId] = nil
end

function PlayerRemoving(Player: Player)
	local userId = Player.UserId

	playerClasses[userId].Emotes = { ['1'] = Player.Emotes['1'].Value; ['2'] = Player.Emotes['2'].Value; ['3'] = Player.Emotes['3'].Value; ['4'] = Player.Emotes['4'].Value; ['5'] = Player.Emotes['5'].Value; ['6'] = Player.Emotes['6'].Value; ['7'] = Player.Emotes['7'].Value; ['8'] = Player.Emotes['8'].Value; }
	
	SaveData(userId)
end





--// Main \\--

for _,v in Players:GetPlayers() do
	if not v:GetAttribute('Added') then
		task.spawn(function()
			PlayerAdded(v)
		end)
	end
end


Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)
game:BindToClose(function()
	for userId, playerClass in playerClasses do
		task.spawn(SaveData, userId, playerClass)
	end
end)


Remotes.Emotes.Get.OnServerInvoke = function(plr)
	return playerClasses[plr.UserId].Emotes, playerClasses[plr.UserId].Emotes2
end

MsgS:SubscribeAsync('GlobalAnnouncement', function(Params)
	ComSet:FireAllClients('Announcement', { Msg = Params.Data; })
end)

MsgS:SubscribeAsync('resetPlayers', function()
	for _, plr in Players:GetPlayers() do
		task.spawn(function()
			repeat task.wait() until plr:GetAttribute('Loaded') == true or plr.Parent == nil
			
			if plr.Parent ~= nil then
				plr.leaderstats.Kills.Value = 0
			end
		end)
	end
end)

local updateStartTime = time()
RNS.Heartbeat:Connect(function()
	if time() - updateStartTime > 300 then
		updateStartTime = time()
		
		for _,v in updateFunctions do
			task.spawn(v)
		end
	end
end)
for _,v in updateFunctions do
	task.spawn(v)
end


if not DataStore:GetAsync('LastMonthReset') then
	DataStore:SetAsync('LastMonthReset', os.time())
else
	if os.time() - DataStore:GetAsync('LastMonthReset') >= 604900 then
		DataStore:SetAsync('LastMonthReset', os.time())
		
		task.spawn(function()
			local Kills = MonthlyKillsDatastore:GetSortedAsync(false, 100)

			repeat
				for _,data in Kills:GetCurrentPage() do
					MonthlyKillsDatastore:SetAsync(data.key, 0)
				end

				if Kills.IsFinished == false then
					Kills:AdvanceToNextPageAsync()
				end
			until Kills.IsFinished == true
		end)
		
		task.spawn(function()
			local Donations = DonationsDatastore:GetSortedAsync(false, 100)

			repeat
				for _,data in Donations:GetCurrentPage() do
					DonationsDatastore:SetAsync(data.key, 0)
				end

				if Donations.IsFinished == false then
					Donations:AdvanceToNextPageAsync()
				end
			until Donations.IsFinished == true
		end)
		
		MsgS:PublishAsync('resetPlayers')
		
		for _, plr in Players:GetPlayers() do
			task.spawn(function()
				repeat task.wait() until plr:GetAttribute('Loaded') == true or plr.Parent == nil

				if plr.Parent ~= nil then
					plr.leaderstats.Kills.Value = 0
				end
			end)
		end
	end
end

MarketplaceService.PromptProductPurchaseFinished:Connect(function(userId, productId, isPurchased)
	if isPurchased == true then
		local Player = Players:GetPlayerByUserId(userId)
		if not Player then return end
		
		for passName: string, passId: number in Products do
			if passId == productId then
				if passName == 'Random Emote' or passName == 'Random Emote x5' or passName == 'Random Emote x10' then
					if passName == 'Random Emote' then
						SpinEmoteFunc(Player)
					elseif passName == 'Random Emote x5' then
						for i = 1, 5 do
							SpinEmoteFunc(Player, true)
						end
					elseif passName == 'Random Emote x10' then
						for i = 1, 10 do
							SpinEmoteFunc(Player, true)
						end
					end
					
					Remotes.Emotes.Set:FireClient(Player, 'UpdateOwnedEmotes', { OwnedEmotes = playerClasses[Player.UserId].OwnedEmotes; })
				end
				
				return
			end
		end
	end
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(Player, passId, isPurchased)
	if isPurchased == true then
		if passId == Passes["More Emote Slots"] then
			ComSet:FireClient(Player, 'AddEmoteSlots')
		elseif passId == Passes['Second Emote Page'] then
			ComSet:FireClient(Player, 'AddSecondPage')
		elseif passId == Passes['PS+'] then
			ComSet:FireClient(Player, 'PS+')
		elseif passId == Passes["Early Access"] then
			
		end
	end
end)

ComGet.OnServerInvoke = function(Player, Function, Params)
	return ComunicatorFunctions[Function](Player, Params)
end

ComSet.OnServerEvent:Connect(function(Player, _Function, Params)
	ComunicatorFunctions[_Function](Player, Params)
end)


MarketplaceService.ProcessReceipt = function(receiptInfo)
	if receiptInfo.PlaceIdWherePurchased ~= game.PlaceId then return end
	
	local Player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	local ProductId = receiptInfo.ProductId
	local isDono = false
	for _,v in DonationsProducts do
		if v == ProductId then
			isDono = true
			
			break
		end
	end
	

	if isDono == true then
		local TotalDonated = TotalDonationsDatastore:GetAsync(tostring(receiptInfo.PlayerId))
		local MonthlyDonated = DonationsDatastore:GetAsync(tostring(receiptInfo.PlayerId))
		
		if TotalDonated then
			TotalDonated = TotalDonated.value
		else
			TotalDonated = 0
		end
		
		if MonthlyDonated then
			MonthlyDonated = MonthlyDonated.value
		else
			MonthlyDonated = 0
		end

		TotalDonationsDatastore:SetAsync(tostring(receiptInfo.PlayerId), TotalDonated + receiptInfo.CurrencySpent)
		DonationsDatastore:SetAsync(tostring(receiptInfo.PlayerId), MonthlyDonated + receiptInfo.CurrencySpent)

		if Player then
			if FirstOnLBValues.TotalDonated and FirstOnLBValues.MonthlyDonated then
				if TotalDonated >= FirstOnLBValues.TotalDonated or MonthlyDonated >= FirstOnLBValues.MonthlyDonated then
					ComSet:FireClient(Player, 'GiveAdminChar')
				end
			else
				ComSet:FireClient(Player, 'GiveAdminChar')
			end
		end
	else
		if not Player then return end
		
		for passName: string, passId: number in Products do
			if passId == ProductId then
				if passName == 'Random Emote' or passName == 'Random Emote x5' or passName == 'Random Emote x10' then
					if passName == 'Random Emote' then
						SpinEmoteFunc(Player)
					elseif passName == 'Random Emote x5' then
						for i = 1, 5 do
							SpinEmoteFunc(Player, true)
						end
					elseif passName == 'Random Emote x10' then
						for i = 1, 10 do
							SpinEmoteFunc(Player, true)
						end
					end

					Remotes.Emotes.Set:FireClient(Player, 'UpdateOwnedEmotes', { OwnedEmotes = playerClasses[Player.UserId].OwnedEmotes; })
				end

				return
			end
		end
	end
end