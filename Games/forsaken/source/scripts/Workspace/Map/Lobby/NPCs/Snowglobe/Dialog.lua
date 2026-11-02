-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:44
-- Luau version 6, Types version 3
-- Time taken: 0.003692 seconds

return {
	Config = {
		FacePlayer = false;
		PlayIdleOutsideOfDialog = false;
	};
	Interacted = function(arg1) -- Line 10
		arg1:CreateDialog({
			Text = "It's a small snowglobe.";
		})
		arg1:CreateDialog({
			Text = "The snow falls with a snowman inside.";
		})
		arg1:CreateDialog({
			Text = "You notice some writing.";
		})
		arg1:CreateDialog({
			Text = "Read it?";
		})
		arg1:ProcessResponse(arg1:GetUserResponse({{
			Choice = "Yes";
		}, {
			Choice = "No";
		}}), {function() -- Line 33
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:CreateDialog({
				Text = "You take a closer look.";
			})
			arg1:CreateDialog({
				Text = "\"Memento tempus fugit.\"";
			})
			arg1:CreateDialog({
				Text = "It's interesting.";
			})
		end, function() -- Line 48
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:CreateDialog({
				Text = "Not today, then.";
			})
		end})
	end;
}