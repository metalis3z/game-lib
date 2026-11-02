-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CurrentCamera = workspace.CurrentCamera
local t = {}

t.__index = t
function t.Init(p1, p2, p3, p4, p5) --[[ Init | Line: 9 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Ceive = p1
	v2.Propertys = p2
	v2.Request = p3
	v2.Release = p4
	v2.Retain = p5

	return v2
end
function t.Draw(p1, p2, p3, p4) --[[ Draw | Line: 21 | Upvalues: CurrentCamera (copy) ]]
	local Ceive = p1.Ceive

	if not Ceive.Enabled then
		return
	end

	if p1.Propertys.AlwaysOnTop then
		local v1 = Ceive.PopProperty("Color3")

		Ceive.PushProperty("Color3", Color3.new())
		Ceive.AOTWireframeHandle:AddText(p2 + -(Vector3.new(1, 1, 0)).Unit * ((p2 - CurrentCamera.CFrame.Position).Magnitude * 0.00175), p3, p4)
		Ceive.PushProperty("Color3", v1)
		Ceive.AOTWireframeHandle:AddText(p2, p3, p4)
	else
		local v3 = Ceive.PopProperty("Color3")

		Ceive.PushProperty("Color3", Color3.new())
		Ceive.WireframeHandle:AddText(p2 + -(Vector3.new(1, 1, 0)).Unit * ((p2 - CurrentCamera.CFrame.Position).Magnitude * 0.00175), p3, p4)
		Ceive.PushProperty("Color3", v3)
		Ceive.WireframeHandle:AddText(p2, p3, p4)
	end

	p1.Ceive.ScheduleCleaning()
end
function t.Create(p1, p2, p3, p4) --[[ Create | Line: 60 ]]
	local t = {
		Enabled = true,
		Destroy = false,
		Origin = p2,
		Text = p3,
		Size = p4,
		AlwaysOnTop = p1.Propertys.AlwaysOnTop,
		Transparency = p1.Propertys.Transparency,
		Color3 = p1.Propertys.Color3
	}

	p1.Retain(p1, t)

	return t
end
function t.Update(p1, p2) --[[ Update | Line: 77 ]]
	local Ceive = p1.Ceive

	Ceive.PushProperty("AlwaysOnTop", p2.AlwaysOnTop)
	Ceive.PushProperty("Transparency", p2.Transparency)
	Ceive.PushProperty("Color3", p2.Color3)
	p1:Draw(p2.Origin, p2.Text, p2.Size)
end

return t