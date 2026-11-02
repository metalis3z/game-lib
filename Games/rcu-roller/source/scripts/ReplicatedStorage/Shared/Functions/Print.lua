-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:55
-- Luau version 6, Types version 3
-- Time taken: 0.000484 seconds

local GetScriptSource_upvr = require(script.Parent.GetScriptSource)
return function(arg1, arg2) -- Line 8
	--[[ Upvalues[1]:
		[1]: GetScriptSource_upvr (readonly)
	]]
	local var3 = arg2
	if not var3 then
		var3 = print
	end
	var3(`[{GetScriptSource_upvr(3)}]: {arg1}`)
end