-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:44
-- Luau version 6, Types version 3
-- Time taken: 0.001693 seconds

local Character = game.Players.LocalPlayer.Character
local Humanoid = Character:FindFirstChild("Humanoid")
bodyAngularVelocity = Instance.new("BodyAngularVelocity") -- Setting global
bodyAngularVelocity.P = 10000
bodyAngularVelocity.Name = "Tripforce"
bodyAngularVelocity.Parent = Character:FindFirstChild("Torso")
if Humanoid then
	while 0 < 3 do
		rand = math.random(1, 100) -- Setting global
		rand2 = math.random(2, 50) -- Setting global
		bodyAngularVelocity.angularvelocity = Vector3.new(rand / 10, rand2 * rand / 10, rand / rand2)
		game.Workspace.CurrentCamera.CameraType = 1
		Humanoid.Sit = not Humanoid.Sit
		wait(0.15)
	end
	Humanoid.Sit = false
	if bodyAngularVelocity then
		bodyAngularVelocity:Remove()
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	game.Workspace.CurrentCamera.CameraType = 5
end
wait(2)
script:Remove()