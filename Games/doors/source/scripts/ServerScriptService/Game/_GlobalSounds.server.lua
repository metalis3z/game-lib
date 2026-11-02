-- Created and Fixed by BUILDG Studios

spawn(function()
	while task.wait(math.random(25, 45)) do
		local noices_Folder = script.Noises

		local random = noices_Folder:GetChildren()[math.random(1, #noices_Folder:GetChildren())]
		local cloned = random:Clone()

		local attach = Instance.new("Attachment", workspace.Terrain)

		cloned.Parent = attach
		cloned:Play()

		cloned.Ended:Connect(function()
			attach:Remove()
		end)
	end
end)