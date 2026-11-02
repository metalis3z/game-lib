local Window = script.Parent
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Tween = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Tween"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))


local Add10 = Window:WaitForChild("Add10")
local Add100 = Window:WaitForChild("Add100")
local Add1000 = Window:WaitForChild("Add1000")
local Add10000 = Window:WaitForChild("Add10000")
local Get = Window:WaitForChild("Get")
local Basement = Window:WaitForChild("Basement")



local CurrentUpgrade = Window:WaitForChild("CurrentUpgrade")
local NextUpgrade = Window:WaitForChild("NextUpgrade")


local MenuMoneyzIcon = (Enums.GamepadEnabled and MainGui.Menu:WaitForChild("GamepadMoneyz"):WaitForChild("Icon")) or MainGui.Menu:WaitForChild("Menu"):WaitForChild("Moneyz"):WaitForChild("Icon")


local ProgressBar = Window:WaitForChild("ProgressBar")
local Bar = ProgressBar:WaitForChild("Bar")
local BackgroundBar = ProgressBar:WaitForChild("BackgroundBar")
local MoneyzIcon = Bar:WaitForChild("MoneyzIcon")
local Moneyz = player:WaitForChild("Moneyz")


local windowData = GuiManager:RegisterWindow(Window,"Left","Right",nil,nil,true)
windowData:SetConsoleSize(UDim2.new(0,654,1,0))
windowData.FirstSelectedObject = Add10 --first item for gamepad



local upgradeName,progress = Utility:SendData("GetUpgrade","PlayerChannel",10) --or Utility:SendData("GetUpgrade","PlayerChannel",10)

if upgradeName == nil then
	upgradeName,progress = Utility:SendData("GetUpgrade","PlayerChannel",10)
	if upgradeName == nil then return end
end

BAR_SIZE = Bar.AbsoluteSize.Y




local CurrentAmount = progress
local GoalAmount = Enums.UpgradePrices[Enums.NextUpgradeName[upgradeName]]



local MaxAlpha = BAR_SIZE / BackgroundBar.AbsoluteSize.X  --shorten the bar by the width of the coin

local bufferAmount = CurrentAmount



function ShowFullyUpgraded()
	Basement.Visible = false
	Window:WaitForChild("FullyUpgraded").Visible = true
	NextUpgrade.Visible = false
	Add100.Visible = false
	Add1000.Visible = false
	Add10000.Visible = false	
	Add10.Visible = false
	CurrentUpgrade.Visible = false
	NextUpgrade.Visible = false
	ProgressBar.Visible = false
	Get.Visible = false
	windowData.FirstSelectedObject = Basement
end



local OriginalGoalPosition = BackgroundBar.GoalAmount.Position


function UpdateProgressBar()
	local alpha = Utility:ConvertScale(CurrentAmount,{0,GoalAmount},{0,1-MaxAlpha})
	
	if alpha >= 0 and alpha <= 1 then
		Bar.Size = UDim2.new(alpha,BAR_SIZE,1,0)
		Bar.CurrentAmount.Text = tostring(CurrentAmount)
		BackgroundBar.GoalAmount.Text = tostring(GoalAmount)
		
		if Bar.CurrentAmount.AbsolutePosition.X +  Bar.CurrentAmount.AbsoluteSize.X > BackgroundBar.GoalAmount.AbsolutePosition.X then
			BackgroundBar.GoalAmount.Position = UDim2.new(1,BackgroundBar.GoalAmount.AbsoluteSize.X,0,-BackgroundBar.GoalAmount.AbsoluteSize.Y)
		else
			BackgroundBar.GoalAmount.Position = OriginalGoalPosition
		end
	end
end


function UpdateHouseImages()
	CurrentUpgrade.Image = "http://www.roblox.com/thumbs/asset.ashx?x=100&y=100&format=png&assetid=" .. Enums.HouseImages[upgradeName]
	CurrentUpgrade.UpgradeName.Text = Enums.ExtendedHouseName[upgradeName]
	
	local nextUpgradeName = Enums.NextUpgradeName[upgradeName]
	NextUpgrade.Image = "http://www.roblox.com/thumbs/asset.ashx?x=100&y=100&format=png&assetid=" .. Enums.HouseImages[nextUpgradeName]
	NextUpgrade.UpgradeName.Text = Enums.ExtendedHouseName[nextUpgradeName]

end



function ResetProgress()
	local newUpgradeIndex = Enums.UpgradeNameToIndex[upgradeName]+1
	local newUpgradeName = Enums.NextUpgradeName[upgradeName]
	upgradeName = Enums.HouseSizes[newUpgradeIndex]

	if upgradeName then
		CurrentAmount = 0
		local nextUpgrade = Enums.NextUpgradeName[newUpgradeName]
		GoalAmount = Enums.UpgradePrices[nextUpgrade]
		bufferAmount = 0	
		UpdateHouseImages()
		UpdateProgressBar()
		
		--after tweening off screen
		delay(2,function()
			Add100.Visible = true
			Add1000.Visible = true
			Add10000.Visible = true
		end)
	end
end

--command bar code to get cframe
-------------print(workspace.House.Upgrades.Backyard.Doors.FrontDoor.DoorTouch.CFrame:toObjectSpace(workspace.CurrentCamera.CoordinateFrame))----------

--Garage
-------------print(workspace.House.Upgrades.Backyard.Marker.CFrame:toObjectSpace(workspace.CurrentCamera.CoordinateFrame))----------


local ObjectSpaceCFrames = {
	["Mini"] = CFrame.new(-12.0253296, 7.3174829, 11.8217773, 0.616813779, 0.312368929, -0.722472429, -1.4901163e-008, 0.917880893, 0.396855921, 0.787109137, -0.244786188, 0.566161573),
	["Tiny"] = CFrame.new(-19.0253296, 14.3174829, 18.8217773, 0.616813779, 0.312368929, -0.722472429, -1.4901163e-008, 0.917880893, 0.396855921, 0.787109137, -0.244786188, 0.566161573),
	["Small"] =  CFrame.new(-22.2919617, 11.6489248, 21.9883728, 0.633162737, 0.238986582, -0.736200094, 1.49011594e-008, 0.951139927, 0.308760732, 0.774018764, -0.195495799, 0.602226257),
	["Medium"] =  CFrame.new(-21.5307007, 12.4938002, 23.1558838, 0.605746388, 0.281004161, -0.744384348, -0, 0.935558438, 0.353172094, 0.795657873, -0.213932723, 0.566711068),
	["Large"] =  CFrame.new(-26.8104553, 11.8914042, 25.7923279, 0.600266755, 0.266761184, -0.754001558, 1.4901163e-008, 0.942737818, 0.333534867, 0.799799979, -0.200209901, 0.565894067),
	["TwoStory"] =  CFrame.new(-36.4672852, 24.937645, 34.3004456, 0.611608565, 0.306388646, -0.729425073, -1.4901163e-008, 0.921968579, 0.387264848, 0.791160524, -0.236854479, 0.563883841),
	["ThreeStory"] =  CFrame.new(-41.9396973, 39.4231453, 39.1841125, 0.611189425, 0.306478411, -0.729738772, 1.49011594e-008, 0.921987653, 0.387219757, 0.791484416, -0.236664638, 0.563508987),
	["Backyard"] =  CFrame.new(93.791275, 29.1934509, -38.5803223, -0.748807847, -0.352124304, 0.561511636, 1.4901163e-008, 0.847197533, 0.531278074, -0.662787199, 0.397825181, -0.634388089),
	["Basement"] =  CFrame.new(93.791275, 29.1934509, -38.5803223, -0.748807847, -0.352124304, 0.561511636, 1.4901163e-008, 0.847197533, 0.531278074, -0.662787199, 0.397825181, -0.634388089),
	["FourStory"] =  CFrame.new(93.791275, 29.1934509, -38.5803223, -0.748807847, -0.352124304, 0.561511636, 1.4901163e-008, 0.847197533, 0.531278074, -0.662787199, 0.397825181, -0.634388089),
	["Massive"] =  CFrame.new(93.791275, 29.1934509, -38.5803223, -0.748807847, -0.352124304, 0.561511636, 1.4901163e-008, 0.847197533, 0.531278074, -0.662787199, 0.397825181, -0.634388089),
	["Hotel"] =  CFrame.new(93.791275, 29.1934509, -38.5803223, -0.748807847, -0.352124304, 0.561511636, 1.4901163e-008, 0.847197533, 0.531278074, -0.662787199, 0.397825181, -0.634388089),
	["Garage"] = CFrame.new(30.5450745, 12.9179039, -21.4428864, -0.484797299, -0.3407529, 0.805517912, 1.49011612e-008, 0.920985103, 0.389598131, -0.874626637, 0.188876137, -0.446491003),
}


local camera = workspace.CurrentCamera
local cutsceneLock = false


workspace.Main.StartUpgradeCutscene.OnClientEvent:connect(function(houseUpgradeObject,forGarage)

	local sound = SoundFX:GetSoundObject("HouseUpgrade")
	local focus = (forGarage and houseUpgradeObject.Marker) or houseUpgradeObject.Doors.FrontDoor.DoorTouch
	local upgradeName = (forGarage and "Garage") or  houseUpgradeObject.Name
	local endCFrame = focus.CFrame:toWorldSpace(ObjectSpaceCFrames[upgradeName])
	local ColorCorrection = game.Lighting.CurrentCorrection.Value
	local originalBrightness = ColorCorrection.Brightness
	local originalContrast = ColorCorrection.Contrast
	
	windowData:SetVisible(false)
	delay(1,function()
		cutsceneLock = false
	end)
	
	--hide catalog
	if forGarage then
		local catalogData = GuiManager:GetWindowDataByName("Catalog")
		if catalogData then
			catalogData:SetVisible(false)
		end
	end
	
	game:GetService("ContentProvider"):PreloadAsync({sound.SoundId})
	
	workspace.Main.FadeMusic.FadeMusic:Invoke("Out",true)

	sound:Play()
	
	camera.CameraType = "Scriptable"
	
	--[[camera:Interpolate(endCFrame,door.CFrame,2)
	camera.InterpolationFinished:connect(function()
		
	
	end)]]
	
	Utility:InterpolateCameraType2(camera,endCFrame.p,focus,2,function()
		camera.CFrame = endCFrame
	end)
	
	
	spawn(function()
		
		while sound.TimePosition < 3.3 do wait() end
		
		ColorCorrection.Brightness = 1
		ColorCorrection.Contrast = -1
		
		local newHouseUpgradeObject = (not forGarage and Utility:SendData("UpgradeHouse","HouseChannel",2)) or Utility:SendData("GarageUpgrade","HouseChannel",2)
		
		if not forGarage and newHouseUpgradeObject then
			camera.CFrame = newHouseUpgradeObject.Doors.FrontDoor.DoorTouch.CFrame:toWorldSpace(ObjectSpaceCFrames[newHouseUpgradeObject.Name])
		end
		
		Tween(ColorCorrection,"Brightness","Number",1,originalBrightness,2,"Linear","Out")
		Tween(ColorCorrection,"Contrast","Number",-1,originalContrast,2,"Linear","Out")
		wait(5)
		
		camera.CameraType = "Custom"
		
		workspace.Main.FadeMusic.FadeMusic:Invoke("In",true)
	end)
	
	
end)



local NUM_COIN_SOUNDS = 10
local coins = {}
local coin = SoundFX:GetSoundObject("Coin")
local coinSoundIndex = 1


for i=1,NUM_COIN_SOUNDS do
	local coinSound = coin:clone()
	coinSound.Parent = Window
	table.insert(coins,coinSound)
end

TWEEN_SPEED = .5


local debounce = false
function ButtonPress(value)
	
	
	if debounce then return end
	debounce = true
	
	local startValue = 10
	if value == 10 and GoalAmount - CurrentAmount < value then --if player has an amount not divible by 10 somehow 1198/1200
		value = GoalAmount - CurrentAmount
		startValue = value
	end
	

	if Moneyz.Value >= value and GoalAmount - CurrentAmount >= value then--and bufferAmount + value <= GoalAmount then

		--bufferAmount = bufferAmount + value
		--increase the value per coin so 1,000 doesnt take forever
		local increment = 10
		if value == 1000 then
			increment = 25
		end

		if value == 10000 then
			increment = 200
		end		
						
		for i=startValue,value,increment do
						
			Moneyz.Value = Moneyz.Value - increment

			Utility:TweenAbsolutePosition(MainGui,MoneyzIcon,MenuMoneyzIcon.AbsolutePosition + Vector2.new(MenuMoneyzIcon.AbsoluteSize.X,0),MoneyzIcon.AbsolutePosition + Vector2.new(MoneyzIcon.AbsoluteSize.X,0),"Out","Sine",TWEEN_SPEED,function()
				if coinSoundIndex > NUM_COIN_SOUNDS then
					coinSoundIndex = 1
				end
				coins[coinSoundIndex]:Play()
				
				coinSoundIndex = coinSoundIndex + 1
				
				CurrentAmount = CurrentAmount + increment
				UpdateProgressBar()
				if CurrentAmount >= GoalAmount then
					cutsceneLock = true
					delay(.5,function() ResetProgress() end)
				end
			end)
			
			wait()
		end
		
		--update server as soon as the last coin reaches desination
		wait(TWEEN_SPEED)
	
		Utility:SendData("IncrementPayments","PlayerChannel",nil,value)
		
		
		while cutsceneLock do wait(1) end --wait for the cutscene to start before allowing the buttons to be pressed again

		
	elseif value == 100 then
		Add100.Visible = false
		Add1000.Visible = false
		Add10000.Visible = false
				
	elseif value == 1000 then
		Add1000.Visible = false
		Add10000.Visible = false

	elseif value == 10000 then
		Add10000.Visible = false
								
	end
	debounce = false
end




--upgradeName will be nill when there are no more upgrades left to upgrade

if upgradeName == "Hotel" then
	ShowFullyUpgraded()
	return
end

--show buttons when window is opened
Window.Changed:connect(function(property)
	if property == "Visible" then
		Add100.Visible = true
		Add1000.Visible = true
		if GoalAmount - CurrentAmount < 100 then
			Add100.Visible = false
			Add1000.Visible = false
			Add10000.Visible = false
		elseif  GoalAmount - CurrentAmount < 1000 then
			Add1000.Visible = false
			Add10000.Visible = false
		elseif  GoalAmount - CurrentAmount < 10000 then
			Add10000.Visible = false
		end
	end
end)


Add10000.MouseButton1Click:connect(function() ButtonPress(10000) end)
Add1000.MouseButton1Click:connect(function() ButtonPress(1000) end)
Add100.MouseButton1Click:connect(function() ButtonPress(100) end)
Add10.MouseButton1Click:connect(function() ButtonPress(10) end)
Get.MouseButton1Click:connect(function()
	local catalogData = GuiManager:GetWindowDataByName("Catalog")
	catalogData:SetVisible(true)
	windowData:SetVisible(false)
	wait()
	local catalogObject = catalogData.Object
	GuiManager.Data[catalogObject.Tabs]:SetFirstTabPressed(catalogObject.Tabs.Moneyz) --sets tab to moneyz section
end)



UpdateProgressBar()
UpdateHouseImages()

--if the house was never upgraded for some reason last play session, incrementing payments should trigger Cutscene and upgrade house
if CurrentAmount == GoalAmount then
	while not _G["StartedPlaying"] do
		wait(15)
		Utility:SendData("IncrementPayments","PlayerChannel",nil,0)
	end
end

