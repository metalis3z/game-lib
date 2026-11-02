-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Emit = require(ReplicatedStorage.Library.Functions.Emit)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}

t.__index = t
t.__class = "OfflineGeneratedMoney"

local v1 = Color3.new(255/255, 255/255, 255/255)
local v2 = Log.new()
local BuckPiles = ReplicatedStorage.Assets.Models.BuckPiles

assert(BuckPiles:IsA("Folder"), "ReplicatedStorage.Assets.Models.BuckPiles must be a Folder")

local MoneyCollect = ReplicatedStorage.Assets.VFX.MoneyCollect

assert(MoneyCollect:IsA("Folder"), "ReplicatedStorage.Assets.VFX.MoneyCollect must be a Folder")
function t.new(p1, p2) --[[ new | Line: 75 | Upvalues: Asserts (copy), t (copy), Trove (copy), Signal (copy), BuckPiles (copy) ]]
	Asserts.BasePart(p1)
	Asserts.Instance(p2)

	local v1 = t
	local v2 = setmetatable({}, v1)
	local LocalOfflineGeneratedMoneyPiles = Instance.new("Folder")

	LocalOfflineGeneratedMoneyPiles.Name = "LocalOfflineGeneratedMoneyPiles"
	LocalOfflineGeneratedMoneyPiles.Parent = p2

	local v3 = Trove.new()

	v2._trove = v3
	v2._animationTrove = Trove.new()
	v2._bucketRoot = p1
	v2._runtimeFolder = LocalOfflineGeneratedMoneyPiles
	v2._stages = {}
	v2._currentStageIndex = 0
	v2._lastStageCenterCFrame = nil
	v2._destroyed = false
	v2._lastAdornee = nil
	v2.BillboardAdorneeChanged = Signal.new()
	v3:Add(LocalOfflineGeneratedMoneyPiles)
	v3:Add(v2._animationTrove)
	v3:Add(p1:GetPropertyChangedSignal("CFrame"):Connect(function() --[[ Line: 99 | Upvalues: v2 (copy), t (ref), p1 (copy) ]]
		for i, v in ipairs(v2._stages) do
			t._pivotRootToBucket(v.model, v.rootPart, p1)
		end
	end))

	local list = {}

	for i, v in ipairs(BuckPiles:GetChildren()) do
		if v:IsA("Model") then
			list[#list + 1] = v
		end
	end

	table.sort(list, function(p1, p2) --[[ Line: 112 | Upvalues: t (ref) ]]
		return t._getStageSortIndex(p1) < t._getStageSortIndex(p2)
	end)
	assert(if #list == 3 then true else false, "BuckPiles must contain exactly three stage models")

	for i, v in ipairs(list) do
		v2._stages[#v2._stages + 1] = v2:_buildStage(v)
	end

	v2:_hideAllStages()

	return v2
end
function t._getStageSortIndex(p1) --[[ _getStageSortIndex | Line: 130 ]]
	local v2 = tonumber(p1.Name)

	assert(v2, (("BuckPiles stage %* must be numerically named"):format(p1.Name)))

	return v2
end
function t._readVector3Attribute(p1, p2) --[[ _readVector3Attribute | Line: 136 | Upvalues: Asserts (copy) ]]
	local v1 = p1:GetAttribute(p2)

	Asserts.Vector3(v1)

	return v1
end
function t._readCFrameAttribute(p1, p2) --[[ _readCFrameAttribute | Line: 142 | Upvalues: Asserts (copy) ]]
	local v1 = p1:GetAttribute(p2)

	Asserts.CFrame(v1)

	return v1
end
function t._getVisibleTransparency(p1) --[[ _getVisibleTransparency | Line: 148 ]]
	if p1.Transparency >= 1 then
		return 0
	end

	return p1.Transparency
end
function t._pivotRootToBucket(p1, p2, p3) --[[ _pivotRootToBucket | Line: 152 ]]
	local v1 = p1:GetPivot()

	p1:PivotTo(p3.CFrame * p2.CFrame:Inverse() * v1)
end
function t._createTopAttachment(p1) --[[ _createTopAttachment | Line: 158 | Upvalues: Asserts (copy) ]]
	local GeneratedMoneyTopAttachment = p1:FindFirstChild("GeneratedMoneyTopAttachment")

	if GeneratedMoneyTopAttachment then
		Asserts.Attachment(GeneratedMoneyTopAttachment)

		return GeneratedMoneyTopAttachment
	end

	local GeneratedMoneyTopAttachment2 = Instance.new("Attachment")

	GeneratedMoneyTopAttachment2.Name = "GeneratedMoneyTopAttachment"
	GeneratedMoneyTopAttachment2.Parent = p1

	return GeneratedMoneyTopAttachment2
end
function t._createHighlight(p1) --[[ _createHighlight | Line: 171 | Upvalues: v1 (copy) ]]
	local OfflineMoneyBucketHighlight = Instance.new("Highlight")

	OfflineMoneyBucketHighlight.Name = "OfflineMoneyBucketHighlight"
	OfflineMoneyBucketHighlight.Adornee = p1
	OfflineMoneyBucketHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	OfflineMoneyBucketHighlight.FillTransparency = 1
	OfflineMoneyBucketHighlight.OutlineColor = v1
	OfflineMoneyBucketHighlight.OutlineTransparency = 0
	OfflineMoneyBucketHighlight.Enabled = false
	OfflineMoneyBucketHighlight.Parent = p1

	return OfflineMoneyBucketHighlight
end
function t._syncTopAttachment(p1) --[[ _syncTopAttachment | Line: 184 ]]
	local v1, v2 = p1.model:GetBoundingBox()

	p1.topAttachment.Position = p1.mainPart.CFrame:PointToObjectSpace(v1.Position + v1.UpVector * (v2.Y * 0.5))
end
function t._collectAnimatedParts(p1, p2) --[[ _collectAnimatedParts | Line: 190 | Upvalues: t (copy), v2 (copy) ]]
	local t2 = {}

	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and v ~= p2 then
			local v1 = if v:GetAttribute("OriginalSize") == nil then false else true
			local v22 = if v:GetAttribute("TargetSize") == nil then false else true
			local v3 = if v:GetAttribute("OriginalCFrame") == nil then false else true

			if v1 or (v22 or (v3 or (if v:GetAttribute("TargetCFrame") == nil then false else true))) then
				t2[#t2 + 1] = {
					part = v,
					originalSize = t._readVector3Attribute(v, "OriginalSize"),
					targetSize = t._readVector3Attribute(v, "TargetSize"),
					originalCFrame = t._readCFrameAttribute(v, "OriginalCFrame"),
					targetCFrame = t._readCFrameAttribute(v, "TargetCFrame"),
					visibleTransparency = t._getVisibleTransparency(v)
				}
			end
		end
	end

	if #t2 ~= 0 then
		return t2
	end

	v2:AtWarning():Log((("BuckPiles stage %* has no animated part attributes"):format(p1.Name)))

	return t2
end
function t._setStageVisible(p1, p2) --[[ _setStageVisible | Line: 220 ]]
	for i, v in ipairs(p1.model:GetDescendants()) do
		if v:IsA("BasePart") then
			if v == p1.rootPart then
				v.Transparency = 1

				continue
			end

			local v1 = v:GetAttribute("_OfflineGeneratedMoneyVisibleTransparency")

			v.Transparency = if p2 and typeof(v1) == "number" then v1 else 1
		end
	end

	p1.highlight.Enabled = p2
end
function t._resetStageParts(p1) --[[ _resetStageParts | Line: 237 | Upvalues: t (copy) ]]
	local v1 = p1.rootPart.CFrame

	for i, v in ipairs(p1.animatedParts) do
		v.part.Size = v.originalSize
		v.part.CFrame = v1 * v.originalCFrame
	end

	t._syncTopAttachment(p1)
end
function t._applyStageAlpha(p1, p2) --[[ _applyStageAlpha | Line: 247 | Upvalues: t (copy) ]]
	local v1 = math.clamp(p2, 0, 1)
	local v2 = p1.rootPart.CFrame

	for i, v in ipairs(p1.animatedParts) do
		v.part.Size = v.originalSize:Lerp(v.targetSize, v1)
		v.part.CFrame = v2 * v.originalCFrame:Lerp(v.targetCFrame, v1)
		v.part.Transparency = v.visibleTransparency
	end

	t._syncTopAttachment(p1)
end
function t._buildStage(p1, p2) --[[ _buildStage | Line: 261 | Upvalues: Asserts (copy), t (copy) ]]
	local v1 = p2:Clone()

	v1.Name = ("OfflineGeneratedMoneyStage%*"):format(p2.Name)
	v1.Parent = p1._runtimeFolder

	local RootPart = v1:FindFirstChild("RootPart")

	Asserts.BasePart(RootPart)

	local Main = v1:FindFirstChild("Main")

	Asserts.BasePart(Main)
	v1.PrimaryPart = RootPart
	t._pivotRootToBucket(v1, RootPart, p1._bucketRoot)

	for i, v in ipairs(v1:GetDescendants()) do
		if v:IsA("BasePart") then
			v:SetAttribute("_OfflineGeneratedMoneyVisibleTransparency", t._getVisibleTransparency(v))

			if v == RootPart then
				v.Transparency = 1
			end

			v.CanCollide = false
			v.CanTouch = false
			v.CanQuery = false
		end
	end

	local t2 = {
		index = t._getStageSortIndex(p2),
		model = v1,
		rootPart = RootPart,
		mainPart = Main,
		highlight = t._createHighlight(v1),
		topAttachment = t._createTopAttachment(Main),
		animatedParts = t._collectAnimatedParts(v1, RootPart)
	}

	t._resetStageParts(t2)
	t._setStageVisible(t2, false)

	return t2
end
function t._hideAllStages(p1) --[[ _hideAllStages | Line: 307 | Upvalues: t (copy) ]]
	for i, v in ipairs(p1._stages) do
		t._resetStageParts(v)
		t._setStageVisible(v, false)
	end

	p1._currentStageIndex = 0

	if p1._lastAdornee == nil then
		return
	end

	p1._lastAdornee = nil
	p1.BillboardAdorneeChanged:Fire(nil)
end
function t._fadeOutStages(p1, p2) --[[ _fadeOutStages | Line: 320 | Upvalues: TweenService (copy) ]]
	local v1 = false

	for i, v in ipairs(p1._stages) do
		v.highlight.Enabled = false

		for i2, v2 in ipairs(v.model:GetDescendants()) do
			if v2:IsA("BasePart") and (v2 ~= v.rootPart and v2.Transparency < 1) then
				local v22 = TweenService:Create(v2, TweenInfo.new(p2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1
				})

				p1._animationTrove:Add(v22)
				v22:Play()
				v1 = true
			end
		end
	end

	return v1
end
function t._getCollectAllEffectCFrame(p1) --[[ _getCollectAllEffectCFrame | Line: 345 ]]
	local v1 = if p1._currentStageIndex > 0 then p1._currentStageIndex else nil
	local v2 = if v1 then p1._stages[v1] else nil

	if v2 then
		return v2.mainPart.CFrame
	end

	return p1._lastStageCenterCFrame or p1._bucketRoot.CFrame
end
function t._emitCollectAllCash(p1) --[[ _emitCollectAllCash | Line: 351 | Upvalues: Emit (copy), MoneyCollect (copy) ]]
	Emit(p1, nil, MoneyCollect:GetChildren())
end
function t._setProgress(p1, p2) --[[ _setProgress | Line: 355 | Upvalues: t (copy) ]]
	local v1 = math.clamp(p2, 0, 1)
	local _stages = p1._stages
	local v2 = #_stages

	if v2 <= 0 then
		return
	end

	if v1 <= 0 then
		p1:_hideAllStages()

		return
	end

	local v3 = v1 * v2
	local v5 = math.clamp(math.floor(v3) + 1, 1, v2)
	local v6 = if v1 >= 1 then 1 else v3 - (v5 - 1)

	for i, v in ipairs(_stages) do
		local v7 = if i == v5 then true else false

		t._setStageVisible(v, v7)

		if v7 then
			t._applyStageAlpha(v, v6)

			continue
		end

		t._resetStageParts(v)
	end

	p1._currentStageIndex = v5
	p1._lastStageCenterCFrame = _stages[v5].mainPart.CFrame

	local topAttachment = _stages[v5].topAttachment

	if p1._lastAdornee == topAttachment then
		return
	end

	p1._lastAdornee = topAttachment
	p1.BillboardAdorneeChanged:Fire(topAttachment)
end
function t.UpdateInstant(p1, p2, p3) --[[ UpdateInstant | Line: 397 | Upvalues: Asserts (copy) ]]
	Asserts.finiteNonNegative(p2)
	Asserts.boolean(p3)

	if p3 and not (p2 <= 0) then
		p1:_setProgress((math.clamp(math.max(p2 - 1, 0) / 999999999, 0, 1)))
	else
		p1:_hideAllStages()
	end
end
function t.PlayCollectReset(p1) --[[ PlayCollectReset | Line: 416 | Upvalues: Trove (copy), t (copy) ]]
	p1._animationTrove:Destroy()
	p1._animationTrove = Trove.new()
	p1._trove:Add(p1._animationTrove)

	if p1:_fadeOutStages(0.3) then
		t._emitCollectAllCash(p1:_getCollectAllEffectCFrame())
	end

	p1._animationTrove:Add(task.delay(0.3, function() --[[ Line: 426 | Upvalues: p1 (copy) ]]
		if not p1._destroyed then
			p1:_hideAllStages()
		end
	end))
end
function t.GetBillboardAdornee(p1) --[[ GetBillboardAdornee | Line: 435 ]]
	return p1._lastAdornee
end
function t.Destroy(p1) --[[ Destroy | Line: 439 ]]
	p1._destroyed = true
	p1._trove:Destroy()
end

return t