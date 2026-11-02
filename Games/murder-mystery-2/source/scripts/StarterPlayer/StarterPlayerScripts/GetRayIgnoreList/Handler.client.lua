-- rescripted by clockworkmine

local plr = game.Players.LocalPlayer

function addIgnoreParts(obj, tbl, addAll)
	
	-- Check if should ignore or continue to ignore
	if obj:IsA("BasePart") then
		if obj.CanCollide == false or obj.Transparency == 1 or addAll then
			table.insert(tbl, obj)
			for _, i in pairs(obj:GetChildren()) do
				addIgnoreParts(i, tbl, addAll)
			end
		end
	elseif obj:IsA("Model") or obj:IsA("Accoutrement") or obj:IsA("Tool") then
		if obj:FindFirstChild("Humanoid") and not addAll then
			for _, i in pairs(obj:GetChildren()) do
				if i:IsA("Accoutrement") or i:IsA("Tool") or i.Name == "DisplayKnife" or i.Name == "DisplayRevolver" or i.Name == "Radio" then
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
	addIgnoreParts(workspace, ignore, false)
	
	-- All all camera parts
	for _, i in pairs(workspace.CurrentCamera:GetChildren()) do
		addIgnoreParts(i, ignore, true)
	end
	
	-- Add this characters parts
	if plr.Character ~= nil then
		addIgnoreParts(plr.Character, ignore, true)
	end
	
	-- Return the final table
	return ignore
	
end

