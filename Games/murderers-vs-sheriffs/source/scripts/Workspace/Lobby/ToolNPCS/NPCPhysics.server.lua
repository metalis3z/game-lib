local toolNPCS = script.Parent

local function isDisplayPart(part, npc)
	local cursor = part.Parent
	while cursor and cursor ~= npc do
		if cursor:GetAttribute("ToolNPCDisplay") or cursor.Name:lower():find("display") then
			return true
		end
		cursor = cursor.Parent
	end
	return false
end

local function isBillboardPart(part)
	return part.Name == "Billboard" or part:FindFirstChildWhichIsA("BillboardGui") ~= nil or part:FindFirstChildWhichIsA("SurfaceGui") ~= nil
end

local function prepareBillboard(part)
	part.Anchored = true
	part.CanCollide = false
	part.CanTouch = false
	part.CanQuery = false
	part.Massless = true
	for _, gui in ipairs(part:GetChildren()) do
		if gui:IsA("BillboardGui") then
			gui.Enabled = true
			gui.Adornee = part
			gui.AlwaysOnTop = true
		elseif gui:IsA("SurfaceGui") then
			gui.Enabled = true
			gui.Adornee = part
		end
	end
end

local function configureNPC(npc)
	local humanoid = npc:FindFirstChildWhichIsA("Humanoid")
	if not humanoid then
		return
	end

	local root = npc:FindFirstChild("HumanoidRootPart")
	if root and root:IsA("BasePart") then
		root.Anchored = true
		root.CanCollide = false
		root.CanTouch = false
		root.CanQuery = false
		root.Massless = true
	end

	for _, inst in ipairs(npc:GetDescendants()) do
		if inst:IsA("BasePart") then
			if inst == root then
				-- Root is handled above.
			elseif isBillboardPart(inst) then
				prepareBillboard(inst)
			elseif isDisplayPart(inst, npc) then
				inst.Anchored = true
				inst.CanCollide = false
				inst.CanTouch = false
				inst.CanQuery = false
				inst.Massless = true
			else
				-- Animated rig parts stay unanchored so Motor6D animations can play.
				inst.Anchored = false
				inst.CanCollide = false
				inst.CanTouch = false
				inst.Massless = true
			end
		end
	end

	humanoid.PlatformStand = false
	humanoid.AutoRotate = false
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.JumpHeight = 0
end

for _, npc in ipairs(toolNPCS:GetChildren()) do
	if npc:IsA("Model") then
		configureNPC(npc)
	end
end

toolNPCS.ChildAdded:Connect(function(child)
	if child:IsA("Model") then
		task.defer(configureNPC, child)
	end
end)
