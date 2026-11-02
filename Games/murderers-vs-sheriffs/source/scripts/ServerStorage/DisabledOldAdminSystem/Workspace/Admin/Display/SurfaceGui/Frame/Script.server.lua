-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-13 15:36:21
-- Luau version 6, Types version 3
-- Time taken: 0.000880 seconds

script.Parent:WaitForChild("Buy").Activated:Connect(function() -- Line 2
	game.ReplicatedStorage.Remotes.Shop.GetAdmin:FireServer()
end)