if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Backpack, PlayerGui = Player:FindFirstChild('Backpack'), Player:FindFirstChild('PlayerGui')
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart, Humanoid = Character:WaitForChild('HumanoidRootPart'), Character:WaitForChild('Humanoid')

local Tool = script.Parent.Parent
local Animations = Tool:WaitForChild('Animations')
local Hold = Animations:WaitForChild('Hold') 

local PhoneUI = PlayerGui:WaitForChild('PhoneUI')
if not PhoneUI.Enabled then PhoneUI.Enabled = not PhoneUI.Enabled end

local Anim = nil
Unequip = function()
	if Anim ~= nil then 
		Anim:Stop() 
		Anim = nil
	end
	game:FindService('TweenService'):Create(PhoneUI:FindFirstChild('Main'), TweenInfo.new(0.5), {Position = UDim2.new(0.9, 0, 1.26, 0)}):Play()
end

local UnlockFalse = {'Unlock', 'Date', 'Time', 'Info'}
local UnlockTrue = {'TopApps', 'InsideTime', 'Widget', 'Bottom'}

Tool.Equipped:Connect(function() if Humanoid.Health == 0 then Unequip() return end Unequip()
	Anim = Humanoid:LoadAnimation(Hold)
	Anim.Looped = true
	Anim.Priority = Enum.AnimationPriority.Action2
	Anim:Play()
	if not script.Equip.IsPlaying then script.Equip:Play() end
	game:FindService('TweenService'):Create(PhoneUI:FindFirstChild('Main'), TweenInfo.new(0.5), {Position = UDim2.new(0.9, 0, 0.7, 0)}):Play()
	task.wait(2)
	if Character:FindFirstChild('Phone') then
		if PhoneUI:FindFirstChild('Main'):FindFirstChild('Time').Visible then
			for _,v in next, PhoneUI:FindFirstChild('Main'):GetChildren() do
				if table.find(UnlockFalse, v.Name) then
					v.Visible = false
				elseif table.find(UnlockTrue, v.Name) then
					v.Visible = true
				end
			end
		end
	end
	PhoneUI:FindFirstChild('Main'):FindFirstChild('NotiFrame').Visible = true
end)

local ResetOnDeath = {'Date', 'Info', 'Time', 'Unlock'}
Humanoid.Died:Connect(function() Unequip()
	Tool.Parent = Backpack
	for _,v in next, PhoneUI:FindFirstChild('Main'):GetChildren() do
		if table.find(ResetOnDeath, v.Name) then
			v.Visible = true
		elseif v.Name == 'InsideTime' or v.Name == 'Bottom' or v.Name == 'TopApps' or v.Name == 'Widget' then
			v.Visible = false
			if v.Name == 'InsideTime' then
				v.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end
	end
	
	for _,v in next, PhoneUI:FindFirstChild('Main'):GetChildren() do
		if v:IsA('Frame') then
			if v.Name ~= 'Top' then
				v.Visible = false
			end
		end
	end
	PhoneUI:FindFirstChild('Main'):FindFirstChild('Unlock').BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	for _,v in next, PhoneUI:FindFirstChild('Main'):FindFirstChild('TopApps'):GetChildren() do
		if v:IsA('ImageButton') then
			v.Interactable = true
		end
	end
	for _,v in next,  PhoneUI:FindFirstChild('Main'):FindFirstChild('Bottom'):GetChildren() do
		if v:IsA('ImageButton') then
			v.Interactable = true
		end
	end
	PhoneUI:FindFirstChild('Main'):FindFirstChild('NotiFrame').Visible = true
end)
Tool.Unequipped:Connect(Unequip)
Tool.Destroying:Connect(Unequip)