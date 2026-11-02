-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:31
-- Luau version 6, Types version 3
-- Time taken: 0.002681 seconds

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
		Text = "oh, hi! sorry i was listening to icicle!";
	})
	arg1:GetUserResponse({{
		Choice = "whats your name?";
	}})
	arg1:CreateDialog({
		Text = "its obvious its snow related.. but snowball >_>";
	})
	arg1:GetUserResponse({{
		Choice = "icicle was just talking about snowballs!";
	}})
	arg1:CreateDialog({
		Text = "lol! well im gonna keep talking to my friends :)";
	})
end
return module