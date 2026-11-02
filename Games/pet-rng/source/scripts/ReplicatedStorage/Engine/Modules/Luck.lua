local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
--[[local ServerScripService = game:GetService("ServerScriptService")
local Engine = ServerScripService:WaitForChild("Engine")
local Scripts = Engine:WaitForChild("Scripts")
local Data = Scripts:WaitForChild("Data")]]
local DataManager

if RunService:IsServer() then
	DataManager = require(game:GetService("ServerScriptService").Engine.Scripts.Data.DataManager)
end

local notificationModule = require(game.ReplicatedStorage.Engine.Modules.NotificationModule)

local ids = game.ReplicatedStorage.ID.Products:GetChildren()

local rollEvent = game:GetService("ReplicatedStorage").Engine.RemotesEvents.Roll

local Luck = {}

Luck.LuckBoosts = {
	"Luck Boost I",
	"Luck Boost II",
	"Luck Boost III"
}

Luck.Dice = {
	"Golden Dice",
	"Diamond Dice",
	"Rainbow Dice"
}

Luck.GiveLuck = function(player: Player, Type)
	local Boosts = DataManager.profiles[player].Data["Boosts"]
	local multi = 1
	if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 739678519) then
		multi = 2
	end
	
	if Type == "Luck Potion III" then
		Boosts["Luck Boost III"].Time += 600 * multi
	end
	if Type == "Luck Potion I" then
		Boosts["Luck Boost I"].Time += 600 * multi
	end
	if Type == "Luck Potion II" then
		Boosts["Luck Boost II"].Time += 600 * multi
	end
	if Type == "Golden Dice" then
		Boosts["Golden Dice"].Rolls += 50
	end
	if Type == "Diamond Dice" then
		Boosts["Diamond Dice"].Rolls += 150
	end
	if Type == "Rainbow Dice" then
		Boosts["Rainbow Dice"].Rolls += 200
	end
	if Type == "Luck Aura" then
		Boosts["Luck Aura"] = true
	end
	if Type == "Recharged Aura" then
		Boosts["Recharged Aura"] = true
	end
	if Type == "Bubble Burst" then
		Boosts["Bubble Burst"] = true
	end
	if Type == "Foggy Aura" then
		Boosts["Foggy Aura"] = true
	end
	if Type == "Shining Star" then
		Boosts["Shining Star"] = true
	end
	if Type == "Burst Aura" then
		Boosts["Burst Aura"] = true
	end
	if Type == "Electro Bubble" then
		Boosts["Electro Bubble"] = true
	end
	
	coroutine.wrap(function()
		notificationModule.Notify(player, "Used 1 "..Type)
	end)()
end

Luck.GetLuck = function(player: Player)
	local Boosts =  game.ReplicatedStorage.Engine.RemotesFunctions.GetValue:InvokeServer("Boosts")
	local World =  game.ReplicatedStorage.Engine.RemotesFunctions.GetValue:InvokeServer("World")
	local luck = 0
	
	if player.MembershipType == Enum.MembershipType.Premium then
		luck += 2
		player.PlayerGui.GUI.BottomLeft.PremiumBoost.Visible = true
	end
	
	local boostFrames = player.PlayerGui.GUI.BottomLeft
	
	for _, boost in pairs(Luck.LuckBoosts) do
		local boostInfo = Boosts[boost]
		
		if boostInfo then
			if boostInfo.Time > 0 then
				luck += boostInfo.luck
			end
		end
	end
	
	for _, boost in pairs(Luck.Dice) do
		local boostInfo = Boosts[boost]

		if boostInfo then
			if boostInfo.Rolls > 0 then
				luck += boostInfo.luck
			end
		end
	end
	
	if Boosts["Luck Aura"] == true then
		luck += 10
	end
	if Boosts["Burst Aura"] == true then
		luck += 2
	end
	if Boosts["Foggy Aura"] == true then
		luck += 3
	end
	if Boosts["Recharged Aura"] == true then
		luck += 5
	end
	if Boosts["Shining Star"] == true then
		luck += 7
	end
	if Boosts["Electro Bubble"] == true then
		luck += 9
	end
	if Boosts["Bubble Burst"] == true then
		luck += 12
	end
	
	local worlds = require(game.ReplicatedStorage.DataModules.Worlds)
	local worldBoost = 0
	for worldName, worldInfo in pairs(worlds) do
		if worldName == World then
			worldBoost = worldInfo.bonus	
		end
	end
	luck += worldBoost
	
	if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 739868523) then
		luck += 5
	end
	
	return luck
end

local function convertToMinutes(n)
	if n >= 60 then
		n = math.floor(n/60).."m"
	end
	
	return n
end

if RunService:IsServer() then
	MarketplaceService.PromptProductPurchaseFinished:Connect(function(playerId, id, isPurchased)
		if isPurchased then
			print("a")
			for _, product in pairs(ids) do
				if id == product.Value then
					local player = game.Players:GetPlayerByUserId(playerId)

					if player then

						Luck.GiveLuck(player, product.Name)

					end
				end
			end
		end
	end)
	
	rollEvent.OnServerEvent:Connect(function(player)
		local Boosts = DataManager.profiles[player].Data["Boosts"]
		for _, boost in pairs(Luck.Dice) do
			local boostInfo = Boosts[boost]
			if boostInfo then
				if boostInfo.Rolls > 0 then
					boostInfo.Rolls -= 1
				end
			end
		end
	end)
end

local startedPlayers = {}

local function start(player: Player)
	if not table.find(startedPlayers, player.Name) then
		table.insert(startedPlayers, player.Name)

		coroutine.wrap(function()
			while wait() do
				if player then
					local AurasFolder = game.ReplicatedStorage:WaitForChild("Auras")
					
					local character = player.Character or player.CharacterAdded:Wait()
					local characterAuraFolder = character:WaitForChild("Auras")
					
					local bestBoost = nil
					local bestBoostAmount = 0
					
					for _, boost in pairs(player.PlayerGui.GUI.BottomLeft:GetChildren()) do
						if boost:FindFirstChild("Aura") then
							local boostAmount = string.gsub(boost.Aura.Text, "x", "")
							if boostAmount ~= "" then
								--print(boostAmount)
								if tonumber(boostAmount) > bestBoostAmount then
									bestBoostAmount = tonumber(boostAmount)
									bestBoost = boost.Name
								end
							end
						end
					end
					
					local new = characterAuraFolder:FindFirstChild(bestBoost)
					if not new then
						characterAuraFolder:ClearAllChildren()
						new = AurasFolder:FindFirstChild(bestBoost):Clone()
						new.Parent = characterAuraFolder
					end

					if new.Name == "Luck Aura" then
						new:PivotTo(player.Character.HumanoidRootPart.CFrame)	
					else
						new:PivotTo(player.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3,0))
					end
					--new:MoveTo(player.Character.HumanoidRootPart.Position)
				end
			end
		end)()
	end
end

game.Players.PlayerAdded:Connect(function(player)
	while wait(1) do
		if not DataManager then return end
		repeat wait() until DataManager.profiles[player]
		local Boosts = DataManager.profiles[player].Data["Boosts"]

		for _, boost in pairs(Luck.LuckBoosts) do
			local boostInfo = Boosts[boost]

			if boostInfo then
				if boostInfo.Time > 0 then
					boostInfo.Time -= 1

					local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild(boost)
					if BoostFrame then
						BoostFrame.Time.Text = convertToMinutes(boostInfo.Time)
						BoostFrame.Visible = true
					end
				else
					local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild(boost)
					if BoostFrame then
						BoostFrame.Visible = false
					end
				end
			end
		end

		for _, boost in pairs(Luck.Dice) do
			local boostInfo = Boosts[boost]

			if boostInfo then
				if boostInfo.Rolls > 0 then

					local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild(boost)
					if BoostFrame then
						BoostFrame.Time.Text = boostInfo.Rolls
						BoostFrame.Visible = true
					end
				else
					local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild(boost)
					if BoostFrame then
						BoostFrame.Visible = false
					end
				end
			end
		end


		if Boosts["Luck Aura"] == true then
			local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild("Luck Aura")
			if BoostFrame then
				BoostFrame.Aura.Text = "x10"
				BoostFrame.Visible = true
			end

			start(player)
		end
		if Boosts["Electro Bubble"] == true then
			local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild("Electro Bubble")
			if BoostFrame then
				BoostFrame.Aura.Text = "x9"
				BoostFrame.Visible = true
			end

			start(player)
		end
		if Boosts["Burst Aura"] == true then
			local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild("Burst Aura")
			if BoostFrame then
				BoostFrame.Aura.Text = "x2"
				BoostFrame.Visible = true
			end

			start(player)
		end
		if Boosts["Shining Star"] == true then
			local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild("Shining Star")
			if BoostFrame then
				BoostFrame.Aura.Text = "x7"
				BoostFrame.Visible = true
			end

			start(player)
		end
		if Boosts["Foggy Aura"] == true then
			local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild("Foggy Aura")
			if BoostFrame then
				BoostFrame.Aura.Text = "x3"
				BoostFrame.Visible = true
			end

			start(player)
		end
		if Boosts["Bubble Burst"] == true then
			local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild("Bubble Burst")
			if BoostFrame then
				BoostFrame.Aura.Text = "x12"
				BoostFrame.Visible = true
			end

			start(player)
		end
		if Boosts["Recharged Aura"] == true then
			local BoostFrame = player.PlayerGui.GUI.BottomLeft:FindFirstChild("Recharged Aura")
			if BoostFrame then
				BoostFrame.Aura.Text = "x5"
				BoostFrame.Visible = true
			end

			start(player)
		end
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local new = Instance.new("Folder", character)
		new.Name = "Auras"
	end)
end)

return Luck
