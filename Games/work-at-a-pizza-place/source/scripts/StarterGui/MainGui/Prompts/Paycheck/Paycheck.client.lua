local Window = script.Parent
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Queue = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Queue"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))


local windowData = GuiManager:RegisterWindow(Window,"Left","Right",.6,Enum.EasingStyle.Linear,true)
windowData.IsGamepadNavigateable = false
local menuData = GuiManager:GetWindowDataByName("Menu")



local CashOut = Window:WaitForChild("CashOut")
local AButton = Window:WaitForChild("AButton")
local Title = Window:WaitForChild("Title")
local Check = Window:WaitForChild("Check")
local Amount = Check:WaitForChild("Amount"):WaitForChild("Box"):WaitForChild("Moneyz")
local Date = Check:WaitForChild("Date"):WaitForChild("Date")
local For = Check:WaitForChild("For"):WaitForChild("For")
local PlayerName = Check:WaitForChild("To"):WaitForChild("PlayerName")


local os = require(game.ReplicatedStorage.Utilities.GetDate)
local date = os.date()




local checkTypes = {
	["Daily Check"] = {For = "joining the game today", BackgroundColor = Color3.new(255/255,185/255,185/255)},
	["Paycheck"] = {For = "working", BackgroundColor = Color3.new(255/255,255/255,255/255)},
	["Bonus Check from Manager"] = {For = "being a good worker", BackgroundColor = Color3.new(169/255,230/255,255/255)},
	["Starter Check"] = {For = "playing for the first time", BackgroundColor = Color3.new(255/255,255/255,255/255)},
	["Moneyz Purchase Check"] = {For = "buying moneyz", BackgroundColor = Color3.new(140/255, 255/255, 114/255)},
}

local NUM_COIN_SOUNDS = 10
local coins = {}
local coin = SoundFX:GetSoundObject("Coin")

for i=1,NUM_COIN_SOUNDS do
	local coinSound = coin:clone()
	coinSound.Parent = Window
	table.insert(coins,coinSound)
end


local MoneyzIcon = (_G.GamepadEnabled and MainGui.Menu:WaitForChild("GamepadMoneyz"):WaitForChild("Icon")) or MainGui.Menu:WaitForChild("Menu"):WaitForChild("Moneyz"):WaitForChild("Icon")


local coinSoundIndex = 1
local cashingOut = false

local PaycheckQueue = Queue.new()

function ShowCheck(amount,checkType)
	
	
	
	while _G["StartedPlaying"] == nil do wait(.5) end
	
	PaycheckQueue:Wait()

	workspace.Main.FadeMusic.FadeMusic:Invoke("Out",true) --wait for music to fade out
	
	SoundFX:PlaySound("Paycheck")
	
	
	
	Check.BackgroundColor3 = checkTypes[checkType].BackgroundColor
	For.Text = checkTypes[checkType].For
	Amount.Text = tostring(amount) .. ".00"
	PlayerName.Text = player.Name
	Date.Text = date.month .. "/" .. date.day .. "/" .. date.year
	Title.Text = checkType
	
	windowData:SetVisible(true) --show check

	if not Enums.GamepadEnabled then
		CashOut.MouseButton1Click:wait()  --wait for player to click cashout
	else
		--wait for A button to be pressed
		cashingOut = false
		CashOut.Visible = false
		AButton.Visible = true
		while not cashingOut do
			wait(.1)
		end
	end
	
	if checkType == "Starter Check" then
		menuData:SetVisible(true)
	end
	
	local countdownSpeed = 0.1  --decreases
	local countdownIncrement = 3  --3--increases
	
	local loopCount = 1
	local i = amount
	local goalAmount = player.Moneyz.Value + amount
	

	while i > 0 do
	
	
		
			Amount.Text = tostring(i) .. ".00"
			
			local currentIncrement = (i < countdownIncrement and i) or countdownIncrement
			local currentIndex = i
			Utility:TweenAbsolutePosition(MainGui,MoneyzIcon,Amount.AbsolutePosition + Vector2.new(math.random(0,Amount.AbsoluteSize.X),0) ,MoneyzIcon.AbsolutePosition,"Out","Sine",.5,function()
				--restart index of coinsound lists
				if coinSoundIndex > NUM_COIN_SOUNDS then
					coinSoundIndex = 1
				end
				coins[coinSoundIndex].Pitch = 1.005 - (countdownSpeed/20)
				coins[coinSoundIndex]:Play()
				coinSoundIndex = coinSoundIndex + 1
				
				player.Moneyz.Value = player.Moneyz.Value + currentIncrement
				
				
				countdownSpeed = countdownSpeed - 0.005
				
				--skip to the end if increment is greater than whats left
				if currentIndex < countdownIncrement then
					player.Moneyz.Value = goalAmount
				end
			end)
			
		
		
		
		--incraese value of each coin
		if math.floor(loopCount/20) == loopCount/20 then
			countdownIncrement = countdownIncrement + loopCount
		end 
		
		if i <= countdownIncrement then
			Amount.Text = "0.00"
			break
		end
		
		
		
		i = i - countdownIncrement
		loopCount = loopCount + 1
		
		
		
		wait(countdownSpeed)
	end
	
	
	
	wait(1)

	
	windowData:SetVisible(false)
	
	workspace.Main.GivePaycheck:FireServer(checkType)   --tell sever finished cashing
	
	workspace.Main.FadeMusic.FadeMusic:Invoke("In",true)
	
	
	PaycheckQueue:Next()
end

workspace.Main.GivePaycheck.OnClientEvent:connect(ShowCheck)





UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	
	if window == Window and visible then
		
		--game:GetService("ContextActionService"):BindAction("openDoor", openDoorFunction, false, Enum.KeyCode.ButtonA)
		
	elseif window == Window and not visible then

	end
end)



windowData:RegisterGamepadAction(Enum.KeyCode.ButtonA, function()
	cashingOut = true
	AButton.Visible = false
end)

--[[
wait(2)

spawn(function()
	ShowCheck(1000,"Starter Check")
end)


wait(20)
ShowCheck(11000,"Starter Check")
ShowCheck(40000,"Starter Check")




wait(5)
ShowCheck(500,"Daily Check")

]]

