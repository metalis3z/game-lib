
local scriptParent = script.Parent
local RunService = game:GetService("RunService")

require(scriptParent.Types)

local t1 = {}
local t2 = {
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
local t3 = {}
local t4 = {
	Get = function(_, p2)
		return p2._cameraAttachToPart
	end,
	Set = function(p3, p4, p5)
		if p3 then
			p5._activeCamera = p4
			p5._cameraAttachToPart = p3

			if not p5._cameraRenderBound then
				RunService:BindToRenderStep("MoonliteRenderCamera", 1000, function()
					local _cameraAttachToPart = p5._cameraAttachToPart
					local _cameraLookAtPart = p5._cameraLookAtPart

					if _cameraAttachToPart then
						local _cameraAttachToPartCFrame = _cameraAttachToPart.CFrame

						if _cameraLookAtPart then
							_cameraAttachToPartCFrame = CFrame.new(_cameraAttachToPartCFrame.Position, _cameraLookAtPart.Position)
						end

						p4.CFrame = _cameraAttachToPartCFrame
					end
				end)
				p5._cameraRenderBound = true

				local _cameraAttachToPart = p5._cameraAttachToPart
				local _cameraLookAtPart = p5._cameraLookAtPart

				if _cameraAttachToPart then
					local _cameraAttachToPartCFrame = _cameraAttachToPart.CFrame

					if _cameraLookAtPart then
						_cameraAttachToPartCFrame = CFrame.new(_cameraAttachToPartCFrame.Position, _cameraLookAtPart.Position)
					end

					p4.CFrame = _cameraAttachToPartCFrame
				end

				if not p5.KeepCameraType then
					p4.CameraType = Enum.CameraType.Scriptable

					return
				end
			end
		else
			p5._cameraAttachToPart = nil

			if p5._cameraRenderBound then
				RunService:UnbindFromRenderStep("MoonliteRenderCamera")

				if not p5.KeepCameraType then
					p4.CameraType = Enum.CameraType.Custom
				end

				p5._cameraRenderBound = false
			end
		end
	end
}

function t3.AttachToPart(p6, p7)
	assert(t4.Get)

	return {
		Get = function()
			return t4.Get(p6, p7)
		end,
		Set = function(p8)
			t4.Set(p8, p6, p7)
		end
	}
end

local t5 = {
	Get = function(_, p10)
		return p10._cameraLookAtPart
	end,
	Set = function(p11, p12, p13)
		if p11 then
			p13._activeCamera = p12
			p13._cameraLookAtPart = p11

			if not p13._cameraRenderBound then
				RunService:BindToRenderStep("MoonliteRenderCamera", 1000, function()
					local _cameraAttachToPart = p13._cameraAttachToPart
					local _cameraLookAtPart = p13._cameraLookAtPart

					if _cameraAttachToPart then
						local _cameraAttachToPartCFrame = _cameraAttachToPart.CFrame

						if _cameraLookAtPart then
							_cameraAttachToPartCFrame = CFrame.new(_cameraAttachToPartCFrame.Position, _cameraLookAtPart.Position)
						end

						p12.CFrame = _cameraAttachToPartCFrame
					end
				end)
				p13._cameraRenderBound = true

				local _cameraAttachToPart = p13._cameraAttachToPart
				local _cameraLookAtPart = p13._cameraLookAtPart

				if _cameraAttachToPart then
					local _cameraAttachToPartCFrame = _cameraAttachToPart.CFrame

					if _cameraLookAtPart then
						_cameraAttachToPartCFrame = CFrame.new(_cameraAttachToPartCFrame.Position, _cameraLookAtPart.Position)
					end

					p12.CFrame = _cameraAttachToPartCFrame
				end

				if not p13.KeepCameraType then
					p12.CameraType = Enum.CameraType.Scriptable
				end
			end

			if p13._updateCamera then
				p13._updateCamera()

				return
			end
		else
			p13._cameraLookAtPart = nil

			if not p13._cameraAttachToPart and p13._cameraRenderBound then
				RunService:UnbindFromRenderStep("MoonliteRenderCamera")

				if not p13.KeepCameraType then
					p12.CameraType = Enum.CameraType.Custom
				end

				p13._cameraRenderBound = false
			end
		end
	end
}

function t3.LookAtPart(p14, p15)
	assert(t5.Get)

	return {
		Get = function()
			return t5.Get(p14, p15)
		end,
		Set = function(p16)
			t5.Set(p16, p14, p15)
		end
	}
end

t1.Camera = t3
t1.Terrain = {}

for _, v9 in Enum.Material:GetEnumItems() do
	if pcall(function()
		workspace.Terrain:GetMaterialColor(v9)
	end) then
		local Terrain = t1.Terrain
		local v11 = `MC_{ v9.Name }`
		local t6 = {
			Get = function(p17)
				return p17:GetMaterialColor(v9)
			end,
			Set = function(color3: Color3, p18)
				p18:SetMaterialColor(v9, color3)
			end
		}

		Terrain[v11] = function(p19, p20)
			assert(t6.Get)

			return {
				Get = function()
					return t6.Get(p19, p20)
				end,
				Set = function(p21)
					t6.Set(p21, p19, p20)
				end
			}
		end
	end
end

local color3 = Color3.new(1, 1, 1)
local t7 = {}
local t8 = {
	Get = function(p22)
		return p22:GetPivot()
	end,
	Set = function(cFrame: CFrame, p23)
		p23:PivotTo(cFrame)
	end
}

function t7.CFrame(p24, p25)
	assert(t8.Get)

	return {
		Get = function()
			return t8.Get(p24, p25)
		end,
		Set = function(p26)
			t8.Set(p26, p24, p25)
		end
	}
end

local t9 = {
	Get = function(p27)
		local v82 = color3

		return p27:GetAttribute("__moonlite_Color") or v82
	end,
	Set = function(color3_2: Color3, p28)
		for _, v86 in p28:GetDescendants() do
			if v86:IsA("BasePart") then
				local Color = v86.Color
				local v88 = v86:GetAttribute("__moonlite_Color") or Color

				if v88 ~= color3_2 then
					v86:SetAttribute("__moonlite_Color", if color3_2 ~= v88 then color3_2 else nil)
					v86.Color = color3_2
				end
			end
		end

		p28:SetAttribute("__moonlite_Color", if color3_2 ~= color3 then color3_2 else nil)
	end
}

function t7.Color(p29, p30)
	assert(t9.Get)

	return {
		Get = function()
			return t9.Get(p29, p30)
		end,
		Set = function(p31)
			t9.Set(p31, p29, p30)
		end
	}
end

local t10 = {
	Get = function(p32)
		return p32:GetScale()
	end,
	Set = function(n1: number, p33)
		p33:ScaleTo(n1)
	end
}

function t7.Scale(p34, p35)
	assert(t10.Get)

	return {
		Get = function()
			return t10.Get(p34, p35)
		end,
		Set = function(p36)
			t10.Set(p36, p34, p35)
		end
	}
end

local t11 = {
	Get = function(p37)
		return p37:GetAttribute("__moonlite_Reflectance") or 0
	end,
	Set = function(n2: number, p38)
		if n2 ~= (p38:GetAttribute("__moonlite_Reflectance") or 0) then
			for _, v100 in p38:GetDescendants() do
				if v100:IsA("BasePart") then
					local Reflectance = v100.Reflectance
					local v102 = v100:GetAttribute("__moonlite_BaseReflectance") or Reflectance

					v100.Reflectance = v102 + (1 - v102) * n2
				end
			end

			p38:SetAttribute("__moonlite_Reflectance", if n2 ~= 0 then n2 else nil)
		end
	end
}

function t7.Reflectance(p39, p40)
	assert(t11.Get)

	return {
		Get = function()
			return t11.Get(p39, p40)
		end,
		Set = function(p41)
			t11.Set(p41, p39, p40)
		end
	}
end

local t12 = {
	Get = function(p42)
		return p42:GetAttribute("__moonlite_Transparency") or 0
	end,
	Set = function(n3: number, p43)
		if n3 ~= (p43:GetAttribute("__moonlite_Transparency") or 0) then
			for _, v109 in p43:GetDescendants() do
				if v109:IsA("BasePart") then
					v109.LocalTransparencyModifier = n3
				end
			end

			p43:SetAttribute("__moonlite_Transparency", if n3 ~= 0 then n3 else nil)
		end
	end
}

function t7.Transparency(p44, p45)
	assert(t12.Get)

	return {
		Get = function()
			return t12.Get(p44, p45)
		end,
		Set = function(p46)
			t12.Set(p46, p44, p45)
		end
	}
end

t1.Model = t7

local t13 = {
	AddAccessory = function(p47)
		return {
			Default = nil,
			Set = function(p48)
				if p48 then
					pcall(p47.AddAccessory, p47, p48)
				end
			end
		}
	end,
	ChangeState = function(p49)
		return {
			Default = Enum.HumanoidStateType.None,
			Set = function(p50)
				p49:ChangeState(p50)
			end
		}
	end,
	EquipTool = function(p51)
		return {
			Default = nil,
			Set = function(p52)
				if p52 then
					pcall(p51.EquipTool, p51, p52)
				end
			end
		}
	end
}

local function v21(p53)
	p53.Jump = true
end

function t13.Jump(p54)
	return {
		Default = false,
		Set = function(b1: boolean)
			if b1 then
				v21(p54)
			end
		end
	}
end
function t13.MoveTo(p55)
	local MoveToDefault = p55:GetAttribute("MoveToDefault")

	if typeof(MoveToDefault) ~= "Vector3" then
		local RootPart = p55.RootPart

		MoveToDefault = if not RootPart then Vector3.new(0, 0, 0) else RootPart.Position
		p55:SetAttribute("MoveToDefault", MoveToDefault)
	end

	return {
		Default = MoveToDefault,
		Set = function(vector3: Vector3)
			p55:MoveTo(vector3)
		end
	}
end
function t13.Move(p56)
	local MoveDefault = p56:GetAttribute("MoveDefault")

	if typeof(MoveDefault) ~= "Vector3" then
		local RootPart = p56.RootPart

		MoveDefault = if not RootPart then Vector3.new(0, 0, 0) else RootPart.CFrame.LookVector
		p56:SetAttribute("MoveDefault", MoveDefault)
	end

	return {
		Default = MoveDefault,
		Set = function(vector3: Vector3)
			p56:Move(vector3)
		end
	}
end
function t13.PlayEmote(p57)
	return {
		Default = "",
		Set = function(s1: string)
			p57:PlayEmote(s1)
		end
	}
end

local function v22(p58)
	p58:RemoveAccessories()
end

function t13.RemoveAccessories(p59)
	return {
		Default = false,
		Set = function(b2: boolean)
			if b2 then
				v22(p59)
			end
		end
	}
end
function t13.Sit(p60)
	return {
		Set = function(b3: boolean)
			p60.Sit = b3
		end
	}
end
function t13.TakeDamage(p61)
	return {
		Set = function(n4: number)
			p61:TakeDamage(n4)
		end
	}
end

local function v23(p62)
	p62:UnequipTools()
end

function t13.UnequipTools(p63)
	return {
		Default = false,
		Set = function(b4: boolean)
			if b4 then
				v23(p63)
			end
		end
	}
end

t1.Humanoid = t13

local t14 = {}

local function v25(p64)
	p64:Clear()
end

function t14.Clear(p65)
	return {
		Default = false,
		Set = function(b5: boolean)
			if b5 then
				v25(p65)
			end
		end
	}
end
function t14.Emit(p66)
	local EmitCount = p66:GetAttribute("EmitCount")

	if type(EmitCount) ~= "number" then
		EmitCount = 0
	end

	return {
		Default = EmitCount,
		Set = function(n5: number)
			if n5 > 0 then
				p66:Emit(n5)
			end
		end
	}
end

t1.ParticleEmitter = t14

local t15 = {}

local function v27(p67)
	local clone = p67:Clone()

	clone.Parent = p67.Parent
	clone.PlayOnRemove = true
	clone:Destroy()
end

function t15.PlayOnce(p68)
	return {
		Default = false,
		Set = function(b6: boolean)
			if b6 then
				v27(p68)
			end
		end
	}
end
function t15.SetTime(p69)
	return {
		Default = 0,
		Set = function(n6: number)
			p69.TimePosition = n6
		end
	}
end

local function v28(p70)
	p70:Play()
end

function t15.Play(p71)
	return {
		Default = false,
		Set = function(b7: boolean)
			if b7 then
				v28(p71)
			end
		end
	}
end

local function v29(p72)
	p72:Resume()
end

function t15.Resume(p73)
	return {
		Default = false,
		Set = function(b8: boolean)
			if b8 then
				v29(p73)
			end
		end
	}
end

local function v30(p74)
	p74:Pause()
end

function t15.Pause(p75)
	return {
		Default = false,
		Set = function(b9: boolean)
			if b9 then
				v30(p75)
			end
		end
	}
end

local function v31(p76)
	p76:Stop()
end

function t15.Stop(p77)
	return {
		Default = false,
		Set = function(b10: boolean)
			if b10 then
				v31(p77)
			end
		end
	}
end

t1.Sound = t15

local t16 = {}
local t17 = {}
local t18 = {}
local t19 = {
	__index = function(p78, s2: string)
		local _target = p78._target
		local ClassName = _target.ClassName
		local v150 = t17[ClassName]

		if v150 == nil then
			v150 = {}

			for v151, v152 in t1 do
				if _target:IsA(v151) then
					for v153, v154 in v152 do
						v150[v153] = v154
					end
				end
			end

			t17[ClassName] = v150
		end

		local v155 = v150[s2]
		local v156 = nil

		if v155 then
			v156 = v155(_target, p78._work)
			rawset(p78, s2, v156)
		end

		return v156
	end
}

return {
	Get = function(p79, p80, s3: string)
		local u160 = t18[p80]

		if not u160 then
			u160 = setmetatable({
				_target = p80,
				_work = p79
			}, t19)
			p80.Destroying:Connect(function()
				if t18[p80] == u160 then
					t18[p80] = nil
				end
			end)
			t18[p80] = assert(u160)
		end

		return u160[s3]
	end,
	Static = function(p81, s4: string)
		local ClassName = p81.ClassName

		if not t16[ClassName] then
			local t20 = {}

			for k, v in pairs(t2) do
				if p81:IsA(k) then
					for v167, v168 in v do
						t20[v167] = v168
					end
				end
			end

			t16[ClassName] = t20
		end

		return t16[ClassName][s4] == true
	end,
	Index = t1
}
