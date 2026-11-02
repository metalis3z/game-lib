local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Tool = script.Parent

Tool.Handle.Locked = true
local Handle = Tool.Handle

local FloorWire = Tool.FloorWire
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
	if player and player.Parent then
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
	local player = Tool.PlayerCustomer.Value
	if player and player ==  game.Players:GetPlayerFromCharacter(Tool.Parent)then
		FloorWire.Visible = false
		script:Destroy()
		return
	end

	game.Workspace.Main.RefreshJobsCompleted:FireServer()
	Tool.BringToHouse:clone().Parent = game.Players.LocalPlayer.PlayerGui.MainGui
	
end


function onUnequippedLocal(mouse)
	
	FloorWire.Visible = false

	if game.Players.LocalPlayer.PlayerGui.MainGui:FindFirstChild("BringToHouse") then
		game.Players.LocalPlayer.PlayerGui.MainGui.BringToHouse:Destroy()
	end
	
end



Tool.Equipped:connect(onEquippedLocal)
Tool.Unequipped:connect(onUnequippedLocal)

