-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:43
-- Luau version 6, Types version 3
-- Time taken: 0.001961 seconds

local module_upvr = {
	Config = {
		PlayIdleOutsideOfDialog = false;
	};
}
function module_upvr.Interacted(arg1) -- Line 9
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not module_upvr.SpokenToBefore then
		module_upvr.SpokenToBefore = true
		arg1:CreateDialog({
			Text = "hi";
		})
		arg1:CreateDialog({
			Text = "i'm shiver";
		})
		arg1:CreateDialog({
			Text = "i like the sno";
		})
		arg1:CreateDialog({
			Text = "what about you?";
		})
		arg1:CreateDialog({
			Text = "eh, doesn't matter";
		})
		arg1:CreateDialog({
			Text = "i just like the sno";
		})
		arg1:CreateDialog({
			Text = "hehe";
		})
		arg1:CreateDialog({
			Text = "lots of it this year";
		})
		arg1:CreateDialog({
			Text = "hope to see more soon";
		})
	else
		arg1:CreateDialog({
			Text = "snowy snow";
		})
	end
end
return module_upvr