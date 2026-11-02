---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.Trove)
local v_u_4 = 0
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = CFrame.new(-410.752, -9.782, 59.406):Inverse()
local v_u_8 = v_u_1:GetAttribute("3RoadsEvent")
v_u_1:GetAttributeChangedSignal("3RoadsEvent"):Connect(function()
	-- upvalues: (ref) v_u_8, (copy) v_u_1
	v_u_8 = v_u_1:GetAttribute("3RoadsEvent")
end)
local function v11(p9, p10)
	-- upvalues: (ref) v_u_4, (copy) v_u_5, (copy) v_u_6
	v_u_4 = v_u_4 + 1
	v_u_5[v_u_4] = p9
	v_u_6[v_u_4] = p10
end
local function v13(p12)
	-- upvalues: (ref) v_u_8, (copy) v_u_3, (copy) v_u_7
	if v_u_8 then
		return v_u_3.isPointInVolume_direct(p12, v_u_7, Vector3.new(68, 661.5, 401))
	else
		return v_u_3.isPointInVolume_direct(p12, v_u_7, Vector3.new(20, 661.5, 401))
	end
end
local function v15(p14)
	-- upvalues: (ref) v_u_8, (copy) v_u_3, (copy) v_u_7
	if v_u_8 then
		return v_u_3.isPointInVolume_direct(p14, v_u_7, Vector3.new(34, 661.5, 200.5))
	else
		return v_u_3.isPointInVolume_direct(p14, v_u_7, Vector3.new(10, 661.5, 200.5))
	end
end
local function v16()
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (ref) v_u_4
	debug.profilebegin("SharedEventUtils:StepParts")
	workspace:BulkMoveTo(v_u_5, v_u_6, Enum.BulkMoveMode.FireCFrameChanged)
	v_u_4 = 0
	table.clear(v_u_5)
	table.clear(v_u_6)
	debug.profileend()
end
local function v22(p_u_17, p18, p19)
	local v_u_20 = p18:LoadAnimation(p19)
	local function v_u_21()
		-- upvalues: (copy) v_u_20
		v_u_20:Stop(0)
		v_u_20:Destroy()
	end
	p_u_17:Add(v_u_21)
	return v_u_20, function()
		-- upvalues: (copy) p_u_17, (copy) v_u_21
		p_u_17:Remove(v_u_21)
	end
end
if v2:IsServer() then
	v2.PostSimulation:Connect(v16)
else
	v2.PreRender:Connect(v16)
end
return {
	["pushPartCFrame"] = v11,
	["isPointInCarpet"] = v13,
	["isPointInCarpetHalf"] = v15,
	["loadAnimation"] = v22
}