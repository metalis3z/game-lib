wait(1)
for i,v in pairs(script.Parent.Buttons:GetChildren()) do
	if v:FindFirstChild("ClickDetector") then
		v.ClickDetector.MouseClick:connect(function()
			script.Parent.Color.BrickColor = v.BrickColor
			script.Parent.Parent.Parent.DropColor.Value = v.BrickColor
		end)
	end
end