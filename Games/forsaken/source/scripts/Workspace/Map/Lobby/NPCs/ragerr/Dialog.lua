-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:24
-- Luau version 6, Types version 3
-- Time taken: 0.001544 seconds

local module_upvr = {
	Config = {
		FacePlayer = false;
		PlayIdleOutsideOfDialog = true;
		Poses = {
			Idle = "rbxassetid://82221753254937";
		};
	};
}
function module_upvr.Interacted(arg1) -- Line 11
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not module_upvr.SpokenToBefore then
		module_upvr.SpokenToBefore = true
		arg1:CreateDialog({
			Text = "I'm THE greatest forsaken player";
		})
		arg1:CreateDialog({
			Text = "ME";
		})
	else
		arg1:CreateDialog({
			Text = "I'm lowk buns at the game tho";
		})
	end
end
return module_upvr