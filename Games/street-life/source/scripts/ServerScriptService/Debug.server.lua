Check = function(Player)
	for _,v in ipairs(workspace:GetChildren()) do
		if v.Name == 'NPC ' .. Player.Name then
			if v:FindFirstChild('Interact') then
				v:Destroy()
			end
		end
	end
	for _,v in ipairs(workspace:FindFirstChild('Frosty'):FindFirstChild('NPCArea'):GetChildren()) do
		if v.Name == 'NPC ' .. Player.Name then
			if v:FindFirstChild('Interact') then
				v:Destroy()
			end
		end
	end
end

local Misc = game:FindService('ReplicatedStorage').Misc
local WShirt, WPants, WVisor = Misc.WShirt, Misc.WPants, Misc.WVisor

game:FindService('Players').PlayerAdded:Connect(function(Player)
	pcall(function()
		if not game:FindService('BadgeService'):UserHasBadgeAsync(Player.UserId, 3364289580734431) then
			game:FindService('BadgeService'):AwardBadge(Player.UserId, 3364289580734431)
		end
	end)
	Player.CharacterAdded:Connect(function(Character)
		Check(Player)
		task.wait(1.5)
		Check(Player)
		if Player.Extra.Job.Value == 'Delivery' then
			if not Character:FindFirstChild('WShirt') then
				local Shirt, Pants = WShirt:Clone(), WPants:Clone()
				Shirt.Parent = Character
				Pants.Parent = Character
				for _,v in next, Character:GetChildren() do
					if v:IsA('Shirt') and v.Name ~= 'WShirt' then
						v.Parent = Shirt
					elseif v:IsA('Pants') and v.Name ~= 'WPants' then
						v.Parent = Pants
					end
				end
				WVisor:Clone().Parent = Character
			end
		end
	end)
	if Player.Character then
		Check(Player)
		task.wait(1.5)
		Check(Player)
		if Player.Extra.Job.Value == 'Delivery' then
			if not Player.Character:FindFirstChild('WShirt') then
				local Shirt, Pants = WShirt:Clone(), WPants:Clone()
				Shirt.Parent = Player.Character
				Pants.Parent = Player.Character
				for _,v in next, Player.Character:GetChildren() do
					if v:IsA('Shirt') and v.Name ~= 'WShirt' then
						v.Parent = Shirt
					elseif v:IsA('Pants') and v.Name ~= 'WPants' then
						v.Parent = Pants
					end
				end
			end
			WVisor:Clone().Parent = Player.Character
		end
	end
end)


for _, v in next, workspace:GetDescendants() do
	if v:IsA('Model') and not v:IsDescendantOf(workspace:FindFirstChild('CivCars')) then
		local Total = 0
		for _,vv in next, v:GetChildren() do Total += 1 end
		if Total == 0 then v:Destroy() end
	end
end