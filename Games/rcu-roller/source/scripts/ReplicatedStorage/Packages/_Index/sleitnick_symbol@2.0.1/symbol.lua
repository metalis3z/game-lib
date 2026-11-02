-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:14
-- Luau version 6, Types version 3
-- Time taken: 0.000510 seconds

return function(arg1) -- Line 45, Named "Symbol"
	local newproxy_result1 = newproxy(true)
	local var2_upvw
	if not var2_upvw then
		var2_upvw = ""
	end
	getmetatable(newproxy_result1).__tostring = function() -- Line 50
		--[[ Upvalues[1]:
			[1]: var2_upvw (read and write)
		]]
		return "Symbol("..var2_upvw..')'
	end
	return newproxy_result1
end