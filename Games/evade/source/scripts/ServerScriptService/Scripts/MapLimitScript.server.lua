local Players = game:GetService("Players")
local CHECK_INTERVAL = 0.25
local DISTANCE_THRESHOLD = 700
local TIME_TO_RESET = 0.000001

local map = workspace:WaitForChild("Map")
local targetModel = map:WaitForChild("Borders")
local timers = {}

local function getModelCenter(model)
	if not model.PrimaryPart then
		model.PrimaryPart = model:FindFirstChildWhichIsA("BasePart")
	end
	if model.PrimaryPart then
		return model.PrimaryPart.Position
	end
	return model:GetModelCFrame().Position
end

Players.PlayerAdded:Connect(function(player)
	timers[player.UserId] = 0
	player.CharacterAdded:Connect(function(character)
		local hrp = character:WaitForChild("HumanoidRootPart")
		local humanoid = character:WaitForChild("Humanoid")

		while character.Parent and player.Parent do
			task.wait(CHECK_INTERVAL)
			local targetPos = getModelCenter(targetModel)
			local dist = (hrp.Position - targetPos).Magnitude

			if dist > DISTANCE_THRESHOLD then
				timers[player.UserId] = (timers[player.UserId] or 0) + CHECK_INTERVAL
				if timers[player.UserId] >= TIME_TO_RESET then
					player:LoadCharacter()
					timers[player.UserId] = 0
					break
				end
			else
				timers[player.UserId] = 0
			end
		end
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	timers[player.UserId] = nil
end)