-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:22
-- Luau version 6, Types version 3
-- Time taken: 0.003720 seconds

local module = {
	Config = {
		FacePlayer = false;
		PlayIdleOutsideOfDialog = false;
		VoiceSFX = "rbxassetid://107648255423077";
		Poses = {
			Idle = "rbxassetid://180435571";
		};
	};
}
function module.Interacted(arg1) -- Line 12
	local AFK_upvr = game.Players.LocalPlayer.PlayerData.Settings:FindFirstChild("AFK", true)
	if not AFK_upvr then
	else
		local Network_upvr = require(game.ReplicatedStorage.Modules.Network)
		arg1:CreateDialog({
			Text = "You look at the hypnotizing movements of the grandfather clock. Even it can't tell the real time.";
		})
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "Enable AFK Mode";
		}, {
			Choice = "Disable AFK Mode";
		}, {
			Choice = "Cancel";
		}}), {function() -- Line 26
			--[[ Upvalues[3]:
				[1]: Network_upvr (readonly)
				[2]: AFK_upvr (readonly)
				[3]: arg1 (readonly)
			]]
			Network_upvr:FireServerConnection("UpdateSettings", "REMOTE_EVENT", AFK_upvr, true)
			arg1:CreateDialog({
				Text = "You suddenly feel at peace.";
			})
		end, function() -- Line 30
			--[[ Upvalues[3]:
				[1]: Network_upvr (readonly)
				[2]: AFK_upvr (readonly)
				[3]: arg1 (readonly)
			]]
			Network_upvr:FireServerConnection("UpdateSettings", "REMOTE_EVENT", AFK_upvr, false)
			arg1:CreateDialog({
				Text = "You suddenly start to feel worried.";
			})
		end, function() -- Line 34
		end})
	end
end
return module