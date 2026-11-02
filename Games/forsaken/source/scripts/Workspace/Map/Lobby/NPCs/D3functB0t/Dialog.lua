-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-25 21:23:26
-- Luau version 6, Types version 3
-- Time taken: 0.002207 seconds

local module_upvr = {
	Config = {
		FacePlayer = false;
		PlayIdleOutsideOfDialog = true;
		Poses = {
			Idle = "rbxassetid://137521963277210";
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
			Text = "1 C4N'T M0V3 W1TH TH1S @#%!#< B0DY 0F M1N3!!!! (◣_◢)(◣_◢)(◣_◢)!!!!";
		})
		arg1:CreateDialog({
			Text = "#$<@!!! （＞д＜）（＞д＜）（＞д＜）（＞д＜）!!!!";
		})
		arg1:CreateDialog({
			Text = "wh4t3v3r. ;_;";
		})
	else
		arg1:CreateDialog({
			Text = "?@#$>$!!!! @#>$?!!! ⋋_⋌ ⋋_⋌ ⋋_⋌ ⋋_⋌ ⋋_⋌!!!!";
		})
	end
end
return module_upvr