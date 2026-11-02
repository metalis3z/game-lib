-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:38
-- Luau version 6, Types version 3
-- Time taken: 0.005346 seconds

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
			Text = "Oh! Haha, You found me! Congrats!";
		})
		arg1:CreateDialog({
			Text = "Don’t tell Ethan yet, though! Okay?";
		})
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "Okay";
		}, {
			Choice = "Nah";
		}, {
			Choice = "Bye";
		}}), {function() -- Line 38
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			local tbl_3 = {"Glad to have a pal, see ya’ later!"}
			arg1:CreateDialog({
				Text = tbl_3[math.random(1, #tbl_3)];
			})
		end, function() -- Line 48
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			local tbl_2 = {"H-Hey! Keep it down!", "I wanna win this!"}
			arg1:CreateDialog({
				Text = tbl_2[math.random(1, #tbl_2)];
			})
		end, function() -- Line 30, Named "cancelDialog"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			local tbl = {"Cya, don't be snitching!"}
			arg1:CreateDialog({
				Text = tbl[math.random(1, #tbl)];
			})
		end})
	else
		arg1:CreateDialog({
			Text = "No snitching!";
		})
	end
end
return module_upvr