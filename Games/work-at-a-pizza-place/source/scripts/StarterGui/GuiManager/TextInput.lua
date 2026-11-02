local TextInput = {}
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local UIEvents =PlayerGui:WaitForChild("UIEvents")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiService = game:GetService("GuiService")

TextInput.__index = TextInput





function TextInput.new(textInput,windowData)

	local this = {}
	setmetatable(this, TextInput)
	this.Object = textInput
	this.WindowData = windowData
	this.NumbersOnly = false
	this.LettersOnly = false
	this.SpacesAllowed = true
	this.PunctuationAllowed = true
	this.UnderscoresAllowed = true
	this.NumLines = 1
	this.MaxLength = 1000 -- characters
	this.MinLength = 3
	this.DefaultMessage = nil
	this.DefaultMessageColor = Color3.new(179/255, 179/255, 179/255)
	this.TextColor = textInput.TextColor
	this.FilteredString = nil
	this.UnfilteredText = nil
	this.IsValid = false
	this.ExludedCharacters = nil
	this.IsHashtagedTextValid = true
	this.NeedsToBeFiltered = true
	
	return this
	
end


function TextInput:Initialize()
	
	local object = self.Object
	
	object.TextScaled = false
	object.TextSize = math.floor(object.AbsoluteSize.Y / self.NumLines) -2
	
	if self.DefaultMessage then
		object.TextColor = self.DefaultMessageColor
		object.Text = self.DefaultMessage
	end
	


	object.Focused:connect(function()
		if object.Text == self.DefaultMessage then
			object.Text = ""
			object.TextColor = self.TextColor
		end
	end)
	
	
	
	
	object.FocusLost:connect(function()
		
		
		if string.len(object.Text) < self.MinLength then
			self.Object.ErrorTextLabel.Text = "Too short"
			return
		end
		
		if self.NeedsToBeFiltered then
			self.UnfilteredText = object.Text
			self.FilteredText = workspace.Main.FilterString:InvokeServer(nil,object.Text)
			object.Text = self.FilteredText
			if string.find(self.FilteredText,"##") and not self.IsHashtagedTextValid then
				self.Object.ErrorTextLabel.Text = "Some of the text was filtered. Try again using different words."
				return
			end
		end
		
		
		self.IsValid = true
		
		UIEvents.TextInputChanged:Fire(self.WindowData.Object,self.Object,object.Text)
		UIEvents.TextInputFocusLost:Fire(self.WindowData.Object,self.Object,object.Text)
		
	end)
	
	
	
	
	
	object:GetPropertyChangedSignal("Text"):connect(function()
		
		self.IsValid = false
		
		if string.len(object.Text) > self.MaxLength then
			object.Text = string.sub(1,self.MaxLength)
			return
		end
		--this part has not been tested, may not work
		local pattern = ""
		if self.NumbersOnly then
			pattern = pattern .. "%d"
		elseif self.LettersOnly then
			pattern = pattern .."%a"
			
			if self.SpacesAllowed then
				pattern = pattern .. "%s"
			end
			
		else
			pattern = pattern .."%w" --alpha numeric
			
			if self.SpacesAllowed then
				pattern = pattern .. "%s"
			end
			
			if self.PunctuationAllowed then
				pattern = pattern .. "%p"
			end
		
		end
		
		if self.ExludedCharacters then
			object.Text = object.Text:gsub("[" .. self.ExludedCharacters .. "]+", "")
		end
		
		object.Text = object.Text:gsub("[^" .. pattern .. "]+", "")
		
		UIEvents.TextInputChanged:Fire(self.WindowData.Object,self.Object,object.Text)
		
	end)

end
	
	


function TextInput:IsValid()
	return self.IsValid
end

function TextInput:Reset()
	if self.DefaultMessage then
		self.Object.TextColor = self.DefaultMessageColor
		self.Object.Text = self.DefaultMessage
	else
		self.Object.Text = ""
	end
end





return TextInput
