--credit to prince games studio
local t = {
	StartOrder = 6
}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

game:GetService("TweenService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local SeedPackData = require(ReplicatedStorage.SharedModules.SeedPackData)
local SeedData = require(game.ReplicatedStorage.SharedModules.SeedData)
local SeedPackEffect = require(script.SeedPackEffect)
local CollectionService = game:GetService("CollectionService")
local SeedPacks = ReplicatedStorage.Assets.SeedPacks
local Seeds = ReplicatedStorage.Assets.Seeds
local LocalPlayer = Players.LocalPlayer
local Click = SoundService.SFX.Click
local SeedpackSFX = SoundService.SFX.SeedpackSFX
local SeedpackReward = SeedpackSFX.SeedpackReward
local SeedpackOpen = SeedpackSFX.SeedpackOpen
local SeedpackSpawn = SeedpackSFX.SeedpackSpawn
local SeedpackCollect = SeedpackSFX.SeedpackCollect
local SeedNameAttachment = game.ReplicatedStorage.Assets.SeedNameAttachment
local t2 = {}
local v1 = 0

local function FindGround(p1) --[[ FindGround | Line: 92 ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Include
	v1.FilterDescendantsInstances = { workspace.Baseplate }

	local v2 = workspace:Raycast(p1 + Vector3.new(0, 10, 0), Vector3.new(0, -25, 0), v1)

	if v2 then
		return v2.Position
	end

	return nil
end

local function HasPositionConflict(p1) --[[ HasPositionConflict | Line: 109 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		if (p1 - v2).Magnitude <= 8 then
			return true
		end
	end

	return false
end

local function FindDropPosition(p1) --[[ FindDropPosition | Line: 119 | Upvalues: FindGround (copy), t2 (copy) ]]
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

	for i = 7, 30 do
		local v4 = math.max(1, (math.floor(6.283185307179586 * i / 8)))
		local v5 = 6.283185307179586 / v4

		for j = 0, v4 - 1 do
			local v6 = v2 + j * v5
			local v9 = FindGround(Position + Vector3.new(i * math.cos(v6), 0, i * math.sin(v6)))

			if v9 then
				local v10 = false

				for v11, v12 in t2 do
					if (v9 - v12).Magnitude <= 8 then
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

	return nil
end

local function ExpoInOut(p1) --[[ ExpoInOut | Line: 156 ]]
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

local function EaseOutBack(p1) --[[ EaseOutBack | Line: 169 ]]
	return math.pow(p1 - 1, 3) * 2.70158 + 1 + math.pow(p1 - 1, 2) * 1.70158
end

local function Bezier(p1, p2, p3) --[[ Bezier | Line: 176 ]]
	return function(p12) --[[ Line: 177 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		local v1 = 1 - p12

		return v1 * v1 * p1 + v1 * 2 * p12 * p2 + p12 * p12 * p3
	end
end

local function AutoControlPoint(p1, p2) --[[ AutoControlPoint | Line: 183 ]]
	local v1 = (p1 + p2) / 2

	return Vector3.new(v1.X, math.max(p1.Y, p2.Y) + ((p1 - p2) * Vector3.new(1, 0, 1)).Magnitude, v1.Z)
end

local function LookAtFlat(p1, p2) --[[ LookAtFlat | Line: 189 ]]
	local v1 = Vector3.new(p2.X, p1.Y, p2.Z)

	if (p1.Position - v1).Magnitude < 0.001 then
		return p1
	end

	return CFrame.lookAt(p1.Position, v1)
end

local function SetModelAnchored(p1) --[[ SetModelAnchored | Line: 199 ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			v2.Anchored = true
			v2.CanCollide = false
			v2.CastShadow = false
			v2.CanQuery = false
		end
	end
end

local function EnsurePrimaryPart(p1) --[[ EnsurePrimaryPart | Line: 210 ]]
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

local function RenderFor(p1, p2) --[[ RenderFor | Line: 226 | Upvalues: v1 (ref), RunService (copy) ]]
	v1 = v1 + 1

	local v12 = ("SeedPackRS_%d"):format(v1)
	local v2 = 0
	local v3 = false

	RunService:BindToRenderStep(v12, Enum.RenderPriority.Last.Value, function(p12) --[[ Line: 233 | Upvalues: v3 (ref), v2 (ref), p2 (copy), p1 (copy), RunService (ref), v12 (copy) ]]
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

local function CaptureVisuals(p1) --[[ CaptureVisuals | Line: 251 ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			table.insert(t, {
				Property = "Transparency",
				Instance = v2,
				Original = v2.Transparency
			})

			continue
		end

		if v2:IsA("Decal") or v2:IsA("Texture") then
			table.insert(t, {
				Property = "Transparency",
				Instance = v2,
				Original = v2.Transparency
			})

			continue
		end

		if v2:IsA("ImageLabel") or v2:IsA("ImageButton") then
			table.insert(t, {
				Property = "ImageTransparency",
				Instance = v2,
				Original = v2.ImageTransparency
			})
			table.insert(t, {
				Property = "BackgroundTransparency",
				Instance = v2,
				Original = v2.BackgroundTransparency
			})

			continue
		end

		if v2:IsA("TextLabel") or v2:IsA("TextButton") then
			table.insert(t, {
				Property = "TextTransparency",
				Instance = v2,
				Original = v2.TextTransparency
			})
			table.insert(t, {
				Property = "BackgroundTransparency",
				Instance = v2,
				Original = v2.BackgroundTransparency
			})

			continue
		end

		if v2:IsA("Frame") then
			table.insert(t, {
				Property = "BackgroundTransparency",
				Instance = v2,
				Original = v2.BackgroundTransparency
			})
		end
	end

	return t
end

local function ApplyFade(p1, p2) --[[ ApplyFade | Line: 273 ]]
	for v1, v2 in p1 do
		v2.Instance[v2.Property] = v2.Original + (1 - v2.Original) * p2
	end
end

local function WhiteWash(p1) --[[ WhiteWash | Line: 280 | Upvalues: CollectionService (copy) ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			for v3, v4 in CollectionService:GetTags(v2) do
				CollectionService:RemoveTag(v2, v4)
			end

			v2.Color = Color3.new(255/255, 255/255, 255/255)
			v2.Material = Enum.Material.SmoothPlastic

			continue
		end

		if v2:IsA("Decal") or v2:IsA("Texture") then
			v2:Destroy()
		end
	end
end

local function UpdateLabelPosition(p1, p2) --[[ UpdateLabelPosition | Line: 296 ]]
	p1.CFrame = CFrame.new(p2.Position + Vector3.new(0, 5, 0))
end

local function ApplyBlackHighlight(p1) --[[ ApplyBlackHighlight | Line: 301 ]]
	local Highlight = Instance.new("Highlight")

	Highlight.FillColor = Color3.new(0/255, 0/255, 0/255)
	Highlight.FillTransparency = 0
	Highlight.OutlineColor = Color3.new(0/255, 0/255, 0/255)
	Highlight.OutlineTransparency = 1
	Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	Highlight.Parent = p1

	return Highlight
end

local function ApplySemiTransparency(p1, p2) --[[ ApplySemiTransparency | Line: 314 ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			table.insert(t, {
				Instance = v2,
				Original = v2.Transparency
			})
			v2.Transparency = v2.Transparency + (1 - v2.Transparency) * p2

			continue
		end

		if v2:IsA("Decal") or v2:IsA("Texture") then
			table.insert(t, {
				Instance = v2,
				Original = v2.Transparency
			})
			v2.Transparency = v2.Transparency + (1 - v2.Transparency) * p2
		end
	end

	return t
end

local function RestoreSemiTransparency(p1) --[[ RestoreSemiTransparency | Line: 331 ]]
	for v1, v2 in p1 do
		if v2.Instance and v2.Instance.Parent then
			v2.Instance.Transparency = v2.Original
		end
	end
end

local function GetAllSeedNames() --[[ GetAllSeedNames | Line: 343 | Upvalues: Seeds (copy) ]]
	local t = {}

	for v1, v2 in Seeds:GetChildren() do
		if v2:IsA("Model") or v2:IsA("BasePart") then
			table.insert(t, v2.Name)
		end
	end

	return t
end

local function BuildSlotSequence(p1, p2, p3) --[[ BuildSlotSequence | Line: 353 | Upvalues: SeedPackData (copy), SeedData (copy) ]]
	local t = {}
	local v1 = SeedPackData.GetData(p3)
	local t2 = {}

	if v1 and v1.Seeds then
		for v2, v3 in v1.Seeds do
			if not table.find(t2, v3.SeedName) then
				table.insert(t2, v3.SeedName)
			end
		end
	elseif v1 and v1.CustomProgressBased then
		for v4, v5 in SeedData do
			if v5.RestockShop and not table.find(t2, v5.SeedName) then
				table.insert(t2, v5.SeedName)
			end
		end
	end

	if #t2 == 0 then
		for i = 1, p2 do
			table.insert(t, p1)
		end
	else
		local list = {}

		for v6, v7 in t2 do
			local v8 = nil

			for v9, v10 in SeedData do
				if v10.SeedName == v7 then
					v8 = v10

					break
				end
			end

			local t3 = {
				Name = v7
			}

			t3.Price = v8 and v8.PurchasePrice or 0
			table.insert(list, t3)
		end

		table.sort(list, function(p1, p2) --[[ Line: 394 ]]
			return p1.Price < p2.Price
		end)

		local v12 = 1

		for i, v in ipairs(list) do
			if v.Name == p1 then
				v12 = i

				break
			end
		end

		local t3 = {}
		local v13 = v12 - 1

		if v13 >= 1 then
			table.insert(t3, {
				Weight = 60,
				Index = v13
			})
		end

		table.insert(t3, {
			Weight = 20,
			Index = v12
		})

		local count = v12 + 1
		local v14 = 10

		while count <= #list and v14 >= 0.1 do
			table.insert(t3, {
				Index = count,
				Weight = v14
			})
			count = count + 1
			v14 = v14 / 2
		end

		local sum = 0

		for v15, v16 in t3 do
			sum = sum + v16.Weight
		end

		local function PickFromPool(p1) --[[ PickFromPool | Line: 426 | Upvalues: sum (ref), t3 (copy), list (copy) ]]
			for i = 1, 20 do
				local v1 = math.random() * sum
				local sum2 = 0

				for i2, v in ipairs(t3) do
					sum2 = sum2 + v.Weight

					if v1 <= sum2 then
						local v2 = list[v.Index].Name

						if v2 ~= p1 then
							return v2
						end

						break
					end
				end
			end

			for i, v in ipairs(t3) do
				if list[v.Index].Name ~= p1 then
					return list[v.Index].Name
				end
			end

			return list[t3[1].Index].Name
		end

		for j = 1, p2 - 2 do
			table.insert(t, (PickFromPool(j > 1 and t[j - 1] or nil)))
		end

		local v19 = false

		if math.random(1, 5) == 1 then
			local v20 = math.min(v12 + 3, #list)

			if v12 < v20 then
				local v21 = #t > 0 and t[#t] or nil
				local v22 = list[v20].Name

				if v22 == v21 and v20 < #list then
					v22 = list[v20 + 1].Name
				elseif v22 == v21 and v12 + 1 < v20 then
					v22 = list[v20 - 1].Name
				end

				table.insert(t, v22)
				v19 = true
			end
		end

		if not v19 then
			table.insert(t, (PickFromPool(#t > 0 and t[#t] or nil)))
		end

		table.insert(t, p1)
	end

	return t
end

local function GetSlotInterval(p1, p2) --[[ GetSlotInterval | Line: 480 ]]
	local v1 = p1 / p2

	return v1 * v1 * 0.6 + 0.1
end

local RarityData = game.ReplicatedStorage.SharedModules.RarityData

local function PrepareSeedModel(p1) --[[ PrepareSeedModel | Line: 488 | Upvalues: Seeds (copy), SetModelAnchored (copy), SeedNameAttachment (copy), SeedData (copy), RarityData (copy) ]]
	local v1 = Seeds:FindFirstChild(p1)

	if not v1 then
		return nil, nil, nil
	end

	local v2 = v1:Clone()

	if v2:IsA("BasePart") then
		local Model = Instance.new("Model")

		Model.Name = p1
		v2.Parent = Model
		Model.PrimaryPart = v2
		v2 = Model
	end

	if not v2.PrimaryPart then
		local Center = v2:FindFirstChild("Center")

		if Center then
			v2.PrimaryPart = Center
		else
			local v3 = v2:FindFirstChildWhichIsA("BasePart", true)

			if v3 then
				v2.PrimaryPart = v3
			end
		end
	end

	SetModelAnchored(v2)

	local v4 = SeedNameAttachment:Clone()

	v4.Parent = game.Workspace.Temporary

	local v5 = nil

	for k, v in pairs(SeedData) do
		if v.SeedName == p1 then
			v5 = v
		end
	end

	local v6

	if v5 then
		local Rarity = v5.Rarity
		local v7 = RarityData.Gradients:FindFirstChild(Rarity)

		v4.BillboardGui.Rarity_Name.TextLabel.Text = Rarity
		v4.BillboardGui.Rarity_Name.Text = Rarity

		if v7 then
			v7:Clone().Parent = v4.BillboardGui.Rarity_Name.TextLabel
			v7:Clone().Parent = v4.BillboardGui.Rarity_Name
		end

		v6 = v7
	else
		v6 = nil
	end

	v4.BillboardGui.Seed_Name.TextLabel.Text = p1
	v4.BillboardGui.Seed_Name.Text = p1

	return v2, v4, v6
end

function t.Init(p1) --[[ Init | Line: 540 ]] end
function t.Start(p1) --[[ Start | Line: 543 | Upvalues: Networking (copy), SeedPackEffect (copy), Players (copy) ]]
	Networking.SeedPack.ReplicateOpenSeedPack.OnClientEvent:Connect(function(p1, p2, p3, p4, p5) --[[ Line: 544 | Upvalues: SeedPackEffect (ref), Players (ref), Networking (ref) ]]
		if p1 and p1.Character then
			local Position = p1.Character.HumanoidRootPart.Position
			local v1 = CFrame.new(p5, p5 + CFrame.new(p5, Position).LookVector)

			task.spawn(function() --[[ Line: 551 | Upvalues: SeedPackEffect (ref), p2 (copy), p3 (copy), p4 (copy), Position (copy), v1 (copy), p1 (copy), Players (ref), Networking (ref) ]]
				SeedPackEffect.Open(p2, p3, p4, Position, v1)

				if p1 ~= Players.LocalPlayer then
					return
				end

				Networking.SeedPack.ConfirmSeedPack:Fire(p2, p3, p4)
			end)
		end
	end)
	Networking.SeedPack.ConfirmSeedPack.OnClientEvent:Connect(function(p1, p2) --[[ Line: 564 | Upvalues: SeedPackEffect (ref) ]]
		SeedPackEffect.UpdateDropData(p1, p2)
	end)
end
function t.ReturnRandomItem(p1, p2) --[[ ReturnRandomItem | Line: 569 ]]
	local sum = 0

	for k, v in pairs(p2) do
		sum = sum + v.Chance
	end

	local v1 = math.random() * sum
	local sum2 = 0

	for k, v in pairs(p2) do
		sum2 = sum2 + v.Chance

		if v1 <= sum2 then
			return v
		end
	end

	return p2[#p2]
end
function t.PlaySFXLocation(p1, p2, p3) --[[ PlaySFXLocation | Line: 587 ]]
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.Size = Vector3.new(1, 1, 1)
	Part.Parent = game.Workspace.Temporary
	Part.Transparency = 1
	Part.Position = p3

	local v1 = p2:Clone()

	v1.Parent = Part
	v1.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	v1.Playing = true
	game.Debris:AddItem(Part, v1.TimeLength * v1.PlaybackSpeed)
end
function t.Roll(p1, p2, p3) --[[ Roll | Line: 1024 ]]
	return if p3 then p3 else p1:ReturnRandomItem(p2)
end

return t