-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:35
-- Luau version 6, Types version 3
-- Time taken: 0.001474 seconds

local module = {
	Config = {
		PlayIdleOutsideOfDialog = true;
		Poses = {
			Idle = "rbxassetid://180435571";
		};
	};
}
function module.Interacted(arg1) -- Line 10
	arg1:CreateDialog({
		Text = "HELLO";
	})
	arg1:GetUserResponse({{
		Choice = "oh um, whats your name?";
	}})
	arg1:CreateDialog({
		Text = "MELTY";
	})
	arg1:GetUserResponse({{
		Choice = "i can only wonder why >_>";
	}})
	arg1:CreateDialog({
		Text = "YEAH HAHAHA BYE NOW BYE GET OUT NOW BYE";
	})
end
return module