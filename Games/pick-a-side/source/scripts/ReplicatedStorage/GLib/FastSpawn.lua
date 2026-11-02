-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:03
-- Luau version 6, Types version 3
-- Time taken: 0.000733 seconds

local new_upvr = Instance.new
local new_upvr_result1_2 = new_upvr("BindableEvent")
local connect_upvr = new_upvr_result1_2.Event.connect
local Fire_upvr = new_upvr_result1_2.Fire
local Destroy_upvr = new_upvr_result1_2.Destroy
return function(arg1, ...) -- Line 14
	--[[ Upvalues[4]:
		[1]: new_upvr (readonly)
		[2]: connect_upvr (readonly)
		[3]: Fire_upvr (readonly)
		[4]: Destroy_upvr (readonly)
	]]
	local new_upvr_result1 = new_upvr("BindableEvent")
	connect_upvr(new_upvr_result1.Event, arg1)
	Fire_upvr(new_upvr_result1, ...)
	Destroy_upvr(new_upvr_result1)
end