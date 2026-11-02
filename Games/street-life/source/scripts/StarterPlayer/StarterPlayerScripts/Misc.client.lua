if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local PlayerGui = Player:FindFirstChild('PlayerGui')
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')

local Stored = Player:WaitForChild('stored')

local Job = Player:WaitForChild('Extra'):WaitForChild('Job')

local JobRemote = game:FindService('ReplicatedStorage'):FindFirstChild('Job')

Change = function(Parent, Arg)
	for _,v in next, Parent:GetChildren() do
		if v:IsA('BasePart') then
			v.Transparency = Arg
		end
	end
end

Delete = function()
	for _,v in ipairs(Player.Character:GetChildren()) do
		if v.Name == 'ArrowHandler' or v.Name == 'Arrow' then
			v:Destroy()
		end
	end
end

local PickupJob = nil
local CleanJob = nil
local BoxJob = nil
local FrostyJob = nil
JobRemote.OnClientEvent:Connect(function(Arg, Extra)
	if Arg == 'Quit' then
		Extra.ObjectText = 'Start Delivery Job'
		Change(PickupJob.Parent.Parent, 0)
		Delete()
		PickupJob.Enabled = false
		PickupJob.Parent.Parent.Ye.BillboardGui.Enabled = false
		PickupJob = nil
	elseif Arg == 'PickedUp' then
		Change(PickupJob.Parent.Parent, 0)
		PickupJob.Enabled = false
		PickupJob.Parent.Parent.Ye.BillboardGui.Enabled = false
		Delete()
		task.wait(.1)
		local Clone = script:FindFirstChild('ArrowHandler'):Clone()
		Clone.Parent = Player.Character
		Clone.Target.Value = workspace:WaitForChild('NPC ' .. Player.Name):WaitForChild('HumanoidRootPart')
		Clone.Enabled = true
	elseif Arg == 'Delivered' then
		Delete()
		task.wait(2)
		Change(PickupJob.Parent.Parent, 0)
		Delete()
		local Clone = script:FindFirstChild('ArrowHandler'):Clone()
		Clone.Parent = Player.Character
		Clone.Target.Value = PickupJob.Parent
		Clone.Enabled = true
		PickupJob.Enabled = true
		PickupJob.Parent.Parent.Ye.BillboardGui.Enabled = true
	elseif Arg == 'Delivery' then
		Extra.ObjectText = 'End Delivery Job'
		PickupJob = workspace.Work.DeliveryJob.Pickup.Target.Interact
		PickupJob.Enabled = true
		PickupJob.Parent.Parent.Ye.BillboardGui.Enabled = true
		local Clone = script:FindFirstChild('ArrowHandler'):Clone()
		Clone.Parent = Player.Character
		Clone.Target.Value = PickupJob.Parent
		Clone.Enabled = true
	elseif Arg == 'Clean' then
		Extra.ObjectText = 'End Cleaning Job'
		CleanJob = Extra.Parent.Parent:FindFirstChild('Clean')
		for _,v in next, CleanJob:GetDescendants() do
			if v:IsA('ProximityPrompt') then
				v.Enabled = true
			end
		end
	elseif Arg == 'CleanQuit' then
		Extra.ObjectText = 'Start Cleaning Job'
		for _,v in next, CleanJob:GetDescendants() do
			if v:IsA('ProximityPrompt') then
				v.Enabled = false
			end
		end
		CleanJob = nil
	elseif Arg == 'Box' then
		BoxJob = Extra
		BoxJob.Enabled = false
		local Clone = script:FindFirstChild('ArrowHandler'):Clone()
		Clone.Parent = Player.Character
		Clone.Target.Value = BoxJob.Parent.Parent.Deliver
		Clone.Enabled = true
	elseif Arg == 'BoxDelivered' then
		BoxJob.Enabled = true
		if not script.Kaching.IsPlaying then script.Kaching:Play() end
		Delete()
		BoxJob = nil
	elseif Arg == 'Frosty' then
		Extra.ObjectText = 'End Frosty Job'
		FrostyJob = Extra.Parent.Parent
		for _,v in next, FrostyJob:GetDescendants() do
			if v:IsA('ProximityPrompt') then
				v.Enabled = true
			end
		end
		PlayerGui:FindFirstChild('FrostyUI').Enabled = true
	elseif Arg == 'FrostyQuit' then
		Extra.ObjectText = 'Start Frosty Job'
		if FrostyJob ~= nil then
			for _,v in next, FrostyJob:GetDescendants() do
				if v:IsA('ProximityPrompt') then
					if v.Parent.Name  ~= 'Interact' then
						v.Enabled = false
					end
				end  
			end
		end
		FrostyJob = nil
		PlayerGui:FindFirstChild('FrostyUI').Enabled = false
	end
end)

Player.CharacterAdded:Connect(function()
	if PickupJob ~= nil then
		local Clone = script:FindFirstChild('ArrowHandler'):Clone()
		Clone.Parent = Player.Character
		Clone.Target.Value = PickupJob.Parent
		Clone.Enabled = true
		PickupJob.Enabled = true
	end
	if BoxJob ~= nil then
		BoxJob.Enabled = true
		BoxJob = nil
	end
end)

workspace.ChildAdded:Connect(function(Child)
	task.wait(1)
	if Child:IsA('Model') then
		local Split = string.split(Child.Name, ' ')
		if Split[1] == 'NPC' and game:FindService('Players'):FindFirstChild(Split[2]) then
			if Split[2] ~= Player.Name then
				Child:Destroy()
			end
		end
	end
end)


workspace:WaitForChild('Frosty'):WaitForChild('NPCArea').ChildAdded:Connect(function(Child)
	task.wait(.5)
	if Child:IsA('Model') then
		local Split = string.split(Child.Name, ' ')
		if Split[1] and Split[2] then
			if Split[1] == 'NPC' and game:FindService('Players'):FindFirstChild(Split[2]) then
				if Split[2] ~= Player.Name then
					Child:Destroy()
				end
			end
		end
	end
end)

task.wait(1)

for _,v in next, workspace:FindFirstChild('Frosty'):FindFirstChild('NPCArea'):GetChildren() do
	if v:IsA('Model') then
		local Split = string.split(v.Name, ' ')
		if Split[1] and Split[2] then
			if Split[1] == 'NPC' and game:FindService('Players'):FindFirstChild(Split[2]) then
				if Split[2] ~= Player.Name then
					v:Destroy()
				end
			end
		end
	end
end

for _,v in next, workspace:WaitForChild('Clean NPC'):FindFirstChild('Clean'):GetDescendants() do
	if v:IsA('ProximityPrompt') then
		v.Enabled = false
		v:GetPropertyChangedSignal('Enabled'):Connect(function()
			if Job.Value ~= 'Clean' then
				v.Enabled = false
			end
		end)
	end
end

if Stored then
	if Stored:FindFirstChild('Money').Value == 500 and Stored:FindFirstChild('Level').Value == 1 and Stored:FindFirstChild('Bank').Value == 0 and Stored:FindFirstChild('Gang').Value == 0 then
		task.wait(45)
		game:FindService('AvatarEditorService'):PromptSetFavorite(game.PlaceId, Enum.AvatarItemType.Asset, true)
	end
end