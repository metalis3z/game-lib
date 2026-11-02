-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:29
-- Luau version 6, Types version 3
-- Time taken: 0.005319 seconds

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
		arg1:CreateDialog({
			Text = "Heh! Hey! Long time no see!";
		})
		arg1:CreateDialog({
			Text = "Look I'm a red herring haha!";
		})
		arg1:CreateDialog({
			Text = "Haha! I have learnt instant transmission!";
		})
		arg1:CreateDialog({
			Text = "heh...";
		})
		arg1:CreateDialog({
			Text = "...";
		})
		arg1:CreateDialog({
			Text = "please dont kill me";
		})
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "kill";
		}, {
			Choice = "Not today.";
		}, {
			Choice = "I won't";
		}}), {function() -- Line 53
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			local tbl_2 = {"awww mannn"}
			arg1:CreateDialog({
				Text = tbl_2[math.random(1, #tbl_2)];
			})
		end, function() -- Line 63
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			local tbl = {"Oh."}
			arg1:CreateDialog({
				Text = tbl[math.random(1, #tbl)];
			})
		end, function() -- Line 45, Named "cancelDialog"
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			local tbl_3 = {"bye"}
			arg1:CreateDialog({
				Text = tbl_3[math.random(1, #tbl_3)];
			})
		end})
	else
		arg1:CreateDialog({
			Text = "hi";
		})
	end
end
return module_upvr