-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	["Load"] = function(p1)
		local v2 = next
		local v3, v4 = script:GetChildren()
		for _, v5 in v2, v3, v4 do
			if v5:IsA("Model") then
				for _, v6 in v5:GetChildren() do
					v6:Clone().Parent = p1.Character:WaitForChild(v5.Name, 4)
				end
			end
		end
	end
}