local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local event = ReplicatedStorage:WaitForChild("PlayKeySound")

local function getRandomSoundName()
	local names = {"KeySound1", "KeySound2", "Silent"}
	return names[math.random(1, #names)]
end

for _, model in ipairs(Workspace:GetDescendants()) do
	if model:IsA("Model") and model.Name == "ModelKey" then
		local sensor = model:FindFirstChild("Sensor")
		local key = model:FindFirstChild("KeyMesh")

		if sensor and key and sensor:IsA("BasePart") and key:IsA("BasePart") then
			local originalCFrame = key.CFrame
			local pressed = false

			local function tweenKey(targetCFrame)
				local tween = TweenService:Create(key, tweenInfo, {CFrame = targetCFrame})
				tween:Play()
			end

			sensor.Touched:Connect(function(hit)
				local player = game.Players:GetPlayerFromCharacter(hit.Parent)
				if player and not pressed then
					pressed = true
					tweenKey(originalCFrame + Vector3.new(0, -0.8, 0))
					event:FireClient(player, sensor, getRandomSoundName())
				end
			end)

			sensor.TouchEnded:Connect(function(hit)
				local player = game.Players:GetPlayerFromCharacter(hit.Parent)
				if player and pressed then
					pressed = false
					tweenKey(originalCFrame)
				end
			end)
		end
	end
end
