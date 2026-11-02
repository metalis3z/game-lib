-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:45
-- Luau version 6, Types version 3
-- Time taken: 0.000741 seconds

Tool = script.Parent -- Setting global
QuakeEnabled = Tool:WaitForChild("QuakeEnabled") -- Setting global
ReloadTime = 10 -- Setting global
QuakeEnabled.Changed:connect(function() -- Line 9
	if not QuakeEnabled.Value then
		wait(ReloadTime)
		QuakeEnabled.Value = true
	end
end)