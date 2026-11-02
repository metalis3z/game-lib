-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local EggActionMovement = require(script.Parent.EggActionMovement)
local EggRenderer = require(script.Parent.EggRenderer)
local SkipEggEffect = ReplicatedStorage.Assets.Particles["Egg Open"].SkipEggEffect

return {
	Play = function(p1) --[[ Play | Line: 24 | Upvalues: Asserts (copy), EggRenderer (copy), SkipEggEffect (copy), RunService (copy), Easing (copy), EggActionMovement (copy), Debris (copy) ]]
		Asserts.Model(p1)
		EggRenderer.DisableCollisions(p1)

		local v1 = p1:GetPivot()
		local v2 = SkipEggEffect.Attachment:Clone()

		v2.Parent = workspace.Terrain

		local sum = 0

		for v3, v4 in v2:GetDescendants() do
			v4.Enabled = true
		end

		v2.WorldCFrame = v1 * CFrame.Angles(0, 0, math.pi)

		while sum < 1.2 do
			sum = sum + RunService.Heartbeat:Wait()

			local v5 = Easing(sum / 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local v6 = v1 * CFrame.Angles(0, math.rad(v5 * 1080), 0)

			EggActionMovement.SetPivot(p1, v6 * CFrame.Angles(0, 0, (math.rad(math.sin(1080 * v5) * 35 * (1 - v5)))))
		end

		for v8, v9 in v2:GetDescendants() do
			v9.Enabled = false
		end

		Debris:AddItem(v2, 5)
	end
}