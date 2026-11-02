-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.Init(p1, p2, p3, p4, p5) --[[ Init | Line: 4 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Ceive = p1
	v2.Propertys = p2
	v2.Request = p3
	v2.Release = p4
	v2.Retain = p5

	return v2
end
function t.Draw(p1, p2, p3) --[[ Draw | Line: 16 ]]
	local Ceive = p1.Ceive

	if not Ceive.Enabled then
		return
	end

	if p1.Propertys.AlwaysOnTop then
		Ceive.AOTWireframeHandle:AddLine(p2, p3)
	else
		Ceive.WireframeHandle:AddLine(p2, p3)
	end

	local Ceive2 = p1.Ceive

	Ceive2.ActiveRays = Ceive2.ActiveRays + 1
	p1.Ceive.ScheduleCleaning()
end
function t.Create(p1, p2, p3) --[[ Create | Line: 34 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Origin = p2,
		End = p3,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 50 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Origin, p2.End)
end

return t