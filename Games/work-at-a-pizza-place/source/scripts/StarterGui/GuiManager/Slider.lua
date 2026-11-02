local Slider = {}
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local UIS = game:GetService("UserInputService")
local TouchEnabled = UIS.TouchEnabled
local ContextActionService = game:GetService("ContextActionService")


Slider.__index = Slider

SliderMinAndMax = 10 --how far the slider can go to the left or right in pixels
localMinPosition = SliderMinAndMax


function Slider:SetPositionAlpha(alpha)
	local object = self.object
	local bar = self.Object.Bar
	local dragger = self.Object.Dragger
	local newPosition = Utility:ConvertScale(alpha,{0,1},{localMinPosition,self.LocalMaxPosition})
	self.Object.Dragger.Position = UDim2.new(0,newPosition,.5,0)
	bar.Size = UDim2.new(0,dragger.Position.X.Offset,bar.Size.Y.Scale,bar.Size.Y.Offset)
	UIEvents.SliderMoved:Fire(self.WindowData.Object,object,alpha)

end

function Slider:DragSlider(inputObjectPosX)
		local object = self.Object
		local dragger = self.Object.Dragger
		local localMaxPosition = object.AbsoluteSize.X - SliderMinAndMax
		
		local newPosition = (inputObjectPosX - object.AbsolutePosition.X) + self.DraggingOffsetX --Utility:ConvertScale(x,{absoluteMinPosition,abosoluteMaxPosition},{localMinPosition,localMaxPosition})
		dragger.Position = UDim2.new(0,newPosition,0.5,0)
			
			
		if dragger.Position.X.Offset > localMaxPosition then dragger.Position = UDim2.new(0,localMaxPosition,.5,0)  end
		if dragger.Position.X.Offset < localMinPosition then  dragger.Position = UDim2.new(0,localMinPosition,.5,0) end
			
		object.Bar.Size = UDim2.new(0,dragger.Position.X.Offset,object.Bar.Size.Y.Scale,object.Bar.Size.Y.Offset)
			
		self.PositionAlpha = Utility:ConvertScale(dragger.Position.X.Offset,{localMinPosition,localMaxPosition},{0,1})
			
		UIEvents.SliderMoved:Fire(self.WindowData.Object,object,self.PositionAlpha)
	
end


function Slider.new(object,windowData,initialValue)
		
		
	local this = {}
	setmetatable(this, Slider)
	this.Object = object
	this.Type = "Slider"
	this.IsOn = initialValue
	this.WindowData = windowData
	this.PositionAlpha = initialValue
	this.DraggerSize = object.Dragger.Size.X.Offset
	this.LocalMaxPosition = object.AbsoluteSize.X - SliderMinAndMax
	this.DraggingOffsetX = 0
	
	object.Dragger.MouseEnter:connect(function()
		object.Dragger.ImageColor3 = Color3.new(1,1,1)
	end)
	
	object.Dragger.MouseLeave:connect(function()
		object.Dragger.ImageColor3 = Color3.new(230/255,230/255,230/255)
	end)
	

	
	local draggerSize = object.Dragger.Size.X.Offset
	local dragger = object.Dragger
	local bar = object.Bar
	
	
	local draggerPositionY = object.Dragger.Position.Y.Offset
	
	local lastPositionAlpha = initialValue
	
	if initialValue then
		this:SetPositionAlpha(initialValue)
	end
	
	
	
	local inputChanged
	local inputBegan
	local inputEnded
	local selectionGained
	local selectionLost

	
	
	
	local function InputChanged(inputObject, gameProccess)

		if  gameProccess and inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch then
			if TouchEnabled then
				if not Utility:PointInsideGui(this.WindowData.Object,inputObject.Position) then
					UIEvents.SliderStopped:Fire(windowData.Object,object,this.PositionAlpha)
					inputChanged:disconnect()
					return
				end
			end
			
			this:DragSlider(inputObject.Position.X)
			
		
		end
		
	end
	
	
	
	UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
		--when the window that contains this slider is opened, set connecitons
		if visible and window == windowData.Object then
			
			inputBegan = dragger.InputBegan:connect(function(inputObject, gameProccess)
				if inputChanged then inputChanged:disconnect() end
				if not gameProccess and inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
					this.DraggingOffsetX = (dragger.AbsolutePosition.X + (draggerSize/2)) - inputObject.Position.X
					inputChanged = UIS.InputChanged:connect(InputChanged)
				end
			end)
			
			
			--dont detect input ended on mobile
			if not TouchEnabled then
				
				inputEnded = dragger.InputEnded:connect(function(inputObject, gameProccess)
					if inputChanged and (inputObject.Position.Y <= 4 or (not gameProccess and (inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch))) then
						if inputChanged then inputChanged:disconnect() end
						if lastPositionAlpha ~= this.PositionAlpha then
							lastPositionAlpha = this.PositionAlpha
							UIEvents.SliderStopped:Fire(window,object,this.PositionAlpha)
						end
					end
				end)
				
			end
			
			
			
			if Enums.GamepadEnabled then

				local x,y,direction


				local function MoveSliderGamepad(direction)
					
					local INCREMENT = 10
					local PixelRange = this.LocalMaxPosition - localMinPosition
					local increment = PixelRange / INCREMENT
					
					this:DragSlider(dragger.AbsolutePosition.X + (dragger.AbsoluteSize.X/2) + (direction * increment))
				end
				
			
			
				selectionGained = dragger.SelectionGained:connect(function()

					GamepadInputBegan = UIS.InputBegan:connect(function(inputObject,gameProcessed)
										
						if inputObject.KeyCode == Enum.KeyCode.DPadLeft then
							MoveSliderGamepad(-1)
									
						elseif inputObject.KeyCode == Enum.KeyCode.DPadRight then
							MoveSliderGamepad(1)
								
						end
					end)	
						
						
					GamepadInputChanged = UIS.InputChanged:connect(function(inputObject,gameProcessed)

						if inputObject.KeyCode == Enum.KeyCode.Thumbstick1 then
							x = inputObject.Position.X
							y = inputObject.Position.Y
							if math.sqrt(math.pow(x,2)+math.pow(y,2)) > .7 then --if thumbstick is nearing the edge.
								if direction == nil then
									if x > -.5 and x < .5 then
										if y > 0 then
											direction = "Up"
										else
											direction = "Down"
										end
									elseif x > .5 then
										direction = "Right"
									elseif x < -.5 then
										direction = "Left"
									end
										
									if direction == "Right" then  --move left and right
										MoveSliderGamepad(1)
									elseif direction == "Left" then
										MoveSliderGamepad(-1)
									end	
								end
										
										
							else
								direction = nil
							end
						end
					end)
					
					
					
						
				end)
				
				selectionLost = dragger.SelectionLost:connect(function()
					if GamepadInputBegan then GamepadInputBegan:disconnect() end
					if GamepadInputChanged then GamepadInputChanged:disconnect() end

				end)
				
			end
			
			
			
		elseif not visible and window == windowData.Object then
			if inputChanged then inputChanged:disconnect() end
			if inputBegan then inputBegan:disconnect() end
			if inputEnded then inputEnded:disconnect() end
			if selectionGained then selectionGained:disconnect() end
			if selectionLost then selectionLost:disconnect() end
			if GamepadInputBegan then GamepadInputBegan:disconnect() end
			if GamepadInputChanged then GamepadInputChanged:disconnect() end


		end
	end)
	
	
	return this
	
	
end








return Slider
