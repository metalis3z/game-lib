-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:34
-- Luau version 6, Types version 3
-- Time taken: 0.004166 seconds

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
	if module_upvr.choice == 1 then
		arg1:CreateDialog({
			Text = "How quiet it has gotten.";
		})
		arg1:CreateDialog({
			Text = "Crops have gone undisturbed as I ensured.";
		})
	else
		if module_upvr.choice == 2 then
			arg1:CreateDialog({
				Text = "Tread lightly.";
			})
			return
		end
		arg1:CreateDialog({
			Text = "All are victim to its influence and live each day.";
		})
		arg1:CreateDialog({
			Text = "To see everything as it is will be when you are truly living.";
		})
		arg1:CreateDialog({
			Text = "With curiosity, there is reason.";
		})
		arg1:CreateDialog({
			Text = "A motivation to seek answers.";
		})
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "What's up with the mask?";
		}, {
			Choice = "Huh?";
		}}), {function() -- Line 32
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: module_upvr (copied, readonly)
			]]
			arg1:CreateDialog({
				Text = "A figure that is representative of what I am.";
			})
			module_upvr.choice = 1
		end, function() -- Line 36
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: module_upvr (copied, readonly)
			]]
			arg1:CreateDialog({
				Text = "Influence will remain for as long as your presence does.";
			})
			arg1:CreateDialog({
				Text = "It watches every moment.";
			})
			arg1:CreateDialog({
				Text = "Stay for as long as you wish, only I can watch where we all stand.";
			})
			module_upvr.choice = 2
		end})
	end
end
return module_upvr