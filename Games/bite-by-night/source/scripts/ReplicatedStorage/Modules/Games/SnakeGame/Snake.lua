-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
v_u_1.__index = v_u_1
v_u_1.ClassName = "Snake"
require("./Types")
function v_u_1.new()
	-- upvalues: (copy) v_u_1
	local v2 = v_u_1
	local v3 = setmetatable({}, v2)
	v3.NextDirection = {}
	v3.Length = 0
	v3.Positions = { Vector2.zero }
	v3.MoveDirection = Vector2.new(1, 0)
	return v3
end
function v_u_1.MoveForward(p4)
	local v5 = #p4.Positions
	local v6 = nil
	for v7, v8 in p4.Positions do
		if v6 then
			p4.Positions[v7] = v6
		else
			local v9 = p4.Positions
			v9[v7] = v9[v7] + p4.MoveDirection
		end
		if v7 == v5 then
			p4.FruitTailPos = v8
			v6 = v8
		else
			v6 = v8
		end
	end
end
function v_u_1.EatFruit(p10)
	local v11 = p10.Positions
	local v12 = p10.FruitTailPos
	table.insert(v11, v12)
	p10.Length = p10.Length + 1
end
function v_u_1.UpdateDirection(p13)
	if #p13.NextDirection > 0 then
		if p13.Positions[2] ~= p13.Positions[1] + p13.NextDirection[1] then
			p13.MoveDirection = p13.NextDirection[1]
		end
		table.remove(p13.NextDirection, 1)
	end
end
function v_u_1.AttemptToSetMoveDirection(p14, p15)
	if p14.Length == 0 then
		local v16 = p14.NextDirection
		table.insert(v16, p15)
		p14:UpdateDirection()
	else
		local v17 = p14.NextDirection
		table.insert(v17, p15)
		p14:UpdateDirection()
	end
end
function v_u_1.Destroy(p18)
	setmetatable(p18, nil)
	table.clear(p18)
end
return v_u_1