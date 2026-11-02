-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:15
-- Luau version 6, Types version 3
-- Time taken: 0.001313 seconds

return function(arg1, arg2) -- Line 7
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var18
	if arg2 then
		var18 = Random.new(arg2)
	end
	var18 = 0
	for _, v in pairs(arg1) do
		local var22
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var22 = v.chance
			return var22
		end
		if typeof(v) ~= "table" or not v.chance or not INLINED() then
			var22 = v
		end
		var18 += var22
	end
	for i_2, v_2 in pairs(arg1) do
		local var26
		local function INLINED_2() -- Internal function, doesn't exist in bytecode
			var26 = v_2.chance
			return var26
		end
		if typeof(v_2) ~= "table" or not v_2.chance or not INLINED_2() then
			var26 = v_2
		end
		if var18:NextNumber(0, var18) <= 0 + var26 then
			return i_2
		end
	end
end