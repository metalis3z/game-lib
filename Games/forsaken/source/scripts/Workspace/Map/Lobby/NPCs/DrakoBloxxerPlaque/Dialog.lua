-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:17
-- Luau version 6, Types version 3
-- Time taken: 0.001898 seconds

local module_upvr = {
	Config = {
		FacePlayer = false;
		PlayIdleOutsideOfDialog = true;
		VoiceSFX = "rbxassetid://140647479280509";
		Poses = {
			Idle = "rbxassetid://180435571";
		};
		Actions = {
			Wave = "rbxassetid://128777973";
		};
	};
}
function module_upvr.Interacted(arg1) -- Line 15
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not module_upvr.SpokenToBefore then
		module_upvr.SpokenToBefore = true
		arg1:CreateDialog({
			Text = "<Color=Red>HELP<Color=/> I WAS STUCK ON THIS WALL AND I CANT GET OUT";
		})
		arg1:CreateDialog({
			Text = "<Color=Red>DUDE<Color=/> AHHHHHHHHHHHH";
		})
	else
		require(game.ReplicatedStorage.Modules.Sounds):Play("rbxassetid://1007368252", {
			Parent = script.Parent.PrimaryPart;
		})
		arg1:CreateDialog({
			Text = "<Color=Red>AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHH<Color=/>";
		})
	end
end
return module_upvr