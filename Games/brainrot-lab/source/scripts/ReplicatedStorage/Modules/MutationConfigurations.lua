--!strict
-- LOCATION: ReplicatedStorage/Modules/MutationConfigurations

local MutationConfigurations = {
	Normal = {
		DisplayName = "Normal",
		TextColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(0, 0, 0),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(155, 155, 155)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
		})
	},
	Acid = {
		DisplayName = "Acid",
		TextColor = Color3.fromRGB(180, 255, 50),
		StrokeColor = Color3.fromRGB(50, 80, 0),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 200, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 255, 50)),
		})
	},
	Love = {
		DisplayName = "Love",
		TextColor = Color3.fromRGB(255, 105, 180),
		StrokeColor = Color3.fromRGB(120, 0, 60),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 20, 147)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 182, 193)),
		})
	},
	Brazil = {
		DisplayName = "Brazil",
		TextColor = Color3.fromRGB(0, 255, 0),
		StrokeColor = Color3.fromRGB(0, 50, 0),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)),
		})
	},
	Matteo = {
		DisplayName = "Matteo",
		TextColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(40, 40, 40),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200)),
		})
	},
	Aquatic = {
		DisplayName = "Aquatic",
		TextColor = Color3.fromRGB(0, 200, 255),
		StrokeColor = Color3.fromRGB(0, 50, 100),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 220, 255)),
		})
	},
	Tecnologia = {
		DisplayName = "Tecnologia",
		TextColor = Color3.fromRGB(255, 100, 200),
		StrokeColor = Color3.fromRGB(100, 0, 80),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 150)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 230)),
		})
	},
	Lava = {
		DisplayName = "Lava",
		TextColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(139, 0, 0),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
		})
	},
	Hacker = {
		DisplayName = "Hacker",
		TextColor = Color3.fromRGB(0, 255, 0),
		StrokeColor = Color3.fromRGB(0, 50, 0),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 0)),
		})
	},
	Neon = {
		DisplayName = "Neon",
		TextColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(25, 75, 0),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)),
		})
	},
	Ruby = {
		DisplayName = "Ruby",
		TextColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(145, 0, 0),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 127)),
		})
	},
	Diamond = {
		DisplayName = "Diamond",
		TextColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(0, 100, 255),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
		})
	},
	Gold = {
		DisplayName = "Gold",
		TextColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(255, 215, 0),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
		})
	},
	Golden = {
		DisplayName = "Golden",
		TextColor = Color3.fromRGB(255, 255, 255),
		StrokeColor = Color3.fromRGB(120, 78, 0),
		StrokeThickness = 3,
		GradientColor = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)),
		})
	},
}

return MutationConfigurations