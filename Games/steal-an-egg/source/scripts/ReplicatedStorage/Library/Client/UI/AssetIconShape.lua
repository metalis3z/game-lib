-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Directory.Assets.Types.Interface)

local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local Assets = require(ReplicatedStorage.Directory.Assets)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local v1 = UDim2.fromScale(0.77, 0.77)
local v2 = UDim2.fromScale(0.85, 0.85)
local v3 = UDim2.fromScale(0.5, 0.5)
local v4 = Vector2.new(0.5, 0.5)
local t = {}

local function clearShapedIcon(p1) --[[ clearShapedIcon | Line: 36 ]]
	local AssetIconShapeLayer = p1:FindFirstChild("AssetIconShapeLayer")

	if AssetIconShapeLayer == nil then
		return
	end

	AssetIconShapeLayer:Destroy()
end

local function clearOverlay(p1) --[[ clearOverlay | Line: 43 ]]
	local RainbowOverlayImage = p1:FindFirstChild("RainbowOverlayImage")

	if not (RainbowOverlayImage and RainbowOverlayImage:IsA("ImageLabel")) then
		return
	end

	RainbowOverlayImage:Destroy()
end

local function getSizeMutationIconZoom(p1) --[[ getSizeMutationIconZoom | Line: 50 ]]
	return 1, nil
end

local function hasRainbowMutation(p1) --[[ hasRainbowMutation | Line: 54 | Upvalues: Mutations (copy) ]]
	local Rainbow = Mutations.GetMutationsMap().Rainbow

	return if p1.BaseMutation == Rainbow then true else table.find(p1.Mutations, Rainbow) ~= nil
end

local function hasMutation(p1, p2) --[[ hasMutation | Line: 59 ]]
	return if p1.BaseMutation == p2 then true else table.find(p1.Mutations, p2) ~= nil
end

local function resolveIconImage(p1, p2) --[[ resolveIconImage | Line: 63 | Upvalues: Mutations (copy) ]]
	local v1 = Mutations.GetMutationsMap()
	local MutationIcons = p1.MutationIcons

	if MutationIcons == nil then
		return p1.Icon or ""
	end

	local Golden = v1.Golden

	if (if p2.BaseMutation == Golden then true elseif table.find(p2.Mutations, Golden) == nil then false else true) and MutationIcons[v1.Golden] ~= nil then
		return MutationIcons[v1.Golden]
	end

	local Silver = v1.Silver

	if (if p2.BaseMutation == Silver then true else table.find(p2.Mutations, Silver) ~= nil) and MutationIcons[v1.Silver] ~= nil then
		return MutationIcons[v1.Silver]
	end

	return p1.Icon or ""
end

function t.ApplyRainbowOverlay(p1, p2) --[[ ApplyRainbowOverlay | Line: 88 | Upvalues: Asserts (copy), Rarity (copy), v3 (copy), v4 (copy) ]]
	Asserts.ImageLabel(p1)
	Asserts.string(p2)

	local v1 = Rarity.Rarities.Rainbow.Gradient:Clone()
	local RainbowOverlayImage = Instance.new("ImageLabel")

	RainbowOverlayImage.Name = "RainbowOverlayImage"
	RainbowOverlayImage.Image = p2
	RainbowOverlayImage.ImageTransparency = 0.5
	RainbowOverlayImage.Size = UDim2.fromScale(1, 1)
	RainbowOverlayImage.Position = v3
	RainbowOverlayImage.AnchorPoint = v4
	RainbowOverlayImage.BackgroundTransparency = 1
	RainbowOverlayImage.ScaleType = Enum.ScaleType.Fit
	RainbowOverlayImage.ZIndex = p1.ZIndex + 1
	RainbowOverlayImage.Parent = p1
	v1.Parent = RainbowOverlayImage

	return RainbowOverlayImage
end
function t.Clear(p1) --[[ Clear | Line: 111 | Upvalues: Asserts (copy) ]]
	Asserts.ImageLabel(p1)

	local RainbowOverlayImage = p1:FindFirstChild("RainbowOverlayImage")

	if RainbowOverlayImage and RainbowOverlayImage:IsA("ImageLabel") then
		RainbowOverlayImage:Destroy()
	end

	local AssetIconShapeLayer = p1:FindFirstChild("AssetIconShapeLayer")

	if AssetIconShapeLayer == nil then
		p1.ImageTransparency = 0

		return
	end

	AssetIconShapeLayer:Destroy()
	p1.ImageTransparency = 0
end
function t.SetVisualState(p1, p2, p3) --[[ SetVisualState | Line: 119 | Upvalues: Asserts (copy) ]]
	Asserts.ImageLabel(p1)
	Asserts.Color3(p2)
	Asserts.number(p3)
	p1.ImageColor3 = p2
	p1.ImageTransparency = p3

	local AssetIconShapeLayer = p1:FindFirstChild("AssetIconShapeLayer")

	if AssetIconShapeLayer == nil then
		return
	end

	for i, v in ipairs(AssetIconShapeLayer:GetDescendants()) do
		if v:IsA("ImageLabel") then
			v.ImageTransparency = p3

			if v.Name == "IconStrokeImage" and p2 ~= Color3.fromRGB(0, 0, 0) then
				v.ImageColor3 = Color3.fromRGB(0, 0, 0)

				continue
			end

			v.ImageColor3 = p2
		end
	end
end
function t.Apply(p1, p2) --[[ Apply | Line: 146 | Upvalues: Asserts (copy), AssetItem (copy), Assets (copy), resolveIconImage (copy), t (copy), Mutations (copy), v3 (copy), v4 (copy), v2 (copy), v1 (copy) ]]
	Asserts.ImageLabel(p1)
	assert(AssetItem.AssetItemData(p2))

	local v12 = Assets.Directory[p2.Category]

	assert(v12 ~= nil, (("Unknown asset icon category \"%*\""):format(p2.Category)))

	local v42 = resolveIconImage(v12, p2)
	local v5 = 1
	local v6 = nil
	local v7 = if v6 then v6 else UDim2.fromScale(0, 0)

	assert(v7, "luau")
	t.Clear(p1)
	p1.BackgroundTransparency = 1
	p1.ScaleType = Enum.ScaleType.Fit

	if v5 <= 1 then
		p1.Image = v42
		p1.ImageTransparency = 0

		local Rainbow = Mutations.GetMutationsMap().Rainbow

		if not (if p2.BaseMutation == Rainbow then true else table.find(p2.Mutations, Rainbow) ~= nil) then
			return
		end

		t.ApplyRainbowOverlay(p1, v12.WhiteImage or v42)
	else
		p1.Image = ""
		p1.ImageTransparency = 1

		local AssetIconShapeLayer = Instance.new("Frame")

		AssetIconShapeLayer.Name = "AssetIconShapeLayer"
		AssetIconShapeLayer.Size = UDim2.fromScale(1, 1)
		AssetIconShapeLayer.Position = v3
		AssetIconShapeLayer.AnchorPoint = v4
		AssetIconShapeLayer.BackgroundTransparency = 1
		AssetIconShapeLayer.ZIndex = p1.ZIndex
		AssetIconShapeLayer.Parent = p1

		local IconStrokeFrame = Instance.new("CanvasGroup")

		IconStrokeFrame.Name = "IconStrokeFrame"
		IconStrokeFrame.Size = v2
		IconStrokeFrame.Position = v3
		IconStrokeFrame.AnchorPoint = v4
		IconStrokeFrame.BackgroundTransparency = 1
		IconStrokeFrame.ClipsDescendants = true
		IconStrokeFrame.ZIndex = p1.ZIndex
		IconStrokeFrame.Parent = AssetIconShapeLayer

		local IconStrokeImage = Instance.new("ImageLabel")

		IconStrokeImage.Name = "IconStrokeImage"
		IconStrokeImage.Image = v42
		IconStrokeImage.ImageColor3 = Color3.fromRGB(0, 0, 0)
		IconStrokeImage.Size = UDim2.fromScale(v5, v5)
		IconStrokeImage.Position = v3 + v7
		IconStrokeImage.AnchorPoint = v4
		IconStrokeImage.BackgroundTransparency = 1
		IconStrokeImage.ScaleType = Enum.ScaleType.Fit
		IconStrokeImage.ZIndex = p1.ZIndex
		IconStrokeImage.Parent = IconStrokeFrame

		local IconClipFrame = Instance.new("CanvasGroup")

		IconClipFrame.Name = "IconClipFrame"
		IconClipFrame.Size = v1
		IconClipFrame.Position = v3
		IconClipFrame.AnchorPoint = v4
		IconClipFrame.BackgroundTransparency = 1
		IconClipFrame.ClipsDescendants = true
		IconClipFrame.ZIndex = p1.ZIndex + 1
		IconClipFrame.Parent = AssetIconShapeLayer

		local IconImage = Instance.new("ImageLabel")

		IconImage.Name = "IconImage"
		IconImage.Image = v42
		IconImage.Size = UDim2.fromScale(v5, v5)
		IconImage.Position = v3 + v7
		IconImage.AnchorPoint = v4
		IconImage.BackgroundTransparency = 1
		IconImage.ScaleType = Enum.ScaleType.Fit
		IconImage.ZIndex = p1.ZIndex + 1
		IconImage.Parent = IconClipFrame

		local Rainbow = Mutations.GetMutationsMap().Rainbow

		if not (if p2.BaseMutation == Rainbow then true else table.find(p2.Mutations, Rainbow) ~= nil) then
			return
		end

		t.ApplyRainbowOverlay(IconImage, v12.WhiteImage or v42)
	end
end

local function scaleIconSize(p1, p2, p3) --[[ scaleIconSize | Line: 233 ]]
	return UDim2.new(p1.X.Scale * p2, p1.X.Offset * p2, p1.Y.Scale * p3, p1.Y.Offset * p3)
end

function t.BindHoverSquashEffect(p1, p2, p3) --[[ BindHoverSquashEffect | Line: 237 | Upvalues: Asserts (copy), Trove (copy), Tween (copy) ]]
	Asserts.GuiObject(p1)
	Asserts.ImageLabel(p2)
	Asserts.optional.func(p3)

	local v1 = nil
	local Size = p2.Size
	local v2 = Trove.new()

	local function stopAssetIconHoverTween() --[[ stopAssetIconHoverTween | Line: 251 | Upvalues: v1 (ref) ]]
		if not v1 then
			return
		end

		v1:Cancel()
		v1:Destroy()
		v1 = nil
	end

	local function updateIconsScaleType(p1) --[[ updateIconsScaleType | Line: 259 | Upvalues: p2 (copy) ]]
		local list = { p2 }

		for i, v in ipairs(p2:GetDescendants()) do
			if v:IsA("ImageLabel") then
				table.insert(list, v)
			end
		end

		for i, v in ipairs(list) do
			v.ScaleType = p1
		end
	end

	local function resetAssetIconHoverState(p1) --[[ resetAssetIconHoverState | Line: 272 | Upvalues: v1 (ref), p2 (copy), Size (copy), updateIconsScaleType (copy) ]]
		if v1 then
			v1:Cancel()
			v1:Destroy()
			v1 = nil
		end

		if not p2 then
			return
		end

		local v12 = if p1 then p1 else Size

		if v12 then
			p2.Size = v12
		end

		updateIconsScaleType(Enum.ScaleType.Fit)
	end

	local function restoreAssetIconHover(p1) --[[ restoreAssetIconHover | Line: 283 | Upvalues: p2 (copy), Size (copy), v1 (ref), updateIconsScaleType (copy), Tween (ref) ]]
		if p2 and Size then
			if v1 then
				v1:Cancel()
				v1:Destroy()
				v1 = nil
			end

			local v12 = Size

			if p1 ~= false then
				v1 = Tween(p2, {
					Size = v12
				}, { 0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out })

				local v2 = v1

				assert(v2, "luau")
				v1.Completed:Once(function(p1) --[[ Line: 303 | Upvalues: updateIconsScaleType (ref), v1 (ref) ]]
					if p1 ~= Enum.PlaybackState.Cancelled then
						updateIconsScaleType(Enum.ScaleType.Fit)
						v1 = nil
					end
				end)
				v1:Play()

				return
			end

			if v1 then
				v1:Cancel()
				v1:Destroy()
				v1 = nil
			end

			if not p2 then
				return
			end

			local v3 = if v12 then v12 else Size

			if v3 then
				p2.Size = v3
			end
		else
			if v1 then
				v1:Cancel()
				v1:Destroy()
				v1 = nil
			end

			if not p2 then
				return
			end

			local v4 = Size

			if v4 then
				p2.Size = v4
			end
		end

		updateIconsScaleType(Enum.ScaleType.Fit)
	end

	local function playAssetIconHoverSquash() --[[ playAssetIconHoverSquash | Line: 313 | Upvalues: p2 (copy), p3 (copy), v1 (ref), updateIconsScaleType (copy), Tween (ref), Size (copy) ]]
		if not p2 or p3 and not p3() then
			return
		end

		local v3

		if v1 then
			v1:Cancel()
			v1:Destroy()
			v1 = nil
		end

		updateIconsScaleType(Enum.ScaleType.Stretch)
		v3 = {}
		v3.Size = UDim2.new(Size.X.Scale * 1.2, Size.X.Offset * 1.2, Size.Y.Scale * 0.43, Size.Y.Offset * 0.43)
		v1 = Tween(p2, v3, { 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })
		assert(v1, "luau")
		v1:Play()
	end

	v2:Add(stopAssetIconHoverTween)
	v2:Connect(p1.MouseEnter, playAssetIconHoverSquash)
	v2:Connect(p1.MouseLeave, restoreAssetIconHover)
	v2:Connect(p1.InputEnded, function(p1) --[[ Line: 333 | Upvalues: restoreAssetIconHover (copy) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		restoreAssetIconHover()
	end)

	return v2, restoreAssetIconHover
end

return t