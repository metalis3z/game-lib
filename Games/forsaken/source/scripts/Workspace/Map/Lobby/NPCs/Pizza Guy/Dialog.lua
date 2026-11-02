-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:13
-- Luau version 6, Types version 3
-- Time taken: 0.002404 seconds

local module_upvr = {
	Config = {
		PlayIdleOutsideOfDialog = true;
		Poses = {
			Idle = "rbxassetid://180435571";
		};
		Actions = {
			Wave = "rbxassetid://128777973";
		};
	};
}
function module_upvr.Interacted(arg1) -- Line 13
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not module_upvr.SpokenToBefore then
		module_upvr.SpokenToBefore = true
		arg1:CreateDialog({
			Text = "i was called to deliver some pizza earlier but i dont think this is the right house";
		})
		arg1:CreateDialog({
			Text = "and i lost my car on the way here so now idk how to get back home";
		})
	else
		arg1:CreateDialog({
			Text = "i dont think im gonna get my paycheck after telling boss about this one";
		})
	end
end
return module_upvr