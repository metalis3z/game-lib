-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:40
-- Luau version 6, Types version 3
-- Time taken: 0.001534 seconds

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
		Text = "hee hee did you guys hear about- >_< oh hello!!";
	})
	arg1:GetUserResponse({{
		Choice = "hi whats your name? :?";
	}})
	arg1:CreateDialog({
		Text = "oh me? i'm icicle! good to meet you!!";
	})
	arg1:GetUserResponse({{
		Choice = "what do you like to do around here?";
	}})
	arg1:CreateDialog({
		Text = "i like to make snowballs and throw them at my friends XD";
	})
end
return module