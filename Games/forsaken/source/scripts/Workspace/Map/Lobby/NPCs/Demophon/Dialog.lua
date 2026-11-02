-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:30
-- Luau version 6, Types version 3
-- Time taken: 0.004049 seconds

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
		require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UnlockAchievement", "REMOTE_EVENT", "MeetDemophon")
		module_upvr.SpokenToBefore = true
		arg1:CreateDialog({
			Text = "Congratulations. You have found me.";
		})
		arg1:CreateDialog({
			Text = "I am hidden in the water. Away from prying eyes.";
		})
		arg1:CreateDialog({
			Text = "...";
		})
		arg1:CreateDialog({
			Text = "Come, stay here for a moment and listen to my tale.";
		})
		arg1:CreateDialog({
			Text = "Are you familiar with the story of a Captain and his ship?";
		})
		arg1:CreateDialog({
			Text = "Each rotting board of the ship was replaced with newer boards.";
		})
		arg1:CreateDialog({
			Text = "The repaired ship would be beautiful; full and complete.";
		})
		arg1:CreateDialog({
			Text = "Many wonder if it is still the same ship.";
		})
		arg1:CreateDialog({
			Text = "It is correct to assume that the Captain now has a brand new ship.";
		})
		arg1:CreateDialog({
			Text = "Now I want you to wonder for a moment.";
		})
		arg1:CreateDialog({
			Text = "What if there was no ship. Just a Captain, building his own ship?";
		})
		arg1:CreateDialog({
			Text = "What if this Captain was malicious and depraved. Stealing parts from others ships.";
		})
		arg1:CreateDialog({
			Text = "Is it his ship now, or is it an amalgamation of stolen parts?";
		})
		local function _() -- Line 67, Named "cancelDialog"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:CreateDialog({
				Text = "Farewell.";
			})
		end
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "what?";
		}}), {function() -- Line 74
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:CreateDialog({
				Text = "In time you will understand.";
			})
			arg1:CreateDialog({
				Text = "For it is always here. Listening. Watching.";
			})
			arg1:CreateDialog({
				Text = "The captain will never stop in his quest. His ship will be complete.";
			})
			arg1:CreateDialog({
				Text = "Goodbye now.";
			})
		end})
	else
		arg1:CreateDialog({
			Text = "...";
		})
		arg1:CreateDialog({
			Text = "I have no more stories to tell you. I wish to swim now.";
		})
	end
end
return module_upvr