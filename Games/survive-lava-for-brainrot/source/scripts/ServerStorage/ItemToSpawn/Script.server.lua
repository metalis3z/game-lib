local model = script.Parent

-- Conectar el Touched a TODAS las partes del modelo
for _, part in ipairs(model:GetDescendants()) do
	if part:IsA("BasePart") then
		part.Touched:Connect(function(hit)
			local character = hit.Parent
			if not character then return end

			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				humanoid.Health = 0 -- MUERE
			end
		end)
	end
end

