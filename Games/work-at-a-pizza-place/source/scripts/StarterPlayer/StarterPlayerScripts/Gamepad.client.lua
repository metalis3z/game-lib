local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))

if not Enums.GamepadEnabled then
	return
end

local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local Menu =  MainGui:WaitForChild("Menu"):WaitForChild("Menu")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("UIEvents")

local openWindows = {}
local lastWindowData
local GamepadMainMenu = MainGui.Menu:WaitForChild("GamepadMainMenu")
local WindowData = GuiManager:GetWindowDataByName("GamepadMainMenu")


local MenuGamepadHelp = MainGui:WaitForChild("Notifications"):WaitForChild("MenuGamepadHelp")
local EmoteGamepadHelp = MainGui:WaitForChild("Notifications"):WaitForChild("EmoteGamepadHelp")
local ChatGamepadHelp = MainGui:WaitForChild("Menu"):WaitForChild("ChatWindow"):WaitForChild("ChatGamepadHelp")




game:GetService("GuiService").GuiNavigationEnabled = false
game:GetService("GuiService").AutoSelectGuiEnabled = false
game:GetService("GuiService").CoreGuiNavigationEnabled = false

function MenuButtonPressed(actionName,InputState,InputObject)
	
	if InputState == Enum.UserInputState.Begin and _G.StartedPlaying then
	
	 	local visible = not GamepadMainMenu.Visible	
		
		if visible then
			GuiManager:CloseAllWindows()
		end
				
				
		WindowData:SetVisible(visible)

		if _G.TutorialEnabled then
			workspace.TutorialService.PlayerAction:FireServer("RadialMenuOpened",true)
		end
		
		
		if not visible then
			--cancel selection if menu button is pressed again
			if GuiManager[GamepadMainMenu].SelectionMode then
				GuiManager[GamepadMainMenu]:CancelSelection()
			end
		end
	end
	
end


game:GetService("ContextActionService"):BindAction("MenuButtonPressed", MenuButtonPressed, false, Enum.KeyCode.ButtonSelect,Enum.KeyCode.ButtonL2)









--[[
	Glee
	Sad
	Angry
	Laugh
	
	Scared
	Amazed
	Confused
	Think
	
	Hi
	Bye
	Point
	Cheer
	
	Dance
	Dance1
	Dance2
	Dance3
	Trip
	
]]


local EmotesDpadHint = MainGui:WaitForChild("Notifications"):WaitForChild("EmotesDpadHint")

local Mapping = {
	Left = {Left = "Amazed",Right = "Scared",Up = "Confused",Down = "Think"},
	Right = {Left = "Sad",Right = "Glee",Up = "Angry",Down = "Laugh"},
	Up = {Left = "Cheer",Right = "Point",Up = "Hi",Down = "Bye"},
	Down = {Left = "Dance2",Right = "Dance3",Up = "Dance",Down = "Trip"},
}

local CurrentGroup = nil
local version = 0

function DpadPressed(buttonName,InputState,InputObject)
	
	if InputState == Enum.UserInputState.Begin then
		GuiManager:GetWindowDataByName("Emotions"):SetVisible(true)
	end


	
	--when player chooses a category
	--[[if InputState == Enum.UserInputState.Begin then
		if not CurrentGroup then
			
			CurrentGroup = buttonName
			EmotesDpadHint.Visible = true
			
			--set the dpad labels
			for _,obj in ipairs(EmotesDpadHint:GetChildren()) do
				if obj:IsA("TextLabel") then
					obj.Text = Mapping[buttonName][obj.Name]
				end
			end
			
			--exipre hint after 5 seconds
			version = version + 1
			local currentVersion = version
			delay(3,function()
				if version == currentVersion then
					CurrentGroup = nil
					EmotesDpadHint.Visible = false
				end
			end)
			
		--when player chooses an emotion
		elseif CurrentGroup then
			EmotesDpadHint.Visible = false
			version = version + 1
			game.Workspace.Main.InvokeEmotion.InvokeEmotion:Fire(Mapping[CurrentGroup][buttonName])	
			CurrentGroup = nil
	
		end
	end]]
end


game:GetService("ContextActionService"):BindAction("Left", DpadPressed, false, Enum.KeyCode.DPadLeft)
game:GetService("ContextActionService"):BindAction("Right", DpadPressed, false, Enum.KeyCode.DPadRight)
game:GetService("ContextActionService"):BindAction("Up", DpadPressed, false, Enum.KeyCode.DPadUp)
game:GetService("ContextActionService"):BindAction("Down", DpadPressed, false, Enum.KeyCode.DPadDown)







--[[
local visible = false
local function ShowConsole(action,state,inputObject) 
	
	if state == Enum.UserInputState.Begin and Enums.Admins[player.Name] then
		--GuiManager:GetWindowDataByName("Emotions"):SetVisible(true)
		
		visible = not visible
		game:GetService("GuiService").AutoSelectGuiEnabled = visible
		game:GetService("GuiService").CoreGuiNavigationEnabled = visible
		
		game:GetService("GuiService").AutoSelectGuiEnabled = visible
		game.StarterGui:SetCore("DeveloperConsoleVisible", visible)
	end
end

if Enums.Admins[player.Name] then
	game:GetService("ContextActionService"):BindAction("LeftTrigger", ShowConsole, false, Enum.KeyCode.)
end]]






	
	
	
spawn(function()
	while not _G["StartedPlaying"] do
		wait(.1)
	end
	ChatGamepadHelp.Visible = true
	EmoteGamepadHelp.Visible = true
	MenuGamepadHelp.Visible = true
end)
	
	
