-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local AssetViewport = require(ReplicatedStorage.Library.Client.AssetViewport)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Assets = require(ReplicatedStorage.Directory.Assets)
local GradientSwap = require(ReplicatedStorage.Library.Functions.GradientSwap)

require(ReplicatedStorage.Directory.LimitedEgg.Types.Interface)

local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)

require(ReplicatedStorage.Library.Modules.Packages.Trove)
require(script.Parent.Types.Interface)

local Directory = Assets.Directory
local v1 = Log.new()
local t = {}

local function getViewportExtent(p1) --[[ getViewportExtent | Line: 57 ]]
	local AbsoluteSize = p1.Frame.AbsoluteSize

	return math.sqrt((math.max(AbsoluteSize.X * AbsoluteSize.Y, 1)))
end

local function getViewportScale(p1, p2) --[[ getViewportScale | Line: 62 ]]
	return math.min((p1 / p2 - 1) * 0.3, 0.08000000000000007) + 1
end

local function getTargetYaw(p1) --[[ getTargetYaw | Line: 67 ]]
	return 0.2617993877991494 - 0.6666666666666666 * math.atan(p1 * 1.5)
end

local function getCameraFraming(p1, p2, p3) --[[ getCameraFraming | Line: 74 ]]
	local v1 = p1.Position - p2

	return Vector2.new(v1.X, v1.Z).Magnitude / p3, v1.Y / p3
end

local function addViewportState(p1, p2, p3, p4, p5, p6) --[[ addViewportState | Line: 79 | Upvalues: AssetViewport (copy) ]]
	p2.Chance.Text = string.format("%.0f%%", p4)

	local LimitedEggAssetViewport = AssetViewport.Create(p2.Frame)

	LimitedEggAssetViewport.Name = "LimitedEggAssetViewport"
	p1:Add(LimitedEggAssetViewport)

	local _, v1, v2 = AssetViewport.AttachOnViewport(p3, LimitedEggAssetViewport, true)

	assert(if v1 == nil then false else true, (("Limited egg asset model \"%*\" is not replicated"):format(p3)))
	assert(if v2 == nil then false else true, (("Limited egg asset model \"%*\" did not attach"):format(p3)))

	local LimitedEggAssetViewportShadow = LimitedEggAssetViewport:Clone()

	LimitedEggAssetViewportShadow.Name = "LimitedEggAssetViewportShadow"
	LimitedEggAssetViewportShadow.Position = UDim2.fromScale(0.45, 0.54)
	LimitedEggAssetViewportShadow.ImageColor3 = Color3.new(0/255, 0/255, 0/255)
	LimitedEggAssetViewportShadow.ImageTransparency = 0.5
	LimitedEggAssetViewportShadow.ZIndex = LimitedEggAssetViewport.ZIndex - 1
	LimitedEggAssetViewportShadow.Parent = p2.Frame
	p1:Add(LimitedEggAssetViewportShadow)

	local v7 = LimitedEggAssetViewportShadow:FindFirstChildWhichIsA("WorldModel")

	assert(if v7 == nil then false else true, "Limited egg shadow viewport requires its cloned WorldModel")

	local v9 = v7:FindFirstChildWhichIsA("Model")

	assert(if v9 == nil then false else true, "Limited egg shadow viewport requires its cloned asset model")

	local v11 = AssetViewport.PlayIdleAnimation(p3, v9)

	assert(if v11 == nil then false else true, (("Limited egg shadow asset \"%*\" requires an Idle animation and Animator"):format(p3)))
	p1:Add(v11)

	local v14 = LimitedEggAssetViewportShadow:FindFirstChildWhichIsA("Camera")

	assert(if v14 == nil then false else true, "Limited egg shadow viewport requires its cloned camera")
	LimitedEggAssetViewportShadow.CurrentCamera = v14

	local Rotation = v2:GetPivot().Rotation
	local Rotation2 = v9:GetPivot().Rotation
	local v16, v17 = v2:GetBoundingBox()
	local v18, v19 = v9:GetBoundingBox()
	local v20 = v16.Position - Rotation.UpVector * v17.Y * p6
	local v21 = v18.Position - Rotation2.UpVector * v19.Y * p6
	local v22 = v1.CFrame.Position - v20
	local v23 = Vector2.new(v22.X, v22.Z).Magnitude / p5
	local v24 = v22.Y / p5
	local v25 = v14.CFrame.Position - v21
	local v26 = Vector2.new(v25.X, v25.Z).Magnitude / p5
	local v27 = v25.Y / p5
	local v28 = 0.2617993877991494

	AssetViewport.SetLocalCameraOrbit(v1, Rotation, v20, v23, v24, v28, 0)
	AssetViewport.SetLocalCameraOrbit(v14, Rotation2, v21, v26, v27, v28, 0)

	return {
		Pitch = 0,
		Camera = v1,
		ShadowCamera = v14,
		ModelRotation = Rotation,
		ShadowModelRotation = Rotation2,
		Focus = v20,
		ShadowFocus = v21,
		HorizontalDistance = v23,
		ShadowHorizontalDistance = v26,
		BaseHeight = v24,
		ShadowBaseHeight = v27,
		Yaw = v28
	}
end

local function stepCameras(p1, p2, p3) --[[ stepCameras | Line: 153 | Upvalues: UserInputService (copy), AssetViewport (copy) ]]
	local v1 = UserInputService:GetMouseLocation()
	local AbsoluteSize = p1.AbsoluteSize
	local v2 = p1.AbsolutePosition + AbsoluteSize * 0.5
	local v5 = (v1.X - v2.X) / math.max(AbsoluteSize.X * 0.5, 1)
	local v8 = (v1.Y - v2.Y) / math.max(AbsoluteSize.Y * 0.5, 1)
	local v9 = 0.2617993877991494 - 0.6666666666666666 * math.atan(v5 * 1.5)
	local v10 = math.clamp(v8 * 0.5235987755982988, -0.4363323129985824, 0.4363323129985824)
	local v11 = 1 - math.exp(p3 * -9)

	for i, v in ipairs(p2) do
		v.Yaw = v.Yaw + (v9 - v.Yaw) * v11
		v.Pitch = v.Pitch + (v10 - v.Pitch) * v11
		AssetViewport.SetLocalCameraOrbit(v.Camera, v.ModelRotation, v.Focus, v.HorizontalDistance, v.BaseHeight, v.Yaw, v.Pitch)
		AssetViewport.SetLocalCameraOrbit(v.ShadowCamera, v.ShadowModelRotation, v.ShadowFocus, v.ShadowHorizontalDistance, v.ShadowBaseHeight, v.Yaw, v.Pitch)
	end
end

function t.Start(p1, p2, p3, p4) --[[ Start | Line: 192 | Upvalues: Asserts (copy), Directory (copy), GradientSwap (copy), addViewportState (copy), RenderStepped (copy), stepCameras (copy), v1 (copy) ]]
	Asserts.table(p1)
	Asserts.GuiObject(p2)
	assert(if #p4 == 6 then true else false, "Limited egg viewport session requires six entries")
	assert(if #p3 == #p4 then true else false, "Limited egg viewport session requires one authored slot per entry")

	local sum = 0

	for i, v in ipairs(p4) do
		assert(if v.Weight > 0 then true else false, "Limited egg drop weights must be positive")
		sum = sum + v.Weight
	end

	assert(if sum > 0 then true else false, "Limited egg drop table total weight must be positive")

	local v5 = (1 / 0)

	for i, v in ipairs(p3) do
		local AbsoluteSize = v.Frame.AbsoluteSize

		v5 = math.min(v5, (math.sqrt((math.max(AbsoluteSize.X * AbsoluteSize.Y, 1)))))
	end

	local t = {}

	for i, v in ipairs(p4) do
		local v10 = p3[i]
		local v11 = Directory[v.AssetId]
		local Shadow = v10.Frame:WaitForChild("Shadow")

		assert(Shadow:IsA("ImageLabel"), (("Limited egg slot %*.Shadow must be an ImageLabel"):format(v10.Frame.Name)))

		local Gradient = Shadow:WaitForChild("Gradient")

		assert(Gradient:IsA("UIGradient"), (("Limited egg slot %*.Shadow.Gradient must be a UIGradient"):format(v10.Frame.Name)))

		local v16 = Gradient:Clone()

		GradientSwap(Shadow, v11.Rarity.Gradient)
		p1:Add(function() --[[ Line: 228 | Upvalues: GradientSwap (ref), Shadow (copy), v16 (copy) ]]
			GradientSwap(Shadow, v16)
			v16:Destroy()
		end)

		local AbsoluteSize = v10.Frame.AbsoluteSize

		table.insert(t, (addViewportState(p1, v10, v.AssetId, v.Weight / sum * 100, (math.min((math.sqrt((math.max(AbsoluteSize.X * AbsoluteSize.Y, 1))) / v5 - 1) * 0.3, 0.08000000000000007) + 1) * v11.LimitedEggViewportScale, v11.LimitedEggViewportVerticalOffset)))
	end

	local v22 = RenderStepped(function(p1) --[[ Line: 246 | Upvalues: stepCameras (ref), p2 (copy), t (copy) ]]
		stepCameras(p2, t, p1)

		return false
	end)

	p1:Add(function() --[[ Line: 250 | Upvalues: v22 (copy) ]]
		v22:Destroy()
	end)
	v1:AtTrace():Log("Limited egg viewport session opened")
end

return t