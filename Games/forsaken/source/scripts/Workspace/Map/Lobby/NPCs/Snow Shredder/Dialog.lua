-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:40
-- Luau version 6, Types version 3
-- Time taken: 0.005608 seconds

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
			Text = "Yo, buddy!";
		})
		arg1:CreateDialog({
			Text = "This environment is totally killer, right";
		})
		arg1:CreateDialog({
			Text = "I could rock on this all night long!";
		})
		arg1:CreateDialog({
			Text = "Whaddya' think? Eh?";
		})
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "Uh, sure?";
		}, {
			Choice = "Nobody talks like that";
		}}), {function() -- Line 35
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:CreateDialog({
				Text = "Wicked, isn't it?";
			})
			arg1:CreateDialog({
				Text = "Oh man, I could go down these slopes forever!";
			})
			arg1:CreateDialog({
				Text = "It's some real gnarly stuff, bro!";
			})
			arg1:CreateDialog({
				Text = "I gotta get in on this snow action soon.";
			})
			arg1:CreateDialog({
				Text = "Talk to ya' later, okay?";
			})
		end, function() -- Line 57
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:CreateDialog({
				Text = "What're you talkin' about, bud?";
			})
			arg1:CreateDialog({
				Text = "Don't gotta be hatin' on my style!";
			})
			arg1:CreateDialog({
				Text = "I bring nothin' but good energy all around!";
			})
			arg1:CreateDialog({
				Text = "Maybe you're just not feelin' it tonight, man.";
			})
			arg1:CreateDialog({
				Text = "Talk to ya' later, okay?";
			})
		end})
	else
		arg1:CreateDialog({
			Text = "This ROCKS!";
		})
	end
end
return module_upvr