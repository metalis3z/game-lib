-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:25
-- Luau version 6, Types version 3
-- Time taken: 0.000998 seconds

local module = {
	Config = {
		FacePlayer = false;
		PlayIdleOutsideOfDialog = true;
		Poses = {
			Idle = "rbxassetid://82221753254937";
		};
	};
}
function module.Interacted(arg1) -- Line 12
	arg1:CreateDialog({
		Text = "I ordered a pizza before I was taken into this place... it was taking a while tho.";
	})
end
return module