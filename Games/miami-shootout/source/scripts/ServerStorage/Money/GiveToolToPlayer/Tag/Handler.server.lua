

script.Parent.OnServerEvent:connect(function(Player,Target)
	local Char = Player.Character
	local toolname = script.Parent.Parent.Parent.Name

	local pass1gui =  Char:FindFirstChild("Head").Billboard.Text.Text --Mouse.Target.Parent:FindFirstChild("Head").Billboard.Text.Text
	local pass2gui =  Target.Parent:FindFirstChild("Head").Billboard.Text.Text
	local gui = game.ServerStorage:FindFirstChild("BillboardGui"):Clone() 
	gui.Parent = Target.Parent:FindFirstChild("Head")
	gui.Name = "Emote"
	gui.Size = UDim2.new(6,0,1.5,0)
	gui.StudsOffset = Vector3.new(0,2.4,0)
	local label = Instance.new("TextLabel", gui)
	label.Text = "Would receave "..toolname.." from "..pass1gui
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1,0,1,0)
	label.Font = "Highway"
	label.FontSize = "Size24"
	label.TextScaled = true
	label.TextWrapped = true
	label.TextStrokeTransparency = 0
	label.TextColor3 = Color3.new(0.180392, 1, 0)
	
	
	
	local namer = Target.Parent.Name
	local gui3 =  game.Players:FindFirstChild(namer).PlayerGui.Notify:Clone()
	gui3.Parent = game.Players:FindFirstChild(namer).PlayerGui
	gui3.Icons.notification.Text = pass1gui
	gui3.Icons.Text.Text = "Handed you a "..toolname
	gui3.Icons.Text.TextColor3 = Color3.new(0, 1, 0)
	gui3.Icons.Script.Disabled = false	

	------
	local gui2 = game.ServerStorage:FindFirstChild("BillboardGui"):Clone() 
	gui2.Parent = Char:FindFirstChild("Head")
	gui2.Name = "Emote"
	gui2.Size = UDim2.new(6,0,1.5,0)
	gui2.StudsOffset = Vector3.new(0,2.4,0)
	local label2 = Instance.new("TextLabel", gui2)
	label2.Text = "Would pass "..toolname.." to "..pass2gui
	label2.BackgroundTransparency = 1
	label2.Size = UDim2.new(1,0,1,0)
	label2.Font = "Highway"
	label2.FontSize = "Size24"
	label2.TextScaled = true
	label2.TextWrapped = true
	label2.TextStrokeTransparency = 0
	label2.TextColor3 = Color3.new(0.180392, 1, 0)


	
	
end)