local Active = false
local Enabled = true --By default setting
local Main2 = script.Parent.Parent.Main2
script.Parent.MouseButton1Click:Connect(function()
	if Enabled then
		Enabled = false --Changing to false

		for _, Part in pairs(workspace:GetDescendants()) do
			if Part:IsA("BasePart") then
				Part.CastShadow = false
			end
		end
	elseif not Enabled then 
		Enabled = true --Changing to true

		for _, Part in pairs(workspace:GetDescendants()) do
			if Part:IsA("BasePart") then
				Part.CastShadow = true
			end
		end
		Main2.Visible = true;
		script.Parent.Visible = false;

	end
end)
	   