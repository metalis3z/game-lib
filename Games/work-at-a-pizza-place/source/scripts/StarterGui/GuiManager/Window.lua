local Window = {}
local CAS = game:GetService("ContextActionService")
local UIS = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local player =  game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))
local BlurEffect = game.Lighting.Blur
local Tween = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Tween"))

local Menu = MainGui:WaitForChild("Menu")
local Backpack = Menu:WaitForChild("Backpack")
local ChatWindow = Menu:WaitForChild("ChatWindow")
local PlayerList = Menu:WaitForChild("PlayerList")
local ChatMenu = Menu:WaitForChild("ChatMenu")
local GamepadMoneyz = Menu:WaitForChild("GamepadMoneyz")
local Menu = Menu:WaitForChild("Menu")



Window.__index = Window

local DEFAULT_TWEEN_DURATION = .3
local DEFAULT_BLUR_SIZE = 20
local DEFAULT_TWEEN_STYLE = Enum.EasingStyle.Sine






function Window.new(guiManager,window,...)
	
	local args = {...}
	local easeInDirection,easeOutDirection,duration,easingStyle,blurEffect = args[1],args[2],args[3],args[4],args[5]
	
	local this = {}

	
	setmetatable(this, Window)
	this.Object = window
	this.Type = "Window"
	this.GuiManager = guiManager
	this.OriginalPosition = window.Position
	this.TweenDuration = duration or DEFAULT_TWEEN_DURATION
	this.TweenEasingStyle = easingStyle or DEFAULT_TWEEN_STYLE
	this.BlurEffectEnabled = blurEffect or false
	this.IgnoreBlurTween = false --if a new window is tweening and in and current one is tweening out, dont tween BlurEffect
	this.EaseInDirection = easeInDirection
	this.EaseOutDirection = easeOutDirection
	this.Disabled = false --another window is controlling the visiblity of this window, only that window can change the visiblity
	this.WindowsOverriding = {} --list of all the windows this window is controlling
	this.IsCoreGuiWindow = window == GamepadMoneyz or window == Backpack or window == PlayerList or window == ChatWindow or window == ChatMenu or window == Menu --dont allow these windows to controll ther windows when their visiblity changes
	this.TouchControls = {}
	this.GamepadActions = {}
	this.ButtonPopSoundConnections = {}
	this.LastSelection = nil  --reselect that item that was last selected before the window closed
	this.FirstSelectedObject = nil --first object to be selected when window first opens
	this.IsGamepadNavigateable = true --dialog, gamepad radial menu dont need guinaviation
	this.CanBeFocused = true --for notifications that dissapear automatically
	this.IsInteractableCoreGui = false --backpack, chatwindow
	this:UpdateTweenEndPoints()
	this.CanBeCanceled = true
	this.CancelButton = nil

	window.Visible = false
	

	
	--make window close with cancel button is pressed 
	if window:FindFirstChild("CancelButton") and not Enums.GamepadEnabled then
		this.CancelButton = window.CancelButton
		this.CancelButton.MouseButton1Click:connect(function()
			UIEvents.WindowManuallyClosed:Fire(window)
			this:SetVisible(false)
		end)
	--hide cancel button if gamepad enabled and show gamepad controll hints at the bottom of the window
	elseif Enums.GamepadEnabled and (window:FindFirstChild("CancelButton") or window.Name == "Settings" or window.Name == "PetPanel" or window.Name == "Emotions") then
		
		if window:FindFirstChild("CancelButton") then
			window.CancelButton.Visible = false
		end
		
		this:RegisterGamepadAction(Enum.KeyCode.ButtonB,function(action,state,inputObject)
			if state == Enum.UserInputState.Begin and this.CanBeCanceled then
				UIEvents.WindowManuallyClosed:Fire(window)
				this:SetVisible(false)
			end
		end)
		
		--show cancel b button hint at the bottom of all the windows
		if window.Name ~= "DialogBox" then
			local hint = script.CancelGamepadHint:clone()
			hint.Parent = window
			if hint.AbsolutePosition.Y + hint.AbsoluteSize.Y > MainGui.AbsoluteSize.Y then
				hint.AnchorPoint = Vector2.new(1,1)
				hint.Position = UDim2.new(1,0,0, -5)
			end
		end
		
	end
	
	--this:SetVisible(false)
	
	return this

end

--allow/dont allow window to be closed with B button or close button
function Window:CancelingEnabled(enabled)
	if Enums.GamepadEnabled then
		self.CanBeCanceled = enabled
		self.Object.CancelGamepadHint.Visible = enabled
	else
		self.CancelButton.Visible = enabled
	end
end


function Window:UpdateTweenEndPoints()
	
	self.OriginalPosition = self.Object.Position
	
	local easeInDirection = self.EaseInDirection 
	local anchorX = self.Object.AnchorPoint.X
	local anchorY = self.Object.AnchorPoint.Y

	if easeInDirection then					
		self.EaseInStartPosition = UDim2.new(
											--XScale
											(easeInDirection == "Left" or easeInDirection == "Right" and 0)   or   self.Object.Position.X.Scale ,
											--XOffset
											 (easeInDirection == "Left" and -(1-anchorX)*self.Object.AbsoluteSize.X)   or   (easeInDirection == "Right" and MainGui.AbsoluteSize.X + anchorX*self.Object.AbsoluteSize.X)   or   self.Object.Position.X.Offset ,
											--YScale
											 (easeInDirection == "Top" or easeInDirection == "Bottom" and 0)   or   self.Object.Position.Y.Scale ,
											--YOffset
											 (easeInDirection == "Top" and -(1-anchorX)*self.Object.AbsoluteSize.Y)   or   (easeInDirection == "Bottom" and MainGui.AbsoluteSize.Y + anchorX*self.Object.AbsoluteSize.Y)   or   self.Object.Position.Y.Offset
											)
	end
	
	local easeOutDirection = self.EaseOutDirection 
	if easeOutDirection then
		self.EaseOutEndPosition =  UDim2.new(
											--XScale
											(easeOutDirection == "Left" or easeOutDirection == "Right" and 0)   or   self.Object.Position.X.Scale ,
											--XOffset
											 (easeOutDirection == "Left" and -(1-anchorX)*self.Object.AbsoluteSize.X)   or   (easeOutDirection == "Right" and MainGui.AbsoluteSize.X + anchorX*self.Object.AbsoluteSize.X)   or   self.Object.Position.X.Offset ,
											--YScale
											 (easeOutDirection == "Top" or easeOutDirection == "Bottom" and 0)   or   self.Object.Position.Y.Scale ,
											--YOffset
											 (easeOutDirection == "Top" and -(1-anchorX)*self.Object.AbsoluteSize.Y)   or   (easeOutDirection == "Bottom" and MainGui.AbsoluteSize.Y + anchorX*self.Object.AbsoluteSize.Y)   or   self.Object.Position.Y.Offset
											)
	end
end


function Window:RegisterGamepadAction(GamepadButton,action)
	self.GamepadActions[GamepadButton] = action
end



function Window:GamepadActionsEnabled(enabled)
	for gamepadButton, action in pairs(self.GamepadActions) do
		local actionName = self.Object.Name .. tostring(gamepadButton)
		if enabled then
			CAS:BindAction(actionName, action, false, gamepadButton)
		else
			CAS:UnbindAction(actionName)
		end
	end
end

function Window:SetConsoleSize(size)
	if _G.GamepadEnabled then
		self.Object.Size = size
		self:UpdateTweenEndPoints()
	end
end

function Window:SetSize(size)
	Window.Size = size
	self:UpdateTweenEndPoints()
end




function HideOverlappingTouchControls(self,phantom)
	
	spawn(function()
		--let last window make the controls visible first
		wait()
		if game:GetService("UserInputService").TouchEnabled then
			local touchGui = PlayerGui:FindFirstChild("TouchGui")
			if touchGui then
				local touchFrame = touchGui:FindFirstChild("TouchControlFrame")
				if touchFrame then
					for _,control in ipairs(touchFrame:GetChildren()) do
						if control.Visible and Utility:GuiIsOverlapping(phantom,control) then
							control.Visible = false
							table.insert(self.TouchControls,control)
						end
					end
				end
			end
		end
	end)
end


function Window:GamepadCaptureFocus()

	local windowStack = self.GuiManager.WindowFocusStack
	
	--disable camera, walking, and jumping because some windows may have nothing to select with guinavigation
	if #windowStack == 0 then
		UIS.MouseIconEnabled = false
		GuiService.GuiNavigationEnabled = true
		CAS:BindAction("AButtonLock", function() end, false, Enum.KeyCode.ButtonA)
		CAS:BindAction("Thumbstick1Lock", function() end, false, Enum.KeyCode.Thumbstick1)
		--CAS:BindAction("Thumbstick2Lock", function() end, false, Enum.KeyCode.Thumbstick2)
		self.GuiManager:CoreGuiGamepadActionsEnabed(false)
		
	else
					
		windowStack[1].LastSelection = GuiService.SelectedObject --save selection of previous window
	end
		
	GuiService.SelectedObject = nil --reset selection		
				
	self:GamepadActionsEnabled(true)
	
	table.insert(windowStack,1,self)
				
		
	--if opened before, select where the player left off
	delay(self.TweenDuration,function()
		if windowStack[1] == self and self.IsGamepadNavigateable and not self.IsCoreGuiWindow then
			if self.LastSelection and self.LastSelection.Parent then
				GuiService.SelectedObject = self.LastSelection
						
			elseif self.FirstSelectedObject then
				GuiService.SelectedObject = self.FirstSelectedObject
			
							
			end
		end
	end)

end

function Window:GamepadLoseFocus()
	local windowStack = self.GuiManager.WindowFocusStack
	
	for i,windowData in ipairs(windowStack) do
		if windowData == self then
			table.remove(windowStack,i)
		end
	end
	self.LastSelection = GuiService.SelectedObject
				
	self:GamepadActionsEnabled(false)
	
	local previousWindow = windowStack[1]
	
				
	--allow player to move if all the windows have been closed
	if #windowStack == 0 then
		UIS.MouseIconEnabled = true
		GuiService.GuiNavigationEnabled = false
		CAS:UnbindAction("AButtonLock")
		CAS:UnbindAction("Thumbstick1Lock")
		CAS:UnbindAction("Thumbstick2Lock")
		GuiService.SelectedObject = nil
		self.GuiManager:CoreGuiGamepadActionsEnabed(true)
	
	elseif previousWindow.LastSelection and previousWindow.LastSelection.Parent then
		GuiService.SelectedObject = previousWindow.LastSelection
		
	elseif previousWindow.FirstSelectedObject and previousWindow.FirstSelectedObject.Parent then
		GuiService.SelectedObject = previousWindow.FirstSelectedObject
	
	else
		GuiService.SelectedObject = nil
	
	end
	
end


function Window:SetVisible(visible)
	local window = self.Object
	if not self.Disabled and window.Visible ~= visible then
		
		
		--GAMEPAD
		if _G.GamepadEnabled and not self.IsCoreGuiWindow and self.CanBeFocused then
			
			if visible then
				self:GamepadCaptureFocus()
			else
				self:GamepadLoseFocus()			
			end
		end
		
		
		
		--tween window open
		if visible and self.EaseInStartPosition then
			local currentPosition = window.AbsolutePosition
			window.Position = self.EaseInStartPosition
			window.Visible = true
			UIEvents.WindowVisibilityChanged:Fire(self.Object,true)
			
			--dont let coreguiwindows disable other windows
			if not self.IsCoreGuiWindow then
				
				--phantom appear where the window tween ends and is used to detect if overlapping windows
				local phantom = Instance.new("Frame")
				phantom.Size = self.Object.Size
				phantom.Position = self.OriginalPosition 
				phantom.BackgroundTransparency = 1
				phantom.Parent = self.Object.Parent
				phantom.AnchorPoint = self.Object.AnchorPoint
			
				
				HideOverlappingTouchControls(self,phantom)
				
				
				--sets the disabled propery of the core gui menus it overlaps and make visible = false
				for _,wind in ipairs({Backpack,PlayerList,ChatWindow,GamepadMoneyz}) do
					local windowData = self.GuiManager.Data[wind]
					if windowData.Object.Visible and windowData.Disabled == false then
						local phantom2 = Instance.new("Frame")
						phantom2.Size = windowData.Object.Size
						phantom2.Position = windowData.OriginalPosition 
						phantom2.BackgroundTransparency = 1
						phantom2.Parent = windowData.Object.Parent
						phantom2.AnchorPoint = self.Object.AnchorPoint
						if Utility:GuiIsOverlapping(phantom,phantom2) then
							windowData:SetVisible(false)
							windowData.Disabled = true
							table.insert(self.WindowsOverriding,wind)
						else
						end
						phantom2:Destroy()
					end
				end
				phantom:Destroy()
			end
			
			
			
			
			
			window:TweenPosition(self.OriginalPosition, Enum.EasingDirection.Out,self.TweenEasingStyle,self.TweenDuration,true)
			
			if self.BlurEffectEnabled then
				self.GuiManager:TouchControlsEnabled(false)
			end
			
			--tween blur if screen is not already blurred
			if self.BlurEffectEnabled and BlurEffect.Size == 0 then
				BlurEffect.Enabled = true
				Tween(BlurEffect,"Size","Number",0,DEFAULT_BLUR_SIZE,self.TweenDuration,"Linear","Out")
			end
			
			
			
		--tween window closed
		elseif not visible and self.EaseInStartPosition then
		
			for _,wind in ipairs(self.WindowsOverriding) do
				self.GuiManager.Data[wind].Disabled = false
				self.GuiManager.Data[wind]:SetVisible(true)
			end
			self.WindowsOverriding = {}
			
			for _,control in ipairs(self.TouchControls) do
				control.Visible = true
			end
			self.TouchControls = {}
			
			
			window:TweenPosition(self.EaseOutEndPosition, Enum.EasingDirection.In,self.TweenEasingStyle,self.TweenDuration,true,function()
				window.Position = self.OriginalPosition
				window.Visible = false
				UIEvents.WindowVisibilityChanged:Fire(self.Object,false)

			end)
			
			if self.BlurEffectEnabled then
				if self.IgnoreBlurTween then --dont tween blur just one time
					self.IgnoreBlurTween = false
					return
				end
				Tween(BlurEffect,"Size","Number",BlurEffect.Size,0,self.TweenDuration,"Linear","Out"):connect(function()
					
					BlurEffect.Enabled = false
				end)
				wait(self.TweenDuration)
				self.GuiManager:TouchControlsEnabled(true)
			end
			
			
			
		--dont tween window, just make visible/invisible
		else  
			
			window.Visible = visible
			
			UIEvents.WindowVisibilityChanged:Fire(self.Object,visible)
			
			if self.BlurEffectEnabled then
				BlurEffect.Size = DEFAULT_BLUR_SIZE
				BlurEffect.Enabled = visible
			end
			
		end
		
		
		--connect and disconnect the button pop sounds when visiblibt changes
		if visible then
			
			local function connecter(dir)
				if not dir:FindFirstChild("PopSoundDisabled") then
					for i,v in ipairs(dir:GetChildren()) do	
						if v:IsA("TextButton") or v:IsA("ImageButton") then
							self.ButtonPopSoundConnections[v] = v.MouseButton1Click:connect(function() SoundFX:PlaySound("Pop3") end)
						elseif v:IsA("Frame") or v:IsA("ScrollingFrame") or v:IsA("Folder") then
							connecter(v)
						end
					end
				end
			end
			connecter(self.Object)
			
			
			local function decAdded(dec)
				wait()
				if dec:IsA("TextButton") or dec:IsA("ImageButton") and not dec.Parent:FindFirstChild("PopSoundDisabled")  then
					self.ButtonPopSoundConnections[dec] = dec.MouseButton1Down:connect(function() SoundFX:PlaySound("Pop3") end)
				end
			end
			
			local function decRemoved(dec)
				wait()
				if dec:IsA("TextButton") or dec:IsA("ImageButton") and self.ButtonPopSoundConnections[dec] then
					self.ButtonPopSoundConnections[dec]:disconnect()
					self.ButtonPopSoundConnections[dec] = nil
				end
			end
			
			self.ButtonPopSoundConnections[self.Object] = self.Object.DescendantAdded:connect(decAdded)
			self.ButtonPopSoundConnections[self.Object] = self.Object.DescendantRemoving:connect(decRemoved)
		
			
		else
			for object,connection in pairs(self.ButtonPopSoundConnections) do
				connection:disconnect()
			end
			self.ButtonPopSoundConnections = {}
		end

		
	end
	
	
end



function Window:IsOverlapping(otherWindow)
	 return Utility:GuiIsOverlapping(self.Object,otherWindow)
end






return Window 
