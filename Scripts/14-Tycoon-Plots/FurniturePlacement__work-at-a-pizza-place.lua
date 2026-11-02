-- Reference copy for study. Game: work-at-a-pizza-place
-- Original: ServerScriptService/Houses/House.lua
-- Excerpt of lines 313-378 (code unchanged; gaps marked with "-- [...]")
-- What it does: Server side of placing furniture in a player house: enforces a per-upgrade furniture cap,
--   removes one from inventory, and stores the CFrame relative to the house's Marker part (ToObjectSpace) so
--   saved layouts survive the house being at a different spot next session. DeleteFurniture refunds it.

-- [lines 313-378]
function House:PlaceFurniture(player,assetId,furnitureModel,newCFrame)
	
	
	--if has too much furniture in house
	if self.FurnitureCount >= Enums.MaxNumFurniture[self.Upgrade] then
		Dialog:ShowMessage(player,"House Full","You have too much furniture in your house.")
		furnitureModel:Destroy()
		return
	end


	if furnitureModel == nil then
		error("Furniture model dosent exist playerData = " .. tostring(self.Owner))
	end
	
	local playerData = self.Owner
	local inventory = playerData.Inventory
	local placedFurniture = playerData.PlacedFurniture
	local notZero = playerData:IncrementItemQuantity(assetId,-1) --subtract 1 from item in inventory
	if notZero then --if item was in inventory
		

		local border = furnitureModel.BorderPointer.Value
		--furnitureModel:SetPrimaryPartCFrame(newCFrame) --update model to the new positiond define by the client
		local localCFrame = self.UpgradeModel.Marker.CFrame:toObjectSpace(newCFrame) --convert to local
		
		local furniture = Furniture.new(self,nil,assetId,localCFrame,furnitureModel)
		self.Furniture[furniture.Object] = furniture
		furniture:Initialize() --need to be here
		
		--keep track of the number of furniture
		if furniture.Data.Category == "Customization" then
			self.FurnitureCount = self.FurnitureCount + .5
		else
			self.FurnitureCount = self.FurnitureCount + 1
		end
	
		
		
		
		
		playerData.DraggingFurniture = nil

	else
		furnitureModel:Destroy()
		
	end
end

function House:DeleteFurniture(furnitureModel)
	for furnitureObject,furnitureData in pairs(self.Furniture) do
		if furnitureData.Object == furnitureModel then
			local success = furnitureData.House.Owner:IncrementItemQuantity(furnitureData.AssetId,1)
			if success then
				if furnitureData.Data.Category == "Customization" then
					self.FurnitureCount = self.FurnitureCount - .5
				else
					self.FurnitureCount = self.FurnitureCount - 1
				end
				furnitureData:Delete()
				self.Furniture[furnitureObject] = nil
			end
		end
	end
end

