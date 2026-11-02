-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:21
-- Luau version 6, Types version 3
-- Time taken: 0.001402 seconds

local module_upvr = {
	Config = {
		PlayIdleOutsideOfDialog = true;
		Poses = {
			Idle = "rbxassetid://180435571";
		};
	};
}
function module_upvr.Interacted(arg1) -- Line 10
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not module_upvr.first then
		module_upvr.first = true
		arg1:CreateDialog({
			Text = "Hey again";
		})
		arg1:CreateDialog({
			Text = "I'm back to investigating this <Color=Blue>#Mysterious<Color=/> portrait";
		})
	else
		arg1:CreateDialog({
			Text = "<Color=Blue>#LookingIntoThis<Color=/>...";
		})
	end
end
return module_upvr