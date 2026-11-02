-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local t = {}

t.__index = t

local v1 = Log.new()
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}
local t7 = {}
local v2 = nil

function t.new(p1, p2) --[[ new | Line: 51 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.BasePart(p1)
	Asserts.optional.finiteCFrame(p2)

	local v2 = setmetatable({}, t)

	v2._part = p1
	v2._baseCFrame = nil
	v2._cframeOffset = CFrame.identity
	v2._nextCFrame = nil
	v2._tweenStartCFrame = nil
	v2._tweenGoalCFrame = nil
	v2._tweenInfo = nil
	v2._tweenElapsed = 0
	v2._baseSize = nil
	v2._sizeScale = Vector3.new(1, 1, 1)
	v2._destroyed = false

	if p2 then
		v2:SetCFrame(p2)
	end

	return v2
end

local function isLivePart(p1) --[[ isLivePart | Line: 79 ]]
	return if p1 == nil then false else p1.Parent ~= nil
end

local function clearTween(p1) --[[ clearTween | Line: 83 | Upvalues: t4 (copy) ]]
	t4[p1] = nil
	p1._tweenStartCFrame = nil
	p1._tweenGoalCFrame = nil
	p1._tweenInfo = nil
	p1._tweenElapsed = 0
end

local function multiplyVector(p1, p2) --[[ multiplyVector | Line: 91 ]]
	return Vector3.new(p1.X * p2.X, p1.Y * p2.Y, p1.Z * p2.Z)
end

local function getComposedCFrame(p1, p2) --[[ getComposedCFrame | Line: 95 ]]
	return p2 * p1._cframeOffset
end

local function applyComposedSize(p1) --[[ applyComposedSize | Line: 99 | Upvalues: v2 (ref) ]]
	local _part = p1._part

	if not (if _part == nil then false elseif _part.Parent == nil then false else true) then
		v2(p1)

		return
	end

	local v22 = p1._baseSize or _part.Size
	local _sizeScale = p1._sizeScale

	_part.Size = Vector3.new(v22.X * _sizeScale.X, v22.Y * _sizeScale.Y, v22.Z * _sizeScale.Z)
end

v2 = function(p1) --[[ Line: 114 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
	local _part = p1._part

	if not _part then
		t3[p1] = nil
		t4[p1] = nil
		p1._tweenStartCFrame = nil
		p1._tweenGoalCFrame = nil
		p1._tweenInfo = nil
		p1._tweenElapsed = 0
		p1._part = nil
		p1._baseCFrame = nil
		p1._nextCFrame = nil
		p1._baseSize = nil
		p1._destroyed = true

		return
	end

	t2[_part] = nil
	t3[p1] = nil
	t4[p1] = nil
	p1._tweenStartCFrame = nil
	p1._tweenGoalCFrame = nil
	p1._tweenInfo = nil
	p1._tweenElapsed = 0
	p1._part = nil
	p1._baseCFrame = nil
	p1._nextCFrame = nil
	p1._baseSize = nil
	p1._destroyed = true
end

local function pruneDeadComponents() --[[ pruneDeadComponents | Line: 130 | Upvalues: t2 (copy), v2 (ref) ]]
	for k, v in pairs(t2) do
		if not (if k == nil then false else k.Parent ~= nil) then
			v2(v)
		end
	end
end

local function updateTweenComponents(p1) --[[ updateTweenComponents | Line: 138 | Upvalues: t4 (copy), v2 (ref), TweenService (copy), t3 (copy) ]]
	for k in pairs(t4) do
		local v1
		local _part = k._part
		local _tweenStartCFrame = k._tweenStartCFrame
		local _tweenGoalCFrame = k._tweenGoalCFrame
		local _tweenInfo = k._tweenInfo

		if if _part == nil then false else _part.Parent ~= nil then
			if _tweenStartCFrame and (_tweenGoalCFrame and _tweenInfo) then
				k._tweenElapsed = k._tweenElapsed + p1
				v1 = if _tweenInfo.Time > 0 then math.clamp(k._tweenElapsed / _tweenInfo.Time, 0, 1) else 1
				k._baseCFrame = _tweenStartCFrame:Lerp(_tweenGoalCFrame, (TweenService:GetValue(v1, _tweenInfo.EasingStyle, _tweenInfo.EasingDirection)))
				k._nextCFrame = k._baseCFrame * k._cframeOffset
				t3[k] = true

				if v1 >= 1 then
					t4[k] = nil
					k._tweenStartCFrame = nil
					k._tweenGoalCFrame = nil
					k._tweenInfo = nil
					k._tweenElapsed = 0
				end

				continue
			end

			t4[k] = nil
			k._tweenStartCFrame = nil
			k._tweenGoalCFrame = nil
			k._tweenInfo = nil
			k._tweenElapsed = 0

			continue
		end

		v2(k)
	end
end

function t.SetCFrame(p1, p2) --[[ SetCFrame | Line: 176 | Upvalues: Asserts (copy), v2 (ref), t4 (copy), t3 (copy) ]]
	Asserts.finiteCFrame(p2)

	if p1._destroyed then
		return
	end

	local _part = p1._part

	if if _part == nil then false else _part.Parent ~= nil then
		t4[p1] = nil
		p1._tweenStartCFrame = nil
		p1._tweenGoalCFrame = nil
		p1._tweenInfo = nil
		p1._tweenElapsed = 0
		p1._baseCFrame = p2
		p1._nextCFrame = p2 * p1._cframeOffset
		t3[p1] = true
	else
		v2(p1)
	end
end
function t.SetCFrameNow(p1, p2) --[[ SetCFrameNow | Line: 197 | Upvalues: Asserts (copy), v2 (ref), t4 (copy), t3 (copy) ]]
	Asserts.finiteCFrame(p2)

	if p1._destroyed then
		return
	end

	local _part = p1._part

	if if _part == nil then false elseif _part.Parent == nil then false else true then
		t4[p1] = nil
		p1._tweenStartCFrame = nil
		p1._tweenGoalCFrame = nil
		p1._tweenInfo = nil
		p1._tweenElapsed = 0
		t3[p1] = nil
		p1._baseCFrame = p2
		p1._nextCFrame = p2 * p1._cframeOffset
		_part.CFrame = p1._nextCFrame
	else
		v2(p1)
	end
end
function t.TweenCFrame(p1, p2, p3) --[[ TweenCFrame | Line: 221 | Upvalues: Asserts (copy), v2 (ref), t4 (copy), t3 (copy) ]]
	Asserts.TweenInfo(p2)
	Asserts.finiteCFrame(p3)

	if p1._destroyed then
		return
	end

	local _part = p1._part

	if not (if _part == nil then false elseif _part.Parent == nil then false else true) then
		v2(p1)

		return
	end

	p1._tweenStartCFrame = p1._baseCFrame or _part.CFrame
	p1._tweenGoalCFrame = p3
	p1._tweenInfo = p2
	p1._tweenElapsed = 0
	t4[p1] = true
	t3[p1] = true
end
function t.CancelTween(p1) --[[ CancelTween | Line: 245 | Upvalues: t4 (copy) ]]
	t4[p1] = nil
	p1._tweenStartCFrame = nil
	p1._tweenGoalCFrame = nil
	p1._tweenInfo = nil
	p1._tweenElapsed = 0
end
function t.SetCFrameOffset(p1, p2) --[[ SetCFrameOffset | Line: 249 | Upvalues: Asserts (copy), v2 (ref), t3 (copy) ]]
	Asserts.finiteCFrame(p2)

	if p1._destroyed then
		return
	end

	local _part = p1._part

	if not (if _part == nil then false elseif _part.Parent == nil then false else true) then
		v2(p1)

		return
	end

	p1._cframeOffset = p2

	local v22 = p1._baseCFrame or _part.CFrame

	p1._baseCFrame = v22
	p1._nextCFrame = v22 * p1._cframeOffset
	t3[p1] = true
end
function t.SetBaseSize(p1, p2) --[[ SetBaseSize | Line: 272 | Upvalues: Asserts (copy), v2 (ref) ]]
	Asserts.finiteVector3(p2)

	if p1._destroyed then
		return
	end

	p1._baseSize = p2

	local _part = p1._part

	if not (if _part == nil then false elseif _part.Parent == nil then false else true) then
		v2(p1)

		return
	end

	local v22 = p1._baseSize or _part.Size
	local _sizeScale = p1._sizeScale

	_part.Size = Vector3.new(v22.X * _sizeScale.X, v22.Y * _sizeScale.Y, v22.Z * _sizeScale.Z)
end
function t.SetSizeScale(p1, p2) --[[ SetSizeScale | Line: 283 | Upvalues: Asserts (copy), v2 (ref) ]]
	Asserts.finiteVector3(p2)

	if p1._destroyed then
		return
	end

	p1._sizeScale = p2

	local _part = p1._part

	if not (if _part == nil then false elseif _part.Parent == nil then false else true) then
		v2(p1)

		return
	end

	local v22 = p1._baseSize or _part.Size
	local _sizeScale = p1._sizeScale

	_part.Size = Vector3.new(v22.X * _sizeScale.X, v22.Y * _sizeScale.Y, v22.Z * _sizeScale.Z)
end
function t.Destroy(p1) --[[ Destroy | Line: 294 | Upvalues: v2 (ref) ]]
	if not p1._destroyed then
		v2(p1)
	end
end
function t.GetPart(p1) --[[ GetPart | Line: 302 ]]
	if p1._destroyed then
		return nil
	end

	return p1._part
end
function t7.Register(p1, p2) --[[ Register | Line: 310 | Upvalues: Asserts (copy), t2 (copy), t (copy) ]]
	Asserts.BasePart(p1)
	Asserts.optional.finiteCFrame(p2)

	local v1 = t2[p1]

	if not v1 or v1._destroyed then
		local v2 = t.new(p1, p2)

		t2[p1] = v2

		return v2
	end

	if p2 then
		v1:SetCFrame(p2)
	end

	return v1
end
function t7.SetCFrame(p1, p2) --[[ SetCFrame | Line: 331 | Upvalues: Asserts (copy), t7 (copy) ]]
	Asserts.BasePart(p1)
	Asserts.finiteCFrame(p2)

	local v1 = t7.Register(p1)

	v1:SetCFrame(p2)

	return v1
end
function t7.SetCFrameOffset(p1, p2) --[[ SetCFrameOffset | Line: 342 | Upvalues: Asserts (copy), t7 (copy) ]]
	Asserts.BasePart(p1)
	Asserts.finiteCFrame(p2)

	local v1 = t7.Register(p1)

	v1:SetCFrameOffset(p2)

	return v1
end
function t7.SetCFrameNow(p1, p2) --[[ SetCFrameNow | Line: 353 | Upvalues: Asserts (copy), t7 (copy) ]]
	Asserts.BasePart(p1)
	Asserts.finiteCFrame(p2)

	local v1 = t7.Register(p1)

	v1:SetCFrameNow(p2)

	return v1
end
function t7.TweenCFrame(p1, p2, p3) --[[ TweenCFrame | Line: 364 | Upvalues: Asserts (copy), t7 (copy) ]]
	Asserts.BasePart(p1)
	Asserts.TweenInfo(p2)
	Asserts.finiteCFrame(p3)

	local v1 = t7.Register(p1)

	v1:TweenCFrame(p2, p3)

	return v1
end
function t7.SetSize(p1, p2) --[[ SetSize | Line: 376 | Upvalues: Asserts (copy), t7 (copy) ]]
	Asserts.BasePart(p1)
	Asserts.finiteVector3(p2)

	local v1 = t7.Register(p1)

	v1:SetBaseSize(p2)

	return v1
end
function t7.SetSizeScale(p1, p2) --[[ SetSizeScale | Line: 387 | Upvalues: Asserts (copy), t7 (copy) ]]
	Asserts.BasePart(p1)
	Asserts.finiteVector3(p2)

	local v1 = t7.Register(p1)

	v1:SetSizeScale(p2)

	return v1
end
function t7.Remove(p1) --[[ Remove | Line: 398 | Upvalues: Asserts (copy), t2 (copy), v2 (ref) ]]
	Asserts.BasePart(p1)

	local v1 = t2[p1]

	if not v1 then
		return
	end

	v2(v1)
end
function t7.Flush(p1) --[[ Flush | Line: 408 | Upvalues: updateTweenComponents (copy), t5 (copy), t6 (copy), t3 (copy), v2 (ref), wcall (copy), Workspace (copy), pruneDeadComponents (copy), v1 (copy) ]]
	updateTweenComponents(p1 or 0)
	table.clear(t5)
	table.clear(t6)

	local count = 0

	for k in pairs(t3) do
		t3[k] = nil

		local _part = k._part
		local _nextCFrame = k._nextCFrame

		k._nextCFrame = nil

		if if _part == nil then false elseif _part.Parent == nil then false else true then
			if _nextCFrame then
				count = count + 1
				t5[count] = _part
				t6[count] = _nextCFrame
			end

			continue
		end

		v2(k)
	end

	if count <= 0 then
		return
	end

	if wcall(function() --[[ Line: 443 | Upvalues: Workspace (ref), t5 (ref), t6 (ref) ]]
		Workspace:BulkMoveTo(t5, t6, Enum.BulkMoveMode.FireCFrameChanged)
	end) then
		return
	end

	pruneDeadComponents()
	v1:AtWarning():Log("[BulkMoveController] bulk move failed; pruned dead components")
end
RunService.PreSimulation:Connect(t7.Flush)

return t7