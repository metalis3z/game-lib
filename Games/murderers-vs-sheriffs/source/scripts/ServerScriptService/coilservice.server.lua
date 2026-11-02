local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local templates = ServerStorage:WaitForChild("ToolTemplates")

local COILS = {
	SpeedCoil = {
		product = "SpeedCoil",
		color = Color3.fromRGB(255, 40, 40),
		walkSpeed = 24,
	},
	GravityCoil = {
		product = "GravityCoil",
		color = Color3.fromRGB(55, 145, 255),
		gravityReduction = 0.45,
	},
	SuperCoil = {
		product = "SuperCoil",
		color = Color3.fromRGB(170, 75, 255),
		walkSpeed = 24,
		gravityReduction = 0.45,
	},
}

local activeSpeed = {}
local activeGravity = {}

local function getProductValue(player, productName)
	local products = player:FindFirstChild("Products")
	return products and products:FindFirstChild(productName)
end

local function ownsCoil(player, coilName)
	local def = COILS[coilName]
	local value = def and getProductValue(player, def.product)
	return value and value.Value == true
end

local function isTemporaryTool(tool)
	return tool:GetAttribute("TemporarySpinReward") == true
end

local function isToolAllowed(player, tool)
	return player and tool and (ownsCoil(player, tool.Name) or isTemporaryTool(tool))
end

local function collectPermanentTools(container, toolName, output)
	if not container then
		return output
	end
	for _, child in ipairs(container:GetChildren()) do
		if child:IsA("Tool") and child.Name == toolName and not isTemporaryTool(child) then
			table.insert(output, child)
		end
	end
	return output
end

local function destroyExtras(tools, keep)
	for _, tool in ipairs(tools) do
		if tool ~= keep and tool.Parent then
			tool:Destroy()
		end
	end
end

local function clonePermanentTool(container, toolName)
	if not container then
		return nil
	end
	local template = templates:FindFirstChild(toolName)
	if not template then
		return nil
	end
	local clone = template:Clone()
	clone.CanBeDropped = false
	clone:SetAttribute("GamepassTool", true)
	clone.Parent = container
	return clone
end

local function syncCoilTool(player, toolName)
	local backpack = player:FindFirstChildOfClass("Backpack")
	local starterGear = player:FindFirstChild("StarterGear")
	local character = player.Character

	local activeTools = {}
	collectPermanentTools(character, toolName, activeTools)
	collectPermanentTools(backpack, toolName, activeTools)

	local starterTools = {}
	collectPermanentTools(starterGear, toolName, starterTools)

	if ownsCoil(player, toolName) then
		local activeKeep = activeTools[1]
		if not activeKeep then
			activeKeep = clonePermanentTool(backpack, toolName)
		end
		destroyExtras(activeTools, activeKeep)

		local starterKeep = starterTools[1]
		if not starterKeep then
			starterKeep = clonePermanentTool(starterGear, toolName)
		end
		destroyExtras(starterTools, starterKeep)
	else
		destroyExtras(activeTools, nil)
		destroyExtras(starterTools, nil)
	end
end

local function getRightArm(character)
	return character and (character:FindFirstChild("RightLowerArm") or character:FindFirstChild("Right Arm") or character:FindFirstChild("RightHand"))
end

local function removeWearable(character, toolName)
	local wearable = character and character:FindFirstChild("Equipped" .. toolName .. "Visual")
	if wearable then
		wearable:Destroy()
	end
end

local function prepareVisualPart(part)
	part.Anchored = false
	part.CanCollide = false
	part.CanTouch = false
	part.CanQuery = false
	part.Massless = true
end

local function createWearable(character, toolName)
	local arm = getRightArm(character)
	local template = templates:FindFirstChild(toolName)
	local sourceVisual = template and template:FindFirstChild("ArmVisual")
	if not arm or not sourceVisual or character:FindFirstChild("Equipped" .. toolName .. "Visual") then
		return
	end

	local visual = sourceVisual:Clone()
	visual.Name = "Equipped" .. toolName .. "Visual"
	visual.Parent = character
	visual:PivotTo(arm.CFrame)

	for _, descendant in ipairs(visual:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Transparency = 0
			prepareVisualPart(descendant)
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = arm
			weld.Part1 = descendant
			weld.Parent = descendant
		end
	end
end

local function setHeldToolVisible(tool, visible)
	for _, descendant in ipairs(tool:GetDescendants()) do
		if descendant:IsA("BasePart") and descendant.Name ~= "Handle" then
			descendant.Transparency = visible and 0 or 1
		end
	end
end

local function clearSpeed(player, toolName)
	local state = activeSpeed[player]
	if not state or state.toolName ~= toolName then
		return
	end
	if state.connection then
		state.connection:Disconnect()
	end
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid and humanoid.WalkSpeed == state.appliedSpeed then
		humanoid.WalkSpeed = state.originalSpeed
	end
	activeSpeed[player] = nil
end

local function applySpeed(player, toolName)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	local def = COILS[toolName]
	if not humanoid or not def then
		return
	end
	clearSpeed(player, toolName)

	local state = {
		toolName = toolName,
		originalSpeed = humanoid.WalkSpeed,
		appliedSpeed = def.walkSpeed,
	}
	activeSpeed[player] = state

	local applying = false
	local function enforceSpeed()
		if applying or activeSpeed[player] ~= state then
			return
		end
		local character = player.Character
		if not character or not character:FindFirstChild(toolName) then
			return
		end
		if humanoid.Parent and humanoid.Health > 0 and humanoid.WalkSpeed < state.appliedSpeed then
			applying = true
			humanoid.WalkSpeed = state.appliedSpeed
			applying = false
		end
	end

	state.connection = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(enforceSpeed)
	enforceSpeed()
end

local function clearGravity(player, toolName)
	local state = activeGravity[player]
	if not state or state.toolName ~= toolName then
		return
	end
	if state.force then
		state.force:Destroy()
	end
	if state.attachment then
		state.attachment:Destroy()
	end
	activeGravity[player] = nil
end

local function applyGravity(player, toolName)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local def = COILS[toolName]
	if not root or not def then
		return
	end
	clearGravity(player, toolName)

	local attachment = Instance.new("Attachment")
	attachment.Name = "GravityCoilLiftAttachment"
	attachment.Parent = root

	local force = Instance.new("VectorForce")
	force.Name = "GravityCoilLift"
	force.Attachment0 = attachment
	force.RelativeTo = Enum.ActuatorRelativeTo.World
	force.ApplyAtCenterOfMass = true
	force.Force = Vector3.new(0, root.AssemblyMass * workspace.Gravity * def.gravityReduction, 0)
	force.Parent = root

	activeGravity[player] = {
		toolName = toolName,
		attachment = attachment,
		force = force,
	}
end

local function clearEffects(player, toolName, tool)
	local character = player.Character
	if character then
		removeWearable(character, toolName)
	end
	if tool and tool.Parent then
		setHeldToolVisible(tool, true)
	end
	clearSpeed(player, toolName)
	clearGravity(player, toolName)
end

local function applyEffects(player, tool)
	if not isToolAllowed(player, tool) then
		return
	end
	local toolName = tool.Name
	local character = player.Character
	if not character then
		return
	end
	local def = COILS[toolName]
	setHeldToolVisible(tool, false)
	createWearable(character, toolName)
	if def.walkSpeed then
		applySpeed(player, toolName)
	end
	if def.gravityReduction then
		applyGravity(player, toolName)
	end
end

local function hookTool(tool)
	if tool:GetAttribute("CoilToolHooked") or not COILS[tool.Name] then
		return
	end
	tool:SetAttribute("CoilToolHooked", true)
	tool.Equipped:Connect(function()
		local character = tool.Parent
		local player = character and Players:GetPlayerFromCharacter(character)
		applyEffects(player, tool)
	end)
	tool.Unequipped:Connect(function()
		local character = tool.Parent
		local player = character and Players:GetPlayerFromCharacter(character)
		if not player then
			for _, candidate in ipairs(Players:GetPlayers()) do
				if candidate.Character and candidate.Character:FindFirstChild(tool.Name) == tool then
					player = candidate
					break
				end
			end
		end
		if player then
			clearEffects(player, tool.Name, tool)
		end
	end)
end

local function hookContainer(container)
	if not container then
		return
	end
	for _, child in ipairs(container:GetChildren()) do
		if child:IsA("Tool") then
			hookTool(child)
		end
	end
	container.ChildAdded:Connect(function(child)
		if child:IsA("Tool") then
			hookTool(child)
		end
	end)
end

local function watchPlayer(player)
	local function connectProducts()
		local products = player:FindFirstChild("Products") or player:WaitForChild("Products", 10)
		if not products then
			return
		end
		for toolName, def in pairs(COILS) do
			local value = products:FindFirstChild(def.product) or products:WaitForChild(def.product, 10)
			if value then
				value.Changed:Connect(function()
					syncCoilTool(player, toolName)
				end)
				syncCoilTool(player, toolName)
			end
		end
	end

	player.ChildAdded:Connect(function(child)
		if child.Name == "Products" then
			task.spawn(connectProducts)
		end
	end)
	player.CharacterAdded:Connect(function(character)
		hookContainer(character)
		character.ChildRemoved:Connect(function(child)
			if child:IsA("Tool") and COILS[child.Name] then
				clearEffects(player, child.Name, child)
			end
		end)
		task.defer(function()
			if player.Parent then
				for toolName in pairs(COILS) do
					syncCoilTool(player, toolName)
				end
				hookContainer(player:FindFirstChildOfClass("Backpack"))
				hookContainer(character)
			end
		end)
	end)
	local backpack = player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack", 10)
	if backpack then
		hookContainer(backpack)
	end
	connectProducts()
end

Players.PlayerAdded:Connect(watchPlayer)
Players.PlayerRemoving:Connect(function(player)
	activeSpeed[player] = nil
	activeGravity[player] = nil
end)
for _, player in ipairs(Players:GetPlayers()) do
	watchPlayer(player)
end