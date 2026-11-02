--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerValues = ReplicatedStorage.ServerValues
local KingFruitID = ServerValues.KingFruitID
local KingEnabled = ServerValues.KingEnabled
local Gardens = workspace:WaitForChild("Gardens")
local t = {}
local t2 = {
	StartOrder = 3
}

for v1, v2 in require(ReplicatedStorage.SharedModules.SeedData) do
	local v3 = v2.SeedName or v2.PlantName

	if v2.IsSingleHarvest then
		t[v3] = true
	end
end

local v4 = nil
local v5 = nil
local v6 = 0
local v7 = 0

local function cleanupHighlight() --[[ cleanupHighlight | Line: 28 | Upvalues: v6 (ref), v4 (ref), v5 (ref) ]]
	v6 = v6 + 1

	if v4 then
		v4:Destroy()
		v4 = nil
	end

	if not v5 then
		return
	end

	v5:Destroy()
	v5 = nil
end

local function cleanupAll() --[[ cleanupAll | Line: 40 | Upvalues: v6 (ref), v4 (ref), v5 (ref), v7 (ref) ]]
	v6 = v6 + 1

	if v4 then
		v4:Destroy()
		v4 = nil
	end

	if v5 then
		v5:Destroy()
		v5 = nil
	end

	v7 = v7 + 1
end

local function getVisibleCenter(p1) --[[ getVisibleCenter | Line: 45 ]]
	local count = 0
	local sum = Vector3.new(0, 0, 0)

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and v2.Transparency < 1 then
			sum = sum + v2.Position
			count = count + 1
		end
	end

	if count == 0 then
		return nil
	end

	return sum / count
end

local function assignKingFruit(p1) --[[ assignKingFruit | Line: 58 | Upvalues: v6 (ref), v4 (ref), v5 (ref), getVisibleCenter (copy) ]]
	v6 = v6 + 1

	if v4 then
		v4:Destroy()
		v4 = nil
	end

	local v1

	if v5 then
		v5:Destroy()
		v5 = nil
	end

	v6 = v6 + 1
	v1 = v6
	task.spawn(function() --[[ Line: 64 | Upvalues: v1 (copy), v6 (ref), getVisibleCenter (ref), p1 (copy), v4 (ref), v5 (ref) ]]
		local v12 = nil

		while v1 == v6 do
			local v2 = getVisibleCenter(p1)

			v12 = v2

			if v2 then
				break
			end

			if not p1.Parent then
				return
			end

			task.wait(0.1)
		end

		if v1 ~= v6 then
			return
		end

		v4 = Instance.new("Highlight")
		v4.FillTransparency = 0.25
		v4.OutlineTransparency = 0.5
		v4.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		v4.FillColor = Color3.new(1, 0.784314, 0)
		v4.OutlineColor = Color3.new(1, 0.784314, 0)
		v4.Adornee = p1
		v4.Name = "KingHighlight"
		v4.Parent = p1
		v5 = script.attRef:Clone()
		v5.Parent = p1
		v5.WorldCFrame = CFrame.new(v12)

		local CurrentCamera = workspace.CurrentCamera

		while v1 == v6 do
			local Position = CurrentCamera.CFrame.Position

			if not (p1.Parent and p1.PrimaryPart) then
				break
			end

			local Position2 = p1.PrimaryPart.Position
			local v3 = Vector3.new(Position.X, 0, Position.Z)
			local v42 = (v3 - Vector3.new(Position2.X, 0, Position2.Z)).Magnitude < 200

			v4.Enabled = v42
			v5.BillboardGui.Enabled = v42
			task.wait()
		end
	end)
end

local function updateKingFruit() --[[ updateKingFruit | Line: 102 | Upvalues: KingEnabled (copy), v6 (ref), v4 (ref), v5 (ref), v7 (ref), KingFruitID (copy), Gardens (copy), t (copy), getVisibleCenter (copy) ]]
	if KingEnabled.Value then
		v7 = v7 + 1

		local v1 = v7
		local v2 = KingFruitID.Value

		task.spawn(function() --[[ Line: 112 | Upvalues: v1 (copy), v7 (ref), Gardens (ref), t (ref), v2 (copy), v6 (ref), v4 (ref), v5 (ref), getVisibleCenter (ref) ]]
			while v1 == v7 do
				for v12, v22 in Gardens:GetChildren() do
					for v3, v42 in v22.Plants:GetChildren() do
						if not t[v42.Name] then
							local Fruits = v42:FindFirstChild("Fruits")

							if Fruits then
								for v52, v62 in Fruits:GetChildren() do
									if v62:GetAttribute("FruitId") == v2 then
										v6 = v6 + 1

										if v4 then
											v4:Destroy()
											v4 = nil
										end

										local v72

										if not v5 then
											v6 = v6 + 1
											v72 = v6
											task.spawn(function() --[[ Line: 64 | Upvalues: v72 (copy), v6 (ref), getVisibleCenter (ref), v62 (copy), v4 (ref), v5 (ref) ]]
												local v12 = nil

												while v72 == v6 do
													local v2 = getVisibleCenter(v62)

													v12 = v2

													if v2 then
														break
													end

													if not v62.Parent then
														return
													end

													task.wait(0.1)
												end

												if v72 ~= v6 then
													return
												end

												v4 = Instance.new("Highlight")
												v4.FillTransparency = 0.25
												v4.OutlineTransparency = 0.5
												v4.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
												v4.FillColor = Color3.new(1, 0.784314, 0)
												v4.OutlineColor = Color3.new(1, 0.784314, 0)
												v4.Adornee = v62
												v4.Name = "KingHighlight"
												v4.Parent = v62
												v5 = script.attRef:Clone()
												v5.Parent = v62
												v5.WorldCFrame = CFrame.new(v12)

												local CurrentCamera = workspace.CurrentCamera

												while v72 == v6 do
													local Position = CurrentCamera.CFrame.Position

													if not (v62.Parent and v62.PrimaryPart) then
														break
													end

													local Position2 = v62.PrimaryPart.Position
													local v3 = Vector3.new(Position.X, 0, Position.Z)
													local v42 = (v3 - Vector3.new(Position2.X, 0, Position2.Z)).Magnitude < 200

													v4.Enabled = v42
													v5.BillboardGui.Enabled = v42
													task.wait()
												end
											end)

											return
										end

										v5:Destroy()
										v5 = nil
										v6 = v6 + 1
										v72 = v6
										task.spawn(function() --[[ Line: 64 | Upvalues: v72 (copy), v6 (ref), getVisibleCenter (ref), v62 (copy), v4 (ref), v5 (ref) ]]
											local v12 = nil

											while v72 == v6 do
												local v2 = getVisibleCenter(v62)

												v12 = v2

												if v2 then
													break
												end

												if not v62.Parent then
													return
												end

												task.wait(0.1)
											end

											if v72 ~= v6 then
												return
											end

											v4 = Instance.new("Highlight")
											v4.FillTransparency = 0.25
											v4.OutlineTransparency = 0.5
											v4.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
											v4.FillColor = Color3.new(1, 0.784314, 0)
											v4.OutlineColor = Color3.new(1, 0.784314, 0)
											v4.Adornee = v62
											v4.Name = "KingHighlight"
											v4.Parent = v62
											v5 = script.attRef:Clone()
											v5.Parent = v62
											v5.WorldCFrame = CFrame.new(v12)

											local CurrentCamera = workspace.CurrentCamera

											while v72 == v6 do
												local Position = CurrentCamera.CFrame.Position

												if not (v62.Parent and v62.PrimaryPart) then
													break
												end

												local Position2 = v62.PrimaryPart.Position
												local v3 = Vector3.new(Position.X, 0, Position.Z)
												local v42 = (v3 - Vector3.new(Position2.X, 0, Position2.Z)).Magnitude < 200

												v4.Enabled = v42
												v5.BillboardGui.Enabled = v42
												task.wait()
											end
										end)

										return
									end
								end
							end
						end
					end
				end

				task.wait(0.5)
			end
		end)

		return
	end

	v6 = v6 + 1

	if v4 then
		v4:Destroy()
		v4 = nil
	end

	if not v5 then
		v7 = v7 + 1

		return
	end

	v5:Destroy()
	v5 = nil
	v7 = v7 + 1
end

function t2.Init(p1) --[[ Init | Line: 134 | Upvalues: KingEnabled (copy), v6 (ref), v4 (ref), v5 (ref), v7 (ref), KingFruitID (copy), Gardens (copy), t (copy), getVisibleCenter (copy), updateKingFruit (copy) ]]
	if KingEnabled.Value then
		if KingEnabled.Value then
			v7 = v7 + 1

			local v1 = v7
			local v2 = KingFruitID.Value

			task.spawn(function() --[[ Line: 112 | Upvalues: v1 (copy), v7 (ref), Gardens (ref), t (ref), v2 (copy), v6 (ref), v4 (ref), v5 (ref), getVisibleCenter (ref) ]]
				while v1 == v7 do
					for v12, v22 in Gardens:GetChildren() do
						for v3, v42 in v22.Plants:GetChildren() do
							if not t[v42.Name] then
								local Fruits = v42:FindFirstChild("Fruits")

								if Fruits then
									for v52, v62 in Fruits:GetChildren() do
										if v62:GetAttribute("FruitId") == v2 then
											v6 = v6 + 1

											if v4 then
												v4:Destroy()
												v4 = nil
											end

											local v72

											if not v5 then
												v6 = v6 + 1
												v72 = v6
												task.spawn(function() --[[ Line: 64 | Upvalues: v72 (copy), v6 (ref), getVisibleCenter (ref), v62 (copy), v4 (ref), v5 (ref) ]]
													local v12 = nil

													while v72 == v6 do
														local v2 = getVisibleCenter(v62)

														v12 = v2

														if v2 then
															break
														end

														if not v62.Parent then
															return
														end

														task.wait(0.1)
													end

													if v72 ~= v6 then
														return
													end

													v4 = Instance.new("Highlight")
													v4.FillTransparency = 0.25
													v4.OutlineTransparency = 0.5
													v4.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
													v4.FillColor = Color3.new(1, 0.784314, 0)
													v4.OutlineColor = Color3.new(1, 0.784314, 0)
													v4.Adornee = v62
													v4.Name = "KingHighlight"
													v4.Parent = v62
													v5 = script.attRef:Clone()
													v5.Parent = v62
													v5.WorldCFrame = CFrame.new(v12)

													local CurrentCamera = workspace.CurrentCamera

													while v72 == v6 do
														local Position = CurrentCamera.CFrame.Position

														if not (v62.Parent and v62.PrimaryPart) then
															break
														end

														local Position2 = v62.PrimaryPart.Position
														local v3 = Vector3.new(Position.X, 0, Position.Z)
														local v42 = (v3 - Vector3.new(Position2.X, 0, Position2.Z)).Magnitude < 200

														v4.Enabled = v42
														v5.BillboardGui.Enabled = v42
														task.wait()
													end
												end)

												return
											end

											v5:Destroy()
											v5 = nil
											v6 = v6 + 1
											v72 = v6
											task.spawn(function() --[[ Line: 64 | Upvalues: v72 (copy), v6 (ref), getVisibleCenter (ref), v62 (copy), v4 (ref), v5 (ref) ]]
												local v12 = nil

												while v72 == v6 do
													local v2 = getVisibleCenter(v62)

													v12 = v2

													if v2 then
														break
													end

													if not v62.Parent then
														return
													end

													task.wait(0.1)
												end

												if v72 ~= v6 then
													return
												end

												v4 = Instance.new("Highlight")
												v4.FillTransparency = 0.25
												v4.OutlineTransparency = 0.5
												v4.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
												v4.FillColor = Color3.new(1, 0.784314, 0)
												v4.OutlineColor = Color3.new(1, 0.784314, 0)
												v4.Adornee = v62
												v4.Name = "KingHighlight"
												v4.Parent = v62
												v5 = script.attRef:Clone()
												v5.Parent = v62
												v5.WorldCFrame = CFrame.new(v12)

												local CurrentCamera = workspace.CurrentCamera

												while v72 == v6 do
													local Position = CurrentCamera.CFrame.Position

													if not (v62.Parent and v62.PrimaryPart) then
														break
													end

													local Position2 = v62.PrimaryPart.Position
													local v3 = Vector3.new(Position.X, 0, Position.Z)
													local v42 = (v3 - Vector3.new(Position2.X, 0, Position2.Z)).Magnitude < 200

													v4.Enabled = v42
													v5.BillboardGui.Enabled = v42
													task.wait()
												end
											end)

											return
										end
									end
								end
							end
						end
					end

					task.wait(0.5)
				end
			end)
		else
			v6 = v6 + 1

			if v4 then
				v4:Destroy()
				v4 = nil
			end

			if v5 then
				v5:Destroy()
				v5 = nil
			end

			v7 = v7 + 1
		end
	end

	KingFruitID:GetPropertyChangedSignal("Value"):Connect(updateKingFruit)
	Gardens.ChildAdded:Connect(updateKingFruit)
	KingEnabled:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 142 | Upvalues: KingEnabled (ref), v6 (ref), v4 (ref), v5 (ref), v7 (ref), KingFruitID (ref), Gardens (ref), t (ref), getVisibleCenter (ref) ]]
		if KingEnabled.Value and KingEnabled.Value then
			v7 = v7 + 1

			local v1 = v7
			local v2 = KingFruitID.Value

			task.spawn(function() --[[ Line: 112 | Upvalues: v1 (copy), v7 (ref), Gardens (ref), t (ref), v2 (copy), v6 (ref), v4 (ref), v5 (ref), getVisibleCenter (ref) ]]
				while v1 == v7 do
					for v12, v22 in Gardens:GetChildren() do
						for v3, v42 in v22.Plants:GetChildren() do
							if not t[v42.Name] then
								local Fruits = v42:FindFirstChild("Fruits")

								if Fruits then
									for v52, v62 in Fruits:GetChildren() do
										if v62:GetAttribute("FruitId") == v2 then
											v6 = v6 + 1

											if v4 then
												v4:Destroy()
												v4 = nil
											end

											local v72

											if not v5 then
												v6 = v6 + 1
												v72 = v6
												task.spawn(function() --[[ Line: 64 | Upvalues: v72 (copy), v6 (ref), getVisibleCenter (ref), v62 (copy), v4 (ref), v5 (ref) ]]
													local v12 = nil

													while v72 == v6 do
														local v2 = getVisibleCenter(v62)

														v12 = v2

														if v2 then
															break
														end

														if not v62.Parent then
															return
														end

														task.wait(0.1)
													end

													if v72 ~= v6 then
														return
													end

													v4 = Instance.new("Highlight")
													v4.FillTransparency = 0.25
													v4.OutlineTransparency = 0.5
													v4.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
													v4.FillColor = Color3.new(1, 0.784314, 0)
													v4.OutlineColor = Color3.new(1, 0.784314, 0)
													v4.Adornee = v62
													v4.Name = "KingHighlight"
													v4.Parent = v62
													v5 = script.attRef:Clone()
													v5.Parent = v62
													v5.WorldCFrame = CFrame.new(v12)

													local CurrentCamera = workspace.CurrentCamera

													while v72 == v6 do
														local Position = CurrentCamera.CFrame.Position

														if not (v62.Parent and v62.PrimaryPart) then
															break
														end

														local Position2 = v62.PrimaryPart.Position
														local v3 = Vector3.new(Position.X, 0, Position.Z)
														local v42 = (v3 - Vector3.new(Position2.X, 0, Position2.Z)).Magnitude < 200

														v4.Enabled = v42
														v5.BillboardGui.Enabled = v42
														task.wait()
													end
												end)

												return
											end

											v5:Destroy()
											v5 = nil
											v6 = v6 + 1
											v72 = v6
											task.spawn(function() --[[ Line: 64 | Upvalues: v72 (copy), v6 (ref), getVisibleCenter (ref), v62 (copy), v4 (ref), v5 (ref) ]]
												local v12 = nil

												while v72 == v6 do
													local v2 = getVisibleCenter(v62)

													v12 = v2

													if v2 then
														break
													end

													if not v62.Parent then
														return
													end

													task.wait(0.1)
												end

												if v72 ~= v6 then
													return
												end

												v4 = Instance.new("Highlight")
												v4.FillTransparency = 0.25
												v4.OutlineTransparency = 0.5
												v4.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
												v4.FillColor = Color3.new(1, 0.784314, 0)
												v4.OutlineColor = Color3.new(1, 0.784314, 0)
												v4.Adornee = v62
												v4.Name = "KingHighlight"
												v4.Parent = v62
												v5 = script.attRef:Clone()
												v5.Parent = v62
												v5.WorldCFrame = CFrame.new(v12)

												local CurrentCamera = workspace.CurrentCamera

												while v72 == v6 do
													local Position = CurrentCamera.CFrame.Position

													if not (v62.Parent and v62.PrimaryPart) then
														break
													end

													local Position2 = v62.PrimaryPart.Position
													local v3 = Vector3.new(Position.X, 0, Position.Z)
													local v42 = (v3 - Vector3.new(Position2.X, 0, Position2.Z)).Magnitude < 200

													v4.Enabled = v42
													v5.BillboardGui.Enabled = v42
													task.wait()
												end
											end)

											return
										end
									end
								end
							end
						end
					end

					task.wait(0.5)
				end
			end)

			return
		end

		v6 = v6 + 1

		if v4 then
			v4:Destroy()
			v4 = nil
		end

		if v5 then
			v5:Destroy()
			v5 = nil
		end

		v7 = v7 + 1
	end)
end

return t2