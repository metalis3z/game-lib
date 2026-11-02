if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Stored = Player:WaitForChild('stored')
local Tattoos, Money = Stored:WaitForChild('Tattoos'), Stored:WaitForChild('Money')
local Character = Player.Character or Player.CharacterAdded:Wait()
Character:WaitForChild('Humanoid')

local TattoosFolder = game:FindService('ReplicatedStorage'):FindFirstChild('Clothing'):FindFirstChild('Tattoos')
local Main = script.Parent:FindFirstChild('Main')
local Current, Purchase = Main:FindFirstChild('Current'), Main:FindFirstChild('Purchase')

local CurrentNumber, CurrentName, CurrentOwned = Main:FindFirstChild('CurrentNumber'), Main:FindFirstChild('CurrentName'), Main:FindFirstChild('CurrentOwned')

local Left, Right = Main:FindFirstChild('Left'), Main:FindFirstChild('Right')

workspace:WaitForChild('Tattoo')
workspace.Tattoo:WaitForChild('NPCArea')

if workspace.Tattoo.NPCArea:FindFirstChild('NPC') then workspace.Tattoo.NPCArea:FindFirstChild('NPC'):Destroy() end

Character.Archivable = true
local Clone = Character:Clone()
Character.Archivable = false
Clone:SetPrimaryPartCFrame(workspace.Tattoo.NPCArea.CFrame)
Clone.Name = 'NPC'
Clone.Parent = workspace.Tattoo.NPCArea
task.wait(.75)
Clone:WaitForChild('HumanoidRootPart', true).Anchored = true
if Clone:FindFirstChildOfClass('ForceField') then Clone:FindFirstChildOfClass('ForceField'):Destroy() end

if string.find(Tattoos.Value, 'AK') then
	Purchase.Text = 'EQUIPPED'
end

local UpdateNPC = function()
	for _,v in next, Clone:FindFirstChild('Head'):GetChildren() do
		if v:IsA('Decal') and tonumber(v.Name) ~= nil then
			v:Destroy()
		end
	end
	for v in string.gmatch(Tattoos.Value, '%S+') do
		for _,vv in next, TattoosFolder:GetChildren() do 
			if vv:FindFirstChild('Name').Value == v then
				local TatClone = vv:Clone()
				TatClone.Parent = Clone:FindFirstChild('Head')
				TatClone:FindFirstChildOfClass('StringValue'):Destroy()
			end
		end
	end
end

for v in string.gmatch(Tattoos.Value, '%S+') do
	for _,vv in next, TattoosFolder:GetChildren() do 
		if vv:FindFirstChild('Name').Value == v then
			local TatClone = vv:Clone()
			TatClone.Parent = Clone:FindFirstChild('Head')
			TatClone:FindFirstChildOfClass('StringValue'):Destroy()
		end
	end
	local ButtonClone = Main:FindFirstChild('CLONE'):Clone()
	ButtonClone.Parent = CurrentOwned
	ButtonClone.Name = v
	ButtonClone.Text = v
	ButtonClone.Visible = true
	ButtonClone.MouseButton1Click:Connect(function()
		game:FindService('ReplicatedStorage'):FindFirstChild('BuyTattoo'):FireServer(v, 'Remove')
	end)
end

Tattoos:GetPropertyChangedSignal('Value'):Connect(function()
	for _,v in next, Clone:FindFirstChild('Head'):GetChildren() do
		if v:IsA('Decal') and tonumber(v.Name) ~= nil then
			v:Destroy()
		end
	end
	for _,v in next, CurrentOwned:GetChildren() do
		if v:IsA('TextButton') then
			v:Destroy()
		end
	end
	for v in string.gmatch(Tattoos.Value, '%S+') do
		for _,vv in next, TattoosFolder:GetChildren() do 
			if vv:FindFirstChild('Name').Value == v then
				local TatClone = vv:Clone()
				TatClone.Parent = Clone:FindFirstChild('Head')
				TatClone:FindFirstChildOfClass('StringValue'):Destroy()
			end
		end
		local ButtonClone = Main:FindFirstChild('CLONE'):Clone()
		ButtonClone.Parent = CurrentOwned
		ButtonClone.Name = v
		ButtonClone.Text = v
		ButtonClone.Visible = true
		ButtonClone.MouseButton1Click:Connect(function()
			game:FindService('ReplicatedStorage'):FindFirstChild('BuyTattoo'):FireServer(v, 'Remove')
		end)
	end
	
	if string.find(Tattoos.Value, TattoosFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value) then
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
workspace.CurrentCamera.CFrame = workspace:FindFirstChild('Tattoo'):FindFirstChild('Cam').CFrame

Left.MouseButton1Click:Connect(function()
	if not script.Press.IsPlaying then script.Press:Play() end
	if (CurrentNumber.Text ~= '1') and tonumber(CurrentNumber.Text) ~= nil then 
		CurrentNumber.Text = tostring(tonumber(CurrentNumber.Text) - 1)
		CurrentName.Text = TattoosFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value
		UpdateNPC()
		if string.find(Tattoos.Value, TattoosFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value) then
			Purchase.Text = 'EQUIPPED'
			return
		end
		Purchase.Text = 'PURCHASE'
		local TatClone = TattoosFolder:FindFirstChild(CurrentNumber.Text):Clone()
		TatClone.Parent = Clone:FindFirstChild('Head')
		TatClone:FindFirstChildOfClass('StringValue'):Destroy()
	end
end)

Right.MouseButton1Click:Connect(function()
	if not script.Press.IsPlaying then script.Press:Play() end
	if CurrentNumber.Text and tonumber(CurrentNumber.Text) ~= nil then 
		if TattoosFolder:FindFirstChild(tonumber(CurrentNumber.Text) + 1) then
			CurrentNumber.Text = tostring(tonumber(CurrentNumber.Text) + 1)
			CurrentName.Text = TattoosFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value
			UpdateNPC()
			if string.find(Tattoos.Value, TattoosFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value) then
				Purchase.Text = 'EQUIPPED'
				return
			end
			Purchase.Text = 'PURCHASE'
			local TatClone = TattoosFolder:FindFirstChild(CurrentNumber.Text):Clone()
			TatClone.Parent = Clone:FindFirstChild('Head')
			TatClone:FindFirstChildOfClass('StringValue'):Destroy()
		end 
	end
end)

Purchase.MouseButton1Click:Connect(function()
	if Purchase.Text ~= 'EQUIPPED' then
		local CurrentSelected = TattoosFolder:FindFirstChild(CurrentNumber.Text)

		if Money.Value >= 500 and Purchase.Text == 'PURCHASE' then
			game:FindService('ReplicatedStorage'):FindFirstChild('BuyTattoo'):FireServer(TattoosFolder:FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value, 'Purchase')
			Purchase.Text = 'EQUIPPED'
			if not script.Kaching.IsPlaying then script.Kaching:Play() end
		else
			if not script.Error.IsPlaying then script.Error:Play() end
		end
	end
end)