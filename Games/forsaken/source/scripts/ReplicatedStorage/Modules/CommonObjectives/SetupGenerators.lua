-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

return {
	["Name"] = "SetupGenerators",
	["Title"] = "Setup Generators",
	["Description"] = "Complete the puzzles on each generator to get them up & running. (<PROGRESS>/<REQUIREMENT>)",
	["RequiredProgress"] = 5,
	["Order"] = 1,
	["YieldUntilCompleted"] = true,
	["NoStatsAdded"] = true,
	["OnCreation"] = function(p_u_1)
		for _ = 1, p_u_1.RequiredProgress do
			local v2 = script.Generator:Clone()
			local v3 = p_u_1.Map and p_u_1.Map:FindFirstChild("GeneratorPositions")
			if v3 then
				v3 = p_u_1.Map.GeneratorPositions:GetChildren()
			end
			if v3 then
				v3 = v3[math.random(1, #v3)]
			end
			if v2 and v3 then
				v2:SetPrimaryPartCFrame(v3.CFrame)
				v2.Parent = p_u_1.Map
				v3:Destroy()
				for _, v4 in pairs(v2.Scripts:GetChildren()) do
					v4.Enabled = true
				end
				v2.Remotes.BE.Event:Connect(function(p5, p6)
					-- upvalues: (copy) p_u_1
					require(game.ReplicatedStorage.Modules.Util):AddToPlayerStat(p5, "KillerChance", 0.5)
					p_u_1:RemoveTime(3.5)
					if p6 >= 100 then
						p_u_1:AddProgress(p5)
					end
				end)
				v2.Destroying:Connect(function()
					-- upvalues: (copy) p_u_1
					p_u_1:AddProgress()
				end)
			else
				p_u_1:AddProgress()
			end
		end
		local v7 = p_u_1.Map and p_u_1.Map:FindFirstChild("GeneratorPositions")
		if v7 then
			v7 = p_u_1.Map.GeneratorPositions:GetChildren()
		end
		for _, v8 in pairs(v7 or {}) do
			local v9 = Instance.new("CFrameValue", p_u_1.Map.GeneratorPositions)
			v9.Name = "GeneratorPosition"
			v9.Value = v8.CFrame
			v8:Destroy()
		end
	end,
	["OnProgression"] = function(_) end,
	["OnCompletion"] = function(p_u_10)
		task.delay(5, function()
			-- upvalues: (copy) p_u_10
			p_u_10:Destroy()
		end)
	end
}
