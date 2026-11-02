--!strict
-- LOCATION: ServerScriptService/Controllers/CarController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CarConfigurations = require(ReplicatedStorage.Modules.CarConfigurations)

local CarController = {}

local modelsFolder = ReplicatedStorage:WaitForChild("Models")

local function attachCarToPlayer(player: Player, carId: string)
	local character = player.Character
	if not character then return end
	local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
	if not rootPart then return end

	-- 1. Cleanup existing car
	local existingCar = character:FindFirstChild("EquippedCarModel")
	if existingCar then existingCar:Destroy() end

	if carId == "" then return end

	-- 2. Get Config
	local carInfo = CarConfigurations.GetCarById(carId)
	if not carInfo then return end

	-- 3. Find Model
	local modelTemplate = modelsFolder:FindFirstChild(carInfo.ModelName) :: Model
	if not modelTemplate then 
		warn("[CarController] Could not find model: " .. tostring(carInfo.ModelName))
		return 
	end

	-- 4. Clone & Setup
	local carClone = modelTemplate:Clone()
	carClone.Name = "EquippedCarModel"

	-- Safety Check
	if not carClone.PrimaryPart then
		warn("[CarController] Model " .. carInfo.ModelName .. " has no PrimaryPart!")
		carClone:Destroy()
		return
	end

	-- Process parts: Physics safety AND Internal Welding
	for _, desc in ipairs(carClone:GetDescendants()) do
		if desc:IsA("BasePart") then
			desc.CanCollide = false
			desc.Massless = true
			desc.Anchored = false

			-- Weld everything to PrimaryPart so it doesn't fall apart
			if desc ~= carClone.PrimaryPart then
				local internalWeld = Instance.new("WeldConstraint")
				internalWeld.Part0 = carClone.PrimaryPart
				internalWeld.Part1 = desc
				internalWeld.Parent = desc
			end
		end
	end

	carClone.Parent = character

	-- 5. Weld to Player (WITH ROTATION)
	local carPrimary = carClone.PrimaryPart

	-- ## CHANGED: Added * CFrame.Angles(0, math.rad(180), 0) ##
	carPrimary.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(180), 0)

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = rootPart
	weld.Part1 = carPrimary
	weld.Parent = carPrimary
end

local function onPlayerAdded(player: Player)
	local function hook()
		local cars = player:WaitForChild("Cars", 10)
		if not cars then return end

		local equipped = cars:WaitForChild("Equipped") :: StringValue

		equipped.Changed:Connect(function(val)
			attachCarToPlayer(player, val)
		end)

		player.CharacterAdded:Connect(function(char)
			task.wait(1) -- Wait for appearance/physics
			attachCarToPlayer(player, equipped.Value)
		end)

		if player.Character then
			attachCarToPlayer(player, equipped.Value)
		end
	end
	task.spawn(hook)
end

function CarController:Init()
end

function CarController:Start()
	for _, p in ipairs(Players:GetPlayers()) do
		onPlayerAdded(p)
	end
	Players.PlayerAdded:Connect(onPlayerAdded)
end

return CarController