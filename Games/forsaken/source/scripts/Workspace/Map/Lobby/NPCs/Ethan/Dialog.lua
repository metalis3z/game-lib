-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:37
-- Luau version 6, Types version 3
-- Time taken: 0.001678 seconds

local module_upvr = {
	Config = {
		PlayIdleOutsideOfDialog = true;
		Poses = {
			Idle = "rbxassetid://180435571";
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
			Text = "Hey, you look like a good seeker!";
		})
		arg1:CreateDialog({
			Text = "Let me know if you spot a brown-haired girl around here with a black and blue sweater, okay?";
		})
		arg1:CreateDialog({
			Text = "We were playing a game, but I haven’t found her in a bit..";
		})
		arg1:CreateDialog({
			Text = "I’m sure she’s around here though!";
		})
	else
		arg1:CreateDialog({
			Text = "Again, let me know if you see her!";
		})
	end
end
return module_upvr