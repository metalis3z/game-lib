local SpawnLocation = workspace:FindFirstChild("SpawnLocation", true)

local ReplicaService = require(game.ServerScriptService.ServerScriptModules.ReplicaService)
local ProfileService = require(game.ServerScriptService.ServerScriptModules.ProfileService)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EntityInfoEvents = ReplicatedStorage:WaitForChild("EntityInfo")
local BrickEvents = ReplicatedStorage:WaitForChild("Bricks")
local RagdollBuilder = require(ReplicatedStorage.buildRagdoll)
local GameData = ReplicatedStorage:WaitForChild("GameData")
local GameStats = ReplicatedStorage:WaitForChild("GameStats")
local TeleportService = game:GetService("TeleportService")

local DataStoreService = game:GetService("DataStoreService")
local PlayerProfileClassToken = ReplicaService.NewClassToken("PlayerProfile")
local DataStoreKey = "DHDevStore_Test"
local DataStore = DataStoreService:GetDataStore(DataStoreKey)

game.Players.PlayerAdded:Connect(function(Player)
	
	local playerId = Player.UserId

	local PlayersModel = game.Players:GetCharacterAppearanceAsync(playerId)
	PlayersModel.Parent = script

	local PlayerReference = Player

	local PlayerGold = Instance.new("NumberValue")
	PlayerGold.Name = "Gold"
	PlayerGold.Parent = Player

	Player:SetAttribute("CurrentRoom", 0)
	Player:SetAttribute("Alive", true)
	Player:SetAttribute("Ready", false)
	Player:SetAttribute("Hasted", false)
	Player:SetAttribute("CantRevive", false)

	Player.CharacterAdded:Connect(function(Character)
		
		local banType = 1000000
		
		if Player:WaitForChild("PlayerStats").Knobs.Value > banType then
			Player:Kick("👺 antivirus: rejoin")
		end
		
		local appearance = game.Players:GetHumanoidDescriptionFromUserId(Player.UserId)
		
		if Character:FindFirstChild(appearance.ShouldersAccessory) then
			Character:FindFirstChild(appearance.ShouldersAccessory):Destroy()
		end
		
		if Character:FindFirstChild(appearance.HatAccessory) then
			Character:FindFirstChild(appearance.HatAccessory):Destroy()
		end
		
		if Character:FindFirstChild(appearance.FaceAccessory) then
			Character:FindFirstChild(appearance.FaceAccessory):Destroy()
		end
		
		if Character:FindFirstChild(appearance.BackAccessory) then
			Character:FindFirstChild(appearance.BackAccessory):Destroy()
		end
		
		Character.Humanoid:ApplyDescription(appearance)
		
		Character.PrimaryPart.Anchored = true
		task.delay(1.4, function()
			Character.PrimaryPart.Anchored = false
		end)
		
		Character.Humanoid.BodyDepthScale.Value = 1
		Character.Humanoid.BodyHeightScale.Value = 1.2
		Character.Humanoid.BodyProportionScale.Value = 0
		Character.Humanoid.BodyTypeScale.Value = 0
		Character.Humanoid.BodyWidthScale.Value = 1
		Character.Humanoid.BodyWidthScale.Value = 1.05

		RagdollBuilder(Character:FindFirstChild("Humanoid"))

		Character:WaitForChild("UpperTorso").CollisionGroup = "None"
		Character:WaitForChild("LowerTorso").CollisionGroup = "None"

		Character:FindFirstChild("Humanoid").Died:connect(function()
			for i, v in pairs(Character:GetDescendants()) do
				if v:IsA("Motor6D") then
					v.Enabled = false
				end
			end
			Player:SetAttribute("Alive", false)

		end)

	end)

	Player:LoadCharacter()

	--[[repeat wait(0.1) until game.Workspace:FindFirstChild(Player.Name)

	for i,v in pairs(PlayersModel:GetChildren()) do
		if v:IsA("BodyColors") then
			v.Parent = Player.Character
		elseif v:IsA("Accessory") then
			v.Parent = Player.Character
		elseif v:IsA("Shirt") then
			v.Parent = Player.Character
		elseif v:IsA("Pants") then
			v.Parent = Player.Character
		end
	end
	PlayersModel:Destroy()--]]
end)

