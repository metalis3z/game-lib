-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:15
-- Luau version 6, Types version 3
-- Time taken: 0.004776 seconds

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
			Text = "What u looking at punk.";
		})
		arg1:CreateDialog({
			Text = "Yeah I can talk. whats it to ya. punk.";
		})
	else
		local var8 = module_upvr
		var8.TimesSpokenTo += 1
		if module_upvr.TimesSpokenTo == 15 then
			require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "ILoveCats")
			arg1:CreateDialog({
				Text = "meow meow meow AGHHAGGAUGHUUGHGHGHG";
			})
			return
		end
		local tbl = {"meow", "mew", "mrow", "myeow", "miau", "nyaw", "nya", "mmrrp", "prrrr"}
		arg1:CreateDialog({
			Text = tbl[math.random(1, #tbl)];
		})
	end
end
return module_upvr