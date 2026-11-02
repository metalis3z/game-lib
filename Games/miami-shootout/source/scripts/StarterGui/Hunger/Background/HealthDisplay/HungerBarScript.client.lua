local Player = game.Players.LocalPlayer
local char = Player.Character

local UIS = game:GetService("UserInputService")

_G.hunger = 100
local isRunning = false

_G.hunger = math.clamp(_G.hunger, 0, 100)

function update()
	script.Parent:TweenSize(UDim2.new(_G.hunger/100, 0, 1, 0), "Out", "Linear",0)
end

local defaultHunger = 1
local hungerWhileRunning = 1.5

local lastMessage = false

spawn(function()
	while wait(15) do
		local hungerDepletion = defaultHunger
		
		if _G.globalRun and _G.globalRun == true then
			hungerDepletion = hungerWhileRunning
		end
		
		local hunga = _G.hunger
		if hunga <= 15 and lastMessage == false then
			lastMessage = true
			_G.showMsg('"I could sure use some food..."',12,"alert")
			delay(60,function()
				lastMessage = false
			end)
		end
		local newHunger = hunga-hungerDepletion
		_G.hunger = math.clamp(newHunger, 0, 100)
		update()
	end
end)	

local hungerEvent = game.ReplicatedStorage:WaitForChild("HUNGEREVENT")

hungerEvent.OnClientEvent:Connect(function(action,param)
	if action == "addHunger" and param then
		print("hunger add")
		local hunga = _G.hunger
		local newHunger = hunga+param
		_G.hunger = math.clamp(newHunger, 0, 100)
		update()
	end
end)
