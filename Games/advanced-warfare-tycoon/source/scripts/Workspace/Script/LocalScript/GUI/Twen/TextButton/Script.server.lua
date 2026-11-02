local clicked = false
script.Parent.MouseButton1Click:connect(function()
	if clicked == false then
		clicked = true
--	script.Parent.Parent.Parent.Parent.Parent:LoadCharacter()
--	wait()
--	game.Workspace.CurrentCamera.CameraSubject = script.Parent.Parent.Parent.Parent.Parent.Character.Humanoid
--	game.Workspace.CurrentCamera.CameraType = "Custom"
while wait(0.8) do
	local things = {"Bright blue", "Reddish brown", "Bright green", "New Yeller", "Bright orange", "Pink", "Bright red", "Bright violet"}
	for i,v in pairs(script.Parent.Parent.Frame:GetChildren()) do
		if v:IsA('TextButton') then
			v:Destroy()
		end
	end
for i,v in pairs(game.Players:GetPlayers()) do
	if v.TeamColor == BrickColor.new("Institutional white") then
	else
		local a = v
		for i,v in pairs(things) do
			if a.TeamColor == BrickColor.new(things[i]) then
				print('aaaa')
			table.remove(things, i)
		end
		end
	end
end
for i,v in pairs(things) do
	local q = Instance.new('TextButton', script.Parent.Parent.Frame)
	q.Size = UDim2.new(0, 400, 0, 25)
	q.Position = UDim2.new(.5, -200, 0, (25*i))
	q.Name = v
	q.TextColor3 = (BrickColor.new(v)).Color
	q.BackgroundTransparency = 0.7
	q.TextScaled = true
	q.Text = v.." Tycoon"
	q.BorderSizePixel = 0
	q.BorderColor3 = Color3.new(1, 1, 1)
	q.BackgroundColor3 = Color3.new(0,0,0)
	q.TextStrokeTransparency = 0.4
	q.Font = "SourceSansBold"
	local aq = Instance.new('BrickColorValue', q)
	aq.Value = BrickColor.new(v)
	aq.Name = "AAA"
end
script.Parent.Parent.Frame.Script.Disabled = true
wait()
script.Parent.Parent.Frame.Script.Disabled = false
end
end
end)