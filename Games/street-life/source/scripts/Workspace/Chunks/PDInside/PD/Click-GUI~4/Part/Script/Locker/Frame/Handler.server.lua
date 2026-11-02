task.wait(.5)

local Player = script.Parent.Parent.Parent.Parent
repeat task.wait(.1) until Player.Character ~= nil
local Character = Player.Character
local Humanoid = Character:WaitForChild('Humanoid')

local Tools, Outfits = script.Parent:WaitForChild('Tools'), script.Parent:WaitForChild('Outfits')
local OutfitsOk = game:FindService('ReplicatedStorage'):WaitForChild('OutfitsOk')

script.Parent.Close.MouseButton1Click:Connect(function()
	script.Parent.Parent:Destroy()
end)

Tools:FindFirstChild('Outfits').MouseButton1Click:Connect(function()
	Tools.Visible = false
	Outfits.Visible = true
end)

Outfits:FindFirstChild('Tools').MouseButton1Click:Connect(function() 
	Outfits.Visible = false
	Tools.Visible = true
end)

for _,v in next, Tools:GetChildren() do
	if v:IsA('TextButton') and v.Name ~= 'Outfits' then
		v.MouseButton1Click:Connect(function()
			if game:FindService('ServerStorage'):FindFirstChild(v.Name) and not Player.Backpack:FindFirstChild(v.Name) and not Character:FindFirstChild(v.Name) then
				local Tool = game:FindService('ServerStorage'):FindFirstChild(v.Name):Clone()
				Tool.Parent = Player.Backpack
				local POLICE = Instance.new('NumberValue', Tool)
				POLICE.Name = 'POLICE'
				if v.Name == 'MO AK-47' then
					for _ = 1, 5 do
						local Clips = game:FindService('ServerStorage'):FindFirstChild('AR Clip'):Clone()
						Clips.Parent = Player.Backpack
						local POLICE = Instance.new('NumberValue', Clips)
						POLICE.Name = 'POLICE'
					end
				elseif v.Name == 'Perun X-16' then
					for _ = 1, 5 do
						local Clips = game:FindService('ServerStorage'):FindFirstChild('AR Clip'):Clone()
						Clips.Parent = Player.Backpack
						local POLICE = Instance.new('NumberValue', Clips)
						POLICE.Name = 'POLICE'
					end
				end
			end
		end)
	end
end

for _,v in next, Outfits:GetChildren() do
	if v:IsA('TextButton') and v.Name ~= 'Tools' then
		v.MouseButton1Click:Connect(function()
			if v.Name == 'MO Shirt' then
				if OutfitsOk:FindFirstChild(v.Name) then
					if Character:FindFirstChildOfClass('Shirt') then
						local PDShirt = OutfitsOk:FindFirstChild(v.Name):Clone()
						local OldShirt = Character:FindFirstChildOfClass('Shirt')
						PDShirt.Parent = Character
						OldShirt.Parent = PDShirt
					else
						OutfitsOk:FindFirstChild(v.Name):Clone().Parent = Character
					end
				end
			elseif v.Name == 'MO Pants' then
				if OutfitsOk:FindFirstChild(v.Name) then
					if Character:FindFirstChildOfClass('Pants') then
						local PDPants = OutfitsOk:FindFirstChild(v.Name):Clone()
						local OldPants = Character:FindFirstChildOfClass('Pants')
						PDPants.Parent = Character
						OldPants.Parent = PDPants
					else
						OutfitsOk:FindFirstChild(v.Name):Clone().Parent = Character
					end
				end
			elseif v.Name == 'MO Helmet' then
				local Helmet = OutfitsOk:FindFirstChild(v.Name):Clone()
				Helmet.Parent = Character

				for _,v in next, Character:GetChildren() do
					if v:IsA('Accessory') and v ~= Helmet and v.Name ~= 'Vest' then
						v:Clone().Parent = Helmet
					end
				end
			elseif v.Name == 'MO Vest' then
				OutfitsOk:FindFirstChild(v.Name):Clone().Parent = Character
				Character:FindFirstChild('Humanoid').MaxHealth = 160
				Character:FindFirstChild('Humanoid').Health = 160
			elseif v.Name == 'Balaclava' then
				game:FindService('ServerStorage'):FindFirstChild(v.Name):Clone().Parent = Player.Backpack
			elseif v.Name == 'Unequip' then
				local CurrentShirt = Character:FindFirstChildOfClass('Shirt')
				local CurrentPants = Character:FindFirstChildOfClass('Pants')
				if CurrentShirt ~= nil and CurrentShirt:FindFirstChildOfClass('Shirt') then
					CurrentShirt:FindFirstChildOfClass('Shirt'):Clone().Parent = Character
					CurrentShirt:Destroy()
				end
				if CurrentPants ~= nil and CurrentPants:FindFirstChildOfClass('Pants') then
					CurrentPants:FindFirstChildOfClass('Pants'):Clone().Parent = Character
					CurrentPants:Destroy()
				end
				if Character:FindFirstChild('Helmet') then Character:FindFirstChild('Helmet'):Destroy() end
			end
		end)
	end
end