local Right = math.random(1, 3)

repeat wait(0.5) until game.Workspace:FindFirstChild("Lide", true)

if Right == 1 then
	script.Parent.RightLide.Value = "Blue"
	local Diffrent = game.Workspace:FindFirstChild("Lide", true).RightLide:GetChildren() --local Diffrent = game.Workspace:FindFirstChild("Lide", true).RightLide:GetChildren()
	for Time=1, #Diffrent do
		Diffrent[Time].Color = Color3.new(0.129412, 0.180392, 0.247059)
	end
	
	game.Workspace:FindFirstChild("Lide", true).Sont1_1.Color = Color3.new(0.282353, 0.176471, 0.176471)
	game.Workspace:FindFirstChild("Lide", true).Sont1_2.Color = Color3.new(0.282353, 0.176471, 0.176471)
elseif Right == 2 then
	script.Parent.RightLide.Value = "Yellow"
	local Diffrent = game.Workspace:FindFirstChild("Lide", true).RightLide:GetChildren()
	for Time=1, #Diffrent do
		Diffrent[Time].Color = Color3.new(0.282353, 0.247059, 0.152941)
	end

	game.Workspace:FindFirstChild("Lide", true).Sont1_1.Color = Color3.new(0.129412, 0.180392, 0.247059)
	game.Workspace:FindFirstChild("Lide", true).Sont1_2.Color = Color3.new(0.129412, 0.180392, 0.247059)
	
	game.Workspace:FindFirstChild("Lide", true).Sont2_1.Color = Color3.new(0.282353, 0.176471, 0.176471)
	game.Workspace:FindFirstChild("Lide", true).Sont2_2.Color = Color3.new(0.282353, 0.176471, 0.176471)
elseif Right == 3 then
	script.Parent.RightLide.Value = "Red"
	local Diffrent = game.Workspace:FindFirstChild("Lide", true).RightLide:GetChildren()
	for Time=1, #Diffrent do
		Diffrent[Time].Color = Color3.new(0.282353, 0.176471, 0.176471)
	end

	game.Workspace:FindFirstChild("Lide", true).Sont1_1.Color = Color3.new(0.129412, 0.180392, 0.247059)
	game.Workspace:FindFirstChild("Lide", true).Sont1_2.Color = Color3.new(0.129412, 0.180392, 0.247059)

	game.Workspace:FindFirstChild("Lide", true).Sont2_1.Color = Color3.new(0.282353, 0.247059, 0.152941)
	game.Workspace:FindFirstChild("Lide", true).Sont2_2.Color = Color3.new(0.282353, 0.247059, 0.152941)
end