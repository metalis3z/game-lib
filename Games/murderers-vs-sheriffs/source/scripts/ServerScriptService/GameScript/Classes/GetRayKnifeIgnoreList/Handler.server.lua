-- goro7

function addIgnoreParts(obj, tbl, addAll)

	-- Check if should ignore or continue to ignore
	if game.Players:GetPlayerFromCharacter(obj.Parent) then
		return
	end
	if obj:IsA("BasePart") then
		if (obj.CanCollide == false and obj.Transparency == 1) or addAll  or obj.Name == "ThrowingServerKnife" or obj.Name == "ThrowingKnife" then
			table.insert(tbl, obj)
			for _, i in pairs(obj:GetChildren()) do
				addIgnoreParts(i, tbl, addAll)
			end
		end
	elseif obj:IsA("Model") or obj:IsA("Accoutrement") or obj:IsA("Tool") then
		if obj:FindFirstChild("Humanoid") then
			for _, i in pairs(obj:GetChildren()) do
				if i:IsA("Accoutrement") or i:IsA("Tool") then
					addIgnoreParts(i, tbl, true)
				end
			end
		else
			for _, i in pairs(obj:GetChildren()) do
				addIgnoreParts(i, tbl, addAll)
			end
		end
	end

end

script.Parent.OnInvoke = function()

	-- Make table
	local ignore = {}

	-- Add all non-collidable parts in workspace
	addIgnoreParts(workspace, ignore)

	-- Return the final table
	return ignore

end
