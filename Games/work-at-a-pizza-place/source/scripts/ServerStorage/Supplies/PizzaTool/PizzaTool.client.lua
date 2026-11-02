local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle",1)
local FloorWire = Tool:WaitForChild("FloorWire",1)

if not Handle then return end

Handle.Locked = true
FloorWire.Transparency = 0.5



local order = Tool.House.Value
if order ~= nil and order.CurrentUpgrade ~= nil and order.CurrentUpgrade.Value ~= nil  then
		
	FloorWire.From = Tool.Handle
	FloorWire.To = order.CurrentUpgrade.Value.GivePizza
	workspace.TutorialService.PlayerAction:FireServer("GrabbedPizza",true)
	
	--change team
	if game.Players.LocalPlayer.TeamColor ~= BrickColor.new(37) and game.Players.LocalPlayer.TeamColor ~= BrickColor.new(23) then
		Utility:SendData("ChangeJob","PlayerChannel",nil,"Delivery")	
	end
	
else
	local player = Tool.PlayerCustomer.Value
	if player and player.Parent and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		FloorWire.From = Tool.Handle
		FloorWire.To = player.Character.HumanoidRootPart
	else
		Tool.Parent = workspace
		Tool:Destroy()
	end
	workspace.TutorialService.PlayerAction:FireServer("GrabbedPizza",true)

end

connection = nil

local debounce = false

local frame = nil
local mouseMove = nil
local mouseClick = nil
local equipped = false

game.Workspace.Main.RefreshJobsCompleted.OnClientEvent:connect(function(jobs_completed)
	if jobs_completed and jobs_completed["Delivery"] < 10 or (Tool and Tool:FindFirstChild("PlayerCustomer") and Tool.PlayerCustomer.Value)  then
		FloorWire.Visible = true
	else
		FloorWire.Visible = false
	end
end)


function onEquippedLocal(mouse)
	
	local playerCustomer = Tool.PlayerCustomer.Value
	if playerCustomer == game.Players.LocalPlayer then
		
		
		frame = Tool.Handle:clone()
		frame.Name = "Frame"
		frame.Parent = workspace
		frame.Anchored = true
		frame.CanCollide = false
		frame.Transparency = 1
		frame.Decal.Transparency = 1
		mouse.TargetFilter = frame
		
		local selection = Instance.new("SelectionBox")
		selection.Adornee = frame
		selection.Parent = frame
		
		mouseMove = mouse.Move:connect(function()
			if (mouse.Hit.p - Handle.Position).magnitude < 30 then
				frame.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0,.35,0))
			end
		end)
		
		mouseClick = mouse.Button1Down:connect(function()
			workspace.Main.PlacePizzaSlices:FireServer(Tool,frame.CFrame)
			onUnequippedLocal(mouse)
		end)
		
		wait(.5)
		FloorWire.Visible = false
		
	
	else
		game.Workspace.Main.RefreshJobsCompleted:FireServer()
		Tool.BringToHouse:clone().Parent = game.Players.LocalPlayer.PlayerGui.MainGui
	end
	
end


function onUnequippedLocal(mouse)
	if mouseMove then mouseMove:disconnect() end
	if mouseClick then mouseClick:disconnect() end
	if frame then frame:Destroy() end
	
	FloorWire.Visible = false

	if game.Players.LocalPlayer.PlayerGui.MainGui:FindFirstChild("BringToHouse") then
		game.Players.LocalPlayer.PlayerGui.MainGui.BringToHouse:Destroy()
	end
	if mouse then mouse.Icon = "" end
	
end



Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)

