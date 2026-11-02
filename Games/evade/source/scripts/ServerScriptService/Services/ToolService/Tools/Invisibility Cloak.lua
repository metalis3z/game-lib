--!strict

local TweenService = game:GetService("TweenService")

local InvisibilityTool = {}

local playerCooldowns = {}
local playerInvisibleState = {}
local playerUnequipConnections = {}
local playerOriginalSpeed = {}
local playerActiveTweens = {}
local playerTargetTransparency = {}

local COOLDOWN_TIME = 1
local FADE_TIME = 0.5
local SPEED_MULTIPLIER = 2

local function fadeInvisibility(character: Model, targetTransparency: number, playerId: number)
	playerTargetTransparency[playerId] = targetTransparency

	if playerActiveTweens[playerId] then
		for _, tween in ipairs(playerActiveTweens[playerId]) do
			tween:Cancel()
		end
		playerActiveTweens[playerId] = nil
	end

	local tweenInfo = TweenInfo.new(FADE_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	local tweens = {}

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") or part:IsA("MeshPart") then
			if part.Name ~= "HumanoidRootPart" then
				local tween = TweenService:Create(part, tweenInfo, {Transparency = targetTransparency})
				table.insert(tweens, tween)
				tween:Play()
			end
		elseif part:IsA("Decal") and part.Name == "face" then
			local tween = TweenService:Create(part, tweenInfo, {Transparency = targetTransparency})
			table.insert(tweens, tween)
			tween:Play()
		end
	end

	playerActiveTweens[playerId] = tweens

	for _, tween in ipairs(tweens) do
		tween.Completed:Wait()
	end

	playerActiveTweens[playerId] = nil
end

local function makeVisible(player: Player, character: Model)
	if not playerInvisibleState[player.UserId] then
		return
	end

	playerInvisibleState[player.UserId] = false

	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid and humanoid:IsA("Humanoid") then
		local originalSpeed = playerOriginalSpeed[player.UserId] or 34
		humanoid.WalkSpeed = originalSpeed
	end

	task.spawn(fadeInvisibility, character, 0, player.UserId)

	if playerUnequipConnections[player.UserId] then
		playerUnequipConnections[player.UserId]:Disconnect()
		playerUnequipConnections[player.UserId] = nil
	end
end

function InvisibilityTool.OnExecution(player: Player, character: Model, tool: Tool)
	if playerCooldowns[player.UserId] then
		return
	end

	playerCooldowns[player.UserId] = true

	local currentState = playerInvisibleState[player.UserId] or false
	local newState = not currentState
	playerInvisibleState[player.UserId] = newState

	local targetTransparency = newState and 1 or 0
	task.spawn(fadeInvisibility, character, targetTransparency, player.UserId)

	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid and humanoid:IsA("Humanoid") then
		if newState then
			playerOriginalSpeed[player.UserId] = humanoid.WalkSpeed
			humanoid.WalkSpeed = humanoid.WalkSpeed * SPEED_MULTIPLIER
		else
			local originalSpeed = playerOriginalSpeed[player.UserId] or 34
			humanoid.WalkSpeed = originalSpeed
		end
	end

	if newState then
		if playerUnequipConnections[player.UserId] then
			playerUnequipConnections[player.UserId]:Disconnect()
		end

		playerUnequipConnections[player.UserId] = tool.Unequipped:Connect(function()
			makeVisible(player, character)
		end)
	else
		if playerUnequipConnections[player.UserId] then
			playerUnequipConnections[player.UserId]:Disconnect()
			playerUnequipConnections[player.UserId] = nil
		end
	end

	task.wait(COOLDOWN_TIME)
	playerCooldowns[player.UserId] = nil
end

return InvisibilityTool