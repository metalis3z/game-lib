-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:23
-- Luau version 6, Types version 3
-- Time taken: 0.003481 seconds

local module_upvr = {
	Config = {
		PlayIdleOutsideOfDialog = true;
		VoiceSFX = "rbxassetid://5416513331";
		Poses = {
			Idle = "rbxassetid://96388674191102";
		};
	};
}
function module_upvr.Interacted(arg1) -- Line 11
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not module_upvr.TimesInteracted then
		module_upvr.TimesInteracted = 0
	end
	local var5 = module_upvr
	var5.TimesInteracted += 1
	if module_upvr.TimesInteracted == 1 then
		arg1:CreateDialog({
			Text = "gleeb";
		})
		arg1:CreateDialog({
			Text = "haha wasn't that a good one";
		})
	else
		if module_upvr.TimesInteracted == 2 then
			arg1:CreateDialog({
				Text = "gleeb";
			})
			arg1:CreateDialog({
				Text = "haha that one was good too wasn't it";
			})
			return
		end
		if module_upvr.TimesInteracted == 3 then
			arg1:CreateDialog({
				Text = "gleeb";
			})
			arg1:CreateDialog({
				Text = "haha did i get you with that one";
			})
			return
		end
		if module_upvr.TimesInteracted == 4 then
			arg1:CreateDialog({
				Text = "gleeb";
			})
			arg1:CreateDialog({
				Text = "haha that one's gotta be my funniest one yet";
			})
			return
		end
		if module_upvr.TimesInteracted == 5 then
			arg1:CreateDialog({
				Text = "okay dude now you're just dragging it on";
			})
			return
		end
		arg1:CreateDialog({
			Text = "...";
		})
	end
end
return module_upvr