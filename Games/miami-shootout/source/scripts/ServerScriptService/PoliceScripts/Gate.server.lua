local pdGateOpen = false
local TweenService = game:GetService("TweenService")

local pdGate = game.Workspace.Map.PDGATEPART
local pdGateBlock = game.Workspace.PDGATEBLOCK

local openPos = CFrame.new(-1204.854, 3.011, -314.427)
local closedPos = CFrame.new(-1204.854, 11.717, -305.324)

local timer = 3

local hinge = pdGate
local goalOpen = {}
--goalOpen.CFrame = hinge.CFrame * CFrame.Angles(0, 0, math.rad(-90))

--local goalClose = {}
--goalClose.CFrame = hinge.CFrame * CFrame.Angles(math.rad(-90), math.rad(-90), 0)

--local openTween = TweenService:Create(hinge, TweenInfo.new(timer), goalOpen)--{Position = openCFrame, Orientation = Vector3.new(0, 0, -90)})
--local closeTween = TweenService:Create(hinge, TweenInfo.new(timer), goalClose) --{Position = closeCFrame, Orientation =  Vector3.new(-90, -90, 0)})

local opening = false
local closing = false

local garageOpenTimer = 3
local garageOpen = false
local garageOperating = false

local EMS = {
	["first"] = {
		["openTween"] = TweenService:Create(game.Workspace.GarageDoor1, TweenInfo.new(garageOpenTimer), {Position = Vector3.new(-883.183, 16.44, 500.758)}),
		["closeTween"] = TweenService:Create(game.Workspace.GarageDoor1, TweenInfo.new(garageOpenTimer), {Position = Vector3.new(-883.183, 4.665, 500.758)})
	},
	["second"] = {
		["openTween"] = TweenService:Create(game.Workspace.GarageDoor2, TweenInfo.new(garageOpenTimer), {Position = Vector3.new(-940.587, 16.31, 500.758)}),
		["closeTween"] = TweenService:Create(game.Workspace.GarageDoor2, TweenInfo.new(garageOpenTimer), {Position = Vector3.new(-940.587, 4.686, 500.758)})
	},
}

--[[
openTween.Completed:Connect(function()
	pdGateBlock.Parent = game.Lighting
	opening = false
end)
--]]

--[[
closeTween.Completed:Connect(function()
	pdGateBlock.Parent = game.Workspace
	closing = false
end)
--]]

function toggle(p)
	
	if opening or closing then return end
	
	if pdGateOpen == false then
		print("opening")
		pdGateOpen = true
		hinge.CFrame = closedPos
		pdGateBlock.Parent = game.Lighting
		hinge.Orientation = Vector3.new(0, 0, -90)
		--openTween:Play()	
	else
		print("closing")
		pdGateOpen = false
		pdGateBlock.Parent = game.Workspace
		hinge.CFrame = openPos
		hinge.Orientation = Vector3.new(-90, -90, 0)
		--closeTween:Play()	
	end
	
end

function garageShift(p)
	if garageOperating then return end
	
	if garageOpen == false then
		garageOperating = true
		local garage1, garage2 = game.Workspace.GarageDoor1, game.Workspace.GarageDoor2
		garage1.Open:Play() garage2.Open:Play()
		EMS["first"]["openTween"]:Play() EMS["second"]["openTween"]:Play()
		wait(garageOpenTimer+0.5)
		garageOperating = false
		garageOpen = true
	else
		garageOperating = true
		local garage1, garage2 = game.Workspace.GarageDoor1, game.Workspace.GarageDoor2
		garage1.Open:Play() garage2.Open:Play()
		EMS["first"]["closeTween"]:Play() EMS["second"]["closeTween"]:Play()
		wait(garageOpenTimer+0.5)
		garageOperating = false
		garageOpen = false
	end
end

game.Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg)
		
		local cmd = msg:lower()
		
		if p.Team == game.Teams.Police then
			if cmd == "/pdgate" then
				toggle(p)
			end
		end
		if p.Team == game.Teams.EMS then
			if cmd == "/emsgate" or cmd == "/garage" then
				garageShift(p)
			end
		end
	end)
end)