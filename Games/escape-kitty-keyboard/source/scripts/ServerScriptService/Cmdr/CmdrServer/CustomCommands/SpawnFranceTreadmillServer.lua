local Workspace = game:GetService("Workspace")

return function(context)
	local treadmillFolder = Workspace:FindFirstChild("Treadmill")
	if not treadmillFolder then
		return "❌ Erreur : le folder 'Treadmill' n'existe pas dans workspace."
	end

	local sourceModel = treadmillFolder:FindFirstChild("FranceTreadmill")
	if not sourceModel then
		return "❌ Erreur : le model 'FranceTreadmill' est introuvable dans le folder Treadmill."
	end

	local success, result = pcall(function()
		local newModel = sourceModel:Clone()
		newModel.Parent = treadmillFolder
		local targetPosition = Vector3.new(-230.52, 25.552, 56.017)

		if newModel:IsA("Model") and newModel.PrimaryPart then
			newModel:SetPrimaryPartCFrame(CFrame.new(targetPosition))
		elseif newModel:IsA("BasePart") then
			newModel.Position = targetPosition
		else
			local firstPart = newModel:FindFirstChildWhichIsA("BasePart", true)
			if firstPart then
				local offset = targetPosition - firstPart.Position
				for _, part in pairs(newModel:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Position = part.Position + offset
					end
				end
			else
				error("Aucune BasePart trouvée dans le model cloné pour le positionner.")
			end
		end

		return newModel
	end)

	if not success then
		return "❌ Erreur pendant le spawn : " .. tostring(result)
	end

	return "✅ FranceTreadmill spawné dans Treadmill à la position demandée."
end