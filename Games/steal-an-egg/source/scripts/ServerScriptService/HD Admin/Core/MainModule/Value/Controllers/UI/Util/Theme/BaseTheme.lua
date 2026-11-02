--!strict
return {
	Color = {
		Primary = Color3.fromRGB(92, 124, 255),
		PrimaryContent = Color3.fromRGB(255, 255, 255), -- auto-derived
		Secondary = Color3.fromRGB(255, 255, 255),
		Accent = Color3.fromRGB(255, 255, 255),
		Neutral = Color3.fromRGB(39, 39, 42),
		NeutralDark = Color3.fromRGB(17, 17, 18),
		NeutralContent = Color3.fromRGB(61, 61, 63),
		NeutralStroke = Color3.fromRGB(49, 49, 52),
		NeutralContentMain = Color3.fromRGB(212, 212, 216),
		NeutralContentDark = Color3.fromRGB(161, 161, 170),
		Base = Color3.fromRGB(24, 24, 27),
		BaseContent = Color3.fromRGB(255, 255, 255),
		Success = Color3.fromRGB(34, 197, 94),
		Error = Color3.fromRGB(239, 68, 68),
		Warning = Color3.fromRGB(251, 191, 36),
		Info = Color3.fromRGB(34, 211, 238),
	},
	Font = {
		Body = "rbxasset://fonts/families/BuilderSans.json",
		Heading = "rbxasset://fonts/families/BuilderSans.json",
	},
	FontWeight = {
		Light = Enum.FontWeight.Light,
		Regular = Enum.FontWeight.Regular,
		Body = Enum.FontWeight.SemiBold,
		Bold = Enum.FontWeight.Bold,
		Heading = Enum.FontWeight.Heavy,
	},
	Emphasis = {
		Light = 0.1,
		Regular = 0.15,
		Strong = 0.5,
		Contrast = 1,
	},
	Animation = {
		SpringSpeed = 60,
		SpringDampening = 1.5,
	},
	TextSize = {
		Title = 22,
		Subtitle = 18,
		Body = 16,
		Label = 14,
		Small = 12,
	},
	Layout = {
		CornerRadius = 6,
		StrokeThickness = 1,
		Spacing = 18,
		Padding = 16,
		Sizing = 16,
		ContentScale = 1,
	},
	Sound = {
		Hover = "rbxassetid://10066936758",
		Click = "rbxassetid://16480549841",
		Focus = "rbxassetid://16480549841",
		Switch = "rbxassetid://9119713951",
	},
	Settings = {
		LockPrimaryColor = false,
		LockFont = false,
		LockContentScale = false,
		ShowInYouSettings = true,
	},
}