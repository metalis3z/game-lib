if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Stored = Player:WaitForChild('stored')
local Accessories, Money = Stored:WaitForChild('Accessories'), Stored:WaitForChild('Money')
local Character = Player.Character or Player.CharacterAdded:Wait()
Character:WaitForChild('Humanoid')

local AccessoriesFolder = game:FindService('ReplicatedStorage'):FindFirstChild('Clothing'):FindFirstChild('Accessories')
local Main = script.Parent:FindFirstChild('Main')
local Current, Purchase = Main:FindFirstChild('Current'), Main:FindFirstChild('Purchase')

local CurrentNumber, CurrentName, CurrentOwned = Main:FindFirstChild('CurrentNumber'), Main:FindFirstChild('CurrentName'), Main:FindFirstChild('CurrentOwned')

local Left, Right = Main:FindFirstChild('Left'), Main:FindFirstChild('Right')

workspace:WaitForChild('Accessory')
workspace.Accessory:WaitForChild('NPCArea')

if workspace.Accessory.NPCArea:FindFirstChild('NPC') then workspace.Accessory.NPCArea:FindFirstChild('NPC'):Destroy() end

local Positions = {
	['1'] = CFrame.new(0, -1.35, 0) * CFrame.Angles(0, math.rad(180), 0),
	['2'] = CFrame.new(0, -1.9, 0),
	['3'] = CFrame.new(0, 0, 0),
	['4'] = CFrame.new(0, -1.85, 0) * CFrame.Angles(0, math.rad(90), 0),
	['5'] = CFrame.new(0, -1.5, 0.2),
	['6'] = CFrame.new(0, -1.5, 0),
	['7'] = CFrame.new(0, -1.9, 0),
	['8'] = CFrame.new(0, -0.65, 0),
	['9'] = CFrame.new(0, -0.1, 0),
	['10'] = CFrame.new(0.95, 0.05, 0),
}

Character.Archivable = true
local Clone = Character:Clone()
Character.Archivable = false
Clone:SetPrimaryPartCFrame(workspace.Accessory.NPCArea.CFrame)
Clone.Name = 'NPC'
Clone.Parent = workspace.Accessory.NPCArea
task.wait(.75)
Clone:WaitForChild('HumanoidRootPart', true).Anchored = true
if Clone:FindFirstChildOfClass('ForceField') then Clone:FindFirstChildOfClass('ForceField'):Destroy() end

if string.find(Accessories.Value, 'Balaclava') then
	Purchase.Text = 'EQUIPPED'
else
	local AccClone = AccessoriesFolder:FindFirstChild('1'):Clone()
	local Motor6D = Instance.new('Motor6D', AccClone)
	Motor6D.Part0 = AccClone:FindFirstChild('Handle')
	Motor6D.Part1 = Clone:FindFirstChild('UpperTorso')
	Motor6D.C0 = Positions['1']
	Clone:FindFirstChildOfClass('Humanoid'):AddAccessory(AccClone)
	AccClone:FindFirstChildOfClass('StringValue'):Destroy()
end

local UpdateNPC = function()
	for _,v in next, Clone:GetChildren() do
		if v:IsA('Accessory') and tonumber(v.Name) ~= nil then
			v:Destroy()
		end
	end
	for v in string.gmatch(Accessories.Value, '%S+') do
		for _,vv in next, AccessoriesFolder:GetChildren() do 
			if vv:FindFirstChild('Name').Value == v then
				local AccClone = vv:Clone()
				local Motor6D = Instance.new('Motor6D', AccClone)
				Motor6D.Part0 = AccClone:FindFirstChild('Handle')
				Motor6D.Part1 = Clone:FindFirstChild('UpperTorso')
				Motor6D.C0 = Positions[vv.Name]
				Clone:FindFirstChildOfClass('Humanoid'):AddAccessory(AccClone)
				AccClone:FindFirstChildOfClass('StringValue'):Destroy()
			end
		end
	end
end

for v in string.gmatch(Accessories.Value, '%S+') do
	for _,vv in next, AccessoriesFolder:GetChildren() do 
		if vv:FindFirstChild('Name').Value == v then
			local AccClone = vv:Clone()
			local Motor6D = Instance.new('Motor6D', AccClone)
			Motor6D.Part0 = AccClone:FindFirstChild('Handle')
			Motor6D.Part1 = Clone:FindFirstChild('UpperTorso')
			Motor6D.C0 = Positions[vv.Name]
			Clone:FindFirstChildOfClass('Humanoid'):AddAccessory(AccClone)
			AccClone:FindFirstChildOfClass('StringValue'):Destroy()
		end
	end
	local ButtonClone = Main:FindFirstChild('CLONE'):Clone()
	ButtonClone.Parent = CurrentOwned
	ButtonClone.Name = v
	ButtonClone.Text = v
	ButtonClone.Visible = true
	ButtonClone.MouseButton1Click:Connect(function()
		game:FindService('ReplicatedStorage'):FindFirstChild('BuyAccessory'):FireServer(v, 'Remove')
	end)
end

Accessories:GetPropertyChangedSignal('Value'):Connect(function()
	for _,v in next, Clone:GetChildren() do
		if v:IsA('Accessory') and tonumber(v.Name) ~= nil then
			v:Destroy()
		end
	end
	for _,v in next, CurrentOwned:GetChildren() do
		if v:IsA('TextButton') then
			v:Destroy()
		end
	end
	for v in string.gmatch(Accessories.Value, '%S+') do
		for _,vv in next, AccessoriesFolder:GetChildren() do 
			if vv:FindFirstChild('Name').Value == v then
				local AccClone = vv:Clone()
				local Motor6D = Instance.new('Motor6D', AccClone)
				Motor6D.Part0 = AccClone:FindFirstChild('Handle')
				Motor6D.Part1 = Clone:FindFirstChild('UpperTorso')
				Motor6D.C0 = Positions[vv.Name]
				Clone:FindFirstChildOfClass('Humanoid'):AddAccessory(AccClone)
				AccClone:FindFirstChildOfClass('StringValue'):Destroy()
			end
		end
		local ButtonClone = Main:FindFirstChild('CLONE'):Clone()
		ButtonClone.Parent = CurrentOwned
		ButtonClone.Name = v
		ButtonClone.Text = v
		ButtonClone.Visible = true
		ButtonClone.MouseButton1Click:Connect(function()
			game:FindService('ReplicatedStorage'):FindFirstChild('BuyAccessory'):FireServer(v, 'Remove')
		end)
	end
	
	if string.find(Accessories.Value, AccessoriesFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value) then
		Purchase.Text = 'EQUIPPED'
	else
		Purchase.Text = 'PURCHASE'
	end
end)

local NPC = Clone
Main:FindFirstChild('Close').MouseButton1Click:Connect(function()
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	workspace.CurrentCamera.CFrame = Character:FindFirstChild('HumanoidRootPart').CFrame
	if NPC then NPC:Destroy() end
	script.Parent:Destroy()
end)

if NPC:FindFirstChildOfClass('Highlight') then NPC:FindFirstChildOfClass('Highlight'):Destroy() end
if NPC:FindFirstChild('HumanoidRootPart'):FindFirstChild('Shield') then NPC:FindFirstChild('HumanoidRootPart'):FindFirstChild('Shield'):Destroy() end
workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
workspace.CurrentCamera.CFrame = workspace:FindFirstChild('Accessory'):FindFirstChild('Cam').CFrame

Left.MouseButton1Click:Connect(function()
	if not script.Press.IsPlaying then script.Press:Play() end
	if (CurrentNumber.Text ~= '1') and tonumber(CurrentNumber.Text) ~= nil then 
		CurrentNumber.Text = tostring(tonumber(CurrentNumber.Text) - 1)
		CurrentName.Text = AccessoriesFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value
		UpdateNPC()
		if string.find(Accessories.Value, AccessoriesFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value) then
			Purchase.Text = 'EQUIPPED'
			return
		end
		Purchase.Text = 'PURCHASE'
		local AccClone = AccessoriesFolder:FindFirstChild(CurrentNumber.Text):Clone()
		local Motor6D = Instance.new('Motor6D', AccClone)
		Motor6D.Part0 = AccClone:FindFirstChild('Handle')
		Motor6D.Part1 = Clone:FindFirstChild('UpperTorso')
		Motor6D.C0 = Positions[CurrentNumber.Text]
		AccClone.Parent = Clone
		AccClone:FindFirstChildOfClass('StringValue'):Destroy()
	end
end)

Right.MouseButton1Click:Connect(function()
	if not script.Press.IsPlaying then script.Press:Play() end
	if CurrentNumber.Text and tonumber(CurrentNumber.Text) ~= nil then 
		if AccessoriesFolder:FindFirstChild(tonumber(CurrentNumber.Text) + 1) then
			CurrentNumber.Text = tostring(tonumber(CurrentNumber.Text) + 1)
			CurrentName.Text = AccessoriesFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value
			UpdateNPC()
			if string.find(Accessories.Value, AccessoriesFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value) then
				Purchase.Text = 'EQUIPPED'
				return
			end
			Purchase.Text = 'PURCHASE'
			local AccClone = AccessoriesFolder:FindFirstChild(CurrentNumber.Text):Clone()
			local Motor6D = Instance.new('Motor6D', AccClone)
			Motor6D.Part0 = AccClone:FindFirstChild('Handle')
			Motor6D.Part1 = Clone:FindFirstChild('UpperTorso')
			Motor6D.C0 = Positions[CurrentNumber.Text]
			AccClone.Parent = Clone
			AccClone:FindFirstChildOfClass('StringValue'):Destroy()
		end 
	end
end)

Purchase.MouseButton1Click:Connect(function()
	if Purchase.Text ~= 'EQUIPPED' then
		local CurrentSelected = AccessoriesFolder:FindFirstChild(CurrentNumber.Text)

		if Money.Value >= 1000 and Purchase.Text == 'PURCHASE' then
			game:FindService('ReplicatedStorage'):FindFirstChild('BuyAccessory'):FireServer(AccessoriesFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value, 'Purchase')
			Purchase.Text = 'EQUIPPED'
			if not script.Kaching.IsPlaying then script.Kaching:Play() end
		else
			if not script.Error.IsPlaying then script.Error:Play() end
		end
	end
end)