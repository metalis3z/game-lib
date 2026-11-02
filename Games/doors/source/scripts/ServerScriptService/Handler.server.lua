-- Created and Fixed by BUILDG Studios

local ServerStorage = game:GetService("ServerStorage")

local workspace = workspace

repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EntityInfoEvents = ReplicatedStorage:WaitForChild("EntityInfo")
local BrickEvents = ReplicatedStorage:WaitForChild("Bricks")
local RagdollBuilder = require(ReplicatedStorage.buildRagdoll)
local GameData = ReplicatedStorage:WaitForChild("GameData")
local GameStats = ReplicatedStorage:WaitForChild("GameStats")
local TeleportService = game:GetService("TeleportService")

local DataStoreService = game:GetService("DataStoreService")

--// GAME VARIABLES
local TotalGameStat
local PreRun = true
local aguyloaded = false
local GameStartedAlready = false

-----------------------------------------------------
-- EntityInfo Events
-----------------------------------------------------
local play = false

local EntityInfoEventsTable = {
	
	PreRunShop = function(Player, p1)
		if p1 and Player then
			
			local OverPrice = 0
			
			repeat wait(0.5) until game.Workspace.Game.GameData.GameStart.Value == true
			
			for v17, v18 in pairs(p1) do
				if v18 ~= nil then
					local itms = require(game.ReplicatedStorage.Items)
					local req = require(game.ServerScriptService.Game.Directory.ItemsAttributes)
					
					if req[v18] then
						local Item = game.ServerStorage[v18]:Clone()
						Item.Parent = Player.Backpack
						print(itms[v18])
						OverPrice = OverPrice + tostring(itms[v18].Cost)
						
						if Player.PlayerStats.Knobs then
							Player.PlayerStats.Knobs.Value = (Player.PlayerStats.Knobs.Value - OverPrice)
						end
					end
				end
			end
			
		end
	end,
	
	AwardAchieve = function(Player, p1, code)
		print("Functioofoaofawfkl")
		local function Function()
			local ach = p1
			local p1_player = Player

			if game.Players[p1_player].InGameStats.Achievements:FindFirstChild(ach) then
				local achive = game.Players[p1_player].InGameStats.Achievements:FindFirstChild(ach)
				local req = require(game.ReplicatedStorage.Achievements)[ach]

				if achive.Value == false then
					achive.Value = true
					if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
						game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
						game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
					end
				end

			end
		end

		local CorrectCode = game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")

		if not code or not CorrectCode then
			return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "AntiVirus")
		end

		if CorrectCode == code or code == "ServerTypeInput" then
			Function()
		else
			game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Code is incorrent", "Error")
		end
	end,
	
	Screech = function(Player, NoDamage)
		if Player then
			if NoDamage == true then

			elseif NoDamage == false then

				if Player.Character then
					if Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("HumanoidRootPart") then
						Player.Character.Humanoid:TakeDamage(50)
					end
				end
			end
		end
	end,

	Test_PlzJumpscareMe = function(Player, Entity)
		if Player then
			EntityInfoEvents.Jumpscare:FireClient(Player, Entity)
		end
	end,
	
	Footstep = function(Player, p1)
		if Player then
			print(p1.Volume)
			print("Side print")
		end
	end,
	
	PL = function(Player, p1)
		if p1 == game.ServerScriptService.Handler:GetAttribute("Number1")..game.ServerScriptService.Handler:GetAttribute("Number2")..game.ServerScriptService.Handler:GetAttribute("Number3")..game.ServerScriptService.Handler:GetAttribute("Number4")..game.ServerScriptService.Handler:GetAttribute("Number5") then
			local pad = game.Workspace:FindFirstChild("Padlock", true)
			
			if not pad then
				return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Padlock is not exist", "Error")
			end
			
			pad.Padlocked.Value = false
			
			for i, v in pairs(pad.AnimationController:GetPlayingAnimationTracks()) do
				v:Stop(0)
			end
			
			local animlaod = pad.AnimationController:LoadAnimation(pad.Animations["open"])
			animlaod.Priority = Enum.AnimationPriority.Action4
			wait()
			animlaod:Play()
		
			task.delay(1.3, function()
				local hint = workspace:FindFirstChild("PickupItem", true)

				if hint:GetAttribute("LibraryHintPaper") then
					hint:Destroy()
				end
				
				script:SetAttribute("LibraryEscape", true)
				pad:Destroy()

				for i, v in pairs(game.Players:GetPlayers()) do
					v.PlayerGui.PermUI.Hints.Visible = false
					if v then
						if v.Backpack:FindFirstChild("HintPaper") then
							v.Backpack:FindFirstChild("HintPaper"):Destroy()
						end

						if v.Character:FindFirstChild("HintPaper") then
							v.Character:FindFirstChild("HintPaper"):Destroy()
						end
					end
				end
			end)
		else
			game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Wrong key broo", "Print")
		end
	end,
	
	A90 = function(Player, p1)
		if p1 == true then
			Player.Character.Humanoid:TakeDamage(90)
		else
			
		end
	end,
	
	PlayAgain = function(Player, p1, p2)
		if Player then
			Player:SetAttribute("Ready", true)
			if play == false then
				play = true
				
				if p1 == "Secret" then
					local PlayerTable = {}

					local PlayerStats = {}
					for _, player in pairs(game.Players:GetPlayers()) do
						player:SetAttribute("Ready", true)
						table.insert(PlayerTable, player)
					end

					
					for _, player in pairs(PlayerTable) do
						PlayerStats[player.Name] = {}
						local local_stat = PlayerStats[player.Name]
						local_stat["Items"] = {}
						local items = local_stat["Items"]
						local_stat["Gold"] = player.Stats.Gold.Value
						local_stat["HP"] = player.Character:WaitForChild("Humanoid").Health or 100
						local function package(v2_lol)
							items[v2_lol.Name] = {}
							local inf = items[v2_lol.Name]
							inf.haveDurability = false
							inf.ItemID = v2_lol.Name
							inf.Durability = 0
							if v2_lol:GetAttribute("Durability") ~= nil then
								inf.haveDurability = true
								inf.Durability = v2_lol:GetAttribute("Durability")
							end
						end
						for _, v2 in pairs(player.Backpack:GetChildren()) do
							if v2:IsA("Tool") then
								package(v2)
							end
						end
						for _, v2 in pairs(player.Character:GetChildren()) do
							if v2:IsA("Tool") then
								package(v2)
							end
						end

						game.ReplicatedStorage.EntityInfo.Loading:FireClient(player, true)
						player.PlayerStats.TypeRun.Value = "HuntExit"
					end

					task.delay(1, function()
						local RES = TeleportService:ReserveServer(game.PlaceId)

						TeleportService:TeleportToPrivateServer(game.PlaceId, RES, PlayerTable, nil, PlayerStats)
					end)
				else
					
					local PlayerTable = {}
				
					local d = 15
					for i = 1, 15 do
						task.wait(1.1)
						game.ReplicatedStorage.GameData.PlayAgainText.Value = tostring(d)
						d = d - 1
					end
					
					for i, pt in pairs(game.Players:GetPlayers()) do
						if pt:GetAttribute("Ready") == true then
							table.insert(PlayerTable, pt)
						end
					end

					task.delay(1, function()
						local RES = TeleportService:ReserveServer(game.PlaceId)
						for i, player in pairs(game.Players:GetPlayers()) do
							if player then
								if player:GetAttribute("Ready") == true then
									game.ReplicatedStorage.EntityInfo.Loading:FireClient(player, true)
								end
							end
						end
						TeleportService:TeleportToPrivateServer(game.PlaceId, RES, PlayerTable)
					end)
				end
			end
		end
	end,

	Revive = function(Player, code)
		local function Function()
			if Player then
				local playerId = Player.UserId

				local appearance = game.Players:GetHumanoidDescriptionFromUserId(Player.UserId)
				Player.Character.Humanoid:ApplyDescription(appearance)

				Player:LoadCharacter()
				Player:SetAttribute("CantRevive", true)

				if Player.PlayerStats.Revives.Value > 0 then
					Player.PlayerStats.Revives.Value -= 1
				end
				wait()

				local ach = "Revive"
				local p1_player = Player

				if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
					local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
					local req = require(game.ReplicatedStorage.Achievements)[ach]

					if achive.Value == false then
						achive.Value = true
						if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
							game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
							game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
						end
					end

				end

				Player.Character.Humanoid.BodyDepthScale.Value = 1
				Player.Character.Humanoid.BodyHeightScale.Value = 1.2
				Player.Character.Humanoid.BodyProportionScale.Value = 0
				Player.Character.Humanoid.BodyTypeScale.Value = 0
				Player.Character.Humanoid.BodyWidthScale.Value = 1
				Player.Character.Humanoid.BodyWidthScale.Value = 1.05
				
				if game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1):FindFirstChild("RoomStart") then
					Player.Character:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).RoomStart.CFrame)
				else
					Player.Character:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).RoomEntrance.CFrame)
				end
			end
		end

		local CorrectCode = game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")

		if not code or not CorrectCode then
			return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end

		if CorrectCode == code or code == "ServerTypeInput" then
			Function()
		else
			game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end
	end,

	ChangeSettings = function(Player, st)
		for i, v in pairs(st) do
			_G.PlayerProfiles[Player].Replica:SetValue("Settings."..i, v)
		end
	end,

	MotorReplication = function(Player, ...)
		
	end,

	CheckRevive = function(Player)
		local Value = false
		
		return Value
	end,
	
	GetLimbs = function(Player)
		
		if not game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode") then
			return
		end
		
		game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player Get code to remote", "Print")
		
		return game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")
		
	end,
	
	GiveGolded = function(Player, v, code)
		
		local function Function()
			Player.Stats.Gold.Value += v
			wait(1)
			game.Workspace.GameSettings.Fires.SetLimbs:Fire()
		end
		
		local CorrectCode = game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")
		
		if not code or not CorrectCode then
			return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "AntiVirus")
		end
		
		if CorrectCode == code then
			Function()
		else
			game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Code is incorrent", "Error")
		end
		
	end,
	
	BadgeSc = function(Player, code)
		
		local function Function()
			
			if require(game.ReplicatedStorage.ClientModules.Module_AdminPanel):haveAccess(Player) and Player.PlayerStats.AdminPanel.Value == true then
				
			else
				
				if game.Workspace.GameSettings.Hardcore.Value == true then
					local ach = "EscapeHardHotel"
					local p1_player = Player

					if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
						local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
						local req = require(game.ReplicatedStorage.Achievements)[ach]

						if achive.Value == false then
							achive.Value = true
							if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
								game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
								game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
							end
						end

					end
				else
					local ach = "EscapeHotel"
					local p1_player = Player

					if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
						local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
						local req = require(game.ReplicatedStorage.Achievements)[ach]

						if achive.Value == false then
							achive.Value = true
							if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
								game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
								game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
							end
						end

					end
				end
			end
		end
		
		local CorrectCode = game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")

		if not code or not CorrectCode then
			return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end

		if CorrectCode == code then
			Function()
		else
			game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end
		
	end,
	
	GiveItem = function(Player, p1, p2, code)
		local function Function()
			local item = game.ServerStorage:FindFirstChild(p1):Clone()
			if p2 then
				item:SetAttribute("Durability", p2)
			end
			item.Parent = Player.Backpack
		end

		local CorrectCode = game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")

		if not code or not CorrectCode then
			return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end

		if CorrectCode == code then
			Function()
		else
			game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end
	end,
	
	RiftClearItemData = function(Player, p1, code)
		local function Function()
			Player.PlayerStats.RiftStore.Value = false
			Player.PlayerStats.RiftItem.Value = "NoItem"
		end

		local CorrectCode = game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")

		if not code or not CorrectCode then
			return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end

		if CorrectCode == code then
			Function()
		else
			game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end
	end,
	
	r4 = function(Player, p1, p2, p3, code)
		local function Function()
			Player.PlayerStats.RiftStore.Value = true
			Player.PlayerStats.RiftItem.Value = p1
			Player.PlayerStats.RiftItemDurability.Value = p2
			
			if p3:FindFirstChild("Used") then
				p3:FindFirstChild("Used").Value = true
			end
			
			wait()

			p3:Destroy()
		end

		local CorrectCode = game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")

		if not code or not CorrectCode then
			return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end

		if CorrectCode == code then
			Function()
		else
			game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end
	end,
	
	SetStats = function(Player, p1, code)
		local function Function()
			game.ReplicatedStorage.EntityInfo.Statistics:FireClient(Player, p1)
		end

		local CorrectCode = game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")

		if not code or not CorrectCode then
			return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end

		if CorrectCode == code then
			Function()
		else
			game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
		end
	end,
	
	-- game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer()
	-- Example
	--[[local function Function()

	end

	local CorrectCode = game.ServerStorage.AcceptedLimbs:GetAttribute("RequestCode")

	if not code or not CorrectCode then
		return game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
	end

	if CorrectCode == code then
		Function()
	else
		game.ReplicatedStorage.EntityInfo:FindFirstChild("SendErrorLog"):FireClient(Player, "Player didnt have code to remove this event", "Warn")
	end--]]

	--[[Statistics = function(Player)
		local funnytable = {
			["Stats"] = 
				{
					["DailyStreak"] = {"Pee", "Poo"},
					["Leftover Gold"] = {100, 60},
					["Spent Gold"] = {20, 40}

				},
			["Multipliers"] = 
				{
					"5X BOOST ACTIVE", 30
				},
			["Knobs"] = 
				{
					5,
					2,
					4
				}
		}
		game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("Statistics"):FireClient(Player, funnytable, nil)
	end,--]]

}

-- do you love me?


for _, Event in pairs(EntityInfoEvents:GetChildren()) do
	if EntityInfoEventsTable[Event.Name] then
		if Event:IsA("RemoteEvent") then
			Event.OnServerEvent:Connect(EntityInfoEventsTable[Event.Name])
		elseif Event:IsA("RemoteFunction") then
			Event.OnServerInvoke = EntityInfoEventsTable[Event.Name]
		end
	else
		if Event:IsA("RemoteEvent") then
			Event.OnServerEvent:Connect(function(Player, ...)
				local args = {...}
				for i, v in ipairs(args) do
					print(i,v)
				end
			end)
		elseif Event:IsA("RemoteFunction") then
			Event.OnServerInvoke = function(Player, ...)
				print("Player fired ["..Event.Name.."] With args: ")
				local args = {...}
				for i, v in ipairs(args) do
					print(i,v)
				end
			end
		end
	end
end

for _, Event in pairs(BrickEvents:GetChildren()) do
	--[[if EntityInfoEventsTable[Event.Name] then
		if Event:IsA("RemoteEvent") then
			Event.OnServerEvent:Connect(EntityInfoEventsTable[Event.Name])
		elseif Event:IsA("RemoteFunction") then
			Event.OnServerInvoke = EntityInfoEventsTable[Event.Name]
		end
	else]]
	if Event:IsA("RemoteEvent") then
		Event.OnServerEvent:Connect(function(Player, ...)
			--print("Player fired Brick ["..Event.Name.."] With args: ")
			local args = {...}
			for i, v in ipairs(args) do
				--print(i,v)
			end
		end)
	elseif Event:IsA("RemoteFunction") then
		Event.OnServerInvoke = function(Player, ...)
			print("Player fired Brick ["..Event.Name.."] With args: ")
			local args = {...}
			for i, v in ipairs(args) do
				print(i,v)
			end
		end
	end
end
--end

-----------------------------------------------------
-- Brick Events
-----------------------------------------------------




-----------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------

-- to see doors go to generation handler
