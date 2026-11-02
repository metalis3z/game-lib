-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:21
-- Luau version 6, Types version 3
-- Time taken: 0.002121 seconds

local module_upvr = {
	Config = {
		PlayIdleOutsideOfDialog = true;
		VoiceSFX = "rbxassetid://107715594645264";
		Poses = {
			Idle = "rbxassetid://180435571";
		};
		Actions = {
			Wave = "rbxassetid://128777973";
		};
	};
}
function module_upvr.Interacted(arg1) -- Line 14
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not module_upvr.TimesSpokenTo then
		module_upvr.TimesSpokenTo = 0
		arg1:CreateDialog({
			Text = "yo";
		})
		arg1:CreateDialog({
			Text = "the tables here are free";
		})
		arg1:CreateDialog({
			Text = "they'd cost more but there's no point in costing anything if i can't go to the store to spend my money";
		})
		arg1:CreateDialog({
			Text = "because there are no stores here";
		})
	else
		local var10 = module_upvr
		var10.TimesSpokenTo += 1
		arg1:CreateDialog({
			Text = "the tables here are free";
		})
		arg1:CreateDialog({
			Text = "they'd cost more but there's no point in costing anything if i can't go to the store to spend my money";
		})
		arg1:CreateDialog({
			Text = "because there are no stores here";
		})
	end
end
return module_upvr