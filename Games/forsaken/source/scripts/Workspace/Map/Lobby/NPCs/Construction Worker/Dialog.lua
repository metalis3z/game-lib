-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:16
-- Luau version 6, Types version 3
-- Time taken: 0.002877 seconds

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
			Text = "i was told to not let anyone go past this point because of like evil monsters or something";
		})
		arg1:CreateDialog({
			Text = "so you can't go past these planks i built";
		})
		arg1:CreateDialog({
			Text = "unless you like climb over them";
		})
		arg1:CreateDialog({
			Text = "but you wouldnt do that i think";
		})
	else
		arg1:CreateDialog({
			Text = "pretty please dont go over my barrier";
		})
		arg1:CreateDialog({
			Text = "i spent a lot of time making it just so that you dont go past it";
		})
	end
end
return module_upvr