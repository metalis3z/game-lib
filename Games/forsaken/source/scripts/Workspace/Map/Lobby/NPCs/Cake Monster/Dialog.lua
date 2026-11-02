-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:19
-- Luau version 6, Types version 3
-- Time taken: 0.005584 seconds

local module = {
	Config = {
		FacePlayer = false;
		PlayIdleOutsideOfDialog = true;
		VoiceSFX = "rbxassetid://107648255423077";
		Poses = {
			Idle = "rbxassetid://180435571";
		};
	};
}
function module.Interacted(arg1) -- Line 12
	arg1:CreateDialog({
		Text = "Mmarghh.. Mmmrgh..";
	})
	arg1:CreateDialog({
		Text = "RRGH? Rrghh...";
	})
	arg1:ProcessResponse(arg1:GetUserResponse({{
		Choice = "Yuck";
	}, {
		Choice = "What are you?";
	}, {
		Choice = "You look yummy";
	}}), {function() -- Line 31
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local tbl = {"MMMMRAGGH", "MARRGHH! HAAARGHH!!!!", "AGHRGHHRAAAAHHH", "HHRGRRAHHH!!!", "NNRAHHGHHH! NHHRRAGGHH!!", "MMRRGHHHRHGG!!", "HHRAGGHHH! HRGGRHHHG!!"}
		arg1:CreateDialog({
			Text = tbl[math.random(1, #tbl)];
		})
	end, function() -- Line 44
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		local tbl_2 = {"Mrrghh.. hhnghh..", "hhghhh.. gllrgrg..", "Ghhrggh...", "Hhrrhhrrghh.. gghhhhnn..", "Nnhhhrhhggghhh..."}
		arg1:CreateDialog({
			Text = tbl_2[math.random(1, #tbl_2)];
		})
	end, function() -- Line 55
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:CreateDialog({
			Text = "!!!";
		})
		local tbl_3 = {"RRAGHGH! MARRGH!! HHAAARRGGH!!!!!", "RRAGHGH! HHAAARRGGH!! MARRGH!!!!!", "HHAAARRGGH! RRAGHGH!! MARRGH!!!!!", "HHAAARRGGH! MARRGH!! RRAGHGH!!!!!", "MARRGH! HHAAARRGGH!! RRAGHGH!!!!!", "MARRGH! RRAGHGH!! HHAAARRGGH!!!!!"}
		arg1:CreateDialog({
			Text = tbl_3[math.random(1, #tbl_3)];
		})
	end})
end
return module