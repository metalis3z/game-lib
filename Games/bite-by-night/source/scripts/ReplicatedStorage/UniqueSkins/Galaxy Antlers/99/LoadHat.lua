-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Load"] = function(p_u_1)
		task.delay(0.1, function()
			-- upvalues: (copy) p_u_1
			if p_u_1.Character:FindFirstChild("GalaxyBeautifulHair") then
				p_u_1.Character:FindFirstChild("GalaxyBeautifulHair"):Destroy()
			end
			if p_u_1.Character:FindFirstChild("Shadow Antlers") then
				p_u_1.Character:FindFirstChild("Shadow Antlers"):Destroy()
			end
			p_u_1.Character.ChildAdded:Connect(function(p2)
				if p2.Name == "GalaxyBeautifulHair" then
					p2:Destroy()
				end
				if p2.Name == "Shadow Antlers" then
					p2:Destroy()
				end
			end)
		end)
		local v3 = script:FindFirstChild("Glow"):Clone()
		v3.Weld1.Part0 = p_u_1.Character:FindFirstChild("Head")
		v3.Weld2.Part0 = p_u_1.Character:FindFirstChild("Head")
		v3.Parent = p_u_1.Character
		v3:FindFirstChild("Hair").Parent = workspace.IGNORE
		v3:FindFirstChild("Antlers").Parent = workspace.IGNORE
	end
}