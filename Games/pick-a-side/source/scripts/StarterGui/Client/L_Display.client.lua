-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:26
-- Luau version 6, Types version 3
-- Time taken: 0.008966 seconds

function _G.ShowChar(arg1, arg2) -- Line 8
	for _, v in pairs(arg1:GetChildren()) do
		if v.ClassName == "MeshPart" or v.ClassName == "Part" or v.Name ~= "HumanoidRootPart" and v.Name ~= "Mark" then
			v.Transparency = arg2
			if v.Name == "Head" then
				local face = v:FindFirstChild("face")
				if face then
					face.Transparency = arg2
				end
			end
			if v.Name == "Radio" then
				local Particles_2 = v:FindFirstChild("Particles")
				if Particles_2 then
					Particles_2.Transparency = NumberSequence.new(arg2)
				end
			end
		end
		if v.Name == "HumanoidRootPart" then
			local Running_2 = v:FindFirstChild("Running")
			if Running_2 then
				Running_2.Volume = 0.65 - arg2
			end
			local Jumping_2 = v:FindFirstChild("Jumping")
			if Jumping_2 then
				Jumping_2.Volume = 0.65 - arg2
			end
		end
		if v:IsA("Accoutrement") then
			local Handle_2 = v:FindFirstChild("Handle")
			if Handle_2 then
				Handle_2.Transparency = arg2
			end
		end
	end
	for _, v_2 in pairs(arg1:GetDescendants()) do
		Handle_2 = v_2.ClassName
		local var73 = Handle_2
		if var73 == "ParticleEmitter" then
			if arg2 ~= 0 then
				var73 = false
			else
				var73 = true
			end
			v_2.Enabled = var73
		end
	end
end
while true do
	wait(0.5)
	for _, v_3 in pairs(game:GetService("Players"):GetChildren()) do
		if v_3 ~= game.Players.LocalPlayer then
			local Character = v_3.Character
			if Character then
				local Torso_2 = Character:FindFirstChild("Torso")
				if Torso_2 then
					if game:GetService("ReplicatedStorage").Status.Title.Value == "Pick a Side!" and 3.9 < Torso_2.Position.Y and -42 < Torso_2.Position.Z then
						_G.ShowChar(Character, 1)
						game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
					else
						_G.ShowChar(Character, 0)
						game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
					end
				end
			end
		end
	end
end