local Window = script.Parent
local MenuFolder = Window.Parent
local Emotions = Window:WaitForChild("Emotions")
local Inventory = Window:WaitForChild("Inventory")
local Pets = Window:WaitForChild("PetPanel")
local Ratings = Window:WaitForChild("Ratings")
local Settings = Window:WaitForChild("Settings")
local Upgrade = Window:WaitForChild("Upgrade")
local Catalog = Window:WaitForChild("Catalog")
local Leave = Window:WaitForChild("Leave")
local Teleport = Window:WaitForChild("Teleport")



local player = game.Players.LocalPlayer
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))

local Moneyz = (_G.GamepadEnabled and MenuFolder:WaitForChild("GamepadMoneyz")) or Window:WaitForChild("Moneyz")
local WindowData = GuiManager:RegisterWindow(Window)
local GamepadMoneyzWindowData = GuiManager:GetWindowDataByName("GamepadMoneyz")


WindowData:SetVisible(true)

if _G.GamepadEnabled then
	GamepadMoneyzWindowData:SetVisible(true)
end

if Enums.IsPartyServer then
	Leave.Visible = true
	Teleport.Visible = true
	Window.Size = UDim2.new(0,450,0,36)
	Window.UIListLayout:ApplyLayout() 
end



local touchEnabled = game:GetService("UserInputService").TouchEnabled 


--put in the topbar area
Window.Position = UDim2.new(Window.Position.X.Scale, Window.Position.X.Offset,0, -36)


for _,obj in ipairs(Window:GetChildren()) do
	if obj:IsA("TextButton") then
		GuiManager:RegisterTopbarButton(obj)
	end
end



local currentButton = nil
local lastWindowData = nil
local lastButton = nil




function ButtonPressed(button)
	
	if button.Parent == Window then
		
		
		local buttonName = button.Name
		
		--open catalog when moneyz counter is pressed
		if button.Name == "Moneyz" then 
			buttonName = "Catalog"
			delay(.1,function()
				local catalogObject = GuiManager:GetWindowDataByName("Catalog").Object
				GuiManager.Data[catalogObject.Tabs]:SetFirstTabPressed(catalogObject.Tabs.Moneyz) --sets tab to moneyz section
			end)
		elseif button.Name == "Leave" then
			if Dialog:GetChoice("Leave party island", "Are you sure you want to go back to the Pizza Place?","Yes","No") then
				game:GetService("TeleportService"):Teleport(Enums.MainGameId,player)
			end
			button.Selected = false

			return
				
		elseif button.Name == "Teleport" then
			if Dialog:GetChoice("Teleport", "Are you sure you want to teleport to your house?","Yes","No") then
				
				Utility:SendData("TeleportHome","PlayerChannel",nil,nil)
			end
			button.Selected = false
			return
		end
		
		
		
		local windowData = GuiManager:GetWindowDataByName(buttonName)
		
		
		
		currentWindow = windowData.Object
		button.Selected = true

		windowData:SetVisible(not windowData.Object.Visible) --toggle visible
		
	
		--if the next and previous window both have blur, then dont tween the blur

		
		if lastWindowData and lastWindowData ~= windowData then
			if windowData.BlurEffectEnabled and button ~= lastButton and lastWindowData and lastWindowData.BlurEffectEnabled and lastWindowData.Object.Visible then
				lastWindowData.IgnoreBlurTween = true
			end
			
			lastWindowData:SetVisible(false)

		end
		
		lastWindowData = windowData
		
		if lastButton and button ~= lastButton then
			lastButton.Selected = false
		end
		
		lastButton = button
	
	end
end



UIEvents.TopbarButtonPressed.Event:connect(
	Utility:Debounce(function(button)  --emulator registers both clicks and taps  at the same time - need to let only one of the events through - 
		ButtonPressed(button) 
		wait() 
	end) 
)


local ChatMenu = MainGui.Menu:WaitForChild("ChatMenu")
local OriginalPosition = Window.Position
--move so it is not on top of the chat menu buttons
local function RealighMenu()
	Window.Position = OriginalPosition
	if WindowData:IsOverlapping(ChatMenu) then
		Window.Position = UDim2.new(0, ChatMenu.Position.X.Offset + ChatMenu.Size.X.Offset,OriginalPosition.Y.Scale,OriginalPosition.Y.Offset)
	end
end

--when window is closed, deselect menu button
UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	if lastWindowData and window == lastWindowData.Object and not visible then
	
		currentWindow = nil
		lastButton.Selected = false
	elseif window == Window and visible then
		RealighMenu()
	end
end)




MainGui.Changed:connect(function(prop)
	if prop == "AbsoluteSize" then
		RealighMenu()
	end
end)

RealighMenu()


local OriginalLength = Window.Size.X.Offset
local MoneyzCount = Moneyz.MoneyzCount
local Overflow1 = script.Parent.Parent:WaitForChild("Catalog"):WaitForChild("MoneyzOverflow"):WaitForChild("MoneyzCount")
local Overflow2 = script.Parent.Parent:WaitForChild("Upgrade"):WaitForChild("MoneyzOverflow"):WaitForChild("MoneyzCount")
local Overflow3 = MainGui:WaitForChild("Prompts"):WaitForChild("Paycheck"):WaitForChild("MoneyzOverflow"):WaitForChild("MoneyzCount")
local OverflowEnabled = false

--update moneyz counter

function MoneyzChanged()
	if not string.match(tostring(player.Moneyz.Value),",") then --if commas have not been added to text
	
		local money = Utility:AddCommas(player.Moneyz.Value)
		if not OverflowEnabled then
			MoneyzCount.Text = money
		else
			Overflow1.Text = money
			Overflow2.Text = money
			Overflow3.Text = money
			return
		end
		
			
		if not Moneyz.MoneyzCount.TextFits then
			local PADDING = 8
			local ICON_PADDING_GAMEPAD = 15
			
			if _G.GamepadEnabled then
				Moneyz.Size = UDim2.new(0, Moneyz.MoneyzCount.TextBounds.X + Moneyz.Icon.AbsoluteSize.X + ICON_PADDING_GAMEPAD,0,50)
				return
			end


			Window.Size = UDim2.new(0,OriginalLength + Moneyz.MoneyzCount.TextBounds.X + PADDING,0,36)
			
			if _G.GamepadEnabled then return end --dont need to do anthing else
			
			wait()
			Moneyz.Size =  UDim2.new(0, (Window.AbsolutePosition.X + Window.AbsoluteSize.X) - Moneyz.AbsolutePosition.X,0,36)
			
			Window.Position = UDim2.new(0.5,-Window.Size.X.Offset/2,0,-36)
			OriginalPosition = Window.Position
			RealighMenu()
		end
		
		if _G.GamepadEnabled then return end --dont need to do anthing else

		
		--make room by removing the icon
		if Moneyz.AbsolutePosition.X + Moneyz.AbsoluteSize.X > MainGui.AbsoluteSize.X then
			Moneyz.Icon.Visible = false
			MoneyzCount.Size = UDim2.new(1,0,1,0)
			MoneyzCount.Position = UDim2.new(0,0,0,0)
			Moneyz.Size = UDim2.new(0, MainGui.AbsoluteSize.X - Moneyz.AbsolutePosition.X,0,36)
		end
		
		--if there stil isnt enough room, make the text scale
		if not MoneyzCount.TextFits and not Moneyz.Icon.Visible then
			MoneyzCount.TextScaled = true
			wait() --let text resize
		end
		
		
		--if moneyz count scaled text is too small or the entire moneyz icon is offscreen
		if (Moneyz.AbsolutePosition.X > MainGui.AbsoluteSize.X or MoneyzCount.TextBounds.Y < 20 or MoneyzCount.TextWrapped) and not OverflowEnabled then
			Moneyz.Visible = false
			Overflow1.Parent.Visible = true
			Overflow2.Parent.Visible = true
			Overflow3.Parent.Visible = true
			
			OverflowEnabled = true
			
			MoneyzChanged()
		end
		
	end
end

player:WaitForChild("Moneyz").Changed:connect(function()
	MoneyzChanged()
end)

MoneyzChanged()


if Enums.GamepadEnabled then
	WindowData:SetVisible(false)
	WindowData.Disabled = true
	--MainGui:WaitForChild("Notifications"):WaitForChild("GamepadMenuNotification").Visible = true
end


