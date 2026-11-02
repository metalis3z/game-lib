-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:41
-- Luau version 6, Types version 3
-- Time taken: 0.001403 seconds

local module_upvr = {
	Config = {
		FacePlayer = false;
		PlayIdleOutsideOfDialog = false;
	};
}
function module_upvr.Interacted(arg1) -- Line 10
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not module_upvr.SpokenToBefore then
		module_upvr.SpokenToBefore = true
		arg1:CreateDialog({
			Text = "Wow... this new headset I got is great!";
		})
		arg1:CreateDialog({
			Text = "It's so realistic, I can actually feel the cold!";
		})
	else
		arg1:CreateDialog({
			Text = "This is so cool!";
		})
		arg1:CreateDialog({
			Text = "Literally!";
		})
	end
end
return module_upvr