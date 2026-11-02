-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:40
-- Luau version 6, Types version 3
-- Time taken: 0.001005 seconds

Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
Player = Players.LocalPlayer -- Setting global
Camera = game:GetService("Workspace").CurrentCamera -- Setting global
function DestroyScript() -- Line 9
	Debris:AddItem(script, 1)
end
Player.CameraMode = Enum.CameraMode.Classic
Camera.FieldOfView = 70
DestroyScript()