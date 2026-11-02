-- Game: steal-a-brainrot
-- Original: ReplicatedStorage/Datas/Mutations.lua
-- Excerpt of lines 1-59
-- What it does: Two entries of the mutation table: each mutation has a display name, rich text, sort order, roll Weight, income Modifier, icon and colour palettes used to recolour the model.
-- ===== Excerpt of lines 1-59 of ReplicatedStorage/Datas/Mutations.lua =====
return {
	Gold = {
		DisplayText = "Gold",
		DisplayWithRichText = "<font color=\"#FFDE59\">Gold</font>",
		Order = 2,
		Weight = 7,
		Modifier = 0.25,
		Icon = "rbxassetid://136133057822407",
		MainColor = Color3.fromRGB(255, 222, 89),
		Palettes = {
			{
				Color3.fromRGB(237, 178, 0),
				Color3.fromRGB(237, 194, 86),
				Color3.fromRGB(215, 111, 1),
				Color3.fromRGB(139, 74, 0),
				Color3.fromRGB(255, 164, 164),
				Color3.fromRGB(255, 244, 190)
			},
			{
				Color3.fromRGB(237, 178, 0),
				Color3.fromRGB(237, 194, 86),
				Color3.fromRGB(215, 111, 1),
				Color3.fromRGB(139, 74, 0),
				Color3.fromRGB(237, 194, 86),
				Color3.fromRGB(255, 251, 131),
				Color3.fromRGB(255, 178, 0),
				Color3.fromRGB(215, 111, 1)
			}
		}
	},
	Diamond = {
		DisplayText = "Diamond",
		DisplayWithRichText = "<font color=\"#25C4FE\">Diamond</font>",
		Order = 3,
		Weight = 3,
		Modifier = 0.5,
		Icon = "rbxassetid://100875709547015",
		MainColor = Color3.fromRGB(37, 196, 254),
		Palettes = {
			{
				Color3.fromRGB(37, 196, 254),
				Color3.fromRGB(116, 212, 254),
				Color3.fromRGB(28, 137, 254),
				Color3.fromRGB(21, 64, 254),
				Color3.fromRGB(160, 162, 254),
				Color3.fromRGB(176, 255, 252)
			},
			{
				Color3.fromRGB(37, 196, 254),
				Color3.fromRGB(116, 212, 254),
				Color3.fromRGB(28, 137, 254),
				Color3.fromRGB(21, 64, 254),
				Color3.fromRGB(116, 212, 254),
				Color3.fromRGB(116, 212, 254),
				Color3.fromRGB(37, 196, 254),
				Color3.fromRGB(28, 137, 254)
			}
		}
	},
