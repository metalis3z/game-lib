-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:45
-- Luau version 6, Types version 3
-- Time taken: 0.006934 seconds

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
			Text = "Hello there!";
		})
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "Wait, shouldn't you be hiding?";
		}, {
			Choice = "Toothy deer man you dont have to hide behind a disguise, we all know its you";
		}}), {function() -- Line 24
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:CreateDialog({
				Text = "Oh no, you must be confusing me with my cousin.";
			})
			arg1:CreateDialog({
				Text = "He thinks he looks strange, but I love him all the same.";
			})
			arg1:CreateDialog({
				Text = "Say, do you know where he is?";
			})
			arg1:ProcessResponse(arg1:GetUserResponse({{
				Choice = "Not sure, one day he was here and the next he was gone.";
			}}), {function() -- Line 42
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:CreateDialog({
					Text = "Oh, alright. Well, if you see him, tell him I said hello!";
				})
			end})
		end, function() -- Line 50
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:CreateDialog({
				Text = "Huh? What are you talking about...?";
			})
			arg1:CreateDialog({
				Text = "Oh! You must be confusing me with my cousin.";
			})
			arg1:CreateDialog({
				Text = "He thinks he looks strange, but I love him all the same.";
			})
			arg1:CreateDialog({
				Text = "Say, do you know where he is?";
			})
			arg1:ProcessResponse(arg1:GetUserResponse({{
				Choice = "Not sure, one day he was here and the next he was gone.";
			}, {
				Choice = "I know it's you.";
			}}), {function() -- Line 73
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:CreateDialog({
					Text = "Oh, alright. Well, if you see him, tell him I said hello!";
				})
			end, function() -- Line 78
				--[[ Upvalues[1]:
					[1]: arg1 (copied, readonly)
				]]
				arg1:CreateDialog({
					Text = "Uhhh... I can assure you I'm not him.";
				})
				arg1:CreateDialog({
					Text = "If you do seem, tell him I say hello.";
				})
			end})
		end})
	else
		arg1:CreateDialog({
			Text = "Hope you're doing alright!";
		})
	end
end
return module_upvr