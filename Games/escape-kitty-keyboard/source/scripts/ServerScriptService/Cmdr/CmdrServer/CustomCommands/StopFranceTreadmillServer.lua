local Workspace = game:GetService("Workspace")

return function(context)
	local FIXED_X = -230.52
	local FIXED_Z = 56.017
	local HIDDEN_Y = -26.891

	local treadmillFolder = Workspace:FindFirstChild("Treadmill")
	if not treadmillFolder then
		return "❌ Erreur : le folder 'Treadmill' n'existe pas dans workspace."
	end

	local targetPosition = Vector3.new(FIXED_X, HIDDEN_Y, FIXED_Z)
	local movedCount = 0
	local errors = {}

	-- Déplace TOUS les objets nommés "FranceTreadmill" trouvés (pas juste le 1er),
	-- au cas où plusieurs copies existent (ex: plusieurs spawnfrancetreadmill faits)
	for _, model in ipairs(treadmillFolder:GetChildren()) do
		if model.Name == "FranceTreadmill" then
			local success, err = pcall(function()
				if model:IsA("Model") and model.PrimaryPart then
					model:SetPrimaryPartCFrame(CFrame.new(targetPosition))
				elseif model:IsA("BasePart") then
					model.Position = targetPosition
				else
					local firstPart = model:FindFirstChildWhichIsA("BasePart", true)
					if firstPart then
						local offset = targetPosition - firstPart.Position
						for _, part in pairs(model:GetDescendants()) do
							if part:IsA("BasePart") then
								part.Position = part.Position + offset
							end
						end
					else
						error("Aucune BasePart trouvée.")
					end
				end
			end)

			if success then
				movedCount += 1
			else
				table.insert(errors, tostring(err))
			end
		end
	end

	if movedCount == 0 then
		return "❌ Erreur : aucun objet 'FranceTreadmill' trouvé dans le folder Treadmill."
	end

	local resultMsg = "✅ " .. movedCount .. " FranceTreadmill déplacé(s) sous la map (invisible)."
	if #errors > 0 then
		resultMsg = resultMsg .. " ⚠️ " .. #errors .. " erreur(s) : " .. table.concat(errors, " | ")
	end

	return resultMsg
end