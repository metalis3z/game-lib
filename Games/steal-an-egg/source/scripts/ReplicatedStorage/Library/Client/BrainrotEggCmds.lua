-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Functions = require(ReplicatedStorage.Library.Functions)
local Audio = require(ReplicatedStorage.Library.Audio)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new():LimitUnderLevel("Debug")

require(script.Types)

local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local ItemDisplay = require(ReplicatedStorage.Library.Modules.ItemDisplay)

require(ReplicatedStorage.Library.Types.AssetItem)

local Assets = require(ReplicatedStorage.Directory.Assets)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local AssetModelStreaming = require(ReplicatedStorage.Library.Client.AssetModelStreaming)
local Directory = Assets.Directory
local InstanceCache = require(ReplicatedStorage.Library.Modules.Packages.InstanceCache)
local GetAssetsSoundParams = require(ReplicatedStorage.Library.Util.GetAssetsSoundParams)
local BBFromArrayVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromArrayVisibleOnly)
local AssetSoundUtil = require(ReplicatedStorage.Library.Util.AssetSoundUtil)
local RarityNumber = Rarities.BrainrotGod.RarityNumber
local t = {}
local __OBJECTS = workspace:WaitForChild("__OBJECTS")
local BrainrotRollModelPool = __OBJECTS:FindFirstChild("BrainrotRollModelPool")

if not BrainrotRollModelPool then
	BrainrotRollModelPool = Instance.new("Folder")
	assert(BrainrotRollModelPool, "luau")
	BrainrotRollModelPool.Name = "BrainrotRollModelPool"
	BrainrotRollModelPool.Parent = __OBJECTS
end

local t2 = {
	AnyBrainrotEggOpened = Signal.new(),
	LocalPlayerBrainrotEggOpened = Signal.new(),
	LocalPlayerBrainrotEggOpenCompleted = Signal.new()
}

local function setModelAnchoredState(p1, p2) --[[ setModelAnchoredState | Line: 88 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = p2
		end
	end
end

local function setRollModelPhysics(p1, p2, p3) --[[ setRollModelPhysics | Line: 96 ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			if p3 then
				if v == p1.PrimaryPart then
					v.Anchored = p2
				end
			else
				v.Anchored = p2
			end

			v.CanCollide = false
			v.CanQuery = false
			v.CanTouch = false
			v.Massless = true
		end
	end
end

local function stripHumanoidAndAnimation(p1) --[[ stripHumanoidAndAnimation | Line: 114 | Upvalues: ItemDisplay (copy) ]]
	ItemDisplay.StripRuntimeRig(p1, true, true)
end

local function forceLoadRollAssetModels(p1) --[[ forceLoadRollAssetModels | Line: 118 | Upvalues: AssetModelStreaming (copy), v1 (copy) ]]
	local t = {}
	local t2 = {}

	for i, v in ipairs(p1) do
		local Category = v.Category

		if not t[Category] then
			t[Category] = true
			table.insert(t2, Category)
		end
	end

	if #t2 == 0 then
		return true
	end

	local ok, result = pcall(function() --[[ Line: 135 | Upvalues: AssetModelStreaming (ref), t2 (copy) ]]
		AssetModelStreaming.ForceLoadAssetModels(t2)
	end)

	if ok then
		return true
	end

	v1:AtWarning():Log((("Roll asset model force-load failed: %*"):format((tostring(result)))))

	return false
end

local function createExternalRollModel(p1, p2, p3) --[[ createExternalRollModel | Line: 146 | Upvalues: AssetModelStreaming (copy), ItemDisplay (copy) ]]
	if p3 ~= true then
		AssetModelStreaming.ForceLoadAssetModels({ p1.Category })
	end

	local v1 = ItemDisplay.CreateActiveModel(nil, p1, true, true, true)

	ItemDisplay.StripRuntimeRig(v1, true, true)

	local FXPart = v1:FindFirstChild("FXPart")

	if p2 then
		local AnimationBillboard = ItemDisplay.CreateDataBillboard(v1, p1.Category, p1)

		if AnimationBillboard then
			AnimationBillboard.Name = "AnimationBillboard"
			AnimationBillboard.MaxDistance = 80
			AnimationBillboard.Enabled = true
		end
	end

	return v1, FXPart
end

local function attachGroundPivotAnchor(p1, p2) --[[ attachGroundPivotAnchor | Line: 171 | Upvalues: BBFromArrayVisibleOnly (copy) ]]
	local PivotAnchor = p1:FindFirstChild("PivotAnchor")

	if PivotAnchor and PivotAnchor:IsA("BasePart") then
		p1.PrimaryPart = PivotAnchor

		return
	end

	local v1 = p1.PrimaryPart or p1:FindFirstChild("HumanoidRootPart")

	if not (v1 and v1:IsA("BasePart")) then
		return
	end

	if p2 then
		p1:PivotTo(p2)
	end

	local v2, v3 = BBFromArrayVisibleOnly(p1)
	local v4 = v2.Position.Y - v3.Y * 0.5
	local v5, v6

	if p2 then
		local v7 = Vector3.new(p2.Position.X, v4, p2.Position.Z)

		v5 = p2.Rotation
		v6 = v7
	else
		local v9 = v2.Position - Vector3.new(0, v3.Y * 0.5, 0)

		v5 = v1.CFrame.Rotation
		v6 = v9
	end

	local PivotAnchor2 = Instance.new("Part")

	PivotAnchor2.Name = "PivotAnchor"
	PivotAnchor2.Size = Vector3.new(0.1, 0.1, 0.1)
	PivotAnchor2.Transparency = 1
	PivotAnchor2.CanCollide = false
	PivotAnchor2.CanQuery = false
	PivotAnchor2.CanTouch = false
	PivotAnchor2.Massless = true
	PivotAnchor2.Anchored = v1.Anchored
	PivotAnchor2.CFrame = v5 + v6
	PivotAnchor2.Parent = p1
	p1.PrimaryPart = PivotAnchor2

	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Part0 = PivotAnchor2
	WeldConstraint.Part1 = v1
	WeldConstraint.Parent = PivotAnchor2
end

function stripModelForPooling(p1) --[[ stripModelForPooling | Line: 225 | Upvalues: setModelAnchoredState (copy) ]]
	local list = {}

	for i, v in ipairs(p1:GetDescendants()) do
		if v.Name == "InitialPoses" or (v:IsA("Motor6D") or (v:IsA("Motor") or (v:IsA("Bone") or v:IsA("Constraint") and v.Name ~= "WeldConstraint"))) or (v:IsA("AnimationController") or v:IsA("Animator")) then
			table.insert(list, v)
		end
	end

	for i, v in ipairs(list) do
		v:Destroy()
	end

	setModelAnchoredState(p1, true)

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
			v.CanQuery = false
			v.CanTouch = false
			v.Massless = true
		end
	end
end

local function cleanupRollModel(p1) --[[ cleanupRollModel | Line: 258 | Upvalues: Mutations (copy) ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v:Destroy()
		end
	end

	stripModelForPooling(p1)
	Mutations.RemoveAllMutations(p1)

	local v1 = p1:GetAttribute("BrainrotRollBaseScale")

	if typeof(v1) ~= "number" then
		local v2 = p1:GetScale()

		p1:SetAttribute("BrainrotRollBaseScale", v2)
		v1 = v2
	end

	return v1
end

local function moveModelToHiddenSpace(p1) --[[ moveModelToHiddenSpace | Line: 277 | Upvalues: InstanceCache (copy), BrainrotRollModelPool (ref) ]]
	p1:PivotTo(InstanceCache.GetRandomHiddenCFrame())
	p1.Parent = BrainrotRollModelPool
end

local function resolveRollDefaultScale(p1) --[[ resolveRollDefaultScale | Line: 282 | Upvalues: Directory (copy) ]]
	local v1 = Directory[p1.Category]

	return (if v1 then v1.BaseModelScale or 1 else 1) * (p1.Scale or 1)
end

local function createRollModelForCategory(p1, p2) --[[ createRollModelForCategory | Line: 290 | Upvalues: AssetModelStreaming (copy), Personalities (copy), ItemDisplay (copy), cleanupRollModel (copy) ]]
	if p2 ~= true then
		AssetModelStreaming.ForceLoadAssetModels({ p1 })
	end

	local v1 = ItemDisplay.CreateActiveModel(nil, {
		Scale = 1,
		HasBeenFirstPlaced = true,
		Category = p1,
		Mutations = {},
		Personality = Personalities.Personalities.Normal
	})

	cleanupRollModel(v1)

	return v1
end

local function acquirePooledRollModel(p1, p2, p3) --[[ acquirePooledRollModel | Line: 308 | Upvalues: t (copy), Directory (copy), cleanupRollModel (copy), setModelAnchoredState (copy), createRollModelForCategory (copy) ]]
	local Category = p1.Category
	local v1 = t[Category]
	local v2 = Directory[p1.Category]
	local v4 = (if v2 then v2.BaseModelScale or 1 else 1) * (p1.Scale or 1)
	local v5 = if p2 == nil then true else p2

	if v1 and #v1 > 0 then
		local v6 = table.remove(v1)

		assert(v6, "pooled model missing")
		cleanupRollModel(v6)
		v6:ScaleTo(v4)

		if not v5 then
			setModelAnchoredState(v6, false)
		end

		return v6, v4
	end

	local v7 = createRollModelForCategory(Category, p3)

	v7:ScaleTo(v4)

	if not v5 then
		setModelAnchoredState(v7, false)
	end

	return v7, v4
end

local function releasePooledRollModel(p1, p2) --[[ releasePooledRollModel | Line: 343 | Upvalues: t (copy), cleanupRollModel (copy), InstanceCache (copy), BrainrotRollModelPool (ref) ]]
	local v1 = t[p1]

	if not v1 then
		v1 = {}
		t[p1] = v1
	end

	if #v1 >= 5 then
		p2:Destroy()
	else
		p2:ScaleTo((cleanupRollModel(p2)))
		p2:PivotTo(InstanceCache.GetRandomHiddenCFrame())
		p2.Parent = BrainrotRollModelPool
		table.insert(v1, p2)
	end
end

local function cloneArray(p1) --[[ cloneArray | Line: 362 ]]
	if p1 == nil then
		return {}
	end

	return table.clone(p1)
end

local function cloneRollAssetItemData(p1) --[[ cloneRollAssetItemData | Line: 370 ]]
	local v1 = table.clone(p1)

	if v1.Mutations then
		local Mutations = v1.Mutations

		v1.Mutations = if Mutations == nil then {} else table.clone(Mutations)
	end

	return v1
end

local function buildRollAssetItemDatas(p1, p2, p3, p4) --[[ buildRollAssetItemDatas | Line: 380 ]]
	if not p2 then
		return {}, 0
	end

	local v1 = if p1 then p1.DropTable else nil
	local Category = p2.Category
	local v2 = p2.Mutations or p3 or {}
	local v3 = p2.Scale or (p4 or 1)
	local t = {}
	local t2 = {}
	local v4 = 0

	local function addCategory(p1) --[[ addCategory | Line: 399 | Upvalues: t2 (copy), v2 (copy), v3 (copy), p2 (copy), Category (copy), t (copy), v4 (ref) ]]
		if typeof(p1) ~= "string" or t2[p1] then
			return
		end

		t2[p1] = true

		local t3 = {
			Category = p1
		}
		local v1 = v2

		t3.Mutations = if v1 == nil then {} else table.clone(v1)
		t3.Scale = v3
		t3.Personality = p2.Personality
		t3.HasBeenFirstPlaced = p2.HasBeenFirstPlaced

		if p1 == Category then
			local Mutations = p2.Mutations

			t3.Mutations = if Mutations == nil then {} else table.clone(Mutations)
			t3.Scale = p2.Scale or v3
		end

		table.insert(t, t3)

		if p1 ~= Category then
			return
		end

		v4 = #t
	end

	if v1 then
		for i, v in ipairs(v1) do
			local v5 = v[1]

			if v5 ~= Category then
				addCategory(v5)
			end
		end
	end

	addCategory(Category)

	if v4 == 0 then
		v4 = #t
	end

	return t, v4
end

local function applyBlackHighlight(p1) --[[ applyBlackHighlight | Line: 444 ]]
	local GuardCaughtRevealHighlight = p1:FindFirstChild("GuardCaughtRevealHighlight", true)

	if not (GuardCaughtRevealHighlight and GuardCaughtRevealHighlight:IsA("Highlight")) then
		local v1 = p1:FindFirstChild("Model") or p1
		local GuardCaughtRevealHighlight2 = Instance.new("Highlight")

		GuardCaughtRevealHighlight2.Name = "GuardCaughtRevealHighlight"
		GuardCaughtRevealHighlight2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		GuardCaughtRevealHighlight2.FillColor = Color3.new(0/255, 0/255, 0/255)
		GuardCaughtRevealHighlight2.FillTransparency = 0
		GuardCaughtRevealHighlight2.OutlineColor = Color3.new(0/255, 0/255, 0/255)
		GuardCaughtRevealHighlight2.OutlineTransparency = 1
		GuardCaughtRevealHighlight2.Parent = v1
	end
end

local function playRollAnimation(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11) --[[ playRollAnimation | Line: 462 | Upvalues: forceLoadRollAssetModels (copy), ItemDisplay (copy), applyBlackHighlight (copy), setRollModelPhysics (copy), attachGroundPivotAnchor (copy), Trove (copy), acquirePooledRollModel (copy), releasePooledRollModel (copy), RenderStepped (copy), Functions (copy), Audio (copy) ]]
	local v1 = #p4

	if v1 == 0 then
		return nil
	end

	if forceLoadRollAssetModels(p4) then
		local v2 = if p7 == nil then true else p7
		local v3 = if p8 == nil then true else p8
		local v4 = if p10 == true then true else false
		local v5 = p2:IsA("BasePart")
		local v6 = if v5 then p2 else nil
		local v7 = false
		local v9 = ItemDisplay.CreateActiveModel(nil, p4[p5], true, true, true)

		ItemDisplay.StripRuntimeRig(v9, true, true)
		v9:FindFirstChild("FXPart")

		local v10 = v9

		v10.Parent = p2
		applyBlackHighlight(v10)

		if v5 then
			for i, v in ipairs(v10:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Massless = true
					v.Anchored = v2
					v.CanCollide = false
					v.CanQuery = false
					v.CanTouch = false
				end

				if v:IsA("MeshPart") then
					v.Transparency = 0
				end
			end
		else
			setRollModelPhysics(v10, v2, true)
		end

		if v4 then
			attachGroundPivotAnchor(v10, p3)
		end

		v10:PivotTo(p3)

		if v5 then
			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = v6
			WeldConstraint.Part1 = v10.PrimaryPart
			WeldConstraint.Parent = v10.PrimaryPart
		end

		if v1 == 1 then
			if p11 ~= nil and not v7 then
				p11(v10)
			end
		else
			local function shouldFinalizeEarly() --[[ shouldFinalizeEarly | Line: 542 | Upvalues: p1 (copy) ]]
				return if p1 == nil then false else p1.forceFinalize == true
			end

			if if p1 == nil then false elseif p1.forceFinalize == true then true else false then
				if p11 ~= nil and not v7 then
					p11(v10)
				end
			else
				local v12 = Trove.new()
				local v13 = table.create(v1)
				local v14 = table.create(v1)

				v13[p5] = v10
				v14[p5] = v10:GetScale()

				local v15

				for i, v in ipairs(p4) do
					local v16

					if i ~= p5 then
						if v3 then
							local v17, v18 = acquirePooledRollModel(v, v2, true)

							v15 = v17
							v17.Parent = p2
							v16 = v18
						else
							local v19 = ItemDisplay.CreateActiveModel(nil, v, true, true, true)

							ItemDisplay.StripRuntimeRig(v19, true, true)
							v19:FindFirstChild("FXPart")
							v15 = v19
							v19.Parent = p2

							if v4 then
								attachGroundPivotAnchor(v19, p3)
							end

							v16 = v19:GetScale()
						end

						applyBlackHighlight(v15)
						v15:PivotTo(p3)

						if v5 then
							for i2, v17 in ipairs(v15:GetDescendants()) do
								if v17:IsA("BasePart") then
									v17.Massless = true
									v17.Anchored = v2
									v17.CanCollide = false
									v17.CanQuery = false
									v17.CanTouch = false
								end
							end
						else
							setRollModelPhysics(v15, v2, true)
						end

						v14[i] = v16
						v13[i] = v15

						if v3 then
							v12:Add(function() --[[ Line: 607 | Upvalues: releasePooledRollModel (ref), v (copy), v15 (ref) ]]
								releasePooledRollModel(v.Category, v15)
							end)
						else
							v12:Add(function() --[[ Line: 611 | Upvalues: v15 (ref) ]]
								if not (v15 and v15.Parent) then
									return
								end

								v15:Destroy()
							end)
						end
					end
				end

				if if p1 == nil then false elseif p1.forceFinalize == true then true else false then
					v12:Destroy()

					if p11 ~= nil and not v7 then
						p11(v10)
					end
				else
					local list = {}
					local v22 = 0

					for i, v in ipairs(v13) do
						if v5 then
							local PrimaryPart = v.PrimaryPart

							if i ~= p5 then
								local WeldConstraint = Instance.new("WeldConstraint")

								assert(v6, "luau")
								WeldConstraint.Part0 = v6
								WeldConstraint.Part1 = PrimaryPart
								WeldConstraint.Parent = PrimaryPart
								table.insert(list, WeldConstraint)
							end
						end
					end

					local function updateModels(p1, p2) --[[ updateModels | Line: 652 | Upvalues: v22 (ref), v13 (copy), v14 (copy), v1 (copy) ]]
						local v12 = os.clock()

						if not p2 and v12 - v22 < 0.03333333333333333 then
							return 0
						end

						v22 = v12

						local Position = workspace.CurrentCamera.CFrame.Position

						for i, v in ipairs(v13) do
							local v2 = v14[i] or 1
							local v6 = math.clamp(v2 * math.sin(math.clamp((p1 - (i - 1)) % v1 * 0.5, 0, 1) * math.pi) * 1.01, 0.0001, v2)

							if not ((Position - v:GetPivot().Position).Magnitude > 250) and v.Parent then
								v:ScaleTo(v6)
							end
						end
					end

					updateModels(0)

					local v23 = v1 * 12 + p5
					local v24 = v23 - 1
					local v25 = 1 % v1

					RenderStepped(function(p12, p2) --[[ Line: 696 | Upvalues: p1 (copy), v23 (copy), Functions (ref), updateModels (copy), v1 (copy), v25 (ref), v24 (copy), Audio (ref), p3 (copy), v7 (ref), p11 (copy), v10 (copy) ]]
						if if p1 == nil then false else p1.forceFinalize == true then
							return true
						end

						local v2 = 0 + (v23 - 0) * Functions.Easing(p2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

						updateModels(v2)

						local v3 = math.floor(v2 + 1) % v1

						if v3 ~= v25 then
							v25 = v3

							if v2 < v24 then
								Audio.Play(16580611883, p3, 1, 2.5, 100)
							end
						end

						if v7 or not (v24 <= v2) then
							return false
						end

						v7 = true

						if p11 == nil then
							return false
						end

						p11(v10)

						return false
					end, p6, true):Wait()
					updateModels(v23)

					if not v7 and p11 ~= nil then
						p11(v10)
					end

					for i, v in ipairs(list) do
						if v then
							v:Destroy()
						end
					end

					v12:Destroy()
				end
			end
		end

		if not p1 then
			return v10
		end

		p1.forceFinalize = nil

		return v10
	end

	if not p1 then
		return nil
	end

	p1.forceFinalize = nil

	return nil
end

local function getRollEffectTarget(p1) --[[ getRollEffectTarget | Line: 743 ]]
	local PrimaryPart = p1.PrimaryPart

	if PrimaryPart then
		return PrimaryPart
	end

	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
		return HumanoidRootPart
	end

	local CENTER = p1:FindFirstChild("CENTER")

	if CENTER and CENTER:IsA("BasePart") then
		return CENTER
	end

	return p1
end

local function playRollResultSound(p1, p2, p3) --[[ playRollResultSound | Line: 762 | Upvalues: Directory (copy), RarityNumber (copy), AssetSoundUtil (copy), ItemDisplay (copy), GetAssetsSoundParams (copy), Audio (copy) ]]
	local Category = p2.Category

	if typeof(Category) ~= "string" then
		return
	end

	local v1 = Directory[Category]

	if not v1 then
		return
	end

	local PlaceSound = v1.PlaceSound

	if not PlaceSound then
		return
	end

	local Rarity = v1.Rarity
	local v2 = if Rarity then Rarity.RarityNumber else Rarity

	if not p3 and (typeof(v2) ~= "number" or v2 < RarityNumber) then
		return
	end

	local PrimaryPart = p1.PrimaryPart
	local v3

	if PrimaryPart then
		v3 = PrimaryPart
	else
		local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

		if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
			v3 = HumanoidRootPart
		else
			local CENTER = p1:FindFirstChild("CENTER")

			v3 = if CENTER and CENTER:IsA("BasePart") then CENTER else p1
		end
	end

	local v4 = AssetSoundUtil.CloneSoundFileWithMutationPlaybackSpeed(PlaceSound, p2.Mutations)
	local v5, v6 = GetAssetsSoundParams((ItemDisplay.GetDisplayScale(p2.Scale)))
	local Volume = v4.Data.Volume

	if typeof(Volume) == "number" then
		v4.Data.Volume = Volume * v5
	else
		v4.Data.Volume = v5
	end

	local PitchShiftSoundEffect = Instance.new("PitchShiftSoundEffect")

	PitchShiftSoundEffect.Octave = v6
	Audio.PlayFromSoundFile(v4, v3.CFrame, (AssetSoundUtil.BuildPlaybackEffectChildren({ PitchShiftSoundEffect }, p2.Mutations)))
end

function t2.CreateExternalRollResultModel(p1) --[[ CreateExternalRollResultModel | Line: 811 | Upvalues: Asserts (copy), AssetModelStreaming (copy), ItemDisplay (copy), attachGroundPivotAnchor (copy), setRollModelPhysics (copy), playRollResultSound (copy) ]]
	Asserts.table(p1)
	Asserts.Instance(p1.parent)
	Asserts.table(p1.assetItemData)

	local v1 = if typeof(p1.pivot) == "function" then p1.pivot() else p1.pivot
	local v2 = table.clone(p1.assetItemData)

	if v2.Mutations then
		local Mutations = v2.Mutations

		v2.Mutations = if Mutations == nil then {} else table.clone(Mutations)
	end

	AssetModelStreaming.ForceLoadAssetModels({ v2.Category })

	local v5 = ItemDisplay.CreateActiveModel(nil, v2, true, true, true)

	ItemDisplay.StripRuntimeRig(v5, true, true)
	v5:FindFirstChild("FXPart")

	if p1.groundAlignToPivot == true then
		attachGroundPivotAnchor(v5)
	end

	local v6 = v5

	v6.Parent = p1.parent

	local v7

	if p1.parent:IsA("BasePart") then
		v7 = v2

		for i, v in ipairs(v6:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Massless = true
				v.Anchored = true
				v.CanCollide = false
				v.CanQuery = false
				v.CanTouch = false
			end

			if v:IsA("MeshPart") then
				v.Transparency = 0
			end
		end

		v6:PivotTo(v1)

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = p1.parent
		WeldConstraint.Part1 = v6.PrimaryPart
		WeldConstraint.Parent = v6.PrimaryPart
	else
		setRollModelPhysics(v6, true, true)
		v6:PivotTo(v1)
		v7 = v2
	end

	if p1.playResultSound ~= false then
		playRollResultSound(v6, v7, true)
	end

	return v6
end
function t2.PlayExternalRollAnimation(p1) --[[ PlayExternalRollAnimation | Line: 862 | Upvalues: Asserts (copy), Rarity (copy), v1 (copy), buildRollAssetItemDatas (copy), Audio (copy), playRollAnimation (copy), playRollResultSound (copy) ]]
	Asserts.table(p1)
	Asserts.Instance(p1.parent)
	Asserts.table(p1.dropTable)
	Asserts.table(p1.assetItemData)
	Asserts.optional.func(p1.onFinalModelWillShow)

	local eggRarityAttr = p1.eggRarityAttr
	local v12 = table.clone(p1.assetItemData)

	if v12.Mutations then
		local Mutations = v12.Mutations

		v12.Mutations = if Mutations == nil then {} else table.clone(Mutations)
	end

	local v4, v5 = buildRollAssetItemDatas({
		DropTable = p1.dropTable
	}, v12, p1.eggMutations, p1.eggScale)

	if #v4 == 0 then
		return nil
	end

	local v6 = v4[v5]

	if not v6 then
		return nil
	end

	local function getPivotCFrame() --[[ getPivotCFrame | Line: 906 | Upvalues: p1 (copy) ]]
		if typeof(p1.pivot) == "function" then
			return p1.pivot()
		end

		return p1.pivot
	end

	local v7 = if typeof(p1.pivot) == "function" then p1.pivot() else p1.pivot

	Audio.Play("rbxassetid://79565241490029", v7)

	local v9 = playRollAnimation(nil, p1.parent, v7, v4, v5, p1.rollDuration or 6, true, p1.usePooledRollModels, p1.useStaticRollModels, p1.groundAlignToPivot, p1.onFinalModelWillShow)

	if v9 then
		playRollResultSound(v9, v6, true)
	end

	return v9
end

return t2