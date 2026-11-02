local randomPainting = math.random(1, 17)
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
	Image.Image = "rbxassetid://6525354226"
	Image.Parent.Parent.Parent.Name = "Quadrants"
	TitleNumber.Value = "Quadrants"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Quadrants".')
	end)
elseif Number.Value == 2 then
	Image.Image = "rbxassetid://13113410176"
	Image.Parent.Parent.Parent.Name = "Garden"
	TitleNumber.Value = "Garden"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Garden".')
	end)
elseif Number.Value == 3 then
	Image.Image = "rbxassetid://13113419079"
	Image.Parent.Parent.Parent.Name = "Structures"
	TitleNumber.Value = "Structures"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Structures".')
	end)
elseif Number.Value == 4 then
	Image.Image = "rbxassetid://13113428579"
	Image.Parent.Parent.Parent.Name = "Sprout"
	TitleNumber.Value = "Sprout"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Sprout".')
	end)
elseif Number.Value == 5 then
	Image.Image = "rbxassetid://13113433091" 
	Image.Parent.Parent.Parent.Name = "House"
	TitleNumber.Value = "House"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "House".')
	end)
elseif Number.Value == 6 then
	Image.Image = "rbxassetid://13113443813" 
	Image.Parent.Parent.Parent.Name = "Quietness"
	TitleNumber.Value = "Quietness"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Quietness".')
	end)
elseif Number.Value == 7 then
	Image.Image = "rbxassetid://13113456635"
	Image.Parent.Parent.Parent.Name = "Greediness"
	TitleNumber.Value = "Greediness"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Greediness".')
	end)
elseif Number.Value == 8 then
	Image.Image = "rbxassetid://13113472639"
	Image.Parent.Parent.Parent.Name = "Redrick"
	TitleNumber.Value = "Redrick"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Redrick".')
	end)
elseif Number.Value == 9 then
	Image.Image = "rbxassetid://13113476351"
	Image.Parent.Parent.Parent.Name = "Three Balconies"
	TitleNumber.Value = "Three Balconies"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Three Balconies".')
	end)
elseif Number.Value == 10 then
	Image.Image = "rbxassetid://13113481630"
	Image.Parent.Parent.Parent.Name = "Streetlight"
	TitleNumber.Value = "Streetlight"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Streetlight".')
	end)
elseif Number.Value == 11 then
	Image.Image = "rbxassetid://15196570722"
	Image.Parent.Parent.Parent.Name = "Exit"
	TitleNumber.Value = "Exit"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Exit".')
	end)
elseif Number.Value == 12 then
	Image.Image = "rbxassetid://15196575745"
	Image.Parent.Parent.Parent.Name = "Emotional Man"
	TitleNumber.Value = "Emotional Man"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Emotional Man".')
	end)
elseif Number.Value == 13 then
	Image.Image = "rbxassetid://15196581789"
	Image.Parent.Parent.Parent.Name = "Catching Fresh Cod"
	TitleNumber.Value = "Catching Fresh Cod"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Catching Fresh Cod".')
	end)
elseif Number.Value == 14 then
	Image.Image = "rbxassetid://15196599475"
	Image.Parent.Parent.Parent.Name = "Homestead"
	TitleNumber.Value = "Homestead"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Homestead".')
	end)
elseif Number.Value == 15 then
	Image.Image = "rbxassetid://15196611071"
	Image.Parent.Parent.Parent.Name = "Judgement"
	TitleNumber.Value = "Judgement"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Judgement".')
	end)
elseif Number.Value == 16 then
	Image.Image = "rbxassetid://15196622610"
	Image.Parent.Parent.Parent.Name = "Monkey"
	TitleNumber.Value = "Monkey"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "Monkey".')
	end)
elseif Number.Value == 17 then
	Image.Image = "rbxassetid://15196644734"
	Image.Parent.Parent.Parent.Name = "On Break"
	TitleNumber.Value = "On Break"
	script.Parent.Parent.Parent:SetAttribute("Title")
	script.Parent.Parent.Parent.InteractPrompt.Triggered:Connect(function(plr)
		game.ReplicatedStorage.Bricks.Caption:FireClient(plr, 'This painting is titled "On Break".')
	end)
end