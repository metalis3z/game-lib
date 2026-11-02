local Clothing = game:FindService('ReplicatedStorage'):FindFirstChild('Clothing')
local ClothingShirt, ClothingPants, Tattoos, Accessories = Clothing:FindFirstChild('Shirts'), Clothing:FindFirstChild('Pants'), Clothing:FindFirstChild('Tattoos'), Clothing:FindFirstChild('Accessories')

local UpdateClothing = function(Player, Clothing, Character)
	if Player and Clothing and Character then
		local Split = string.split(Clothing.Value, ' ')
		local Shirt, Pants = Split[1], Split[2]
		local OriginalShirt, OriginalPants
		local Appearance = game:FindService('Players'):GetCharacterAppearanceAsync(Player.UserId)
		OriginalShirt = Appearance:FindFirstChildOfClass('Shirt').ShirtTemplate
		OriginalPants = Appearance:FindFirstChildOfClass('Pants').PantsTemplate
		Appearance:Destroy()
		if Shirt ~= 'nil' then
			if ClothingShirt:FindFirstChild(tostring(Shirt)) then
				if Character:FindFirstChildOfClass('Shirt') then Character:FindFirstChildOfClass('Shirt'):Destroy() end
				ClothingShirt:FindFirstChild(tostring(Shirt)):Clone().Parent = Character
			end
		else
			if Character:FindFirstChildOfClass('Shirt') then 
				Character:FindFirstChildOfClass('Shirt').ShirtTemplate = OriginalShirt
			end
		end
		if Pants ~= 'nil' then
			if ClothingPants:FindFirstChild(tostring(Pants)) then
				if Character:FindFirstChildOfClass('Pants') then Character:FindFirstChildOfClass('Pants'):Destroy() end
				ClothingPants:FindFirstChild(tostring(Pants)):Clone().Parent = Character
			end
		else
			if Character:FindFirstChildOfClass('Pants') then 
				Character:FindFirstChildOfClass('Pants').PantsTemplate = OriginalPants
			end
		end
	end
end

local UpdateTattoos = function(Player, TattoosValue)
	if not Player.Character then Player.CharacterAdded:Wait() end
	task.wait(2)
	for _,v in next, Player.Character:WaitForChild('Head', 5):GetChildren() do
		if v:IsA('Decal') and tonumber(v.Name) ~= nil and string.lower(v.Name) ~= 'face' then
			v:Destroy()
		end
	end
	for v in string.gmatch(TattoosValue.Value, '%S+') do
		for _,vv in next, Tattoos:GetChildren() do 
			if vv:FindFirstChild('Name').Value == v then
				local TatClone = vv:Clone()
				TatClone.Parent = Player.Character:WaitForChild('Head', 5)
				TatClone:FindFirstChildOfClass('StringValue'):Destroy()
			end
		end
	end
end

local UpdateAccessories = function(Player, AccessoriesValue) 
	if not Player.Character then Player.CharacterAdded:Wait() end
	task.wait(2)
	for _,v in next, Player.Character:GetChildren() do
		if v:IsA('Accessory') and tonumber(v.Name) ~= nil then
			v:Destroy()
		end
	end
	for v in string.gmatch(AccessoriesValue.Value, '%S+') do
		for _,vv in next, Accessories:GetChildren() do 
			if vv:FindFirstChild('Name').Value == v then
				local TatClone = vv:Clone()
				TatClone:FindFirstChild('Handle').CanCollide = false
				TatClone:FindFirstChild('Handle').CanTouch = false
				TatClone:FindFirstChild('Handle').CanQuery = false
				TatClone.Parent = Player.Character
				TatClone:FindFirstChildOfClass('StringValue'):Destroy()
			end
		end
	end
end

game:FindService('Players').PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		Character:WaitForChild('Head')
		local Stored = Player:WaitForChild('stored', 10)
		local Clothing, Tattoos, Accessories = Stored:WaitForChild('Clothing'), Stored:WaitForChild('Tattoos'), Stored:WaitForChild('Accessories')
		UpdateTattoos(Player, Tattoos)
		UpdateAccessories(Player, Accessories)

		local Split = string.split(Clothing.Value, ' ')
		local Shirt, Pants = Split[1], Split[2]
		if Shirt and Pants then
			task.wait(2)
			if Shirt ~= 'nil' then
				if ClothingShirt:FindFirstChild(tostring(Shirt)) then
					if Character:FindFirstChildOfClass('Shirt') then Character:FindFirstChildOfClass('Shirt'):Destroy() end
					ClothingShirt:FindFirstChild(tostring(Shirt)):Clone().Parent = Character
				end
			end
			if Pants ~= 'nil' then
				if ClothingPants:FindFirstChild(tostring(Pants)) then
					if Character:FindFirstChildOfClass('Pants') then Character:FindFirstChildOfClass('Pants'):Destroy() end
					ClothingPants:FindFirstChild(tostring(Pants)):Clone().Parent = Character
				end
			end
		end
	end)
	Player:WaitForChild('stored'):WaitForChild('Clothing'):GetPropertyChangedSignal('Value'):Connect(function()
		UpdateClothing(Player, Player:FindFirstChild('stored'):FindFirstChild('Clothing'), Player.Character)
	end)
	Player:WaitForChild('stored'):WaitForChild('Tattoos'):GetPropertyChangedSignal('Value'):Connect(function()
		UpdateTattoos(Player, Player:FindFirstChild('stored'):FindFirstChild('Tattoos'))
	end)
	Player:WaitForChild('stored'):WaitForChild('Accessories'):GetPropertyChangedSignal('Value'):Connect(function()
		UpdateAccessories(Player, Player:FindFirstChild('stored'):FindFirstChild('Accessories'))
	end)
end)

game:FindService('ReplicatedStorage'):FindFirstChild('BuyClothing').OnServerEvent:Connect(function(Player, Clothing, Type)
	if Player and Clothing and (Type == 'Shirts' or Type == 'Pants') then
		if Clothing ~= 'DEFAULT' then
			if game:FindService('ReplicatedStorage'):FindFirstChild('Clothing')[Type]:FindFirstChild(Clothing) then
				local Price = game:FindService('ReplicatedStorage'):FindFirstChild('Clothing')[Type]:FindFirstChild(Clothing):FindFirstChild('Price').Value
				local Name = game:FindService('ReplicatedStorage'):FindFirstChild('Clothing')[Type]:FindFirstChild(Clothing):FindFirstChild('Name').Value

				if Player:FindFirstChild('stored') then
					if Player:FindFirstChild('stored'):FindFirstChild('Money').Value >= Price then
						Player:FindFirstChild('stored'):FindFirstChild('Money').Value -= Price
						local Split = string.split(Player:FindFirstChild('stored'):FindFirstChild('Clothing').Value, ' ')
						if Type == 'Shirts' then
							Player:FindFirstChild('stored'):FindFirstChild('Clothing').Value = Clothing .. ' ' .. Split[2]
						else
							Player:FindFirstChild('stored'):FindFirstChild('Clothing').Value = Split[1] .. ' ' .. Clothing
						end
						game.ReplicatedStorage.server:FireClient(Player, "money", Price)
					end
				end
			end
		else
			local Appearance = game:FindService('Players'):GetCharacterAppearanceAsync(Player.UserId)
			local OriginalShirt = Appearance:FindFirstChildOfClass('Shirt').ShirtTemplate
			local OriginalPants = Appearance:FindFirstChildOfClass('Pants').PantsTemplate
			Appearance:Destroy()
			local Split = string.split(Player:FindFirstChild('stored'):FindFirstChild('Clothing').Value, ' ')
			if Type == 'Shirts' then
				Player:FindFirstChild('stored'):FindFirstChild('Clothing').Value =  'nil ' .. Split[2]
				Player.Character:FindFirstChildOfClass('Shirt').ShirtTemplate = OriginalShirt
			else
				Player:FindFirstChild('stored'):FindFirstChild('Clothing').Value =  Split[1] .. ' nil'
				Player.Character:FindFirstChildOfClass('Pants').PantsTemplate  = OriginalPants
			end
		end
	end
end)

game:FindService('ReplicatedStorage'):FindFirstChild('BuyTattoo').OnServerEvent:Connect(function(Player, Clothing, Type)
	if Player and Clothing and (Type == 'Purchase' or Type == 'Remove') then
		if Type == 'Remove' then
			if Player:FindFirstChild('stored') then
				if Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value == Clothing then
					Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value = ''
					return
				end
				if string.find(Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value, ' ' .. Clothing) then
					Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value = string.gsub(Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value, ' ' .. Clothing, '')
				elseif string.find(Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value, Clothing .. ' ') then
					Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value = string.gsub(Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value, Clothing .. ' ', '')
				else
					Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value = ''

				end
			end 
		elseif Type == 'Purchase' then
			if Player:FindFirstChild('stored') then
				if Player:FindFirstChild('stored'):FindFirstChild('Money').Value >= 500 then
					if not string.find(Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value, Clothing) then
						if Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value == '' then
							Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value = Clothing
						else
							Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value = Player:FindFirstChild('stored'):FindFirstChild('Tattoos').Value .. ' ' .. Clothing
						end
						Player:FindFirstChild('stored'):FindFirstChild('Money').Value -= 500
					end
				end
			end
		end
	end
end)

game:FindService('ReplicatedStorage'):FindFirstChild('BuyAccessory').OnServerEvent:Connect(function(Player, Clothing, Type)
	if Player and Clothing and (Type == 'Purchase' or Type == 'Remove') then
		if Type == 'Remove' then
			if Player:FindFirstChild('stored') then
				if Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value == Clothing then
					Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value = ''
					return
				end
				if string.find(Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value, ' ' .. Clothing) then
					Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value = string.gsub(Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value, ' ' .. Clothing, '')
				elseif string.find(Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value, Clothing .. ' ') then
					Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value = string.gsub(Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value, Clothing .. ' ', '')
				else
					Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value = ''

				end
			end 
		elseif Type == 'Purchase' then
			if Player:FindFirstChild('stored') then
				if Player:FindFirstChild('stored'):FindFirstChild('Money').Value >= 1000 then
					if not string.find(Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value, Clothing) then
						if Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value == '' then
							Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value = Clothing
						else
							Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value = Player:FindFirstChild('stored'):FindFirstChild('Accessories').Value .. ' ' .. Clothing
						end
						Player:FindFirstChild('stored'):FindFirstChild('Money').Value -= 1000
					end
				end
			end
		end
	end
end)