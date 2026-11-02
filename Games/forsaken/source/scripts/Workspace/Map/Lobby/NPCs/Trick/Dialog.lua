-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:28
-- Luau version 6, Types version 3
-- Time taken: 0.002066 seconds

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
	if not module_upvr.SpokenToBefore then
		module_upvr.SpokenToBefore = true
		arg1:CreateDialog({
			Text = "I got way too much candy from everybody.";
		})
		arg1:CreateDialog({
			Text = "You want some of my leftovers?";
		})
	else
		arg1:CreateDialog({
			Text = "It's now Christmas!";
		})
	end
end
return module_upvr