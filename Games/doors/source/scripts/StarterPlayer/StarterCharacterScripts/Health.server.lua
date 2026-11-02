-- Gradually regenerates the Humanoid's Health over time.

local REGEN_RATE = 1/100 -- Regenerate this fraction of MaxHealth per second.
local REGEN_STEP = 1 -- Wait this long between each regeneration step.

--------------------------------------------------------------------------------

local Character = script.Parent
local Humanoid = Character:WaitForChild("Humanoid")

local CharFolder = script.Character
local RootFolder = script.HumanoidRootPart

local ModuleItems = require(game.ServerScriptService.Game.Controls.Items)

--------------------------------------------------------------------------------

--[[while true do
	while Humanoid.Health < Humanoid.MaxHealth do
		local dt = wait(REGEN_STEP)
		local dh = dt*REGEN_RATE*Humanoid.MaxHealth
		Humanoid.Health = math.min(Humanoid.Health + dh, Humanoid.MaxHealth)
	end
	Humanoid.HealthChanged:Wait()
end]]

-- Give Doors's collisions and animations and stuff lol


if Humanoid then
	--game.Players:GetPlayerFromCharacter(script.Parent).Character:FindFirstChildWhichIsA("Humanoid").Died:Connect(function()
	--	game.ReplicatedStorage.EntityInfo.Statistics:FireClient(game.Players:GetPlayerFromCharacter(script.Parent))
	--end)
	
	local Collision = CharFolder.Collision
	Collision.Parent = Character
	Collision.Weld.Part1 = Character:FindFirstChild("HumanoidRootPart")
	
	local BodyGyro = RootFolder.BodyGyro
	BodyGyro.Parent = Character:FindFirstChild("HumanoidRootPart")
	
	local Animations = CharFolder.Animations
	Animations.Parent = Character
	-- Remember to spoof these guys
	
	Humanoid:SetAttribute("SpeedBoost", 0) --// Vitamins and Seek SpeedBoost
	Humanoid:SetAttribute("SpeedBoostBehind", 0) --// Speed Boost when you're behind the player group
	Humanoid:SetAttribute("SpeedBoostExtra", 0) --// Not sure, it doesn't do anything
	Humanoid:SetAttribute("Stunned", false) --// Just changes your state locally?
	--	Humanoid:SetAttribute("AppearanceFinal", true)
	-- to find code related to SpeedBoosts, go to Line 59 in Movement Script
	-- All the speedboosts get overridden by SpeedBoost = SpeedBoostBehind, leaving Extra in the dust and not ebing used
	-- Maybe fix this later or take advantage of it?
	-- I'd say Walkspeed = (SpeedBoost + SpeedBoostBehind) + SpeedBoostExtra or something
	
	Humanoid.Parent:SetAttribute("CurrentRoom", 0)
	Humanoid.Parent:SetAttribute("Hiding", false) -- hiding in closet or bed
	Humanoid.Parent:SetAttribute("HideSickness", false) -- for the hide monster who kicks you out
	
	local Shield = Instance.new("NumberValue")
	Shield.Parent = Humanoid
	Shield.Name = "Shield"
	
	Humanoid.AutoRotate = false --// So the player doesn't spazz out when going backwards, not sure if it's in real doors
	Humanoid.WalkSpeed = 15 --// In real Doors
	
	function DropItems()
		local player = game.Players:GetPlayerFromCharacter(script.Parent)
		
		local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

		if game.MarketplaceService:PlayerOwnsAsset(player, module.gamepass_id) and player.PlayerStats.AdminPanel.Value == true then
			print("Player died with enabled admin panel, progress didnt changed")
		else
			player.PlayerStats.Deaths.Value = player.PlayerStats.Deaths.Value + 1			
		end
		
		wait()
		
		if player.PlayerStats.Deaths.Value == 1 then
			if game.MarketplaceService:PlayerOwnsAsset(player, module.gamepass_id) and player.PlayerStats.AdminPanel.Value == true then
				
			else
				local ach = "DeathAmt1"
				local p1_player = player

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
		
		if player.PlayerStats.Deaths.Value == 10 then
			if game.MarketplaceService:PlayerOwnsAsset(player, module.gamepass_id) and player.PlayerStats.AdminPanel.Value == true then
				
			else
				local ach = "DeathAmt10"
				local p1_player = player

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
		
		if player.PlayerStats.Deaths.Value == 100 then
			if game.MarketplaceService:PlayerOwnsAsset(player, module.gamepass_id) and player.PlayerStats.AdminPanel.Value == true then
				
			else
				local ach = "DeathAmt100"
				local p1_player = player

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
		
		if player.Backpack:FindFirstChild("Lighter") then
			local lighter = game.ServerScriptService.Server.Assets.Items.DroppedItems.LighterHandleDropped:Clone()
			lighter:SetAttribute("Durability", player.Backpack:FindFirstChild("Lighter"):GetAttribute("Durability"))
			
			lighter.Main.PlaySound:Play()
			lighter.Parent = game.Workspace
			lighter:PivotTo(Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(2, 0, 0))
			player.Backpack:FindFirstChild("Lighter"):Destroy()
		end
		
		if player.Character:FindFirstChild("Lighter") then
			local lighter = game.ServerScriptService.Server.Assets.Items.DroppedItems.LighterHandleDropped:Clone()
			lighter:SetAttribute("Durability", player.Character:FindFirstChild("Lighter"):GetAttribute("Durability"))

			lighter.Main.PlaySound:Play()
			lighter.Parent = game.Workspace
			lighter:PivotTo(Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(2, 0, 0))
			player.Character:FindFirstChild("Lighter"):Destroy()
		end
	end
	
	Humanoid.Died:Connect(DropItems)
end

Humanoid.Parent:GetAttributeChangedSignal("HideSickness"):Connect(function()
	if Humanoid.Parent:GetAttribute("HideSickness") == true then
		task.delay(10, function()
			Humanoid.Parent:SetAttribute("HideSickness", false)
		end)
	end
end)--]]

while true do
	task.wait(0.05)
	local roomNumber = game.Workspace.CurrentRooms.CurrentRoom.Value
	local roomN_1 = roomNumber - 1
	local roomN_2 = roomNumber - 2
	local roomN_3 = roomNumber - 3
	local roomN_4 = roomNumber - 4
	
	if game.Workspace.CurrentRooms.CurrentRoom.HaltCorridorValue.Value == true or game.Workspace.CurrentRooms.CurrentRoom.FigureLibraryValue.Value == true then
		Humanoid:SetAttribute("SpeedBoostBehind", 0)
	else
		if Humanoid.Parent:GetAttribute("CurrentRoom") == tostring(roomN_1) then
			wait(1)
			if Humanoid.Parent:GetAttribute("CurrentRoom") == tostring(roomN_1) then
				Humanoid:SetAttribute("SpeedBoostBehind", 0)
			else
				Humanoid:SetAttribute("SpeedBoostBehind", 0)
			end
		elseif Humanoid.Parent:GetAttribute("CurrentRoom") == tostring(roomN_2) then
			wait(1)
			if Humanoid.Parent:GetAttribute("CurrentRoom") == tostring(roomN_2) then
				Humanoid:SetAttribute("SpeedBoostBehind", 3)
			else
				Humanoid:SetAttribute("SpeedBoostBehind", 0)
			end
		elseif Humanoid.Parent:GetAttribute("CurrentRoom") == tostring(roomN_3) then
			wait(1)
			if Humanoid.Parent:GetAttribute("CurrentRoom") == tostring(roomN_3) then
				Humanoid:SetAttribute("SpeedBoostBehind", 5)
			else
				Humanoid:SetAttribute("SpeedBoostBehind", 0)
			end
		elseif Humanoid.Parent:GetAttribute("CurrentRoom") == tostring(roomN_4) then
			if game.ReplicatedStorage.GameData.ChaseInSession.Value == true then
				Humanoid:SetAttribute("SpeedBoostBehind", 4)
			else
				--game.ReplicatedStorage.ClientBricks.Entities.VoidClient:FireClient(game.Players:GetPlayerFromCharacter(script.Parent))
			end
		end
	end
end