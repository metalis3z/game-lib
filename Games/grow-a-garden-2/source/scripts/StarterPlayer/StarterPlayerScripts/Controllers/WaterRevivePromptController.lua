--credit to prince games studio
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local GearShopData = require(ReplicatedStorage.SharedModules.GearShopData)
local PlayerStateClient = require(ReplicatedStorage.ClientModules.PlayerStateClient)
local PlantLifecycleHandler = require(game.Players.LocalPlayer.PlayerScripts.Controllers.PlantLifecycleHandler)
local t = {
	StartOrder = 5
}
local v1 = 0

for v2, v3 in GearShopData.Data do
	if v3.ItemName == "Common Watering Can" then
		v1 = v3.Cost

		break
	end
end

local v4 = UDim2.fromScale(4, 4)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Click = SoundService.SFX.Click
local t2 = {}
local v5 = nil

for v6, v7 in SeedData do
	t2[v7.SeedName] = v7
end

local v8 = nil
local v9 = nil
local v10 = 1

local function GetCharacterPosition() --[[ GetCharacterPosition | Line: 53 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		return HumanoidRootPart.Position
	end

	return nil
end

local function IsHoldingWateringCan() --[[ IsHoldingWateringCan | Line: 61 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return false
	end

	local v1 = Character:FindFirstChildWhichIsA("Tool")

	if not v1 then
		return false
	end

	return v1:GetAttribute("WateringCan") ~= nil
end

local function HasSheckles() --[[ HasSheckles | Line: 69 | Upvalues: v5 (ref), v1 (ref) ]]
	if not v5 then
		return false
	end

	return v1 < (v5.Data.Sheckles or 0)
end

local function HasWateringCanInStock() --[[ HasWateringCanInStock | Line: 74 | Upvalues: ReplicatedStorage (copy), GearShopData (copy) ]]
	local StockValues = ReplicatedStorage:FindFirstChild("StockValues")

	if not StockValues then
		return false
	end

	local GearShop = StockValues:FindFirstChild("GearShop")

	if not GearShop then
		return false
	end

	local Items = GearShop:FindFirstChild("Items")

	if not Items then
		return false
	end

	for v1, v2 in GearShopData.Data do
		if v2.ItemType == "Watering Can" then
			local v3 = Items:FindFirstChild(v2.ItemName)

			if v3 and v3.Value > 0 then
				return true
			end
		end
	end

	return false
end

local function HasEverWatered() --[[ HasEverWatered | Line: 89 | Upvalues: v5 (ref) ]]
	if not v5 then
		return false
	end

	return v5.Data.HasWateredPlants == true
end

local function IsPlantDecaying(p1, p2) --[[ IsPlantDecaying | Line: 94 | Upvalues: t2 (copy), PlantLifecycleHandler (copy) ]]
	if not p1.PrimeStartedAt or p1.PrimeStartedAt <= 0 then
		return false
	end

	if p1.Mutation then
		return false
	end

	local v1 = t2[p1.SeedName]

	if not (v1 and v1.PrimeTime) then
		return false
	end

	if v1.AlwaysPrime then
		return false
	end

	local v2, v3 = string.match(p2, "^(%d+)_(.+)$")

	if not (v2 and v3) then
		return false
	end

	local v4 = PlantLifecycleHandler:GetDecayAlpha(tonumber(v2), v3)

	return if v4 == nil then false else v4 > 0.5
end

local function IsLocalPlayerPlant(p1) --[[ IsLocalPlayerPlant | Line: 111 | Upvalues: LocalPlayer (copy) ]]
	local v1 = string.match(p1, "^(%d+)_")

	if not v1 then
		return false
	end

	local isUserId = tonumber(v1) == LocalPlayer.UserId

	return isUserId
end

local function CreateBillboard(p1) --[[ CreateBillboard | Line: 117 | Upvalues: v4 (copy), Click (copy), ReplicatedStorage (copy), PlayerGui (copy) ]]
	local WaterRevivePrompt = Instance.new("BillboardGui")

	WaterRevivePrompt.Name = "WaterRevivePrompt"
	WaterRevivePrompt.Size = v4
	WaterRevivePrompt.StudsOffset = Vector3.new(0, 4, 0)
	WaterRevivePrompt.AlwaysOnTop = true
	WaterRevivePrompt.ResetOnSpawn = false
	WaterRevivePrompt.Active = true
	WaterRevivePrompt.Adornee = p1.PrimaryPart

	local ReviveButton = Instance.new("ImageButton")

	ReviveButton.Name = "ReviveButton"
	ReviveButton.Image = "rbxassetid://119733290955630"
	ReviveButton.Size = UDim2.fromScale(1, 1)
	ReviveButton.BackgroundTransparency = 1
	ReviveButton.ImageTransparency = 1
	ReviveButton.Parent = WaterRevivePrompt
	ReviveButton.Activated:Connect(function() --[[ Line: 135 | Upvalues: Click (ref), ReplicatedStorage (ref) ]]
		Click.TimePosition = 0
		Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		Click:Play()

		local Notify = ReplicatedStorage:FindFirstChild("Notify")

		if not Notify then
			return
		end

		Notify:Fire("Water this plant to revive it!")
	end)
	WaterRevivePrompt.Parent = PlayerGui

	return WaterRevivePrompt
end

local function SetBillboardTransparency(p1, p2) --[[ SetBillboardTransparency | Line: 150 ]]
	local ReviveButton = p1:FindFirstChild("ReviveButton")

	if not ReviveButton then
		return
	end

	ReviveButton.ImageTransparency = p2
end

local function DestroyBillboard() --[[ DestroyBillboard | Line: 157 | Upvalues: v8 (ref), v9 (ref), v10 (ref) ]]
	if v8 then
		v8:Destroy()
		v8 = nil
	end

	v9 = nil
	v10 = 1
end

function t.Init(p1) --[[ Init | Line: 168 ]] end
function t.Start(p1) --[[ Start | Line: 171 | Upvalues: v5 (ref), PlayerStateClient (copy), RunService (copy), LocalPlayer (copy), v8 (ref), v9 (ref), v10 (ref), v1 (ref), HasWateringCanInStock (copy), PlantLifecycleHandler (copy), IsPlantDecaying (copy), CreateBillboard (copy) ]]
	task.spawn(function() --[[ Line: 172 | Upvalues: v5 (ref), PlayerStateClient (ref) ]]
		v5 = PlayerStateClient:WaitForLocalReplica(30)
	end)
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 176 | Upvalues: v5 (ref), LocalPlayer (ref), v8 (ref), v9 (ref), v10 (ref), v1 (ref), HasWateringCanInStock (ref), PlantLifecycleHandler (ref), IsPlantDecaying (ref), CreateBillboard (ref) ]]
		if not v5 then
			return
		end

		if LocalPlayer:GetAttribute("SecondTimePlayer") == true then
			if if v5 then if v5.Data.HasWateredPlants == true then true else false else false then
				if v8 then
					v8:Destroy()
					v8 = nil
				end

				v9 = nil
				v10 = 1
			else
				local v2 = if v5 then if v1 < (v5.Data.Sheckles or 0) then true else false else false

				if v2 and HasWateringCanInStock() then
					local Character = LocalPlayer.Character
					local v3

					if Character then
						local v4 = Character:FindFirstChildWhichIsA("Tool")

						v3 = if v4 then if v4:GetAttribute("WateringCan") == nil then false else true else false
					else
						v3 = false
					end

					if v3 then
						if not v8 then
							return
						end

						v10 = math.clamp(v10 + p1 * 3, 0, 1)

						local v6 = v10
						local ReviveButton = v8:FindFirstChild("ReviveButton")

						if ReviveButton then
							ReviveButton.ImageTransparency = v6
						end

						if not (v10 >= 1) then
							return
						end

						if v8 then
							v8:Destroy()
							v8 = nil
						end

						v9 = nil
						v10 = 1
					else
						local Character2 = LocalPlayer.Character
						local v7

						if Character2 then
							local HumanoidRootPart = Character2:FindFirstChild("HumanoidRootPart")

							v7 = if HumanoidRootPart then HumanoidRootPart.Position else nil
						else
							v7 = nil
						end

						if v7 then
							local v82 = 30
							local v92 = nil
							local v102 = nil

							for v11, v122 in PlantLifecycleHandler:GetActiveEntries() do
								local v13 = string.match(v11, "^(%d+)_")

								if if v13 then if tonumber(v13) == LocalPlayer.UserId then true else false else false then
									local Model = v122.Model

									if Model and Model.Parent then
										local v15 = IsPlantDecaying(v122, v11)

										if Model:GetAttribute("Decaying") ~= v15 then
											Model:SetAttribute("Decaying", v15)
										end

										if v15 and Model.PrimaryPart then
											local Magnitude = (Model.PrimaryPart.Position - v7).Magnitude

											if Magnitude < v82 then
												v82 = Magnitude
												v92 = Model
												v102 = v11
											end
										end
									end
								end
							end

							if v92 and v102 then
								if v9 ~= v92 then
									if v8 then
										v8:Destroy()
										v8 = nil
									end

									v9 = nil
									v10 = 1
									v8 = CreateBillboard(v92)
									v9 = v92
									v10 = 1
								end

								v10 = math.clamp(v10 - p1 * 3, 0, 1)

								if not v8 then
									return
								end

								local ReviveButton = v8:FindFirstChild("ReviveButton")

								if not ReviveButton then
									return
								end

								ReviveButton.ImageTransparency = v10
							else
								if not v8 then
									return
								end

								v10 = math.clamp(v10 + p1 * 3, 0, 1)

								local v19 = v10
								local ReviveButton = v8:FindFirstChild("ReviveButton")

								if ReviveButton then
									ReviveButton.ImageTransparency = v19
								end

								if not (v10 >= 1) then
									return
								end

								if v8 then
									v8:Destroy()
									v8 = nil
								end

								v9 = nil
								v10 = 1
							end
						else
							if v8 then
								v8:Destroy()
								v8 = nil
							end

							v9 = nil
							v10 = 1
						end
					end
				else
					if v8 then
						v8:Destroy()
						v8 = nil
					end

					v9 = nil
					v10 = 1
				end
			end
		else
			if v8 then
				v8:Destroy()
				v8 = nil
			end

			v9 = nil
			v10 = 1
		end
	end)
end

return t