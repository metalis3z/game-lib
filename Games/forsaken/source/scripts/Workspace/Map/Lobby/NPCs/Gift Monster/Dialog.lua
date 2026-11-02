-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:43
-- Luau version 6, Types version 3
-- Time taken: 0.003476 seconds

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
		arg1:CreateDialog({
			Text = "It looks as though they want to give you something.";
		})
		arg1:CreateDialog({
			Text = "Do you accept?";
		})
		module_upvr.SpokenToBefore = true
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "Yes";
		}, {
			Choice = "No";
		}}), {function() -- Line 27
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: module_upvr (copied, readonly)
			]]
			arg1:CreateDialog({
				Text = "You receive a note with fancy writing.";
			})
			arg1:CreateDialog({
				Text = "\"Do not fret. I am nothing but kindness and a gift.\"";
			})
			arg1:CreateDialog({
				Text = "\"I am also your friend, even if it is only temporarily.\"";
			})
			arg1:CreateDialog({
				Text = "\"It is a pleasure to meet you.\"";
			})
			arg1:CreateDialog({
				Text = "\"May we have a wonderous christmas together.\"";
			})
			arg1:CreateDialog({
				Text = "\"With regards, Gift Monster.\"";
			})
			arg1:CreateDialog({
				Text = "You keep the note in your pockets.";
			})
			module_upvr.AcceptedGift = true
		end, function() -- Line 59
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: module_upvr (copied, readonly)
			]]
			arg1:CreateDialog({
				Text = "They look dejected by your reaction...";
			})
			module_upvr.AcceptedGift = false
		end})
	else
		if module_upvr.AcceptedGift then
			arg1:CreateDialog({
				Text = "They look delighted to see you.";
			})
			arg1:CreateDialog({
				Text = "They wish you a merry christmas.";
			})
			return
		end
		arg1:CreateDialog({
			Text = "They're quiet.";
		})
	end
end
return module_upvr