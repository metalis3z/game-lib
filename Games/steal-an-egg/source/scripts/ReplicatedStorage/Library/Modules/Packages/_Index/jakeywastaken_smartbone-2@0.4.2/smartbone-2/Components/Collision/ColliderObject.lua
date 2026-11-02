-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Collider = require(script.Parent:WaitForChild("Collider"))
local SB_VERBOSE_LOG = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")).SB_VERBOSE_LOG
local t = {}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 57 | Upvalues: t (copy) ]]
	local v2 = setmetatable({
		m_Awake = true,
		m_LastSleepCycle = 0,
		Destroyed = false,
		m_Object = p2,
		Colliders = {}
	}, t)

	v2:m_LoadColliderTable(p1)
	v2.DestroyConnection = p2:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 68 | Upvalues: p2 (copy), v2 (copy) ]]
		if p2.Parent ~= nil then
			return
		end

		v2.Destroyed = true
	end)

	return v2
end
function t.m_LoadCollider(p1, p2) --[[ m_LoadCollider | Line: 80 | Upvalues: Collider (copy) ]]
	local v1 = Vector3.new(p2.ScaleX, p2.ScaleY, p2.ScaleZ)
	local v2 = Vector3.new(p2.OffsetX, p2.OffsetY, p2.OffsetZ)
	local v3 = Vector3.new(p2.RotationX, p2.RotationY, p2.RotationZ)
	local v4 = Collider.new()

	v4.Scale = v1
	v4.Offset = v2
	v4.Rotation = v3
	v4.Type = p2.Type
	v4:SetObject(p1.m_Object)
	table.insert(p1.Colliders, v4)
end
function t.m_LoadColliderTable(p1, p2) --[[ m_LoadColliderTable | Line: 98 ]]
	for v1, v2 in p2 do
		p1:m_LoadCollider(v2)
	end
end
function t.GetObject(p1) --[[ GetObject | Line: 108 ]]
	return p1.m_Object
end
function t.GetCollisions(p1, p2, p3) --[[ GetCollisions | Line: 116 ]]
	if not p1.m_Object then
		return {}
	end

	if #p1.Colliders == 0 then
		return {}
	end

	if os.clock() - p1.m_LastSleepCycle >= 0.2 then
		p1.m_LastSleepCycle = os.clock()

		if p1.m_Object:IsDescendantOf(workspace) then
			p1.m_Awake = true
		else
			p1.m_Awake = false
		end
	end

	if not p1.m_Awake then
		return {}
	end

	local t = {}

	for v1, v2 in p1.Colliders do
		local v3, v4, v5 = v2:GetClosestPoint(p2, p3)

		if v3 then
			table.insert(t, {
				ClosestPoint = v4,
				Normal = v5
			})
		end
	end

	return t
end
function t.Step(p1) --[[ Step | Line: 175 ]]
	for v1, v2 in p1.Colliders do
		v2:Step()
	end
end
function t.DrawDebug(p1, p2, p3, p4, p5) --[[ DrawDebug | Line: 190 ]]
	for v1, v2 in p1.Colliders do
		v2:DrawDebug(p1, p2, p3, p4, p5)
		v2.InNarrowphase = false
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 198 | Upvalues: SB_VERBOSE_LOG (copy) ]]
	task.synchronize()
	SB_VERBOSE_LOG((("Collider object destroying, object: %*"):format(p1.m_Object)))
	p1.DestroyConnection:Disconnect()

	if #p1.Colliders ~= 0 then
		for v1, v2 in p1.Colliders do
			v2:Destroy()
		end
	end

	setmetatable(p1, nil)
	task.desynchronize()
end

return t