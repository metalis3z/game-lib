local ServerScriptService = script.Parent.Parent.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Room = {}
local Houses = Global.Houses
local Players = Global.Players
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))


Room.__index = Room



function Room.new(object,upgradeModel)
	
	
	
	local this = {}
	setmetatable(this, Room)
	this.Object = object
	this.Visible = false
	this.UpgradeModel = upgradeModel
	this.IsHouseRoom = (upgradeModel and true) or false
	this.Wallpapers = {}
	this.Floors = {}
	this.SongId = nil
	
	
	
	
	
	if upgradeModel then
		
	
		
		local roomPointer = Instance.new("ObjectValue") --so client has access to the rooms
		roomPointer.Name = object.Name
		roomPointer.Value = object
		roomPointer.Parent = upgradeModel.Rooms
		
		
		
		for _,obj in ipairs(upgradeModel:GetChildren()) do  
						
			--find all floors and walls inside the room block
					
			if obj.Name == "Wall" and obj:FindFirstChild(object.Name) then 
				table.insert(this.Wallpapers,obj[object.Name])
						
			elseif obj.Name == "Floor" and obj:FindFirstChild(object.Name) then
				table.insert(this.Floors,obj[object.Name])
							
			end
		end
	end
	
	
	
	object.Parent = game.ReplicatedStorage.ZonesDisabled
				


	return this

end


function Room:SetEnabled(enabled)
	self.Object.Parent = (enabled and game.ReplicatedStorage.Zones) or game.ReplicatedStorage.ZonesDisabled
end



return Room
