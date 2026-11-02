--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local Tool = script.Parent

local COOLDOWN_TIME = 30
local DURATION = 15
local SCALE_MULTIPLIER = 2.5
local SPEED_BOOST = 24
local ANIMATION_TIME = 1

local lastUse = {}

local scaleValuesNames = {
	"BodyDepthScale",
	"BodyHeightScale",
	"BodyWidthScale",
	"HeadScale",
}

local function smoothScale(
	humanoid: Humanoid,
	rootPart: BasePart,
	targetScaleDict: { [NumberValue]: number },
	duration: number,
	targetHipHeight: number
): ()
	local steps = 30
	local stepTime = duration / steps
	local startScales: { [NumberValue]: number } = {}

	for scaleObj in pairs(targetScaleDict) do
		startScales[scaleObj] = scaleObj.Value
	end

	local startHipHeight = humanoid.HipHeight
	local startYPosition = rootPart.Position.Y
	local heightDifference = targetHipHeight - startHipHeight

	for i = 1, steps do
		if not (humanoid and humanoid.Parent) then break end

		local alpha = i / steps
		local easeAlpha = alpha < 0.5
			and 2 * alpha * alpha
			or 1 - (-2 * alpha + 2) ^ 2 / 2

		local desiredHip = startHipHeight + (targetHipHeight - startHipHeight) * easeAlpha

		for scaleObj, targetVal in pairs(targetScaleDict) do
			if scaleObj and scaleObj.Parent then
				scaleObj.Value = startScales[scaleObj] + (targetVal - startScales[scaleObj]) * easeAlpha
			end
		end

		humanoid.HipHeight = desiredHip

		local yOffset = heightDifference * easeAlpha
		rootPart.CFrame = CFrame.new(
			rootPart.Position.X,
			startYPosition + yOffset,
			rootPart.Position.Z
		) * (rootPart.CFrame - rootPart.Position)

		task.wait(stepTime)
	end

	if humanoid and humanoid.Parent then
		for scaleObj, targetVal in pairs(targetScaleDict) do
			if scaleObj and scaleObj.Parent then
				scaleObj.Value = targetVal
			end
		end
		humanoid.HipHeight = targetHipHeight
		rootPart.CFrame = CFrame.new(
			rootPart.Position.X,
			startYPosition + heightDifference,
			rootPart.Position.Z
		) * (rootPart.CFrame - rootPart.Position)
	end
end

Tool.Activated:Connect(function()
	local character = Tool.Parent
	local player = Players:GetPlayerFromCharacter(character)

	if not player then return end

	local userId = player.UserId
	local currentTime = os.clock()

	if lastUse[userId] and (currentTime - lastUse[userId]) < COOLDOWN_TIME then
		return
	end

	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?

	if not humanoid or humanoid.Health <= 0 or not rootPart then return end
	if humanoid.RigType == Enum.HumanoidRigType.R6 then return end
	if character:GetAttribute("IsGiant") then return end

	character:SetAttribute("IsGiant", true)
	character:SetAttribute("GiantScale", SCALE_MULTIPLIER)

	lastUse[userId] = currentTime
	ToolsCooldown:FireClient(player, Tool, COOLDOWN_TIME)

	local handle = Tool:FindFirstChild("Handle")
	if handle then
		local sound = handle:FindFirstChild("Drink") or handle:FindFirstChild("Scream")
		if sound then
			(sound :: Sound):Play()
		end
	end

	local highlight = Instance.new("Highlight")
	highlight.Name = "GiantEffect"
	highlight.FillTransparency = 1
	highlight.OutlineColor = Color3.fromRGB(85, 255, 127)
	highlight.OutlineTransparency = 0
	highlight.Parent = character

	local originalScales: { [NumberValue]: number } = {}
	local targetBigScales: { [NumberValue]: number } = {}

	for _, name in ipairs(scaleValuesNames) do
		local val = humanoid:FindFirstChild(name)
		if val and val:IsA("NumberValue") then
			originalScales[val] = val.Value
			local mult = if name == "HeadScale" then SCALE_MULTIPLIER * 0.8 else SCALE_MULTIPLIER
			targetBigScales[val] = val.Value * mult
		end
	end

	local originalHipHeight = humanoid.HipHeight
	local targetHipHeight = originalHipHeight * SCALE_MULTIPLIER
	local originalSpeed = humanoid.WalkSpeed

	humanoid.WalkSpeed = SPEED_BOOST
	humanoid:UnequipTools()

	character:SetAttribute("NewHipHeight", targetHipHeight)

	smoothScale(humanoid, rootPart, targetBigScales, ANIMATION_TIME, targetHipHeight)

	task.wait(math.max(0, DURATION - ANIMATION_TIME * 2))


	if character and character.Parent and humanoid and humanoid.Health > 0 then
		smoothScale(humanoid, rootPart, originalScales, ANIMATION_TIME, originalHipHeight)

		humanoid.WalkSpeed = originalSpeed
		character:SetAttribute("NewHipHeight", nil)

		for scaleObj, originalVal in pairs(originalScales) do
			if scaleObj and scaleObj.Parent then
				scaleObj.Value = originalVal
			end
		end
	else
		humanoid.WalkSpeed = originalSpeed
		character:SetAttribute("NewHipHeight", nil)
		for scaleObj, originalVal in pairs(originalScales) do
			if scaleObj and scaleObj.Parent then
				scaleObj.Value = originalVal
			end
		end
	end

	highlight:Destroy()
	character:SetAttribute("IsGiant", nil)
	character:SetAttribute("GiantScale", nil)
end)

Players.PlayerRemoving:Connect(function(player)
	lastUse[player.UserId] = nil
end)