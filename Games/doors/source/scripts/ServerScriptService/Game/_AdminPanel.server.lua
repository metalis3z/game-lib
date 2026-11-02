local ModuleEvents = require(game.ReplicatedStorage.ClientModules.Module_Events)
local ModuleAdminPanel = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)
local SpecialPlayers = require(game.ReplicatedStorage.SpecialPlayers)
local AdminPanelSettings = Instance.new("Folder", workspace)
AdminPanelSettings.Name = "AdminPanelSettings"
AdminPanelSettings:SetAttribute("NextRoom", "Nil")
game.ReplicatedStorage.Bricks.GetAllRooms.OnServerEvent:Connect(function(pt)
	local h_a = ModuleAdminPanel:haveAccess(pt)
	if not h_a then
		warn("access declined. //request from", pt.Name)
		return
	end
	local rooms = script.Parent.Parent.Server.DifficultyRooms
	local return_value = {}
	local function set(id)
		for i,v in pairs(rooms[id]:GetChildren()) do
			table.insert(return_value, v.Name)
		end
	end
	
	set("2")
	set("3")
	set("4")
	set("5")
	
	--print(return_value)
	
	game.ReplicatedStorage.Bricks.GetAllRooms:FireClient(pt, return_value)
end)
game.ReplicatedStorage.AdminPanelReq.OnServerEvent:Connect(function(pt, id, object)
	local h_a = ModuleAdminPanel:haveAccess(pt)
	if not h_a or pt.PlayerStats.TypeRun.Value == "HardHotel" and not SpecialPlayers.isSpecial(pt.Name) then
		pt:Kick("Anti Bypass! If you didn't use exploit please create ticket.")
		warn("access declined. //request from", pt.Name)
		return
	end
	local function jumpscare(id)
		if id == "Haste" then
			local plr = pt
			if object ~= "" then
				plr = game.Players:WaitForChild(object)
			end
			game.ReplicatedStorage.EntityInfo.HasteJumpscare:FireClient(plr, "Admin Panel")
			return
		end
		if object == "" then
			object = pt
		elseif object ~= "" then
			object = game.Players:WaitForChild(object)
		end
		game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(object, id, "Admin Panel")
	end
	local function getPlayer(n)
		local pt1 = nil
		
		for i,v in pairs(game.Players:GetPlayers()) do
			if string.lower(v.Name) == string.lower(n) then
				pt1 = v
			end
		end
		return pt1
	end
	local function kill(pt1)
		local strange_msgs = {
			{"🚽"},
			{"knock knock", "knock knock", "🚪"},
			{"You died to the...", "KILLER_NAME"},
			{"You died to the...", "You died to the...", "You died to the...", "You died to the...", "You died to the...", "You died to the...", "You died to the...", "nugget"},
			{"You died to the...", "PLAYER_NAME", "lol"},
			{"You died to the...", "RANDOM_ENTITY_NAME", "Right?.."},
			{"faofpjiawjifapwfjo", "igmoapmgoiagpa", "gaegmiagmim", "igmoapmgoiagpa", "gaegmiagmim", "igmoapmgoiagpa", "gaegmiagmim"}
		}
		local random_entity = {"Rush", "Screech", "Timothy", "Ambush", "Haste", "Seek", "Figure", "Halt", "Dupe", "Blitz", "Lookman", "Eyes", "KreekCraft?"}
		pt1.Character:WaitForChild("Humanoid").Health = 0
		local _r = strange_msgs[math.random(1, #strange_msgs)]
		local formatted = {}
		pt1.Stats.Death.Value = pt.Name
		for i,v in pairs(_r) do
			if v == "KILLER_NAME" then
				v = pt.Name
			elseif v == "PLAYER_NAME" then
				v = pt1.Name
			elseif v == "RANDOM_ENTITY_NAME" then
				v = random_entity[math.random(1, #random_entity)]
			end
			table.insert(formatted, i, v)
		end
		_r = formatted
		local random_colors = {"Yellow", "Red", "Grey", "Purple", "Green", "Orange", "Blue"}
		random_colors = random_colors[math.random(1, #random_colors)]
		game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(pt1, _r, random_colors)
	end
	local function damage(pt1, val)
		if typeof(val) == "string" then
			val = tonumber(val)
		end
		if pt1.Character then
			pt1.Character:WaitForChild("Humanoid").Health -= val
		end
	end
	local function revive(pt1)
		if pt1 then
			pt1:SetAttribute("CantRevive", false)
			local playerId = pt1.UserId
			
			local Character = pt1.Character

			local appearance = game.Players:GetHumanoidDescriptionFromUserId(pt1.UserId)
			Character.Humanoid:ApplyDescription(appearance)

			pt1:LoadCharacter()
			pt1:SetAttribute("CantRevive", true)
			wait()
			
			Character.Humanoid.BodyDepthScale.Value = 1
			Character.Humanoid.BodyHeightScale.Value = 1.2
			Character.Humanoid.BodyProportionScale.Value = 0
			Character.Humanoid.BodyTypeScale.Value = 0
			Character.Humanoid.BodyWidthScale.Value = 1
			Character.Humanoid.BodyWidthScale.Value = 1.05

			if not game:GetService("BadgeService"):UserHasBadgeAsync(pt1.UserId, 465348028317226) then
				game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(pt1, "Revive")
				game:GetService("BadgeService"):AwardBadge(pt1.UserId, 465348028317226)
			end
			
			local room = "RoomStart"
			
			if pt1:WaitForChild("PlayerStats").TypeRun.Value == "Hotel" then
				room = "RoomStart"
			elseif pt1:WaitForChild("PlayerStats").TypeRun.Value == "Hunt" then
				room = "RoomEntrance"
			else
				room = "RoomStart"
			end

			pt1.Character:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)[room].CFrame)
		end
	end
	if id == "GiveItem" then
		local new_object = nil
		for i,v in pairs(game.ReplicatedStorage.ClientBricks.ServerStorage:GetChildren()) do
			if string.lower(v.Name) == object then
				new_object = v
			end
		end
		if new_object ~= nil then
			new_object = new_object:Clone()
			new_object.Parent = pt.Backpack
		end
	elseif id == "GiveItemPlayer" then
		local new_object = nil
		local player_give = getPlayer(object[2])
		for i,v in pairs(game.ReplicatedStorage.ClientBricks.ServerStorage:GetChildren()) do
			if string.lower(v.Name) == object[1] then
				new_object = v
			end
		end
		if new_object ~= nil then
			new_object = new_object:Clone()
			new_object.Parent = player_give.Backpack
		end
		print("lol")
	elseif id == "BreakLights" then
		ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1], 55)
	elseif id == "FlickerLights" then
		ModuleEvents.flickerLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1], 3)
	elseif id == "SpawnHaste" then
		workspace.Game:SetAttribute("GameTimer", 0)
	elseif id == "SpawnRush" then
		workspace.GameSettings.Fires.RushMove:Fire(workspace.CurrentRooms.CurrentRoom.Value, "ActiveRushTrueOk")
	elseif id == "SpawnScreech" then
		game.ReplicatedStorage.EntityInfo.Screech:FireClient(pt)
	elseif id == "ScreechPlayer" then
		game.ReplicatedStorage.EntityInfo.Screech:FireClient(game.Players[object])
	elseif id == "SpawnA60" then
		workspace.GameSettings.Fires.A60Move:Fire(workspace.CurrentRooms.CurrentRoom.Value, "ActiveA600TrueOk")
	elseif id == "SpawnTroll" then
		workspace.GameSettings.Fires.TrollMove:Fire(workspace.CurrentRooms.CurrentRoom.Value, "ActiveTrollingTrueOk")
	elseif id == "SpawnKreek" then
		workspace.GameSettings.Fires.KreekMove:Fire(workspace.CurrentRooms.CurrentRoom.Value, "ActiveBaldeKreekTrueOk")
	elseif id == "SpawnAmbush" then
		workspace.GameSettings.Fires.AmbushMove:Fire(workspace.CurrentRooms.CurrentRoom.Value, "ActiveAmbushTrueOk")
	elseif id == "SpawnBlitz" then
		workspace.GameSettings.Fires.BlitzMove:Fire(workspace.CurrentRooms.CurrentRoom.Value)
	elseif id == "SetEndRoom" then
		game.Workspace.Game:SetAttribute("LastRoom", object)
	elseif id == "DisableHaste" then
		workspace.Game:SetAttribute("GameTimer", 999999999)
	elseif id == "GiveCoins" then
		--[[pt.Stats.Gold.Value += object
		for i = 1, math.floor(object / 5000) do
			if math.random(1, 15) == 15 then
				wait(0.01)
			end
		end]]
		pt.Stats.Gold.Value += object
		for i = 1, 25 do -- test thing
			game.ReplicatedStorage.ClientBricks.GoldAnimation:FireClient(pt, "Admin Panel")
		end
	elseif id == "KillSelf" then
		kill(pt)
	elseif id == "KillPlayer" then
		local pt1 = getPlayer(object)
		kill(pt1)
	elseif id == "DamageSelf" then
		damage(pt, object)
	elseif id == "DamagePlayer" then
		local pt1 = getPlayer(object[2])
		damage(pt1, object[1])
	elseif id == "JumpscareRush" then
		jumpscare("Rush")
	elseif id == "JumpscareSeek" then
		jumpscare("Seek")
	elseif id == "JumpscareBlitz" then
		jumpscare("Blitz")
	elseif id == "JumpscareFigure" then
		jumpscare("Figure")
	elseif id == "JumpscareAmbush" then
		jumpscare("Ambush")
	elseif id == "JumpscareHaste" then
		jumpscare("Haste")
	elseif id == "ReviveSelf" then
		revive(pt)
	elseif id == "RevivePlayer" then
		local pt1 = getPlayer(object)
		revive(pt1)
	elseif id == "SetBoost" then
		pt.Character:WaitForChild("Humanoid"):SetAttribute("SpeedBoostExtra", object)
	elseif id == "SetBoostPlayer" then
		local pt1 = getPlayer(object[2])
		pt1.Character:WaitForChild("Humanoid"):SetAttribute("SpeedBoostExtra", object[1])
	elseif id == "SetNextRoom" then
		AdminPanelSettings:SetAttribute("NextRoom", object)
	elseif id == "CustomGL" then
		pt.Stats.Death.Value = "self? lol"
		game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(pt, object.text, object.main_color)
		pt.Character.Humanoid.Health = 0
	elseif id == "CustomEntitySpawn" then
		workspace.GameSettings.Fires.CustomEntityMove:Fire(workspace.CurrentRooms.CurrentRoom.Value, "Super_secret_code_lol", object)
	end
	print("done")
end)