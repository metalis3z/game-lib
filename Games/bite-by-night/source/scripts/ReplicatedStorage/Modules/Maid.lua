-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
v_u_1.__index = v_u_1
v_u_1.ClassName = "Maid"
local v_u_5 = {
	["Instance"] = function(p2)
		p2:Destroy()
	end,
	["RBXScriptConnection"] = function(p3)
		if p3.Connected then
			p3:Disconnect()
		end
	end,
	["thread"] = function(p4)
		if coroutine.status(p4) ~= "suspended" then
			coroutine.close(p4)
		end
	end
}
function v_u_1.new(p6)
	-- upvalues: (copy) v_u_1
	local v7 = v_u_1
	local v8 = setmetatable({}, v7)
	v8._Items = p6 or {}
	v8._CurrIndex = 1
	return v8
end
function v_u_1.Mark(p9, p10)
	local v11 = p9._CurrIndex
	p9._Items[v11] = p10
	p9._CurrIndex = p9._CurrIndex + 1
	return v11
end
function v_u_1.Unmark(p12, p13)
	p12._Items[p13] = nil
end
function v_u_1.Sweep(p14)
	-- upvalues: (copy) v_u_5
	for _, v15 in pairs(p14._Items) do
		if typeof(v15) and v_u_5[typeof(v15)] then
			v_u_5[typeof(v15)](v15)
		end
	end
	p14._Items = {}
	p14._CurrIndex = nil
end
v_u_1.Destroy = v_u_1.Sweep
return v_u_1