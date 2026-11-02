-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local WaitFor = require(ReplicatedStorage.Library.Modules.Packages.WaitFor)
local GuardWakeLookAt = require(script.Parent.GuardWakeLookAt)
local v1 = Log.new()
local t = {}

t.__index = t
t.__class = "GuardComponent"

local v2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true)

function t.new(p1) --[[ new | Line: 49 | Upvalues: Asserts (copy), t (copy), WaitFor (copy), Trove (copy), GuardWakeLookAt (copy) ]]
	Asserts.Model(p1)

	local v2 = setmetatable({}, t)
	local Guard = p1:WaitForChild("Guard")

	assert(Guard:IsA("Model"), (("%*.Guard must be a Model"):format((p1:GetFullName()))))

	local v5, v6 = WaitFor.Descendant(Guard, "Head"):await()

	assert(if v5 then if v6 == nil then false else true else v5, (("%* requires a Head descendant for alert GUI"):format((Guard:GetFullName()))))
	assert(v6:IsA("BasePart"), (("%* must be a BasePart"):format((v6:GetFullName()))))

	local v12

	if if p1.Name == "Forest" then true else false then
		local HumanoidRootPart = Guard:WaitForChild("HumanoidRootPart")

		assert(HumanoidRootPart, (("%* requires a HumanoidRootPart descendant for Forest shake effects"):format((Guard:GetFullName()))))

		local v14 = HumanoidRootPart:IsA("BasePart")

		assert(v14, (("%* must be a BasePart"):format((HumanoidRootPart:GetFullName()))))
		v12 = HumanoidRootPart
	else
		v12 = nil
	end

	local v16, v17 = WaitFor.Descendant(v6, "AlertGui"):await()

	assert(if v16 then if v17 then v17:IsA("BillboardGui") else v17 else v16, (("%* requires an AlertGui descendant"):format((v6:GetFullName()))))
	v2._alertGuiTemplate = v17
	v2._alertGui = nil
	v2._guardModel = Guard
	v2._head = v6
	v2._lastAlertAt = (-1 / 0)
	v2._root = v12
	v2._sleepColorTrove = Trove.new()
	v2._trove = Trove.new()

	if not Guard:GetAttribute("HeadLookAtDisabled") then
		v2._wakeLookAt = GuardWakeLookAt.new(Guard)
	end

	v2._trove:Add(v2._sleepColorTrove)
	v2._trove:Add(Guard:GetAttributeChangedSignal("TargetPlayer"):Connect(function() --[[ Line: 87 | Upvalues: v2 (copy) ]]
		v2:_updateTargetAlert()
	end))
	v2._trove:Add(Guard:GetAttributeChangedSignal("Sleeping"):Connect(function() --[[ Line: 90 | Upvalues: v2 (copy), Guard (copy) ]]
		v2:_applySleepVfx()

		if Guard:GetAttribute("Sleeping") ~= true then
			return
		end

		v2:_clearAlert()
	end))
	v2._trove:Add(Guard:GetAttributeChangedSignal("GuardState"):Connect(function() --[[ Line: 96 | Upvalues: v2 (copy) ]]
		v2:_applySleepVfx()
		v2:_applyGuardStatePresentation()
	end))
	v2._trove:Add(Guard:GetAttributeChangedSignal("WakeTargetPlayer"):Connect(function() --[[ Line: 100 | Upvalues: v2 (copy) ]]
		v2:_applyGuardStatePresentation()
	end))
	v2:_applySleepVfx()
	v2:_applyGuardStatePresentation()
	v2:_updateTargetAlert()

	local v20 = false

	v2._trove:Add(Guard.DescendantAdded:Connect(function(p1) --[[ Line: 108 | Upvalues: v20 (ref), v2 (copy) ]]
		if p1:IsA("BasePart") then
			task.delay(1, function() --[[ Line: 112 | Upvalues: v20 (ref), v2 (ref) ]]
				if v20 then
					return
				end

				v20 = true
				v2:_applyGuardStatePresentation()
				task.wait(1)
				v20 = false
			end)
		end
	end))

	return v2
end
function t._updateTargetAlert(p1) --[[ _updateTargetAlert | Line: 129 ]]
	local v1 = p1._guardModel:GetAttribute("TargetPlayer")

	if typeof(v1) ~= "string" or v1 == "" then
		return
	end

	local v2 = os.clock()

	if not (v2 - p1._lastAlertAt < 3) then
		p1._lastAlertAt = v2
		p1:_showAlert()
	end
end
function t._applySleepVfx(p1) --[[ _applySleepVfx | Line: 144 | Upvalues: v1 (copy) ]]
	local v12 = p1._guardModel:GetAttribute("GuardState") == "Sleeping"
	local SleepVFXAttachment = p1._guardModel:FindFirstChild("SleepVFXAttachment", true)

	if not SleepVFXAttachment then
		v1:AtWarning():Log((("Guard model %* is missing SleepVFXAttachment"):format((p1._guardModel:GetFullName()))))

		return
	end

	for i, v in ipairs(SleepVFXAttachment:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = v12

			if not v12 then
				v:Clear()
			end
		end
	end
end
function t._applyGuardStatePresentation(p1) --[[ _applyGuardStatePresentation | Line: 162 | Upvalues: Asserts (copy) ]]
	local v1 = p1._guardModel:GetAttribute("GuardState")
	local v2 = p1._guardModel:GetAttribute("WakeTargetPlayer")

	Asserts.optional.string(v2)

	if p1._wakeLookAt then
		p1._wakeLookAt:SetWaking(v1 == "Waking", if v2 == "" then nil else v2)
	end

	if v1 == "Sleeping" then
		p1:_applySleepDetailColors()

		return
	end

	if v1 == "Waking" then
		p1:_animateSleepDetailColorsToOriginal()
	end
end
function t._applySleepDetailColors(p1) --[[ _applySleepDetailColors | Line: 185 ]]
	p1._sleepColorTrove:Clean()

	for i, v in ipairs(p1._guardModel:GetDescendants()) do
		if v:IsA("BasePart") then
			local v1 = v:GetAttribute("SleepColor")

			if v1 then
				if v:GetAttribute("OriginalColor") == nil then
					v:SetAttribute("OriginalColor", v.Color)
				end

				v.Color = v1
			end
		end
	end
end
function t._animateSleepDetailColorsToOriginal(p1) --[[ _animateSleepDetailColorsToOriginal | Line: 205 ]]
	p1._sleepColorTrove:Clean()

	for i, v in ipairs(p1._guardModel:GetDescendants()) do
		if v:IsA("BasePart") and v:GetAttribute("SleepColor") then
			local v1 = v:GetAttribute("OriginalColor")

			if v1 == nil then
				v1 = v.Color
				v:SetAttribute("OriginalColor", v1)
			end

			assert(v1, "luau")
			v.Color = v1
		end
	end
end
function t._clearAlert(p1) --[[ _clearAlert | Line: 223 ]]
	local _alertGui = p1._alertGui

	if _alertGui ~= nil then
		p1._alertGui = nil
		_alertGui:Destroy()
	end
end
function t._showAlert(p1) --[[ _showAlert | Line: 233 | Upvalues: Tween (copy), v1 (copy) ]]
	if p1._alertGui == nil then
		local v12 = p1._alertGuiTemplate:Clone()
		local v2 = assert(v12:FindFirstChildWhichIsA("ImageLabel"))

		v2.Transparency = 1
		v12.AlwaysOnTop = true
		v12.Enabled = true
		v12.Parent = p1._head
		p1._alertGui = v12
		p1._trove:Add(v12)
		Tween(v2, {
			ImageTransparency = 0
		}, { 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })

		local v3 = Tween
		local t = {}

		t.StudsOffset = v12.StudsOffset + Vector3.new(0, 1, 0) * math.max(v12.StudsOffset.Y * 0.6, 1)
		v3(v12, t, { 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }).Completed:Once(function() --[[ Line: 254 | Upvalues: Tween (ref), v2 (copy) ]]
			task.wait(1)
			Tween(v2, {
				ImageTransparency = 1
			}, { 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out })
		end)
		task.delay(3, function() --[[ Line: 259 | Upvalues: v12 (copy), p1 (copy) ]]
			if v12.Parent == nil then
				return
			end

			if p1._alertGui == v12 then
				p1._alertGui = nil
			end

			v12:Destroy()
		end)
		v1:AtTrace():Log((("Guard alert shown for %*"):format((p1._guardModel:GetFullName()))))
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 277 ]]
	if p1._wakeLookAt then
		p1._wakeLookAt:Destroy()
	end

	p1._trove:Destroy()
end
function t.GetGuardModel(p1) --[[ GetGuardModel | Line: 284 ]]
	return p1._guardModel
end
function t.PlayWakeUp(p1) --[[ PlayWakeUp | Line: 288 | Upvalues: TweenService (copy), v2 (copy), Debris (copy) ]]
	local GuardWakeHighlight = Instance.new("Highlight")

	GuardWakeHighlight.Name = "GuardWakeHighlight"
	GuardWakeHighlight.FillColor = Color3.fromRGB(255, 0, 0)
	GuardWakeHighlight.OutlineColor = Color3.fromRGB(132, 0, 0)
	GuardWakeHighlight.FillTransparency = 1
	GuardWakeHighlight.OutlineTransparency = 1
	GuardWakeHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
	GuardWakeHighlight.Parent = p1._guardModel
	TweenService:Create(GuardWakeHighlight, v2, {
		FillTransparency = 0.35,
		OutlineTransparency = 0
	}):Play()
	Debris:AddItem(GuardWakeHighlight, v2.Time * 2 + 0.05)
end

return t