local rs = game:GetService("ReplicatedStorage")

rs.StagesLoaded.Changed:Connect(function(value)
	script.Parent.Text = "STAGES LOADED: " .. value .. "/40"
end)