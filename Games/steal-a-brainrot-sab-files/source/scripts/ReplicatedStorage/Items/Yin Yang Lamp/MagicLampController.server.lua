local tool = script.Parent
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local COOLDOWN = 240
local lastUsed = 0

tool.Activated:Connect(function(player)
	local player = Players:GetPlayerFromCharacter(tool.Parent)
	if not player then
		return
	end
	local now = os.clock()
	if now - lastUsed < COOLDOWN then
		return
	end
	lastUsed = now

	ToolsCooldown:FireClient(player, tool, COOLDOWN)

	local player = Players:GetPlayerFromCharacter(tool.Parent)
	if not player then
		return
	end

	local character = player.Character
	if not character then
		return
	end

	local originalTransparencies = {}

	for _, part in pairs(character:GetChildren()) do
		if part:IsA("BasePart") then
			originalTransparencies[part] = part.Transparency
		elseif part:IsA("Accessory") then
			local handle = part:FindFirstChild("Handle")
			if handle then
				originalTransparencies[handle] = handle.Transparency
			end
		elseif part:IsA("Tool") then
			for _, toolPart in pairs(part:GetChildren()) do
				if toolPart:IsA("BasePart") then
					originalTransparencies[toolPart] = toolPart.Transparency
				end
			end
		end
	end

	local head = character:FindFirstChild("Head")
	if head then
		local face = head:FindFirstChild("face")
		if face and face:IsA("Decal") then
			originalTransparencies[face] = face.Transparency
		end
	end

	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	for _, part in pairs(character:GetChildren()) do
		if part:IsA("BasePart") then
			local tween = TweenService:Create(part, tweenInfo, {Transparency = 1})
			tween:Play()
		elseif part:IsA("Accessory") then
			local handle = part:FindFirstChild("Handle")
			if handle then
				local tween = TweenService:Create(handle, tweenInfo, {Transparency = 1})
				tween:Play()
			end
		elseif part:IsA("Tool") then
			for _, toolPart in pairs(part:GetChildren()) do
				if toolPart:IsA("BasePart") then
					local tween = TweenService:Create(toolPart, tweenInfo, {Transparency = 1})
					tween:Play()
				end
			end
		end
	end

	if head then
		for _, child in pairs(head:GetChildren()) do
			if child:IsA("Decal") and child.Name == "face" then
				local tween = TweenService:Create(child, tweenInfo, {Transparency = 1})
				tween:Play()
			end
		end
	end

	task.wait(2.5)

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end

	local plot = nil
	if _G.playerPlots and _G.playerPlots[player.UserId] then
		plot = _G.playerPlots[player.UserId]
	else
		local plots = workspace:FindFirstChild("Plots")
		if plots then
			for _, p in pairs(plots:GetChildren()) do
				if p:GetAttribute("Player") == player.Name then
					plot = p
					break
				end
			end
		end
	end

	if not plot then
		return
	end

	local purchases = plot:FindFirstChild("Purchases")
	if not purchases then
		return
	end

	local plotBlock = purchases:FindFirstChild("PlotBlock")
	if not plotBlock then
		return
	end

	local plotBlockPosition = plotBlock:GetPivot().Position
	local teleportPosition = plotBlockPosition + Vector3.new(0, 3.5, 0)

	humanoidRootPart.CFrame = CFrame.new(teleportPosition) * CFrame.Angles(0, math.rad(-90), 0)

	local sound = tool.Handle:FindFirstChild("Magic Lamp")
	if sound then
		sound:Play()
	end

	for part, originalTransparency in pairs(originalTransparencies) do
		if part and part.Parent then
			part.Transparency = originalTransparency
		end
	end
end)