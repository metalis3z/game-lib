-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {
	"Set",
	"Get",
	"Private",
	"ReadOnly",
	"WriteOnly",
	"Constructor",
	"GlobalGetFunction",
	"GlobalSetFunction"
}
local function v_u_7(p2)
	-- upvalues: (copy) v_u_7
	local v3 = {}
	for v4, v6 in p2 do
		if type(v6) == "table" then
			local v6 = v_u_7(v6) or v6
		end
		v3[v4] = v6
	end
	return v3
end
return function(p_u_8)
	-- upvalues: (copy) v_u_7, (copy) v_u_1
	local v_u_9 = {}
	v_u_9.__index = v_u_9
	v_u_9.__customclass = true
	local v_u_10 = v_u_7(p_u_8.Set or {})
	local v_u_11 = v_u_7(p_u_8.Get or {})
	local v_u_12 = v_u_7(p_u_8.ReadOnly or {})
	local v_u_13 = v_u_7(p_u_8.WriteOnly or {})
	local v_u_14 = v_u_7(p_u_8.Private or {})
	local v_u_15 = p_u_8.GlobalGetFunction
	local v_u_16 = p_u_8.GlobalSetFunction
	local v_u_17 = p_u_8.Constructor
	table.freeze(v_u_10)
	table.freeze(v_u_11)
	table.freeze(v_u_12)
	table.freeze(v_u_13)
	table.freeze(v_u_14)
	table.freeze(p_u_8)
	function v_u_9.new(...)
		-- upvalues: (ref) p_u_8, (ref) v_u_7, (ref) v_u_1, (copy) v_u_14, (copy) v_u_13, (copy) v_u_11, (copy) v_u_15, (copy) v_u_9, (copy) v_u_12, (copy) v_u_10, (copy) v_u_16, (copy) v_u_17
		local v_u_18 = {}
		local v_u_19 = {}
		p_u_8 = v_u_7(p_u_8)
		for v20, v21 in p_u_8 do
			if not table.find(v_u_1, v20) then
				v_u_18[v20] = v21
			end
		end
		local v37 = {
			["__index"] = function(p22, p23)
				-- upvalues: (ref) v_u_14, (copy) v_u_19, (ref) v_u_13, (ref) v_u_11, (ref) v_u_15, (ref) v_u_9, (copy) v_u_18
				local v24 = debug.info(2, "f")
				local v25 = v_u_14[p23]
				if not v_u_19[v24] and v25 then
					return error((("Cannot access private function %* from %*"):format(v24, (debug.info(2, "f")))))
				end
				if v_u_13[p23] then
					return error((("Cannot read from write only property %*"):format(p23)))
				end
				local v26 = v_u_11[p23]
				if v_u_15 then
					v_u_15(p22, p23)
				end
				local v27 = v_u_9
				local v28 = rawget(v27, p23) or v26 and v26(p22)
				if not v28 then
					local v29 = v_u_18
					v28 = rawget(v29, p23)
				end
				return v28
			end,
			["__newindex"] = function(p30, p31, p32)
				-- upvalues: (ref) v_u_14, (copy) v_u_19, (ref) v_u_12, (ref) v_u_10, (copy) v_u_18, (ref) v_u_16
				local v33 = debug.info(2, "f")
				local v34 = v_u_14[p31]
				if not v_u_19[v33] and v34 then
					return error((("Cannot access private function %* from %*"):format(v33, (debug.info(2, "f")))))
				end
				if v_u_12[p31] then
					return error((("Cannot write to read only property %*"):format(p31)))
				end
				local v35 = v_u_10[p31]
				if v35 then
					v35(p30, p31, p32)
				else
					local v36 = v_u_18
					rawset(v36, p31, p32)
				end
				if v_u_16 then
					v_u_16(p30, p31, p32)
				end
			end
		}
		local v38 = setmetatable({
			["RealData"] = v_u_18
		}, v37)
		for _, v39 in v_u_9 do
			if type(v39) == "function" then
				v_u_19[v39] = true
			end
		end
		v_u_19[debug.info(1, "f")] = true
		if v_u_17 then
			v_u_17(v38, ...)
		end
		return v38
	end
	return v_u_9
end
