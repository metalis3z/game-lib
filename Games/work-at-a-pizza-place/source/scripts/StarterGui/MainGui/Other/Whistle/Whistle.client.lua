local Window = script.Parent

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local UIS = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")


local player = game.Players.LocalPlayer
local Notes = Window:WaitForChild("Notes")
local WindowData = GuiManager:RegisterWindow(Window,"Bottom","Bottom")
WindowData.IsGamepadNavigateable = false
WindowData.CanBeFocused = false
local Template = Window:WaitForChild("Template")
local keyCodes = {Enum.KeyCode.Backquote ,Enum.KeyCode.One,Enum.KeyCode.Two,Enum.KeyCode.Three,Enum.KeyCode.Four,Enum.KeyCode.Five,Enum.KeyCode.Six,Enum.KeyCode.Seven,Enum.KeyCode.Eight,Enum.KeyCode.Nine,Enum.KeyCode.Zero,Enum.KeyCode.Minus,Enum.KeyCode.Equals, Enum.KeyCode.Backspace}
local noteIds = {869111684,869112058,868964990,868965072,868965201,868965292,868965388,868965458,868965559,868965711,868965797,868965936,869111262,869111431}
local noteNames = (UIS.KeyboardEnabled and {"`","1","2","3","4","5","6","7","8","9","0","-","+","Bksp"}) or {"D","E","F","G","A","B","C","D","E","F","G","A","B","C"}
local noteButtons = {}
local noteSoundObjects = {}
local noteSoundObjectsSecondary = {} --if same note is already being played
local soundLengths = {}
local noteDebounces = {}
local debounce = false
local NOTE_DURATION = .15
local NUM_NOTES = 14
local BUFFER_DELAY = .45 --seconds

local lastNotePlayed = tick()


local lastHighlight = nil

function HighlightNote(index)
	if lastHighlight then
		lastHighlight.Style = "RobloxRoundButton"
	end
	local button = noteButtons[index]
	button.Style = "RobloxRoundDefaultButton"
	lastHighlight = button
	
	if not _G.GamepadEnabled then
		delay(NOTE_DURATION,function()
			if button.Style == "RobloxRoundDefaultButton" then
				lastHighlight = nil
				button.Style = "RobloxRoundButton"
			end
		end)
	end
end

local function PlayNote(index)
	if not debounce then
		debounce = true
		HighlightNote(index)
		
		local delta
		if tick() - lastNotePlayed >= BUFFER_DELAY then
			delta = 0
		else
			delta = tick() - lastNotePlayed
		end
		
		lastNotePlayed = tick()
		
		--[[if player.Character.Name == "Dued1" then
			local t = tick()
			workspace.Main.GetPing:InvokeServer()
			print(tick() - t,"Ping")
		end]]
		
		workspace.Main.WhistleNotePlayed:FireServer(delta,player.Character.Head,noteIds[index])
		
		if not noteSoundObjects[index].IsPlaying then
			noteSoundObjects[index]:Play()
		elseif not noteSoundObjectsSecondary[index].IsPlaying then  --if secondary is already being played, the primary is probably farther ahead
			noteSoundObjectsSecondary[index]:Play()
		else
			noteSoundObjects[index]:Play() 
		end
		
		wait(NOTE_DURATION)
		debounce = false
	end
end

--crete sound objects for each list
for _,list in ipairs({noteSoundObjects,noteSoundObjectsSecondary}) do
	for _,id in ipairs(noteIds) do
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://" .. id
		sound.Volume = 1
		sound.Parent = player.Character.Head
		table.insert(list,sound)
	end
end

for i,name in ipairs(noteNames) do
	local button  = Template:clone()
	button.Visible = true
	button.Text = name
	button.Parent = Notes
	button.MouseButton1Click:connect(function()
		PlayNote(i)
	end)
	table.insert(noteButtons,button)
end




local bindingNames = {}
local gamepadSelectedIndex = 1
local windowOpen = false



function HookEvents()
	if UIS.KeyboardEnabled and not _G.GamepadEnabled then
		for index,keycode in ipairs(keyCodes) do
			CAS:BindAction("NoteButton" .. tostring(index), function(action,state,inputObject) 
				if state == Enum.UserInputState.Begin then
					PlayNote(index)
				end
			end, false, keycode)
			table.insert(bindingNames,"NoteButton" .. tostring(index))
		end
		
		
	elseif _G.GamepadEnabled then
		
		gamepadSelectedIndex = 1
		local lastSelectedIndex = 1
		HighlightNote(gamepadSelectedIndex)
		
		CAS:BindAction("NoteHighlighter", function(action,state,inputObject) 
			gamepadSelectedIndex = math.floor(Utility:ConvertScale(inputObject.Position.X,{-1,1},{1,NUM_NOTES}))
			print(gamepadSelectedIndex)
			if gamepadSelectedIndex ~= lastSelectedIndex then
				HighlightNote(gamepadSelectedIndex)
				lastSelectedIndex = gamepadSelectedIndex
			end
		end, false, Enum.KeyCode.Thumbstick1)
		
		CAS:BindAction("CloseWindow", function(action,state,inputObject) 
			if state == Enum.UserInputState.Begin then
				WindowData:SetVisible(false)
			end

		end, false, Enum.KeyCode.ButtonB)
		
		CAS:BindAction("PlayNote", function(action,state,inputObject) 
			if state == Enum.UserInputState.Begin then
				PlayNote(gamepadSelectedIndex)
			end
		end, false, Enum.KeyCode.ButtonA)
		
		table.insert(bindingNames,"PlayNote")
		table.insert(bindingNames,"CloseWindow")
		table.insert(bindingNames,"NoteHighlighter")

	end
	
	
	spawn(function()
		while windowOpen do
			local particle = player.Character:FindFirstChild("Whistle")
			if particle then

				if tick() - lastNotePlayed > 1 and particle.Whistle.Enabled  then
					particle.Whistle.Enabled = false
				elseif tick() - lastNotePlayed <= 1 and not particle.Whistle.Enabled then
					particle.Whistle.Enabled = true
				end
			end
			wait(.1)
		end
	end)
	
end


local noteQues = {}
local activeQueIndexes = {}
local localplayer = game.Players.LocalPlayer



workspace.Main.WhistleNotePlayed.OnClientEvent:connect(function(player,deltaTime,head,soundId)

	if localplayer ~= player and localplayer:DistanceFromCharacter(head.Position) < 200 then
		
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://" .. soundId
		sound.Volume = 1
		sound.Parent = player.Character.Head
		
		
		noteQues[player] = noteQues[player] or {}
	
	
		table.insert(noteQues[player],{Delay = deltaTime,Sound  = sound})
		
		
		if not activeQueIndexes[player] then 

			activeQueIndexes[player] = true
			
			wait(BUFFER_DELAY)
			
			while #noteQues[player] > 0 do

				local Delay = noteQues[player][1].Delay
				local Sound = noteQues[player][1].Sound
				
				wait(Delay)
				
				if Sound and Sound.Parent then
					Sound:Play()
				end
				
				delay(2,function()  --cleanup
					if Sound and Sound.Parent then
						sound:Destroy()
					end
				end)

				table.remove(noteQues[player],1)
			end

			activeQueIndexes[player] = false
		end
		
	end
end)



workspace.Animation.AnimationStarted.AnimationStarted.Event:connect(function(animationName)
	if animationName == "Whistle" then
		WindowData:SetVisible(true)
	end
end)

local animationEnded = false
workspace.Animation.AnimationStopped.AnimationStopped.Event:connect(function(animationName)
	if animationName == "Whistle" then
		animationEnded = true
		WindowData:SetVisible(false)
	end
end)


local lastSelection = nil 


UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)

	if window == Window then
		windowOpen = visible
		if _G.GamepadEnabled then
			game:GetService("GuiService").GuiNavigationEnabled = not visible
			if visible then
				lastSelection = game:GetService("GuiService").SelectedObject
				game:GetService("GuiService").SelectedObject = nil
			else
				game:GetService("GuiService").SelectedObject = lastSelection
				lastSelection = nil
			end

		end
		if visible then
			game:GetService("GuiService").SelectedObject = nil
			HookEvents()
			workspace.Main.FadeMusic.FadeMusic:Invoke("Out",false)
			Utility:Preload(noteIds)
		else
			if not animationEnded then --if player closed the window, stop the whistle animation
				workspace.Animation.StopAnimation.StopAnimation:Fire("Whistle",.1)
				
				animationEnded = false --reset for next window close
			end
			for _,actionName in ipairs(bindingNames) do
				CAS:UnbindAction(actionName)
			end
			workspace.Main.FadeMusic.FadeMusic:Invoke("In",false)
		end
	end
end)










