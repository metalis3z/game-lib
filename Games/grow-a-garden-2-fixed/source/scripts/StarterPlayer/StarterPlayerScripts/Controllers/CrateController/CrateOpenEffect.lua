--credit to leon games studio
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local t = {}
local t2 = {}
local Players = game:GetService("Players")

local function FindGround(p1) --[[ FindGround | Line: 23 | Upvalues: Players (copy) ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	local t = {}

	for v3, v4 in Players:GetPlayers() do
		if v4.Character then
			table.insert(t, v4.Character)
		end
	end

	v1.FilterDescendantsInstances = t

	local v5 = workspace:Raycast(p1 + Vector3.new(0, 10, 0), Vector3.new(0, -25, 0), v1)

	if v5 and v5.Instance.Transparency < 1 then
		return v5.Position
	end

	return nil
end

local function HasPositionConflict(p1) --[[ HasPositionConflict | Line: 49 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		if (p1 - v2).Magnitude <= 10 then
			return true
		end
	end

	return false
end

function t.FindDropPosition(p1) --[[ FindDropPosition | Line: 63 | Upvalues: FindGround (copy), t2 (copy) ]]
	local Character = p1.Character

	if not Character then
		return nil
	end

	if not Character.PrimaryPart then
		return nil
	end

	local v1 = Character:GetPivot()
	local Position = v1.Position
	local _, v2, _2 = v1:ToOrientation()
	local v3 = v2 + 1.5707963267948966

	for i = 10, 30 do
		for j = 0, 180, 15 do
			for v4, v5 in { -1, 1 } do
				local v6 = math.rad(j * v5) - v3
				local v9 = FindGround(Position + Vector3.new(i * math.cos(v6), 0, i * math.sin(v6)))

				if v9 then
					local v10 = false

					for v11, v12 in t2 do
						if (v9 - v12).Magnitude <= 10 then
							v10 = true

							break
						end
					end

					if not v10 then
						return v9
					end
				end
			end
		end
	end

	return nil
end

local function ExpoInOut(p1) --[[ ExpoInOut | Line: 109 ]]
	if p1 == 0 then
		return 0
	end

	if p1 == 1 then
		return 1
	end

	local v1 = p1 * 2

	if v1 < 1 then
		return math.pow(2, (v1 - 1) * 10) * 0.5 - 0.0005
	end

	return (-math.pow(2, (v1 - 1) * -10) + 2) * 0.50025
end

local function ExpoIn(p1) --[[ ExpoIn | Line: 122 ]]
	if p1 == 0 then
		return 0
	end

	return math.pow(2, (p1 - 1) * 10) - 0.001
end

local function BounceOut(p1) --[[ BounceOut | Line: 127 ]]
	if p1 < 0.36363636363636365 then
		return p1 * 7.5625 * p1
	end

	if p1 < 0.7272727272727273 then
		local v1 = p1 - 0.5454545454545454

		return v1 * 7.5625 * v1 + 0.75
	end

	if p1 < 0.9090909090909091 then
		local v2 = p1 - 0.8181818181818182

		return v2 * 7.5625 * v2 + 0.9375
	end

	local v3 = p1 - 0.9545454545454546

	return v3 * 7.5625 * v3 + 0.984375
end

local function QuadOut(p1) --[[ QuadOut | Line: 135 ]]
	return p1 * -1 * (p1 - 2)
end

local v1 = 0

local function RenderFor(p1, p2) --[[ RenderFor | Line: 143 | Upvalues: v1 (ref), RunService (copy) ]]
	v1 = v1 + 1

	local v12 = ("CrateRS_%d"):format(v1)
	local v2 = 0
	local v3 = false

	RunService:BindToRenderStep(v12, Enum.RenderPriority.Last.Value, function(p12) --[[ Line: 153 | Upvalues: v3 (ref), v2 (ref), p2 (copy), p1 (copy), RunService (ref), v12 (copy) ]]
		if v3 then
			return
		end

		v2 = math.min(v2 + p12, p2)

		if not (p1(p12, (math.clamp(v2 / p2, 0, 1))) or p2 <= v2) then
			return
		end

		v3 = true
		RunService:UnbindFromRenderStep(v12)
	end)

	while not v3 do
		task.wait()
	end
end

local function Bezier(p1, p2, p3) --[[ Bezier | Line: 175 ]]
	return function(p13) --[[ Line: 176 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		local v12 = 1 - p13

		return v12 * v12 * p1 + v12 * 2 * p13 * p2 + p13 * p13 * p3
	end
end

local function AutoControlPoint(p1, p2) --[[ AutoControlPoint | Line: 183 ]]
	local v1 = (p1 + p2) / 2

	return Vector3.new(v1.X, math.max(p1.Y, p2.Y) + ((p1 - p2) * Vector3.new(1, 0, 1)).Magnitude, v1.Z)
end

local function LookAtFlat(p1, p2) --[[ LookAtFlat | Line: 190 ]]
	local v1 = Vector3.new(p2.X, p1.Y, p2.Z)

	if (p1.Position - v1).Magnitude < 0.001 then
		return p1
	end

	return CFrame.lookAt(p1.Position, v1)
end

local function SetModelAnchored(p1) --[[ SetModelAnchored | Line: 201 ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.Anchored = true
			v2.CanCollide = false
			v2.CastShadow = false
			v2.CanQuery = false
		end
	end
end

local function EnsurePrimaryPart(p1) --[[ EnsurePrimaryPart | Line: 213 ]]
	if p1.PrimaryPart then
		return
	end

	local Center = p1:FindFirstChild("Center")

	if Center then
		p1.PrimaryPart = Center

		return
	end

	local v1 = p1:FindFirstChildWhichIsA("BasePart", true)

	if not v1 then
		return
	end

	p1.PrimaryPart = v1
end

local function EmitAtPosition(p1, p2, p3, p4) --[[ EmitAtPosition | Line: 239 | Upvalues: Debris (copy) ]]
	if not p2 then
		return
	end

	local v1

	if typeof(p2) == "Instance" and p2:IsA("Folder") then
		v1 = p2:GetChildren()
	else
		if type(p2) ~= "table" then
			return
		end

		v1 = p2
	end

	if #v1 == 0 then
		return
	end

	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 1
	Part.Size = Vector3.new(0, 0, 0)
	Part.CFrame = CFrame.new(p1)
	Part.Parent = workspace

	local v3 = 0

	for v4, v5 in v1 do
		if v5:IsA("ParticleEmitter") then
			local v6 = v5:Clone()

			v6.Enabled = false

			if p3 then
				v6.Color = ColorSequence.new(p3)
			end

			v6.Parent = Part
			v6:Emit((math.ceil(v6:GetAttribute("EmitCount") or v6.Rate)))
			v3 = math.max(v3, v6.Lifetime.Max)
		end
	end

	Debris:AddItem(Part, if p4 then p4 else v3 + 0.5)
end

local function PlaySound(p1, p2, p3) --[[ PlaySound | Line: 293 | Upvalues: Debris (copy) ]]
	if not p1 then
		return
	end

	local v1 = p1:Clone()

	if p3 then
		v1.Volume = p1.Volume * p3
	end

	v1.Parent = if p2 then p2 else workspace
	v1:Play()
	Debris:AddItem(v1, v1.TimeLength + 1)
end

local function SetTrailsEnabled(p1, p2) --[[ SetTrailsEnabled | Line: 311 ]]
	for v1, v2 in p1 do
		if v2:IsA("Trail") then
			v2.Enabled = p2
		end

		for v3, v4 in v2:GetDescendants() do
			if v4:IsA("Trail") then
				v4.Enabled = p2
			end
		end
	end
end

local v2 = UDim2.fromScale(5, 5)

local function CreateImageItem(p1, p2) --[[ CreateImageItem | Line: 332 | Upvalues: v2 (copy) ]]
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CastShadow = false
	Part.Transparency = 1
	Part.Size = Vector3.new(1, 1, 1)
	Part.CFrame = p2

	local ItemImageBillboard = Instance.new("BillboardGui")

	ItemImageBillboard.Name = "ItemImageBillboard"
	ItemImageBillboard.Size = v2
	ItemImageBillboard.StudsOffset = Vector3.new(0, 0, 0)
	ItemImageBillboard.Adornee = Part
	ItemImageBillboard.AlwaysOnTop = true
	ItemImageBillboard.LightInfluence = 0
	ItemImageBillboard.Parent = Part

	local ItemImage = Instance.new("ImageLabel")

	ItemImage.Name = "ItemImage"
	ItemImage.Image = p1
	ItemImage.Size = UDim2.fromScale(1, 1)
	ItemImage.Position = UDim2.fromScale(0, 0)
	ItemImage.BackgroundTransparency = 1
	ItemImage.ScaleType = Enum.ScaleType.Fit
	ItemImage.Parent = ItemImageBillboard

	return Part, 2.5
end

local CrateSFX = game.SoundService.SFX.CrateSFX

function t.Play(p1) --[[ Play | Line: 422 | Upvalues: t (copy), FindGround (copy), t2 (copy), SetModelAnchored (copy), Debris (copy), RenderFor (copy), LookAtFlat (copy), EmitAtPosition (copy), CreateImageItem (copy), v2 (copy), TweenService (copy) ]]
	local Player = p1.Player
	local v22 = p1.Sounds or {}
	local v3 = math.clamp(1 - (p1.Rarity or 0.5), 0, 1)
	local v4 = if p1.IsBestItem == true then true else false
	local v6 = if v4 then 2 else 1
	local v7 = if v4 then 1.5 + math.random() * 1.5 else nil
	local VFX = p1.VFX
	local v8 = p1.Particles or {}
	local v9 = v8.Impact or (if VFX then VFX:FindFirstChild("Impact") else nil)
	local v10 = v8.Explosion or (if VFX then VFX:FindFirstChild("Explosion") else nil)
	local v11 = v8.Trail or (if VFX then VFX:FindFirstChild("Trail") else nil)
	local v12 = if p1.ItemImage == nil then false elseif p1.ItemImage == "" then false else true

	local function GetPlayerPosition() --[[ GetPlayerPosition | Line: 447 | Upvalues: Player (copy) ]]
		local Character = Player.Character

		if Character and Character.PrimaryPart then
			return Character.PrimaryPart.Position
		end

		return Vector3.new(0, 10, 0)
	end

	local Character = Player.Character
	local v13 = if Character and Character.PrimaryPart then Character.PrimaryPart.Position else Vector3.new(0, 10, 0)
	local v14

	if p1.Position and ((p1.Position - v13).Magnitude < 100 and p1.Position.Magnitude > 1) then
		v14 = p1.Position
	else
		local v15 = t.FindDropPosition(Player)

		if not v15 then
			local Character2 = Player.Character

			if Character2 and Character2.PrimaryPart then
				local v16 = Character2:GetPivot()
				local v18 = v16.Position + v16.LookVector * 6

				v15 = FindGround(v18) or v18 + Vector3.new(0, -3, 0)
			else
				v15 = v13
			end
		end

		v14 = v15
	end

	table.insert(t2, v14)

	local v21 = p1.CrateModel:Clone()

	if not v21.PrimaryPart then
		local Center = v21:FindFirstChild("Center")

		if Center then
			v21.PrimaryPart = Center
		else
			local v222 = v21:FindFirstChildWhichIsA("BasePart", true)

			if v222 then
				v21.PrimaryPart = v222
			end
		end
	end

	SetModelAnchored(v21)

	local v23 = v21:GetExtentsSize().Y / 2
	local PrimaryPart = v21.PrimaryPart
	local t3 = {}
	local v24

	if v11 then
		local TrailBottom = Instance.new("Attachment")

		TrailBottom.Name = "TrailBottom"
		TrailBottom.Position = Vector3.new(0, -PrimaryPart.Size.Y / 2, 0)
		TrailBottom.Parent = PrimaryPart

		local TrailTop = Instance.new("Attachment")

		TrailTop.Name = "TrailTop"
		TrailTop.Position = Vector3.new(0, PrimaryPart.Size.Y / 2, 0)
		TrailTop.Parent = PrimaryPart

		local v27 = v11:Clone()

		v27.Attachment0 = TrailBottom
		v27.Attachment1 = TrailTop
		v27.Lifetime = 0.5
		v27.Enabled = false
		v27.Parent = PrimaryPart
		table.insert(t3, TrailBottom)
		table.insert(t3, TrailTop)
		table.insert(t3, v27)
		v24 = v27
	else
		v24 = nil
	end

	v21:PivotTo(CFrame.new(v13))
	v21:ScaleTo(0.001)
	v21.Parent = workspace

	local Spawn = v22.Spawn

	if Spawn then
		local v28 = Spawn:Clone()

		v28.Parent = PrimaryPart or workspace
		v28:Play()
		Debris:AddItem(v28, v28.TimeLength + 1)
	end

	if v24 then
		v24.Enabled = true
	end

	local v31 = Vector3.new(v14.X, v14.Y + v23, v14.Z)
	local v32 = (v13 + v31) / 2
	local v34 = Vector3.new(v32.X, math.max(v13.Y, v31.Y) + ((v13 - v31) * Vector3.new(1, 0, 1)).Magnitude, v32.Z)

	local function f35(p13) --[[ Line: 176 | Upvalues: v13 (copy), v34 (copy), v31 (copy) ]]
		local v12 = 1 - p13

		return v12 * v12 * v13 + v12 * 2 * p13 * v34 + p13 * p13 * v31
	end

	local v36 = CFrame.new(v31)
	local v37 = Vector3.new(v13.X, v36.Y, v13.Z)
	local v38 = if (v36.Position - v37).Magnitude < 0.001 then v36 else CFrame.lookAt(v36.Position, v37)

	RenderFor(function(p1, p2) --[[ Line: 554 | Upvalues: v21 (copy), LookAtFlat (ref), f35 (copy), v13 (copy) ]]
		local v2 = math.clamp(p2 * 2, 0, 1)
		local v3

		if v2 == 0 then
			v3 = 0
		elseif v2 == 1 then
			v3 = 1
		else
			local v4 = v2 * 2

			v3 = if v4 < 1 then math.pow(2, (v4 - 1) * 10) * 0.5 - 0.0005 else (-math.pow(2, (v4 - 1) * -10) + 2) * 0.50025
		end

		v21:ScaleTo(v3)
		v21:PivotTo(LookAtFlat(CFrame.new(f35(1 - math.cos(p2 * math.pi / 2))), v13))

		return nil
	end, 0.5)
	v21:ScaleTo(1)
	v21:PivotTo(v38)
	task.delay(0.5, function() --[[ Line: 567 | Upvalues: t3 (ref) ]]
		for v1, v2 in t3 do
			if v2 then
				v2:Destroy()
			end
		end

		t3 = {}
	end)
	EmitAtPosition(v14, v9)

	local Land = v22.Land

	if Land then
		local v40 = Land:Clone()

		v40.Parent = if PrimaryPart then PrimaryPart else workspace
		v40:Play()
		Debris:AddItem(v40, v40.TimeLength + 1)
	end

	local v42 = v21:GetPivot()

	RenderFor(function(p1, p2) --[[ Line: 588 | Upvalues: v21 (copy), v42 (copy) ]]
		local v1

		if p2 < 0.36363636363636365 then
			v1 = p2 * 7.5625 * p2
		elseif p2 < 0.7272727272727273 then
			local v2 = p2 - 0.5454545454545454

			v1 = v2 * 7.5625 * v2 + 0.75
		elseif p2 < 0.9090909090909091 then
			local v3 = p2 - 0.8181818181818182

			v1 = v3 * 7.5625 * v3 + 0.9375
		else
			local v4 = p2 - 0.9545454545454546

			v1 = v4 * 7.5625 * v4 + 0.984375
		end

		v21:PivotTo(v42 + Vector3.new(0, 1.5 * (1 - v1), 0))

		return nil
	end, 0.4)
	v21:PivotTo(v42)
	task.wait(0.5)

	local v43 = v21:GetPivot()
	local v45 = 15 * (v3 * 1.2 + 0.15)
	local v46 = v7 or v3 * 0.5 + 1
	local Shake = v22.Shake

	if Shake then
		local v47 = Shake:Clone()

		v47.Parent = PrimaryPart or workspace
		v47:Play()
		Debris:AddItem(v47, v47.TimeLength + 1)
	end

	RenderFor(function(p1, p2) --[[ Line: 611 | Upvalues: v45 (copy), v46 (copy), v23 (copy), v21 (copy), v43 (copy) ]]
		local v1 = math.min(p2 * 2, 1)
		local v2 = math.max((p2 - 0.6) / 0.4, 0)
		local v3 = v1 * -1 * (v1 - 2) * (1 - v2 * -1 * (v2 - 2))
		local v4 = p2 * 1.2 * 5
		local v6 = math.rad(v45 * math.sin(6.283185307179586 * v4) * v3)
		local v8 = math.rad(v45 * 0.6 * math.sin(6.283185307179586 * v4 * 1.3) * v3)
		local v10 = math.rad(v45 * 0.3 * math.cos(6.283185307179586 * v4 * 1.7) * v3)
		local v11 = 0.22499999999999998 * math.sin(6.283185307179586 * v4 * 0.8) * v3
		local v12 = 0.12 * math.cos(6.283185307179586 * v4 * 1.1) * v3
		local v13 = 1 + (v46 - 1) * v3

		v21:ScaleTo(v13)
		v21:PivotTo(v43 * CFrame.fromOrientation(v6, v8, v10) + Vector3.new(v12, v11 + v23 * (v13 - 1), 0))

		return nil
	end, 1.8 * (v3 * 1 + 0.3) * (if v4 then 2 else 1))
	v21:ScaleTo(1)
	v21:PivotTo(v43)

	local Position = v43.Position
	local v49, v50, v51

	if v12 then
		local v52, v53 = CreateImageItem(p1.ItemImage, CFrame.new(Position))

		v49 = v52
		v50 = v52

		local ItemImageBillboard = v52:FindFirstChild("ItemImageBillboard")

		if ItemImageBillboard then
			ItemImageBillboard.Size = UDim2.fromScale(0, 0)
		end

		v52.Parent = workspace
		v51 = v53
	elseif p1.ItemModel then
		local v54 = p1.ItemModel:Clone()

		if not v54.PrimaryPart then
			local Center = v54:FindFirstChild("Center")

			if Center then
				v54.PrimaryPart = Center
			else
				local v55 = v54:FindFirstChildWhichIsA("BasePart", true)

				if v55 then
					v54.PrimaryPart = v55
				end
			end
		end

		SetModelAnchored(v54)
		v51 = v54:GetExtentsSize().Y / 2
		v54:PivotTo(LookAtFlat(CFrame.new(Position), v13))
		v54.Parent = workspace
		v50 = v54.PrimaryPart
		v49 = v54
	else
		local Part = Instance.new("Part")

		Part.Size = Vector3.new(1, 1, 1)
		Part.Transparency = 1
		Part.Anchored = true
		Part.CanCollide = false
		Part.CFrame = CFrame.new(Position)
		Part.Parent = workspace
		v51 = 0.5
		v50 = Part
		v49 = Part
	end

	local v56

	if v12 then
		v56 = nil
	else
		v56 = Instance.new("Highlight")
		v56.FillColor = Color3.new(255/255, 255/255, 255/255)
		v56.OutlineColor = Color3.new(255/255, 255/255, 255/255)
		v56.FillTransparency = 0
		v56.OutlineTransparency = 0
		v56.DepthMode = Enum.HighlightDepthMode.Occluded
		v56.Parent = v49
	end

	local Highlight = Instance.new("Highlight")

	Highlight.FillColor = Color3.new(255/255, 255/255, 255/255)
	Highlight.OutlineColor = Color3.new(255/255, 255/255, 255/255)
	Highlight.FillTransparency = 0
	Highlight.OutlineTransparency = 0
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.Parent = v21

	local Explosion = v22.Explosion

	if Explosion then
		local v57 = Explosion:Clone()

		if v6 then
			v57.Volume = Explosion.Volume * v6
		end

		v57.Parent = if PrimaryPart then PrimaryPart else workspace
		v57:Play()
		Debris:AddItem(v57, v57.TimeLength + 1)
	end

	EmitAtPosition(Position, v10, p1.RarityColor)
	RenderFor(function(p1, p2) --[[ Line: 724 | Upvalues: v21 (copy), Highlight (copy) ]]
		v21:ScaleTo(1 + p2 * 0.5)
		Highlight.FillTransparency = p2
		Highlight.OutlineTransparency = p2

		for v1, v2 in v21:GetDescendants() do
			if v2:IsA("BasePart") then
				v2.Transparency = p2
			end
		end

		return nil
	end, 0.25)
	v21:Destroy()

	local v60 = Vector3.new(Position.X, Position.Y + v23 + v51, Position.Z)
	local Reveal = v22.Reveal

	if Reveal then
		local v61 = Reveal:Clone()

		v61.Parent = v50 or workspace
		v61:Play()
		Debris:AddItem(v61, v61.TimeLength + 1)
	end

	EmitAtPosition(v60, v10, p1.RarityColor)

	local v63 = if v12 then v49:FindFirstChild("ItemImageBillboard") else nil

	RenderFor(function(p1, p2) --[[ Line: 759 | Upvalues: Position (copy), v60 (copy), v12 (copy), v49 (ref), v63 (ref), v2 (ref), LookAtFlat (ref), Player (copy), v56 (ref) ]]
		local v1

		if p2 == 0 then
			v1 = 0
		elseif p2 == 1 then
			v1 = 1
		else
			local v22 = p2 * 2

			v1 = if v22 < 1 then math.pow(2, (v22 - 1) * 10) * 0.5 - 0.0005 else (-math.pow(2, (v22 - 1) * -10) + 2) * 0.50025
		end

		local v3 = Position:Lerp(v60, v1)

		if v12 then
			v49.CFrame = CFrame.new(v3)

			if not v63 then
				return nil
			end

			local v4 = math.clamp(p2 * 1.5, 0, 1)
			local v5

			if v4 == 0 then
				v5 = 0
			elseif v4 == 1 then
				v5 = 1
			else
				local v6 = v4 * 2

				v5 = if v6 < 1 then math.pow(2, (v6 - 1) * 10) * 0.5 - 0.0005 else (-math.pow(2, (v6 - 1) * -10) + 2) * 0.50025
			end

			v63.Size = UDim2.fromScale(v2.X.Scale * v5, v2.Y.Scale * v5)
		else
			local v9 = CFrame.new(v3)
			local Character = Player.Character

			v49:PivotTo(LookAtFlat(v9, if Character and Character.PrimaryPart then Character.PrimaryPart.Position else Vector3.new(0, 10, 0)))

			if not v56 then
				return nil
			end

			v56.FillTransparency = p2
			v56.OutlineTransparency = p2
		end

		return nil
	end, 0.6)

	if v56 then
		v56:Destroy()
	end

	local v64 = nil

	if not v12 then
		local ItemShine = game.ReplicatedStorage.Assets.VFX:FindFirstChild("ItemShine")

		if ItemShine then
			local Attachment = ItemShine:FindFirstChild("Attachment")

			if Attachment then
				Attachment:Clone().Parent = v50
			end
		end
	end

	if p1.BillboardTemplate then
		v64 = p1.BillboardTemplate:Clone()

		local Size = v64.Size

		v64.Size = UDim2.new(Size.X.Scale * 0.15, Size.X.Offset * 0.15, Size.Y.Scale * 0.15, Size.Y.Offset * 0.15)
		v64.Adornee = v50
		v64.StudsOffset = Vector3.new(0, v51 + 1.5, 0)
		v64.Parent = v49

		local Frame = v64:FindFirstChild("Frame")

		if Frame and Frame:IsA("Frame") then
			local ItemName = Frame:FindFirstChild("ItemName")

			if ItemName and ItemName:IsA("TextLabel") then
				ItemName.Text = p1.ItemName
			end

			local ItemLuck = Frame:FindFirstChild("ItemLuck")

			if ItemLuck and ItemLuck:IsA("TextLabel") then
				ItemLuck.Text = if p1.Rarity then string.format("%s - %.1f%%", p1.RarityName, p1.Rarity * 100) else p1.RarityName
				ItemLuck.TextColor3 = p1.RarityColor

				local v66 = ItemLuck:FindFirstChildWhichIsA("UIGradient")

				if v66 then
					v66.Color = ColorSequence.new(p1.RarityColor)
				end
			end
		end

		TweenService:Create(v64, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = Size
		}):Play()
	end

	local v67 = if v12 then v49.Position else v49:GetPivot().Position

	RenderFor(function(p1, p2) --[[ Line: 868 | Upvalues: v67 (ref), v12 (copy), v49 (ref), LookAtFlat (ref), Player (copy) ]]
		local v3 = v67 + Vector3.new(0, -math.abs((math.sin(1.5707963267948966 * p2))) * 2, 0)

		if v12 then
			v49.CFrame = CFrame.new(v3)
		else
			local v6 = CFrame.new(v3)
			local Character = Player.Character

			v49:PivotTo(LookAtFlat(v6, if Character and Character.PrimaryPart then Character.PrimaryPart.Position else Vector3.new(0, 10, 0)))
		end

		return nil
	end, 2.5)

	if v64 then
		local Size = v64.Size

		TweenService:Create(v64, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(Size.X.Scale * 0.15, Size.X.Offset * 0.15, Size.Y.Scale * 0.15, Size.Y.Offset * 0.15)
		}):Play()
		Debris:AddItem(v64, 0.15)
	end

	local v68 = if v12 then v49.Position else v49:GetPivot().Position
	local Collect = v22.Collect

	if Collect then
		local v69 = Collect:Clone()

		v69.Parent = if v50 then v50 else workspace
		v69:Play()
		Debris:AddItem(v69, v69.TimeLength + 1)
	end

	RenderFor(function(p1, p2) --[[ Line: 907 | Upvalues: Player (copy), v68 (ref), v12 (copy), v49 (ref), v63 (ref), v2 (ref) ]]
		local Character = Player.Character
		local v1 = if Character and Character.PrimaryPart then Character.PrimaryPart.Position else Vector3.new(0, 10, 0)
		local v22 = v68
		local v3 = v68
		local v4 = (v3 + v1) / 2
		local v6 = Vector3.new(v4.X, math.max(v3.Y, v1.Y) + ((v3 - v1) * Vector3.new(1, 0, 1)).Magnitude, v4.Z)

		local function f7(p13) --[[ Line: 176 | Upvalues: v22 (copy), v6 (copy), v1 (copy) ]]
			local v12 = 1 - p13

			return v12 * v12 * v22 + v12 * 2 * p13 * v6 + p13 * p13 * v1
		end

		local v8 = f7(p2)

		if v12 then
			v49.CFrame = CFrame.new(v8)

			if not v63 then
				return nil
			end

			local v10 = 1 - (if p2 == 0 then 0 else math.pow(2, (p2 - 1) * 10) - 0.001)

			v63.Size = UDim2.fromScale(v2.X.Scale * v10, v2.Y.Scale * v10)
		else
			local v11 = Vector3.new(v1.X, v8.Y, v1.Z)
			local v122 = if (v8 - v11).Magnitude < 0.001 then CFrame.new(v8) else CFrame.lookAt(v8, v11)

			if v49:IsA("Model") then
				v49:PivotTo(v122)
				v49:ScaleTo(1 - (if p2 == 0 then 0 else math.pow(2, (p2 - 1) * 10) - 0.001))
			else
				v49.CFrame = v122
			end
		end

		return nil
	end, 0.5)

	if p1.OnCollected then
		p1.OnCollected()
	end

	v49:Destroy()

	local v71 = table.find(t2, v14)

	if v71 then
		table.remove(t2, v71)
	end
end

return t