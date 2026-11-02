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

end

connection = nil

local debounce = false

local frame = nil
local mouseMove = nil
local mouseClick = nil
local equipped = false




function onEquippedLocal(mouse)
	
	FloorWire.Visible = true
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

