-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent
local RunService = game:GetService("RunService")

require(v1.Types)

local t = {}

local function getValue(p1, p2, p3) --[[ getValue | Line: 70 ]]
	return p1:GetAttribute((("__moonlite_%*"):format(p2))) or p3
end

local function setValue(p1, p2, p3, p4) --[[ setValue | Line: 74 ]]
	p1:SetAttribute(("__moonlite_%*"):format(p2), if p3 == p4 then nil else p3)
end

local function BoundProp(p1) --[[ BoundProp | Line: 78 ]]
	return function(p13, p2) --[[ Line: 79 | Upvalues: p1 (copy) ]]
		local Get = p1.Get

		assert(Get)

		return {
			Get = function() --[[ Get | Line: 83 | Upvalues: p1 (ref), p13 (copy), p2 (copy) ]]
				return p1.Get(p13, p2)
			end,
			Set = function(p1) --[[ Set | Line: 87 | Upvalues: p1 (ref), p13 (copy), p2 (copy) ]]
				p1.Set(p1, p13, p2)
			end
		}
	end
end

local function LazyAction(p1) --[[ LazyAction | Line: 94 ]]
	return function(p1) --[[ Line: 95 | Upvalues: p1 (copy) ]]
		return {
			Default = false,
			Set = function(p13) --[[ Set | Line: 99 | Upvalues: p1 (ref), p1 (copy) ]]
				if not p13 then
					return
				end

				p1(p1)
			end
		}
	end
end

local function setCameraActive(p1, p2, p3) --[[ setCameraActive | Line: 114 | Upvalues: RunService (copy) ]]
	if p3 and not p1._cameraRenderBound then
		RunService:BindToRenderStep("MoonliteRenderCamera", 1000, function() --[[ updateCamera | Line: 116 | Upvalues: p1 (copy), p2 (copy) ]]
			local _cameraAttachToPart = p1._cameraAttachToPart
			local _cameraLookAtPart = p1._cameraLookAtPart

			if not _cameraAttachToPart then
				return
			end

			local v1 = _cameraAttachToPart.CFrame

			if _cameraLookAtPart then
				v1 = CFrame.new(v1.Position, _cameraLookAtPart.Position)
			end

			p2.CFrame = v1
		end)
		p1._cameraRenderBound = true

		local _cameraAttachToPart = p1._cameraAttachToPart
		local _cameraLookAtPart = p1._cameraLookAtPart

		if _cameraAttachToPart then
			local v1 = _cameraAttachToPart.CFrame

			if _cameraLookAtPart then
				v1 = CFrame.new(v1.Position, _cameraLookAtPart.Position)
			end

			p2.CFrame = v1
		end

		if not p1.KeepCameraType then
			p2.CameraType = Enum.CameraType.Scriptable
		end
	else
		if p3 or not p1._cameraRenderBound then
			return
		end

		RunService:UnbindFromRenderStep("MoonliteRenderCamera")

		if not p1.KeepCameraType then
			p2.CameraType = Enum.CameraType.Custom
		end

		p1._cameraRenderBound = false
	end
end

local t2 = {}
local t3 = {
	Get = function(p1, p2) --[[ Get | Line: 151 ]]
		return p2._cameraAttachToPart
	end,
	Set = function(p1, p2, p3) --[[ Set | Line: 155 | Upvalues: RunService (copy) ]]
		if p1 then
			p3._activeCamera = p2
			p3._cameraAttachToPart = p1

			if p3._cameraRenderBound then
				return
			end

			RunService:BindToRenderStep("MoonliteRenderCamera", 1000, function() --[[ updateCamera | Line: 116 | Upvalues: p3 (copy), p2 (copy) ]]
				local _cameraAttachToPart = p3._cameraAttachToPart
				local _cameraLookAtPart = p3._cameraLookAtPart

				if not _cameraAttachToPart then
					return
				end

				local v1 = _cameraAttachToPart.CFrame

				if _cameraLookAtPart then
					v1 = CFrame.new(v1.Position, _cameraLookAtPart.Position)
				end

				p2.CFrame = v1
			end)
			p3._cameraRenderBound = true

			local _cameraAttachToPart = p3._cameraAttachToPart
			local _cameraLookAtPart = p3._cameraLookAtPart

			if _cameraAttachToPart then
				local v1 = _cameraAttachToPart.CFrame

				if _cameraLookAtPart then
					v1 = CFrame.new(v1.Position, _cameraLookAtPart.Position)
				end

				p2.CFrame = v1
			end

			if not p3.KeepCameraType then
				p2.CameraType = Enum.CameraType.Scriptable
			end
		else
			p3._cameraAttachToPart = nil
		end
	end
}

function t2.AttachToPart(p13, p2) --[[ Line: 79 | Upvalues: t3 (copy) ]]
	local Get = t3.Get

	assert(Get)

	return {
		Get = function() --[[ Get | Line: 83 | Upvalues: t3 (ref), p13 (copy), p2 (copy) ]]
			return p1.Get(p13, p2)
		end,
		Set = function(p1) --[[ Set | Line: 87 | Upvalues: t3 (ref), p13 (copy), p2 (copy) ]]
			p1.Set(p1, p13, p2)
		end
	}
end

local t4 = {
	Get = function(p1, p2) --[[ Get | Line: 167 ]]
		return p2._cameraLookAtPart
	end,
	Set = function(p1, p2, p3) --[[ Set | Line: 171 | Upvalues: RunService (copy) ]]
		if p1 then
			p3._activeCamera = p2
			p3._cameraLookAtPart = p1

			if not p3._cameraRenderBound then
				RunService:BindToRenderStep("MoonliteRenderCamera", 1000, function() --[[ updateCamera | Line: 116 | Upvalues: p3 (copy), p2 (copy) ]]
					local _cameraAttachToPart = p3._cameraAttachToPart
					local _cameraLookAtPart = p3._cameraLookAtPart

					if not _cameraAttachToPart then
						return
					end

					local v1 = _cameraAttachToPart.CFrame

					if _cameraLookAtPart then
						v1 = CFrame.new(v1.Position, _cameraLookAtPart.Position)
					end

					p2.CFrame = v1
				end)
				p3._cameraRenderBound = true

				local _cameraAttachToPart = p3._cameraAttachToPart
				local _cameraLookAtPart = p3._cameraLookAtPart

				if _cameraAttachToPart then
					local v1 = _cameraAttachToPart.CFrame

					if _cameraLookAtPart then
						v1 = CFrame.new(v1.Position, _cameraLookAtPart.Position)
					end

					p2.CFrame = v1
				end

				if not p3.KeepCameraType then
					p2.CameraType = Enum.CameraType.Scriptable
				end
			end

			if p3._updateCamera then
				p3._updateCamera()
			end
		else
			p3._cameraLookAtPart = nil

			if p3._cameraAttachToPart or not p3._cameraRenderBound then
				return
			end

			RunService:UnbindFromRenderStep("MoonliteRenderCamera")

			if not p3.KeepCameraType then
				p2.CameraType = Enum.CameraType.Custom
			end

			p3._cameraRenderBound = false
		end
	end
}

function t2.LookAtPart(p13, p2) --[[ Line: 79 | Upvalues: t4 (copy) ]]
	local Get = t4.Get

	assert(Get)

	return {
		Get = function() --[[ Get | Line: 83 | Upvalues: t4 (ref), p13 (copy), p2 (copy) ]]
			return p1.Get(p13, p2)
		end,
		Set = function(p1) --[[ Set | Line: 87 | Upvalues: t4 (ref), p13 (copy), p2 (copy) ]]
			p1.Set(p1, p13, p2)
		end
	}
end
t.Camera = t2
t.Terrain = {}

local t5 = {
	Camera = {
		AttachToPart = true,
		LookAtPart = true
	},
	Humanoid = {
		AddAccessory = true,
		ChangeState = true,
		EquipTool = true,
		MoveTo = true,
		Move = true,
		PlayEmote = true,
		RemoveAccessories = true,
		TakeDamage = true,
		UnequipTools = true
	},
	ParticleEmitter = {
		Emit = true,
		Clear = true
	},
	Sound = {
		PlayOnce = true,
		SetTime = true,
		Play = true,
		Resume = true,
		Pause = true,
		Stop = true
	}
}

for v2, v3 in Enum.Material:GetEnumItems() do
	if pcall(function() --[[ Line: 198 | Upvalues: v3 (copy) ]]
		workspace.Terrain:GetMaterialColor(v3)
	end) then
		local v4 = ("MC_%*"):format(v3.Name)
		local t6 = {
			Get = function(p1) --[[ Get | Line: 204 | Upvalues: v3 (copy) ]]
				return p1:GetMaterialColor(v3)
			end,
			Set = function(p1, p2) --[[ Set | Line: 208 | Upvalues: v3 (copy) ]]
				p2:SetMaterialColor(v3, p1)
			end
		}

		t.Terrain[v4] = function(p13, p2) --[[ Line: 79 | Upvalues: t6 (copy) ]]
			local Get = t6.Get

			assert(Get)

			return {
				Get = function() --[[ Get | Line: 83 | Upvalues: t6 (ref), p13 (copy), p2 (copy) ]]
					return p1.Get(p13, p2)
				end,
				Set = function(p1) --[[ Set | Line: 87 | Upvalues: t6 (ref), p13 (copy), p2 (copy) ]]
					p1.Set(p1, p13, p2)
				end
			}
		end
	end
end

local v5 = Color3.new(255/255, 255/255, 255/255)
local t6 = {}
local t7 = {
	Get = function(p1) --[[ Get | Line: 223 ]]
		return p1:GetPivot()
	end,
	Set = function(p1, p2) --[[ Set | Line: 227 ]]
		p2:PivotTo(p1)
	end
}

function t6.CFrame(p13, p2) --[[ Line: 79 | Upvalues: t7 (copy) ]]
	local Get = t7.Get

	assert(Get)

	return {
		Get = function() --[[ Get | Line: 83 | Upvalues: t7 (ref), p13 (copy), p2 (copy) ]]
			return p1.Get(p13, p2)
		end,
		Set = function(p1) --[[ Set | Line: 87 | Upvalues: t7 (ref), p13 (copy), p2 (copy) ]]
			p1.Set(p1, p13, p2)
		end
	}
end

local t8 = {
	Get = function(p1) --[[ Get | Line: 233 | Upvalues: v5 (copy) ]]
		return p1:GetAttribute("__moonlite_Color") or v5
	end,
	Set = function(p1, p2) --[[ Set | Line: 237 | Upvalues: v5 (copy) ]]
		for v1, v2 in p2:GetDescendants() do
			if v2:IsA("BasePart") then
				local v3 = v2:GetAttribute("__moonlite_Color") or v2.Color

				if v3 ~= p1 then
					v2:SetAttribute("__moonlite_Color", if p1 == v3 then nil else p1)
					v2.Color = p1
				end
			end
		end

		p2:SetAttribute("__moonlite_Color", if p1 == v5 then nil else p1)
	end
}

function t6.Color(p13, p2) --[[ Line: 79 | Upvalues: t8 (copy) ]]
	local Get = t8.Get

	assert(Get)

	return {
		Get = function() --[[ Get | Line: 83 | Upvalues: t8 (ref), p13 (copy), p2 (copy) ]]
			return p1.Get(p13, p2)
		end,
		Set = function(p1) --[[ Set | Line: 87 | Upvalues: t8 (ref), p13 (copy), p2 (copy) ]]
			p1.Set(p1, p13, p2)
		end
	}
end

local t9 = {
	Get = function(p1) --[[ Get | Line: 254 ]]
		return p1:GetScale()
	end,
	Set = function(p1, p2) --[[ Set | Line: 258 ]]
		p2:ScaleTo(p1)
	end
}

function t6.Scale(p13, p2) --[[ Line: 79 | Upvalues: t9 (copy) ]]
	local Get = t9.Get

	assert(Get)

	return {
		Get = function() --[[ Get | Line: 83 | Upvalues: t9 (ref), p13 (copy), p2 (copy) ]]
			return p1.Get(p13, p2)
		end,
		Set = function(p1) --[[ Set | Line: 87 | Upvalues: t9 (ref), p13 (copy), p2 (copy) ]]
			p1.Set(p1, p13, p2)
		end
	}
end

local t10 = {
	Get = function(p1) --[[ Get | Line: 264 ]]
		return p1:GetAttribute("__moonlite_Reflectance") or 0
	end,
	Set = function(p1, p2) --[[ Set | Line: 268 ]]
		if (p2:GetAttribute("__moonlite_Reflectance") or 0) == p1 then
			return
		end

		for v1, v2 in p2:GetDescendants() do
			if v2:IsA("BasePart") then
				local v3 = v2:GetAttribute("__moonlite_BaseReflectance") or v2.Reflectance

				v2.Reflectance = v3 + (1 - v3) * p1
			end
		end

		p2:SetAttribute("__moonlite_Reflectance", if p1 == 0 then nil else p1)
	end
}

function t6.Reflectance(p13, p2) --[[ Line: 79 | Upvalues: t10 (copy) ]]
	local Get = t10.Get

	assert(Get)

	return {
		Get = function() --[[ Get | Line: 83 | Upvalues: t10 (ref), p13 (copy), p2 (copy) ]]
			return p1.Get(p13, p2)
		end,
		Set = function(p1) --[[ Set | Line: 87 | Upvalues: t10 (ref), p13 (copy), p2 (copy) ]]
			p1.Set(p1, p13, p2)
		end
	}
end

local t11 = {
	Get = function(p1) --[[ Get | Line: 286 ]]
		return p1:GetAttribute("__moonlite_Transparency") or 0
	end,
	Set = function(p1, p2) --[[ Set | Line: 290 ]]
		if (p2:GetAttribute("__moonlite_Transparency") or 0) == p1 then
			return
		end

		for v1, v2 in p2:GetDescendants() do
			if v2:IsA("BasePart") then
				v2.LocalTransparencyModifier = p1
			end
		end

		p2:SetAttribute("__moonlite_Transparency", if p1 == 0 then nil else p1)
	end
}

function t6.Transparency(p13, p2) --[[ Line: 79 | Upvalues: t11 (copy) ]]
	local Get = t11.Get

	assert(Get)

	return {
		Get = function() --[[ Get | Line: 83 | Upvalues: t11 (ref), p13 (copy), p2 (copy) ]]
			return p1.Get(p13, p2)
		end,
		Set = function(p1) --[[ Set | Line: 87 | Upvalues: t11 (ref), p13 (copy), p2 (copy) ]]
			p1.Set(p1, p13, p2)
		end
	}
end
t.Model = t6

local t12 = {
	AddAccessory = function(p1) --[[ AddAccessory | Line: 312 ]]
		return {
			Default = nil,
			Set = function(p12) --[[ Set | Line: 318 | Upvalues: p1 (copy) ]]
				if not p12 then
					return
				end

				pcall(p1.AddAccessory, p1, p12)
			end
		}
	end,
	ChangeState = function(p1) --[[ ChangeState | Line: 326 ]]
		return {
			Default = Enum.HumanoidStateType.None,
			Set = function(p12) --[[ Set | Line: 330 | Upvalues: p1 (copy) ]]
				p1:ChangeState(p12)
			end
		}
	end,
	EquipTool = function(p1) --[[ EquipTool | Line: 336 ]]
		return {
			Default = nil,
			Set = function(p12) --[[ Set | Line: 342 | Upvalues: p1 (copy) ]]
				if not p12 then
					return
				end

				pcall(p1.EquipTool, p1, p12)
			end
		}
	end
}

local function f6(p1) --[[ Line: 350 ]]
	p1.Jump = true
end

function t12.Jump(p1) --[[ Line: 95 | Upvalues: f6 (copy) ]]
	return {
		Default = false,
		Set = function(p13) --[[ Set | Line: 99 | Upvalues: f6 (ref), p1 (copy) ]]
			if not p13 then
				return
			end

			p1(p1)
		end
	}
end
function t12.MoveTo(p1) --[[ MoveTo | Line: 354 ]]
	local v1 = p1:GetAttribute("MoveToDefault")

	if typeof(v1) ~= "Vector3" then
		local RootPart = p1.RootPart

		v1 = if RootPart then RootPart.Position else Vector3.new(0, 0, 0)
		p1:SetAttribute("MoveToDefault", v1)
	end

	return {
		Default = v1,
		Set = function(p12) --[[ Set | Line: 372 | Upvalues: p1 (copy) ]]
			p1:MoveTo(p12)
		end
	}
end
function t12.Move(p1) --[[ Move | Line: 378 ]]
	local v1 = p1:GetAttribute("MoveDefault")

	if typeof(v1) ~= "Vector3" then
		local RootPart = p1.RootPart

		v1 = if RootPart then RootPart.CFrame.LookVector else Vector3.new(0, 0, 0)
		p1:SetAttribute("MoveDefault", v1)
	end

	return {
		Default = v1,
		Set = function(p12) --[[ Set | Line: 396 | Upvalues: p1 (copy) ]]
			p1:Move(p12)
		end
	}
end
function t12.PlayEmote(p1) --[[ PlayEmote | Line: 402 ]]
	return {
		Default = "",
		Set = function(p12) --[[ Set | Line: 406 | Upvalues: p1 (copy) ]]
			p1:PlayEmote(p12)
		end
	}
end

local function f7(p1) --[[ Line: 412 ]]
	p1:RemoveAccessories()
end

function t12.RemoveAccessories(p1) --[[ Line: 95 | Upvalues: f7 (copy) ]]
	return {
		Default = false,
		Set = function(p13) --[[ Set | Line: 99 | Upvalues: f7 (ref), p1 (copy) ]]
			if not p13 then
				return
			end

			p1(p1)
		end
	}
end
function t12.Sit(p1) --[[ Sit | Line: 416 ]]
	return {
		Set = function(p12) --[[ Set | Line: 418 | Upvalues: p1 (copy) ]]
			p1.Sit = p12
		end
	}
end
function t12.TakeDamage(p1) --[[ TakeDamage | Line: 424 ]]
	return {
		Set = function(p12) --[[ Set | Line: 426 | Upvalues: p1 (copy) ]]
			p1:TakeDamage(p12)
		end
	}
end

local function f8(p1) --[[ Line: 432 ]]
	p1:UnequipTools()
end

function t12.UnequipTools(p1) --[[ Line: 95 | Upvalues: f8 (copy) ]]
	return {
		Default = false,
		Set = function(p13) --[[ Set | Line: 99 | Upvalues: f8 (ref), p1 (copy) ]]
			if not p13 then
				return
			end

			p1(p1)
		end
	}
end
t.Humanoid = t12

local t13 = {}

local function f9(p1) --[[ Line: 442 ]]
	p1:Clear()
end

function t13.Clear(p1) --[[ Line: 95 | Upvalues: f9 (copy) ]]
	return {
		Default = false,
		Set = function(p13) --[[ Set | Line: 99 | Upvalues: f9 (ref), p1 (copy) ]]
			if not p13 then
				return
			end

			p1(p1)
		end
	}
end
function t13.Emit(p1) --[[ Emit | Line: 446 ]]
	local v1 = p1:GetAttribute("EmitCount")

	if type(v1) ~= "number" then
		v1 = 0
	end

	return {
		Default = v1,
		Set = function(p12) --[[ Set | Line: 456 | Upvalues: p1 (copy) ]]
			if not (p12 > 0) then
				return
			end

			p1:Emit(p12)
		end
	}
end
t.ParticleEmitter = t13

local t14 = {}

local function f10(p1) --[[ Line: 470 ]]
	local v1 = p1:Clone()

	v1.Parent = p1.Parent
	v1.PlayOnRemove = true
	v1:Destroy()
end

function t14.PlayOnce(p1) --[[ Line: 95 | Upvalues: f10 (copy) ]]
	return {
		Default = false,
		Set = function(p13) --[[ Set | Line: 99 | Upvalues: f10 (ref), p1 (copy) ]]
			if not p13 then
				return
			end

			p1(p1)
		end
	}
end
function t14.SetTime(p1) --[[ SetTime | Line: 477 ]]
	return {
		Default = 0,
		Set = function(p12) --[[ Set | Line: 481 | Upvalues: p1 (copy) ]]
			p1.TimePosition = p12
		end
	}
end

local function f11(p1) --[[ Line: 487 ]]
	p1:Play()
end

function t14.Play(p1) --[[ Line: 95 | Upvalues: f11 (copy) ]]
	return {
		Default = false,
		Set = function(p13) --[[ Set | Line: 99 | Upvalues: f11 (ref), p1 (copy) ]]
			if not p13 then
				return
			end

			p1(p1)
		end
	}
end

local function f12(p1) --[[ Line: 491 ]]
	p1:Resume()
end

function t14.Resume(p1) --[[ Line: 95 | Upvalues: f12 (copy) ]]
	return {
		Default = false,
		Set = function(p13) --[[ Set | Line: 99 | Upvalues: f12 (ref), p1 (copy) ]]
			if not p13 then
				return
			end

			p1(p1)
		end
	}
end

local function f13(p1) --[[ Line: 495 ]]
	p1:Pause()
end

function t14.Pause(p1) --[[ Line: 95 | Upvalues: f13 (copy) ]]
	return {
		Default = false,
		Set = function(p13) --[[ Set | Line: 99 | Upvalues: f13 (ref), p1 (copy) ]]
			if not p13 then
				return
			end

			p1(p1)
		end
	}
end

local function f14(p1) --[[ Line: 499 ]]
	p1:Stop()
end

function t14.Stop(p1) --[[ Line: 95 | Upvalues: f14 (copy) ]]
	return {
		Default = false,
		Set = function(p13) --[[ Set | Line: 99 | Upvalues: f14 (ref), p1 (copy) ]]
			if not p13 then
				return
			end

			p1(p1)
		end
	}
end
t.Sound = t14

local t15 = {}
local t16 = {}
local t17 = {}
local t18 = {
	__index = function(p1, p2) --[[ __index | Line: 523 | Upvalues: t16 (copy), t (copy) ]]
		local _target = p1._target
		local ClassName = _target.ClassName
		local v1 = t16[ClassName]

		if v1 == nil then
			v1 = {}

			for v2, v3 in t do
				if _target:IsA(v2) then
					for v4, v5 in v3 do
						v1[v4] = v5
					end
				end
			end

			t16[ClassName] = v1
		end

		local v6 = v1[p2]
		local v7

		if v6 then
			local v8 = v6(_target, p1._work)

			rawset(p1, p2, v8)
			v7 = v8
		else
			v7 = nil
		end

		return v7
	end
}

return {
	Get = function(p1, p2, p3) --[[ get | Line: 561 | Upvalues: t17 (copy), t18 (copy) ]]
		local v1 = t17[p2]

		if not v1 then
			v1 = setmetatable({
				_target = p2,
				_work = p1
			}, t18)
			p2.Destroying:Connect(function() --[[ Line: 571 | Upvalues: t17 (ref), p2 (copy), v1 (ref) ]]
				if t17[p2] ~= v1 then
					return
				end

				t17[p2] = nil
			end)

			local v3 = v1

			t17[p2] = assert(v3)
		end

		return v1[p3]
	end,
	Static = function(p1, p2) --[[ static | Line: 585 | Upvalues: t15 (copy), t5 (copy) ]]
		local ClassName = p1.ClassName

		if not t15[ClassName] then
			local t = {}

			for k, v in pairs(t5) do
				if p1:IsA(k) then
					for v1, v2 in v do
						t[v1] = v2
					end
				end
			end

			t15[ClassName] = t
		end

		return t15[ClassName][p2] == true
	end,
	Index = t
}