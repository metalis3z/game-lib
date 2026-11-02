local CollectionService = game:GetService("CollectionService")
CollectionService:AddTag(script.Parent, "InteractiveBox")

local InteractivePart = script.Parent
local RunService = game:GetService("RunService")
local Open = false

local Door = InteractivePart.Parent.Door
local Door1 = Door.Move1
local Door2 = Door.Move2

local InUse = script.Parent.InUse
local Button = script.Parent.Parent.Button


local function OpenDoors()
	InUse.Value = true
	Button.BrickColor = BrickColor.new("Crimson")

	spawn(function()
		for i = 1,90 do
			Door1:SetPrimaryPartCFrame(Door1.RotatePoint.CFrame * CFrame.Angles(0,math.rad(1),0) )
			Door2:SetPrimaryPartCFrame(Door2.RotatePoint.CFrame * CFrame.Angles(0,math.rad(-1),0) )
			RunService.Heartbeat:Wait()
		end
	end)

	wait(11)

	InUse.Value = false
	Button.BrickColor = BrickColor.new("Bright green")
end

local function CloseDoors()
	InUse.Value = true
	Button.BrickColor = BrickColor.new("Crimson")

	spawn(function()
		for i = 1,90 do
			Door1:SetPrimaryPartCFrame(Door1.RotatePoint.CFrame * CFrame.Angles(0,math.rad(-1),0) )
			Door2:SetPrimaryPartCFrame(Door2.RotatePoint.CFrame * CFrame.Angles(0,math.rad(1),0) )
			RunService.Heartbeat:Wait()
		end
	end)

	wait(5)

	InUse.Value = false
	Button.BrickColor = BrickColor.new("Bright green")
end


script.Parent.Interact.OnServerEvent:Connect(function(Player)
	if not InUse.Value then
		if not Open then
			Open = true
			OpenDoors()
		else
			Open = false
			CloseDoors()
		end
	end
end)