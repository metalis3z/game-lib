local v3 = game.Players.LocalPlayer
local v4 = v3.Character or v3.CharacterAdded:Wait()
local v6 = v4:WaitForChild("HumanoidRootPart")
local v7 = 2
local v10 = game:GetService("RunService")
local v12 = {}
local v13 = workspace.CurrentCamera

local function updateModelLocalTransparency_1(p1)
	--print("Updating transparency for model:", p1.Name)
	local v15 = v6
	if not v15 then
		--print("No v6 found.")
		return
	end
	for v18, v25 in pairs(v12) do
		if p1 == v18 then
			--print("Found matching model in v12.")
			local v21 = p1:FindFirstChild("Humanoid")
			if v21 and v13.CameraSubject == v21 then
				--print("CameraSubject is the same as Humanoid, returning.")
				return
			end
			local v23 = p1.PrimaryPart
			if not v23 or not v23:IsA("BasePart") then
				--print("PrimaryPart is not valid.")
				return
			end

			local isWithinRange = false
			for _, descendant in ipairs(v25) do
				if descendant:IsA("BasePart") then
					v23 = descendant
					break
				end
			end

			if not v23 or not v23:IsA("BasePart") then
				--print("No valid BasePart found among descendants.")
				return
			end

			if v7 == 1 then
				isWithinRange = false
			elseif v7 == 3 then
				isWithinRange = true
			elseif v7 == 2 then
				local distX = (v6.Position.X - v23.Position.X) ^ 2
				local distZ = (v6.Position.Z - v23.Position.Z) ^ 2
				local distance = math.sqrt(distX + distZ)
				if distance <= 20 then
					isWithinRange = true
				end
			end

			for _, part : Instance in ipairs(v25) do
				game:GetService("TweenService"):Create(part, TweenInfo.new(0.1), {LocalTransparencyModifier = isWithinRange and 1 or 0}):Play()
			end
			return
		end
	end
end

local function indexModel_1(p3)
	if not p3:IsA("Model") then
		return
	end
	if p3 ~= v4 and not p3.Name:find(v3.Name) then
		local descendants = p3:GetDescendants()
		local partsAndDecals = {}
		for _, desc in ipairs(descendants) do
			if desc:IsA("BasePart") or desc:IsA("Decal") then
				table.insert(partsAndDecals, desc)
			end
		end
		v12[p3] = partsAndDecals

		p3.DescendantAdded:Connect(function(p4)
			if p4:IsA("BasePart") or p4:IsA("Decal") then
				table.insert(v12[p3], p4)
				updateModelLocalTransparency_1(p3)
			end
		end)

		p3.AncestryChanged:Connect(function()
			if not p3:IsDescendantOf(game) then
				v12[p3] = nil
			end
		end)

		updateModelLocalTransparency_1(p3)
	end
end

v13:GetPropertyChangedSignal("CameraSubject"):Connect(function()
	task.wait(0.1)
	for model in pairs(v12) do
		updateModelLocalTransparency_1(model)
	end
end)

for _, player in ipairs(game.Players:GetPlayers()) do
	if player.Character then
		indexModel_1(player.Character)
	end
	player.CharacterAdded:Connect(indexModel_1)
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(indexModel_1)
end)

for _, buddy in ipairs(workspace.Buddies:GetChildren()) do
	indexModel_1(buddy)
end

workspace.Buddies.ChildAdded:Connect(indexModel_1)

v3.CharacterAdded:Connect(function(p6)
	v4 = p6
	v6 = v4:WaitForChild("HumanoidRootPart")
end)

script.UpdHidden.Event:Connect(function(p7)
	v7 = p7
	for model in pairs(v12) do
		updateModelLocalTransparency_1(model)
	end
end)

while true do
	pcall(function()
		while true do
			task.wait(0.2)
			if v7 == 2 then
				for model in pairs(v12) do
					updateModelLocalTransparency_1(model)
				end
			end
		end
	end)
end
