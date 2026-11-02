-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Types.FuseMachine)

local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = Log.new()
local t = {}

t.__index = t
t.__class = "FuseMachineProgressPresentation"

local v2 = Vector2.new(0, -0.5)
local v3 = Vector2.new(0, 0.5)
local v4 = Color3.new(255/255, 255/255, 255/255)
local v5 = Color3.new(0/255, 0/255, 0/255)
local v6 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v7 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v8 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 1, true)
local v9 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v10 = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)

function t.new(p1, p2) --[[ new | Line: 73 | Upvalues: Asserts (copy), t (copy), Trove (copy) ]]
	Asserts.Folder(p1)
	Asserts.Frame(p2)

	local v2 = setmetatable({}, t)

	v2._connectorStates = {}
	v2._connectorTroves = {}
	v2._icon = p2.Icon
	Asserts.ImageLabel(v2._icon)
	v2._iconOriginalBackgroundColor = v2._icon.BackgroundColor3
	v2._iconOriginalColor = v2._icon.ImageColor3
	v2._iconOriginalImage = v2._icon.Image
	v2._iconOriginalTransparency = v2._icon.ImageTransparency
	v2._iconScale = Instance.new("UIScale")
	v2._iconScale.Name = "FuseProgressScale"
	v2._iconScale.Parent = v2._icon
	v2._iconOriginalScale = v2._iconScale.Scale
	v2._iconTrove = Trove.new()
	v2._outputFill = p2.FillContainer.Frame
	Asserts.Frame(v2._outputFill)
	v2._outputOriginalSize = v2._outputFill.Size
	v2._outputTrove = Trove.new()
	v2._selectedCount = nil
	v2._trove = Trove.new()
	v2._trove:Add(v2._iconScale)
	v2._trove:Add(v2._iconTrove)
	v2._trove:Add(v2._outputTrove)

	for i, v in ipairs({ p1["1"], p1["2"], p1["3"] }) do
		Asserts.ImageLabel(v)

		local Fill = v.Fill

		Asserts.ImageLabel(Fill)

		local UIGradient = Fill.UIGradient

		Asserts.UIGradient(UIGradient)
		table.insert(v2._connectorStates, {
			Fill = Fill,
			Gradient = UIGradient,
			OriginalColor = Fill.ImageColor3,
			OriginalOffset = UIGradient.Offset
		})

		local v3 = Trove.new()

		table.insert(v2._connectorTroves, v3)
		v2._trove:Add(v3)
	end

	return v2
end
function t._setConnectorState(p1, p2, p3) --[[ _setConnectorState | Line: 129 | Upvalues: v3 (copy), v2 (copy) ]]
	local v1 = p1._connectorStates[p2]

	assert(if v1 == nil then false else true, (("Missing FuseMachine connector state %*"):format(p2)))

	local v4 = p1._connectorTroves[p2]

	assert(if v4 == nil then false else true, (("Missing FuseMachine connector trove %*"):format(p2)))
	v4:Clean()
	v1.Gradient.Offset = if p3 then v3 else v2
	v1.Fill.ImageColor3 = v1.OriginalColor
end
function t._animateConnector(p1, p2) --[[ _animateConnector | Line: 143 | Upvalues: TweenService (copy), v6 (copy), v3 (copy), v8 (copy), v4 (copy) ]]
	p1:_setConnectorState(p2, false)

	local v1 = p1._connectorStates[p2]

	assert(v1 ~= nil, (("Missing FuseMachine connector state %*"):format(p2)))

	local v42 = p1._connectorTroves[p2]

	assert(if v42 == nil then false else true, (("Missing FuseMachine connector trove %*"):format(p2)))

	local v7 = TweenService:Create(v1.Gradient, v6, {
		Offset = v3
	})
	local v82 = TweenService:Create(v1.Fill, v8, {
		ImageColor3 = v4
	})

	v42:Add(function() --[[ Line: 152 | Upvalues: v7 (copy) ]]
		v7:Cancel()
		v7:Destroy()
	end)
	v42:Add(function() --[[ Line: 156 | Upvalues: v82 (copy) ]]
		v82:Cancel()
		v82:Destroy()
	end)
	v42:Add(v82.Completed:Connect(function(p1) --[[ Line: 160 | Upvalues: v1 (copy) ]]
		if p1 ~= Enum.PlaybackState.Completed then
			return
		end

		v1.Fill.ImageColor3 = v1.OriginalColor
	end))
	v42:Add(v7.Completed:Connect(function(p1) --[[ Line: 165 | Upvalues: v82 (copy), v1 (copy) ]]
		if p1 ~= Enum.PlaybackState.Completed then
			return
		end

		v82:Cancel()
		v1.Fill.ImageColor3 = v1.OriginalColor
	end))
	v7:Play()
	v82:Play()
end
function t._setOutputProgress(p1, p2, p3) --[[ _setOutputProgress | Line: 175 | Upvalues: TweenService (copy), v7 (copy) ]]
	p1._outputTrove:Clean()

	local v1 = UDim2.new(p1._outputOriginalSize.X.Scale, p1._outputOriginalSize.X.Offset, p2 / 3, 0)

	if p3 then
		local v2 = TweenService:Create(p1._outputFill, v7, {
			Size = v1
		})

		p1._outputTrove:Add(function() --[[ Line: 193 | Upvalues: v2 (copy) ]]
			v2:Cancel()
			v2:Destroy()
		end)
		v2:Play()
	else
		p1._outputFill.Size = v1
	end
end
function t._setIncompleteIcon(p1) --[[ _setIncompleteIcon | Line: 200 | Upvalues: v5 (copy) ]]
	p1._iconTrove:Clean()
	p1._icon.ImageTransparency = 0.1
	p1._icon.ImageColor3 = v5
	p1._icon.BackgroundColor3 = v5
	p1._iconScale.Scale = p1._iconOriginalScale
end
function t._setReadyIcon(p1, p2) --[[ _setReadyIcon | Line: 208 | Upvalues: v4 (copy), TweenService (copy), v9 (copy), v10 (copy) ]]
	p1._iconTrove:Clean()
	p1._icon.ImageTransparency = 0
	p1._icon.ImageColor3 = v4
	p1._icon.BackgroundColor3 = v4
	p1._iconScale.Scale = p1._iconOriginalScale

	if p2 then
		p1._iconScale.Scale = 0.8

		local v1 = TweenService:Create(p1._iconScale, v9, {
			Scale = p1._iconOriginalScale * 1.2
		})

		p1._iconTrove:Add(function() --[[ Line: 222 | Upvalues: v1 (copy) ]]
			v1:Cancel()
			v1:Destroy()
		end)
		p1._iconTrove:Add(v1.Completed:Connect(function(p12) --[[ Line: 226 | Upvalues: p1 (copy), TweenService (ref), v10 (ref) ]]
			if p12 == Enum.PlaybackState.Completed and p1._selectedCount == 3 then
				local v1 = TweenService:Create(p1._iconScale, v10, {
					Scale = p1._iconOriginalScale
				})

				p1._iconTrove:Add(function() --[[ Line: 233 | Upvalues: v1 (copy) ]]
					v1:Cancel()
					v1:Destroy()
				end)
				v1:Play()
			end
		end))
		v1:Play()
	end
end
function t.Update(p1, p2, p3) --[[ Update | Line: 246 | Upvalues: Asserts (copy) ]]
	Asserts.integerNonNegative(p2)
	Asserts.cond(if p2 <= 3 then true else false)
	Asserts.optional.string(p3)

	if p2 == 0 then
		p1._icon.Image = p1._iconOriginalImage
	else
		assert(if p3 == nil then false elseif p3 == "" then false else true, "Selected FuseMachine category requires an egg icon")
		p1._icon.Image = p3
	end

	local _selectedCount = p1._selectedCount

	if _selectedCount == p2 then
		return
	end

	p1._selectedCount = p2

	if _selectedCount == nil then
		p1:_setConnectorState(1, p2 >= 1)
		p1:_setConnectorState(2, p2 >= 2)
		p1:_setConnectorState(3, p2 >= 3)
		p1:_setOutputProgress(p2, false)

		if p2 == 3 then
			p1:_setReadyIcon(false)
		else
			p1:_setIncompleteIcon()
		end
	else
		if _selectedCount < p2 then
			for i = _selectedCount + 1, p2 do
				p1:_animateConnector(i)
			end
		else
			for j = p2 + 1, _selectedCount do
				p1:_setConnectorState(j, false)
			end
		end

		p1:_setOutputProgress(p2, true)

		if p2 == 3 then
			p1:_setReadyIcon(true)
		else
			p1:_setIncompleteIcon()
		end
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 297 | Upvalues: v1 (copy) ]]
	p1._trove:Destroy()

	for i, v in ipairs(p1._connectorStates) do
		v.Fill.ImageColor3 = v.OriginalColor
		v.Gradient.Offset = v.OriginalOffset
	end

	p1._outputFill.Size = p1._outputOriginalSize
	p1._icon.Image = p1._iconOriginalImage
	p1._icon.ImageTransparency = p1._iconOriginalTransparency
	p1._icon.ImageColor3 = p1._iconOriginalColor
	p1._icon.BackgroundColor3 = p1._iconOriginalBackgroundColor
	v1:AtTrace():Log("Destroyed FuseMachine progress presentation")
end

return t