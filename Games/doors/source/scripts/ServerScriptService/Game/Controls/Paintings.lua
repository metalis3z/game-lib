local module = {}

function module:Tall(v)
	
	local Data = {
		Paint1 = {
			Title = "Unfathomable",
			Image = "rbxassetid://10500853479"
		},
		Paint2 = {
			Title = "This Is Not A Violin",
			Image = "rbxassetid://13114548841"
		},
		Paint3 = {
			Title = "Deepness",
			Image = "rbxassetid://13114575301"
		},
		Paint4 = {
			Title = "Captain Jack",
			Image = "rbxassetid://13114582360"
		},
		Paint5 = {
			Title = "Station",
			Image = "rbxassetid://13114586302"
		},
		Paint6 = {
			Title = "Terminal",
			Image = "rbxassetid://13114590522"
		},
		Paint7 = {
			Title = "Field",
			Image = "rbxassetid://13114595794"
		},
		Paint8 = {
			Title = "Mona Thump",
			Image = "rbxassetid://13114604765"
		},
		Paint9 = {
			Title = "Late For Work",
			Image = "rbxassetid://13114613583"
		},
		Paint10 = {
			Title = "Alley",
			Image = "rbxassetid://13114621368"
		},
		Paint11 = {
			Title = "Cam Of Man",
			Image = "rbxassetid://15196664536"
		},
		Paint12 = {
			Title = "Van Blugh",
			Image = "rbxassetid://15196681198"
		},
		Paint13 = {
			Title = "White Top hat",
			Image = "rbxassetid://15196699531"
		},
	}

	if next(Data) == nil then
		print("Data table is empty")
	else
		local keys = {}
		for key, _ in pairs(Data) do
			table.insert(keys, key)
		end

		local randomIndex = math.random(1, #keys)
		local randomPaintKey = keys[randomIndex]
		local randomPaint = Data[randomPaintKey]
		
		--print(randomPaint.Title, randomPaint.Image)
		
		local Painting = v
		local Canvas = Painting:FindFirstChild("Canvas")
		local ImageLabel = Canvas.SurfaceGui.ImageLabel
		local Prompt = Painting:FindFirstChild("InteractPrompt")
		
		ImageLabel.Image = randomPaint.Image
		Prompt.Triggered:Connect(function(plr)
			game.ReplicatedStorage.EntityInfo.Caption:FireClient(plr, 'This painting is titled "' ..randomPaint.Title..'".')
		end)
	end

end

function module:Small(v)

	local Data = {
		Paint1 = {
			Title = "Quadrants",
			Image = "rbxassetid://6525354226"
		},
		Paint2 = {
			Title = "Garden",
			Image = "rbxassetid://13113410176"
		},
		Paint3 = {
			Title = "Structures",
			Image = "rbxassetid://13113419079"
		},
		Paint4 = {
			Title = "Sprout",
			Image = "rbxassetid://13113428579"
		},
		Paint5 = {
			Title = "House",
			Image = "rbxassetid://13113433091"
		},
		Paint6 = {
			Title = "Quietness",
			Image = "rbxassetid://13113443813"
		},
		Paint7 = {
			Title = "Greediness",
			Image = "rbxassetid://13113456635"
		},
		Paint8 = {
			Title = "Redrick",
			Image = "rbxassetid://13113472639"
		},
		Paint9 = {
			Title = "Three Balconies",
			Image = "rbxassetid://13113476351"
		},
		Paint10 = {
			Title = "Streetlight",
			Image = "rbxassetid://13113481630"
		},
		Paint11 = {
			Title = "Exit",
			Image = "rbxassetid://15196570722"
		},
		Paint12 = {
			Title = "Emotional Man",
			Image = "rbxassetid://15196575745"
		},
		Paint13 = {
			Title = "Catching Fresh Cod",
			Image = "rbxassetid://15196581789"
		},
	}

	if next(Data) == nil then
		print("Data table is empty")
	else
		local keys = {}
		for key, _ in pairs(Data) do
			table.insert(keys, key)
		end

		local randomIndex = math.random(1, #keys)
		local randomPaintKey = keys[randomIndex]
		local randomPaint = Data[randomPaintKey]

		--print(randomPaint.Title, randomPaint.Image)

		local Painting = v
		local Canvas = Painting:FindFirstChild("Canvas")
		local ImageLabel = Canvas.SurfaceGui.ImageLabel
		local Prompt = Painting:FindFirstChild("InteractPrompt")

		ImageLabel.Image = randomPaint.Image
		Prompt.Triggered:Connect(function(plr)
			game.ReplicatedStorage.EntityInfo.Caption:FireClient(plr, 'This painting is titled "' ..randomPaint.Title..'".')
		end)
	end

end

function module:VeryBig(v)

	local Data = {
		Paint1 = {
			Title = "Alien Maze",
			Image = "rbxassetid://13640159193"
		},
		Paint2 = {
			Title = "Cul De Sac",
			Image = "rbxassetid://13640182089"
		},
		Paint3 = {
			Title = "Finals",
			Image = "rbxassetid://13640189380"
		},
		Paint4 = {
			Title = "Happy Accident",
			Image = "rbxassetid://13640197745"
		},
		Paint5 = {
			Title = "Flaming Man",
			Image = "rbxassetid://13640205682"
		},
		Paint6 = {
			Title = "Marbles",
			Image = "rbxassetid://13640213170"
		},
		Paint7 = {
			Title = "My Neighbourhood",
			Image = "rbxassetid://13640233872"
		},
		Paint8 = {
			Title = "Nine To Five",
			Image = "rbxassetid://13640242782"
		},
		Paint9 = {
			Title = "Petrol",
			Image = "rbxassetid://13640251169"
		},
		Paint10 = {
			Title = "Pirate Cove",
			Image = "rbxassetid://13640260399"
		},
		Paint11 = {
			Title = "Rabbit in a Snow Storm",
			Image = "rbxassetid://0"
		},
		Paint12 = {
			Title = "Theory",
			Image = "rbxassetid://15196772826"
		},
		Paint13 = {
			Title = "The Last Pizza Party",
			Image = "rbxassetid://15196782574"
		},
	}

	if next(Data) == nil then
		print("Data table is empty")
	else
		local keys = {}
		for key, _ in pairs(Data) do
			table.insert(keys, key)
		end

		local randomIndex = math.random(1, #keys)
		local randomPaintKey = keys[randomIndex]
		local randomPaint = Data[randomPaintKey]

		--print(randomPaint.Title, randomPaint.Image)

		local Painting = v
		local Canvas = Painting:FindFirstChild("Canvas")
		local ImageLabel = Canvas.SurfaceGui.ImageLabel
		local Prompt = Painting:FindFirstChild("InteractPrompt")

		ImageLabel.Image = randomPaint.Image
		Prompt.Triggered:Connect(function(plr)
			game.ReplicatedStorage.EntityInfo.Caption:FireClient(plr, 'This painting is titled "' ..randomPaint.Title..'".')
		end)
	end

end

return module
