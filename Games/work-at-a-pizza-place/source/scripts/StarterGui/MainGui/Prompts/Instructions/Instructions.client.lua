local Window = script.Parent

--local coregui = game:GetService("CoreGui")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))



local Layout = Window:WaitForChild("Layout")
local Title = Layout:WaitForChild("Title"):WaitForChild("Title")
local Image = Layout:WaitForChild("Image"):WaitForChild("ImageLabel")
local Next = Layout:WaitForChild("Buttons"):WaitForChild("Next")
local Previous = Layout:WaitForChild("Buttons"):WaitForChild("Previous")
local Finish = Layout:WaitForChild("Buttons"):WaitForChild("Finish")
local Text = Layout:WaitForChild("Text"):WaitForChild("TextLabel")


local WindowData = GuiManager:RegisterWindow(Window,"Left","Right",nil,nil,false)

local instructionIndex

local titles = {
	"How to install Video Maker plugin",

}

local instructions = {
	{
		{ImageId = 887150370,Text = "Find the Roblox Studio icon on your desktop and double click it",Size = Vector2.new(89,119)},
		{ImageId = 887150771,Text = "Click on the 'Plugins' tab",Size = Vector2.new(377,144)},
		{ImageId = 887151014,Text = "Click on the 'Manage Plugins' button to the left",Size = Vector2.new(55,71)},
		{ImageId = 887151168,Text = "Click on the 'Find Plugins' button",Size = Vector2.new(263,202)},
		{ImageId = 887151374,Text = "Type 'video maker' in the search box and then click the search button.",Size = Vector2.new(607,182)},
		{ImageId = 893225038,Text = "Click on 'Pizza Place Video Maker'",Size = Vector2.new(148,199)},
		{ImageId = 887151879,Text = "Install the plugin",Size = Vector2.new(408,262)},
		{ImageId = 893177224,Text = "Press the Ctrl and N keys at the same time.",Size = Vector2.new(400,131)},
		{ImageId = 887150771,Text = "Click on the 'Plugins' tab",Size = Vector2.new(377,144)},
		{ImageId = 887152403,Text = "Click on the 'Open Editor' button",Size = Vector2.new(74,97)},
		{ImageId = 887193218,Text = "Make your video and then press the 'Export' button when you're done.",Size = Vector2.new(1182,607)},

	},
}


local currentSlide = 1

local function ChangeSlide(direction)
	
	currentSlide = currentSlide + direction
	
	if currentSlide <= 1 then
		Previous.Visible = false
	else
		Previous.Visible = true
	end
	
	local instructionsList = instructions[instructionIndex]
	local slideData = instructionsList[currentSlide]
	
	if currentSlide >= #instructionsList then
		Next.Visible = false
		Finish.Visible = true
	else
		Next.Visible = true
		Finish.Visible = false
	end
	
	local imageParentSize = Image.Parent.AbsoluteSize
	local ImageSize = slideData.Size
	
	if imageParentSize.X > ImageSize.X and imageParentSize.Y > ImageSize.Y then
		Image.Size = UDim2.new(0,ImageSize.X,0,ImageSize.Y)
	else
		Image.Size = UDim2.new(1,0,1,0)
	end
	
	Image.Image = "rbxassetid://" .. slideData.ImageId
	Image.UIAspectRatioConstraint.AspectRatio = ImageSize.X / ImageSize.Y
	Text.Text = slideData.Text
	
end


Next.MouseButton1Click:connect(function() ChangeSlide(1) end)
Previous.MouseButton1Click:connect(function() ChangeSlide(-1) end)

Finish.MouseButton1Click:connect(function()
	WindowData:SetVisible(false)
end)


workspace.Main.ShowInstructions.Event:connect(function(index)
	instructionIndex = index
	Title.Text = titles[index]
	currentSlide = 0
	ChangeSlide(1)
	WindowData:SetVisible(true)
end)










