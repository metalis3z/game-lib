local function DeathEffect(rag)
	if rag then
		if rag.Shirt then
			rag.Shirt:Destroy()
		end
		if rag.Pants then
			rag.Pants:Destroy()
		end

		for _, child in ipairs(rag:GetChildren()) do
			if child:IsA("Accessory") or child:IsA("Hat") then
				child:Destroy()
			end
		end

		local cogModel = script.GearDeath:Clone()
		cogModel.Parent = rag
		cogModel.CFrame = rag.UpperTorso.CFrame

		local cogNames = {
			"Cog1", "Cog2", "Cog3", "Cog4", "Cog5", "Cog6", "Cog7", "Cog8", "Cog9", "Cog10", "Cog11"
		}

		for _, cogName in ipairs(cogNames) do
			local cog = cogModel:Clone()
			cog.Name = cogName
			cog.Parent = rag
			cog.CFrame = rag.UpperTorso.CFrame
		end

		local partsToRemove = {
			"LeftHand", "LeftUpperArm", "LeftLowerArm", "RightHand", "RightLowerArm", "RightUpperArm",
			"RightUpperLeg", "RightLowerLeg", "RightFoot", "LeftFoot", "LeftUpperLeg", "LeftLowerLeg",
			"UpperTorso", "LowerTorso", "Head"
		}

		for _, partName in ipairs(partsToRemove) do
			rag:FindFirstChild(partName):Destroy()
		end
	end
end

return DeathEffect