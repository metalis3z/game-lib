

local ItemIcons = {}

function ItemIcons.Start(AssetType, Image, Icon, Viewport, ItemTemplate, ButtonInfo, Offline)
	print(55555)
	coroutine.wrap(function()
		
		if Offline then
			task.wait(1)
		end
		
		if AssetType == "Shirts" then
			Icon.Visible = false
			Viewport.Visible = true

			if Offline then
				Viewport.Rig:Destroy()
				local Rig = game.ReplicatedStorage.Templates.ItemTemplate.ClothingViewport.Rig:Clone()
				Rig.Parent = Viewport
			end


			--Viewport.Rig:MoveTo(-29.83, -0.75, -91.182)
			Viewport.Rig.Pants.PantsTemplate = ""
			Viewport.Rig.Shirt.ShirtTemplate = Image

		elseif AssetType == "T-Shirts" then		
			Icon.Image = Image
			Icon.Visible = true
			Viewport.Visible = false
			local Shirt = game.ReplicatedStorage.Shirt:Clone()

			if ButtonInfo then
				Shirt.Size = UDim2.new(.3, 0, 0, 70)
			end

			Shirt.Parent = ItemTemplate
			Icon.Parent = Shirt
			Icon.Size = UDim2.fromScale(.5, .5)
			Icon.Position = UDim2.fromScale(.5, .5)
		elseif AssetType == "Pants" then
			Icon.Visible = false
			Viewport.Visible = true
			
			if Offline then
				Viewport.Rig:Destroy()
				local Rig = game.ReplicatedStorage.Templates.ItemTemplate.ClothingViewport.Rig:Clone()
				Rig.Parent = Viewport
			end

			--Viewport.Rig:MoveTo(Vector3.new(-29.83, -0.75, -91.182)
			Viewport.Rig.Shirt.ShirtTemplate = ""
			Viewport.Rig.Pants.PantsTemplate = Image
		else
			Icon.Image = Image
			Icon.Visible = true
			Viewport.Visible = false
		end
	end)()
end

return ItemIcons
