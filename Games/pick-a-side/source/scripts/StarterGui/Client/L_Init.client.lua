-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:28
-- Luau version 6, Types version 3
-- Time taken: 0.001129 seconds

print("v0.5.1")
local LocalPlayer = game.Players.LocalPlayer
if LocalPlayer:GetRankInGroup(2845692) < 250 then
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
end
LocalPlayer.CharacterAdded:connect(function(arg1) -- Line 11
	local Humanoid = arg1:WaitForChild("Humanoid")
	Humanoid:SetStateEnabled("Swimming", false)
	Humanoid:SetStateEnabled("Climbing", false)
end)