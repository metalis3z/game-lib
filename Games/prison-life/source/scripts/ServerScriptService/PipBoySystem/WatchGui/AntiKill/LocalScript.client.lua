local pipBoyConfig = game.ReplicatedStorage:WaitForChild("PipBoyConfig")
local remotes = pipBoyConfig:WaitForChild("Remotes")

local playsounds = remotes:WaitForChild("PlaySounds")
local modeAntiKillRemote = remotes:WaitForChild("ShowModeAntiKill")
local modeAntiKillRemoteConfirm = remotes:WaitForChild("ConfirmModeAntiKill")

local selectSound = script.Parent.Select
local PowerOutSound = script.Parent.PowerOut

local canSelect = false
local canAccept = false

local selecteds = ""
local Currentkiller

local names = script.Parent:WaitForChild("Names")
local name1 = names:WaitForChild("Name1")
local name2 = names:WaitForChild("Name2")
local name3 = names:WaitForChild("Name3")
local currentDisplayName = names:WaitForChild("DisplayName")


modeAntiKillRemote.OnClientEvent:Connect(function(killer)
	currentDisplayName.Value = killer.DisplayName
	Currentkiller = killer
	
	script.Parent.CharEnemi.Image = game.Players:GetUserThumbnailAsync(killer.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size180x180)
	script.Parent.Visible = true
	
	playsounds:FireServer("Enter", false)
	
	wait(1)
	
	canSelect = true
	print("finish")
end)

script.Parent.Accept.MouseButton1Down:Connect(function()
	if canAccept == true then 
		canAccept = false
		canSelect = false
		
		PowerOutSound:Play()
		
		playsounds:FireServer("Ready", false)
		modeAntiKillRemoteConfirm:FireServer(selecteds, Currentkiller)
		
		script.Parent.Visible = false
		script.Parent.Accept.Visible = false
		
		name1.Visible = false
		name2.Visible = false
		name3.Visible = false
		
		selecteds = ""
	end
end)

script.Parent.Return.MouseButton1Down:Connect(function()
	canAccept = false
	canSelect = false
	
	remotes.Return:FireServer()
	remotes.Close:FireServer()
	
	script.Parent.Visible = false
	script.Parent.Accept.Visible = false

	name1.Visible = false
	name2.Visible = false
	name3.Visible = false

	selecteds = ""
end)


function choose(selected)
	selecteds = selected
	
	name1.Visible = false
	name2.Visible = false
	name3.Visible = false

	wait(0.09)
	
	playsounds:FireServer("Move", true)
	name1.Text = currentDisplayName.Value.." : "..selected
	name1.Visible = true
	wait(0.09)
	playsounds:FireServer("Move", true)
	name2.Text = currentDisplayName.Value.." : "..selected
	name2.Visible = true
	wait(0.09)
	playsounds:FireServer("Move", true)
	name3.Text = currentDisplayName.Value.." : "..selected
	name3.Visible = true
	
	wait(0.5)
	
	script.Parent.Accept.Visible = true
	canAccept = true
end

script.Parent.Arms.MouseEnter:Connect(function()
	if canSelect == true then
		selectSound:Play()
	end
end)

script.Parent.Arms2.MouseEnter:Connect(function()
	if canSelect == true then
		selectSound:Play()
	end
end)

script.Parent.Legs.MouseEnter:Connect(function()
	if canSelect == true then
		selectSound:Play()
	end
end)

script.Parent.Legs2.MouseEnter:Connect(function()
	if canSelect == true then
		selectSound:Play()
	end
end)

script.Parent.Torso.MouseEnter:Connect(function()
	if canSelect == true then
		selectSound:Play()
	end
end)

script.Parent.Head.MouseEnter:Connect(function()
	if canSelect == true then
		selectSound:Play()
	end
end)

script.Parent.Arms.MouseButton1Down:Connect(function()
	if canSelect == true then
		choose("Right Arm")
	end
end)

script.Parent.Arms2.MouseButton1Down:Connect(function()
	if canSelect == true then
		choose("Left Arm")
	end
end)

script.Parent.Legs.MouseButton1Down:Connect(function()
	if canSelect == true then
		choose("Left Leg")
	end
end)

script.Parent.Legs2.MouseButton1Down:Connect(function()
	if canSelect == true then
		choose("Right Leg")
	end
end)

script.Parent.Torso.MouseButton1Down:Connect(function()
	if canSelect == true then
		choose("Torso")
	end
end)

script.Parent.Head.MouseButton1Down:Connect(function()
	if canSelect == true then
		choose("Head")
	end
end)

--print("loaded")