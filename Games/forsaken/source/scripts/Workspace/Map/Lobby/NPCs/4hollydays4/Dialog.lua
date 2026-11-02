-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:42
-- Luau version 6, Types version 3
-- Time taken: 0.001644 seconds

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
			Text = "Oh, hello!";
		})
		arg1:CreateDialog({
			Text = "I'm waiting on some friends so we can record our Christmas music video soon.";
		})
		arg1:CreateDialog({
			Text = "They have the camera, so I can't really start it without them.";
		})
		arg1:CreateDialog({
			Text = "But I'll keep on waiting!";
		})
		arg1:CreateDialog({
			Text = "It's pretty under the snow, isn't it?";
		})
	else
		arg1:CreateDialog({
			Text = "Still waiting...";
		})
	end
end
return module_upvr