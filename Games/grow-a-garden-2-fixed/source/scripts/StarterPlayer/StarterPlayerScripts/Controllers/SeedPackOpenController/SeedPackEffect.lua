--credit to leon games studio
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Bezier = require(ReplicatedStorage.ClientModules.Bezier)
local Spring2 = require(ReplicatedStorage.ClientModules.Spring2)
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local CamShake = require(ReplicatedStorage.ClientModules.CamShake)
local RarityData = ReplicatedStorage.SharedModules.RarityData
local SeedPackEffects = ReplicatedStorage.Assets.SeedPackEffects

local function CreateSFX(p1, p2, p3) --[[ CreateSFX | Line: 24 | Upvalues: SoundService (copy) ]]
	local Sound = Instance.new("Sound")

	Sound.SoundId = p2
	Sound.Volume = 1
	Sound.RollOffMaxDistance = 200
	Sound.Looped = if p3 == true then true else false
	Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound.Parent = p1

	return Sound
end

local t2 = {}
local v1 = SeedPackEffects.Luck:Clone()
local Attachment = Instance.new("Attachment")

v1.Parent = Attachment
Attachment.Parent = workspace.Terrain

local v2 = RaycastParams.new()

v2.FilterDescendantsInstances = {}
v2.FilterType = Enum.RaycastFilterType.Include

local function raycastClick(p1) --[[ raycastClick | Line: 50 | Upvalues: v2 (copy) ]]
	local Position = workspace.CurrentCamera.CFrame.Position
	local v1 = game.Players.LocalPlayer:GetMouse().Hit.Position - Position

	v2.FilterDescendantsInstances = { p1 }

	return workspace:Raycast(Position, v1, v2)
end

function t.Open(p1, p2, p3, p4, p5) --[[ Open | Line: 65 | Upvalues: ReplicatedStorage (copy), t2 (copy), Spring2 (copy), SeedPackEffects (copy), SoundService (copy), Networking (copy), raycastClick (copy), Attachment (copy), v1 (copy), Bezier (copy), SeedData (copy), CamShake (copy), RarityData (copy) ]]
	local v12 = ReplicatedStorage.Assets.SeedPacks:FindFirstChild(p2)

	t2[p1] = p3

	if not v12 then
		v12 = ReplicatedStorage.Assets.SeedPacks:FindFirstChild("Normal")
			or ReplicatedStorage.Assets.SeedPacks:FindFirstChild("Common Seed Pack")
			or ReplicatedStorage.Assets.SeedPacks:GetChildren()[1]
	end

	local v2 = CFrame.new(p4, p4 + p5.LookVector * Vector3.new(1, 0, 1))
	local v3 = Spring2.new(Vector3.new(0, 0, 0))

	v3.Speed = 11
	v3.Damper = 0.85

	local v4 = v12:Clone()

	v4:PivotTo(v2)

	local v5 = RaycastParams.new()

	v5.FilterType = Enum.RaycastFilterType.Exclude
	v5.FilterDescendantsInstances = { workspace.Temporary }

	local v6 = workspace:Raycast(p5.Position, Vector3.new(-0, -7, -0), v5)

	if v6 and v6.Position then
		local v8 = Vector3.new(p5.X, v6.Position.Y + 2, p5.Z)

		p5 = CFrame.new(v8, v8 + p5.LookVector * Vector3.new(1, 0, 1))
	end

	local v9 = if SeedPackEffects:FindFirstChild(p2) then SeedPackEffects:FindFirstChild(p2):Clone() else SeedPackEffects.Attachment:Clone()
	local v10 = v2

	v9.Parent = v4.PrimaryPart or v4.Handle

	local v122 = v4:GetAttribute("Color")

	for v13, v14 in v9:GetDescendants() do
		if v14:HasTag("ColorPart") then
			v14.Color = ColorSequence.new(v122)
		end
	end

	local v15 = v4.PrimaryPart or v4:FindFirstChild("Handle")
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://73484699086664"
	Sound.Volume = 1
	Sound.RollOffMaxDistance = 200
	Sound.Looped = false
	Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound.Parent = v15

	local Sound2 = Instance.new("Sound")

	Sound2.SoundId = "rbxassetid://121908287846654"
	Sound2.Volume = 1
	Sound2.RollOffMaxDistance = 200
	Sound2.Looped = false
	Sound2.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound2.Parent = v15

	local Sound3 = Instance.new("Sound")

	Sound3.SoundId = "rbxassetid://100648776972641"
	Sound3.Volume = 1
	Sound3.RollOffMaxDistance = 200
	Sound3.Looped = true
	Sound3.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound3.Parent = v15

	local Sound4 = Instance.new("Sound")

	Sound4.SoundId = "rbxassetid://100636385506315"
	Sound4.Volume = 1
	Sound4.RollOffMaxDistance = 200
	Sound4.Looped = false
	Sound4.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound4.Parent = v15

	local v17 = false
	local Part = Instance.new("Part")

	Part.CanCollide = false
	Part.CanQuery = true
	Part.CanTouch = false
	Part.Anchored = true

	local v18 = v4:GetExtentsSize() * 1.25

	Part.Transparency = 1
	Part.Size = v18
	Part.CFrame = p5
	Part.Parent = workspace.Temporary
	game.Debris:AddItem(Part, 4.8)

	local v19 = script.ClickDetector:Clone()

	v19.Parent = Part

	local v20 = v19.MouseClick:Connect(function() --[[ Line: 143 | Upvalues: v17 (ref), Networking (ref), p1 (copy), raycastClick (ref), Part (copy), Attachment (ref), v1 (ref) ]]
		if not v17 then
			Networking.SeedPack.ClickPack:Fire(p1)
		end

		v17 = true
		task.delay(0.1, function() --[[ Line: 149 | Upvalues: v17 (ref) ]]
			v17 = false
		end)

		local v12 = raycastClick(Part)
		local v2 = v12 and v12.Position or game.Players.LocalPlayer:GetMouse().Hit.Position

		if not v12 then
			return
		end

		Attachment.WorldCFrame = CFrame.new(v2)
		v1:Emit(16)
	end)

	task.delay(3.8, function() --[[ Line: 164 | Upvalues: v20 (ref), v19 (copy) ]]
		v20:Disconnect()
		v19:Destroy()
	end)

	local v21 = Bezier.new(v10.Position, (v10.Position + p5.Position) / 2 + Vector3.new(0, 16, 0), p5.Position)
	local v22, v23, v24 = Sound, Sound2, Sound3

	for v25, v26 in v4:GetDescendants() do
		if v26:IsA("BasePart") then
			v26.Anchored = true
			v26.CanQuery = true
		end
	end

	v4.Parent = workspace.Temporary
	v22:Play()

	local sum = 0

	while sum < 0.3 do
		sum = sum + game:GetService("RunService").Heartbeat:Wait()

		local v27 = v21:CalculatePositionAt((game:GetService("TweenService"):GetValue(sum / 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)))

		v4:PivotTo(CFrame.new(v27, v27 + p5.LookVector))
	end

	v23:Play()

	local sum2 = 0

	while sum2 < 0.5 do
		sum2 = sum2 + game:GetService("RunService").Heartbeat:Wait()

		local v28 = 1 - sum2 / 0.5

		v4:PivotTo(p5 * CFrame.new(0, (math.sin(math.rad(v28 * 1440) - 1.5707963267948966) + 1) / 2 * v28 * 0.5, 0))
	end

	v24:Play()

	local v31 = nil
	local v32 = 0
	local v33 = true

	task.spawn(function() --[[ Line: 216 | Upvalues: v9 (ref), v33 (ref), v32 (ref), v31 (ref), v4 (ref), v3 (copy), p5 (ref) ]]
		v9.Trail.Trail.Enabled = false

		local sum = 0

		while v33 do
			local v1 = game:GetService("RunService").Heartbeat:Wait()

			sum = sum + v1

			local v2 = CFrame.Angles(0, 0, 0)

			if v32 > 0 then
				v32 = math.max(v32 - v1, 0)
				v2 = v31()
			end

			local v5 = math.clamp(sum, 0, 1)
			local v6 = tick()
			local v12 = Vector3.new(math.cos((math.rad(v6 * 3))) * 0.3, math.sin(v6 * 2.2) * 0.4, math.cos((math.rad(v6 * 1.6))) * 0.1)

			v3.Target = v4:GetPivot():VectorToObjectSpace(v12)
			v3:Update(v1)

			local v14 = p5 * CFrame.new((Vector3.new(0, 0, 0)):Lerp(v3.Position, v5))
			local v15 = CFrame.new()

			v4:PivotTo(v14 * v15:Lerp(CFrame.Angles(math.cos(tick() * 2) * 0.06, math.sin(tick() * 1.5) * 0.1, math.sin(tick() * 2) * 0.1), v5) * v2)
		end
	end)
	task.wait(0.4)
	v31 = function() --[[ Line: 256 | Upvalues: v32 (ref) ]]
		return CFrame.Angles(0, 0, (math.rad((1 - v32 / 0.9) * math.sin(tick() * 90) * 2)))
	end
	v32 = 0.9
	task.wait(1.4)
	v31 = function() --[[ Line: 266 | Upvalues: v32 (ref) ]]
		return CFrame.Angles(0, 0, (math.rad((1 - v32 / 0.9) * math.sin(tick() * 90) * 4)))
	end
	v32 = 0.9
	task.wait(1.4)
	v31 = function() --[[ Line: 280 | Upvalues: v32 (ref) ]]
		return CFrame.Angles(0, 0, (math.rad((1 - v32 / 0.8) * math.sin(tick() * 90) * 6)))
	end
	v32 = 0.8
	task.wait(0.8)

	local v34 = nil

	for k, v in pairs(SeedData) do
		if v.SeedName == p3 then
			v34 = v
		end
	end

	local Rarity = v34.Rarity

	if table.find({ "Legendary", "Mythic" }, Rarity) then
		local Sound5 = Instance.new("Sound")

		Sound5.SoundId = "rbxassetid://82591599137987"
		Sound5.Volume = 1
		Sound5.RollOffMaxDistance = 200
		Sound5.Looped = false
		Sound5.SoundGroup = SoundService:FindFirstChild("SFXGroup")
		Sound5.Parent = v15
		Sound5:Play()
		task.wait(0.8)

		local v35 = SeedPackEffects.Highlight:Clone()

		v35.FillTransparency = 1
		v35.OutlineTransparency = 1
		v35.Parent = v4
		v35.Enabled = true

		local v36 = 1 - ((game.Workspace.CurrentCamera.CFrame.Position - v4:GetPivot().p).Magnitude + 20) / 90

		CamShake:StartShake(2 * v36, 14 * v36, 12, Vector3.new(0.2, 0.2, 0))
		v31 = function() --[[ Line: 324 | Upvalues: v32 (ref), v35 (copy), v4 (ref) ]]
			local v1 = 1 - v32 / 3

			v35.FillTransparency = 1 - v1
			v35.OutlineTransparency = 1 - v1
			v4:ScaleTo(v1 * 3 + 1)

			local v2 = Random.new():NextUnitVector() * v1
			local v3 = v4:GetExtentsSize().Y / 2 * 0.1
			local v5 = v1 * math.sin(tick() * 90)

			return CFrame.new(v2 * v3) * CFrame.new(0, v4:GetExtentsSize().Y / 2 * v1, 0) * CFrame.Angles(0, 0, (math.rad(v5 * 6)))
		end
		v32 = 3
		task.wait(3)

		for v37, v38 in v9.BigEmit:GetChildren() do
			v38:Emit(v38:GetAttribute("EmitCount"))
		end

		CamShake:StopSustained(0.5)
	else
		for v39, v40 in v9.Emit:GetChildren() do
			v40:Emit(v40:GetAttribute("EmitCount"))
		end
	end

	v24:Stop()
	Sound4:Play()

	for v41, v42 in v4:GetDescendants() do
		if v42:IsA("BasePart") or v42:IsA("Decal") then
			v42.Transparency = 1

			continue
		end

		if v42:IsA("SurfaceGui") then
			v42.Enabled = false
		end
	end

	for v43, v44 in v9.Aura:GetChildren() do
		v44.Enabled = false
	end

	task.spawn(function() --[[ Line: 377 | Upvalues: p3 (ref), t2 (ref), p1 (copy), ReplicatedStorage (ref), v33 (ref), p5 (ref), v34 (ref), RarityData (ref), SeedPackEffects (ref) ]]
		p3 = t2[p1]
		t2[p1] = nil

		local v1 = p3 and ReplicatedStorage.Assets.Seeds:FindFirstChild(p3)

		if v1 then
			v33 = false

			local v2 = v1:Clone()
			local Model = Instance.new("Model")

			v2.Parent = Model
			Model.PrimaryPart = v2

			local v3 = Model

			v3:PivotTo(p5)
			v3.Parent = workspace.Temporary

			local v4 = ReplicatedStorage.Assets.SeedNameAttachment:Clone()

			v4.Position = p5.Position + Vector3.new(0, 1.5, 0)
			v4.BillboardGui.Rarity_Name.UIScale.Scale = 0
			v4.BillboardGui.Seed_Name.UIScale.Scale = 0
			v4.Parent = workspace.Temporary
			game.TweenService:Create(v4, TweenInfo.new(3), {
				Position = p5.Position + Vector3.new(0, 3, 0)
			}):Play()
			v4.BillboardGui.Seed_Name.TextLabel.Text = p3
			v4.BillboardGui.Seed_Name.Text = p3
			game.TweenService:Create(v4.BillboardGui.Seed_Name.UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
				Scale = 1
			}):Play()
			task.delay(0.15, function() --[[ Line: 410 | Upvalues: v4 (copy) ]]
				game.TweenService:Create(v4.BillboardGui.Rarity_Name.UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
					Scale = 1
				}):Play()
			end)
			task.delay(3, function() --[[ Line: 416 | Upvalues: v4 (copy), v3 (ref) ]]
				game.TweenService:Create(v4.BillboardGui.Seed_Name.UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
					Scale = 0
				}):Play()
				task.delay(0.15, function() --[[ Line: 419 | Upvalues: v4 (ref), v3 (ref) ]]
					game.TweenService:Create(v4.BillboardGui.Rarity_Name.UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
						Scale = 0
					}):Play()
					game.Debris:AddItem(v4, 1)
					task.wait(0.15)

					local sum = 0

					while sum < 1 do
						sum = sum + game:GetService("RunService").Heartbeat:Wait()
						v3:ScaleTo((math.clamp(1 - game.TweenService:GetValue(sum, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), 0.01, 1)))
					end

					v3:Destroy()
				end)
			end)

			if v34 then
				local Rarity = v34.Rarity
				local v5 = RarityData.Gradients:FindFirstChild(Rarity)

				v4.BillboardGui.Rarity_Name.TextLabel.Text = Rarity
				v4.BillboardGui.Rarity_Name.Text = Rarity

				if v5 then
					v5:Clone().Parent = v4.BillboardGui.Rarity_Name.TextLabel
					v5:Clone().Parent = v4.BillboardGui.Rarity_Name
				end
			end

			local v6 = SeedPackEffects.Highlight:Clone()

			v6.Parent = v3
			v6.Enabled = true
			task.delay(0.2, function() --[[ Line: 457 | Upvalues: v6 (copy) ]]
				game.TweenService:Create(v6, TweenInfo.new(0.7), {
					FillTransparency = 1
				}):Play()
				game.Debris:AddItem(v6, 0.3)
			end)

			local sum = 0
			local sum2 = 0

			while sum < 5 do
				local v7 = game:GetService("RunService").Heartbeat:Wait()

				sum = sum + v7
				sum2 = sum2 + 25.132741228718345 * math.clamp(1 - sum / 1, 0.1, 1) * v7

				local v9 = (math.sin((tick())) + 1) * 0.5 / 2

				v3:PivotTo(p5 * CFrame.Angles(0, sum2, 0) * CFrame.new(0, v9, 0))
			end
		end
	end)
	game.Debris:AddItem(v4, 5)
end
function t.UpdateDropData(p1, p2) --[[ UpdateDropData | Line: 488 | Upvalues: t2 (copy) ]]
	if t2[p1] ~= nil then
		t2[p1] = p2
	end
end

return t