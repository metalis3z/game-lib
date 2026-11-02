local ui = script.Parent.UI
local template = script.Parent.Template

script.Parent.Toggle.MouseButton1Click:Connect(function()
	if ui.Visible == true then
		ui.Visible = false
		for i, v in pairs(ui:GetChildren()) do
			if v:IsA("Frame") then
				v:Remove()
			end
		end
	else
		ui.Visible = true
		for i, v in pairs(game.Players.LocalPlayer.leaderstats:GetChildren()) do
			local new = template:Clone()
			new.Parent = ui
			new.Name = v.Name
			new.Title.Text = v.Name
			new.Stat.Text = tostring(v.value)
			new.Visible = true
		end
	end
end)