local Window = script.Parent
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))


local WindowData = GuiManager:RegisterWindow(Window,"Left","Right")
WindowData.FirstSelectedObject = Window:WaitForChild("QuitJob")

local UpdatingCounters = false

local currentPlayer = script.Parent:WaitForChild("Current_Player")
local BackToWork = script.Parent:WaitForChild("BackToWork")



CoolDownTimes = {
	GiveBonus = 10,
	BackToWork = 4,
	EmployeeOfTheDay = 15,
	NominateForBan = 11,
}



local CoolDownCounters
function UpdateCounters()
	UpdatingCounters = true

    CoolDownCounters = Utility:SendData("GetCounters","ManagerChannel",2,currentPlayer.Value) or {}

	for counterName,value in pairs(CoolDownCounters) do
		if counterName ~= "QuitJob" then
			local frame = script.Parent:FindFirstChild(counterName)
			local button = frame.Button
			button.Active = false
			--button.Selectable = false
			button.Style = "RobloxRoundButton"
			spawn(function()
				while UpdatingCounters do 
					
					
					
					button.Parent.Text.Percent.Text = math.ceil(100 - ((CoolDownCounters[counterName]/(CoolDownTimes[counterName] *60)) * 100)) .. "%"
					button.Size = UDim2.new(1- (CoolDownCounters[counterName]/(CoolDownTimes[counterName] *60)),0,0,50)
					
					if button.Size.X.Scale < 0.09 then
						button.Bar.Visible = false
					else
						button.Bar.Visible = true
					end
					

					if CoolDownCounters[counterName] == 0 then 
						button.Active = true
						--button.Selectable = true
						button.Style = "RobloxRoundDefaultButton"
						break
					end
					
					
					
					CoolDownCounters[counterName] = CoolDownCounters[counterName] - 1
					
					wait(1)
					
				end
			end)
		end
	end
end




function click(buttonName)
	
	if buttonName ~= "QuitJob" and (currentPlayer.Value == nil or CoolDownCounters[buttonName] == nil or CoolDownCounters[buttonName] > 0)  then return end

	WindowData:SetVisible(false)
	
	Utility:SendData(buttonName ,"ManagerChannel",nil,currentPlayer.Value) --tell server which button the player pressed
	
	currentPlayer.Value = nil


end


--menu.MouseButton1Click:connect(function() click(menu) end)
local connections = {}
local quitConnection
Window.Changed:connect(function(property)
	if property == "Visible" then
		if Window.Visible then
			Window.Title.Text = currentPlayer.Value.Name
			for _,i in ipairs(script.Parent:GetChildren()) do
				if i:IsA("Frame") and i.Name ~= "CancelGamepadHint" then
					table.insert(connections,i.Button.MouseButton1Click:connect(function() click(i.Name) end))
				end
			end
			quitConnection = script.Parent.QuitJob.MouseButton1Click:connect(function() click("QuitJob") end)
			UpdateCounters()
			

		else
			for _,con in ipairs(connections) do
				con:disconnect()
			end
			quitConnection:disconnect()
			UpdatingCounters = false
			
			--[[wait(3)
			script.Parent.Visible = true]]

		end
	end
end)
--[[
wait(2)
currentPlayer.Value = player
WindowData:SetVisible(true)]]
--[[
wait(5)
script.Parent.Visible = true
]]

