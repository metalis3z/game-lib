-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:17:05
-- Luau version 6, Types version 3
-- Time taken: 0.001741 seconds

local module_3 = {
	fromVector3 = function(...) -- Line 19, Named "fromVector3"
		local args_list = {...}
		local module_2 = {}
		for i = 1, #args_list do
			local var6
			if typeof(args_list[i]) ~= "Vector3" then
				var6 = false
			else
				var6 = true
			end
			assert(var6, tostring(args_list[i]).."is not a Vector3 value.")
			var6 = module_2
			table.insert(var6, args_list[i])
		end
		return module_2
	end;
	fromCFrame = function(...) -- Line 29, Named "fromCFrame"
		local args_list_2 = {...}
		local module = {}
		for i_2 = 1, #args_list_2 do
			local var11
			if typeof(args_list_2[i_2]) ~= "CFrame" then
				var11 = false
			else
				var11 = true
			end
			assert(var11, tostring(args_list_2[i_2]).."is not a CFrame value.")
			var11 = module
			table.insert(var11, args_list_2[i_2].Position)
		end
		return module
	end;
	fromInstance = function(...) -- Line 39, Named "fromInstance"
		local args_list_3 = {...}
		local module_5 = {}
		for i_3 = 1, #args_list_3 do
			local var16
			if typeof(args_list_3[i_3]) ~= "Instance" then
				var16 = false
			else
				var16 = true
			end
			assert(var16, args_list_3[i_3].Name.."is not an Instance.")
			var16 = args_list_3[i_3]:IsA("BasePart")
			assert(var16, args_list_3[i_3].Name.."is not a BasePart.")
			var16 = module_5
			table.insert(var16, args_list_3[i_3].Position)
		end
		return module_5
	end;
}
local module_4_upvr = {
	Vector3 = module_3.fromVector3;
	CFrame = module_3.fromCFrame;
	Instance = module_3.fromInstance;
}
function module_3.new(...) -- Line 58
	--[[ Upvalues[1]:
		[1]: module_4_upvr (readonly)
	]]
	assert(module_4_upvr[typeof(...)], "Parameters are not correct value types, try using value specific functions.")
	return module_4_upvr[typeof(...)](...)
end
return module_3