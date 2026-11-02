local randomPainting = math.random(1, 22)
local Image = script.Parent.ImageLabel
local Number = Instance.new("NumberValue")
Number.Value = randomPainting
Number.Name = "Number"
Number.Parent = script.Parent
local TitleNumber = Instance.new("StringValue")
TitleNumber.Value = randomPainting
TitleNumber.Name = "Title"
TitleNumber.Parent = script.Parent

if Number.Value == 1 then
	Image.Image = "rbxassetid://13640159193"
	Image.Parent.Parent.Parent.Name = "Alien Maze"
	TitleNumber.Value = "Alien Maze"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Alien Maze".')
	end)
elseif Number.Value == 2 then
	Image.Image = "rbxassetid://13640182089"
	Image.Parent.Parent.Parent.Name = "Cul De Sac"
	TitleNumber.Value = "Cul De Sac"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Cul De Sac".')
	end)
elseif Number.Value == 3 then
	Image.Image = "rbxassetid://13640189380"
	Image.Parent.Parent.Parent.Name = "Finals"
	TitleNumber.Value = "Finals"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Finals".')
	end)
elseif Number.Value == 4 then
	Image.Image = "rbxassetid://13640197745"
	Image.Parent.Parent.Parent.Name = "Happy Accident"
	TitleNumber.Value = "Happy Accident"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Happy Accident".')
	end)
elseif Number.Value == 5 then
	Image.Image = "rbxassetid://13640205682"
	Image.Parent.Parent.Parent.Name = "Flaming Man"
	TitleNumber.Value = "Flaming Man"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Flaming Man".')
	end)
elseif Number.Value == 6 then
	Image.Image = "rbxassetid://13640213170"
	Image.Parent.Parent.Parent.Name = "Marbles"
	TitleNumber.Value = "Marbles"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Marbles".')
	end)
elseif Number.Value == 7 then
	Image.Image = "rbxassetid://13640233872"
	Image.Parent.Parent.Parent.Name = "My Neighbourhood"
	TitleNumber.Value = "My Neighbourhood"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "My Neighbourhood".')
	end)
elseif Number.Value == 8 then
	Image.Image = "rbxassetid://13640242782"
	Image.Parent.Parent.Parent.Name = "Nine To Five"
	TitleNumber.Value = "Nine To Five"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Nine To Five".')
	end)
elseif Number.Value == 9 then
	Image.Image = "rbxassetid://13640251169"
	Image.Parent.Parent.Parent.Name = "Petrol"
	TitleNumber.Value = "Petrol"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Petrol".')
	end)
elseif Number.Value == 10 then
	Image.Image = "rbxassetid://13640260399"
	Image.Parent.Parent.Parent.Name = "Pirate Cove"
	TitleNumber.Value = "Pirate Cove"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Pirate Cove".')
	end)
elseif Number.Value == 11 then
	Image.Image = "rbxassetid://13766901372"
	Image.Parent.Parent.Parent.Name = "Canon event"
	TitleNumber.Value = "Canon event"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Canon event".')
	end)
elseif Number.Value == 12 then
	Image.Image = "rbxassetid://0"
	Image.Parent.Parent.Parent.Name = "Rabbit in a Snow Storm"
	TitleNumber.Value = "Rabbit in a Snow Storm"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Rabbit in a Snow Storm".')
	end)
elseif Number.Value == 13 then
	Image.Image = "rbxassetid://15196751377"
	Image.Parent.Parent.Parent.Name = "Outlier"
	TitleNumber.Value = "Outlier"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Outlier".')
	end)
elseif Number.Value == 14 then
	Image.Image = "rbxassetid://15196758722"
	Image.Parent.Parent.Parent.Name = "Perch"
	TitleNumber.Value = "Perch"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Perch".')
	end)
elseif Number.Value == 15 then
	Image.Image = "rbxassetid://15196763838"
	Image.Parent.Parent.Parent.Name = "Rooftop"
	TitleNumber.Value = "Rooftop"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Rooftop".')
	end)
elseif Number.Value == 16 then
	Image.Image = "rbxassetid://15196768110"
	Image.Parent.Parent.Parent.Name = "Tabernacle"
	TitleNumber.Value = "Tabernacle"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Tabernacle".')
	end)
elseif Number.Value == 17 then
	Image.Image = "rbxassetid://15196772826"
	Image.Parent.Parent.Parent.Name = "Theory"
	TitleNumber.Value = "Theory"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Theory".')
	end)
elseif Number.Value == 18 then
	Image.Image = "rbxassetid://15196782574"
	Image.Parent.Parent.Parent.Name = "The Last Pizza Party"
	TitleNumber.Value = "The Last Pizza Party"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "The Last Pizza Party".')
	end)
elseif Number.Value == 19 then
	Image.Image = "rbxassetid://15196787780"
	Image.Parent.Parent.Parent.Name = "Galaxy"
	TitleNumber.Value = "Galaxy"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Galaxy".')
	end)
elseif Number.Value == 20 then
	Image.Image = "rbxassetid://15196795315"
	Image.Parent.Parent.Parent.Name = "Alpha"
	TitleNumber.Value = "Alpha"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Alpha".')
	end)
elseif Number.Value == 21 then
	Image.Image = "rbxassetid://15196799216"
	Image.Parent.Parent.Parent.Name = "Horsey"
	TitleNumber.Value = "Horsey"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Horsey".')
	end)
elseif Number.Value == 22 then
	Image.Image = "rbxassetid://15196804325"
	Image.Parent.Parent.Parent.Name = "Apartment"
	TitleNumber.Value = "Apartment"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Apartment".')
	end)
end