-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:19
-- Luau version 6, Types version 3
-- Time taken: 0.002267 seconds

Debris = game:GetService("Debris") -- Setting global
Duration = script:WaitForChild("Duration") -- Setting global
Character = script.Parent -- Setting global
Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
function DestroyScript() -- Line 10
	Debris:AddItem(script, 0.5)
	script:Destroy()
	Humanoid.PlatformStand = false
	Humanoid.AutoRotate = true
end
function Stun() -- Line 17
	Humanoid.PlatformStand = true
	Humanoid.AutoRotate = false
	Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
end
if not Duration or Duration.Value <= 0 or not Humanoid or Humanoid.Health == 0 then
	DestroyScript()
else
	Stun()
	Humanoid.Changed:connect(function() -- Line 30
		Stun()
	end)
	wait(Duration.Value)
	DestroyScript()
end