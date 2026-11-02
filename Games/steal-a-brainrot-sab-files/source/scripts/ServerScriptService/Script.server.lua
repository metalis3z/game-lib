local brainrots = workspace:WaitForChild("Brainrots")

local function visible(brainrot)
	for _, objet in ipairs(brainrot:GetDescendants()) do
		if objet:IsA("BasePart") then
			objet.Transparency = 0
		elseif objet:IsA("Decal") or objet:IsA("Texture") then
			objet.Transparency = 0
		end
	end
end

for _, brainrot in ipairs(brainrots:GetChildren()) do
	visible(brainrot)
end

brainrots.ChildAdded:Connect(function(brainrot)
	task.wait()
	visible(brainrot)
end)
