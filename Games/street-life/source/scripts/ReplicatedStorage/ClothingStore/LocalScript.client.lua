if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Stored = Player:WaitForChild('stored')
local Clothing, Money = Stored:WaitForChild('Clothing'), Stored:WaitForChild('Money')
local Character = Player.Character or Player.CharacterAdded:Wait()
Character:WaitForChild('Humanoid')

local ClothingFolder = game:FindService('ReplicatedStorage'):FindFirstChild('Clothing')
local Main = script.Parent:FindFirstChild('Main')

Main:WaitForChild('Close').MouseButton1Click:Connect(function()
	workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	workspace.CurrentCamera.CFrame = Character:FindFirstChild('HumanoidRootPart').CFrame
	if workspace.Clothing.NPCArea:FindFirstChild('NPC') then workspace.Clothing.NPCArea:FindFirstChild('NPC'):Destroy() end
	script.Parent:Destroy()
end)

local Appearance = game:FindService('Players'):GetCharacterAppearanceAsync(Player.UserId)
OriginalShirt = Appearance:FindFirstChildOfClass('Shirt').ShirtTemplate
OriginalPants = Appearance:FindFirstChildOfClass('Pants').PantsTemplate
Appearance:Destroy()


local Next, Current, Purchase = Main:WaitForChild('Next'), Main:FindFirstChild('Current'), Main:FindFirstChild('Purchase')

local CurrentNumber, CurrentName, CurrentPrice = Main:FindFirstChild('CurrentNumber'), Main:FindFirstChild('CurrentName'), Main:FindFirstChild('CurrentPrice')

local Left, Right = Main:FindFirstChild('Left'), Main:FindFirstChild('Right')

if workspace.Clothing.NPCArea:FindFirstChild('NPC') then workspace.Clothing.NPCArea:FindFirstChild('NPC'):Destroy() end

Character.Archivable = true
local Clone = Character:Clone()
Character.Archivable = false
Clone:SetPrimaryPartCFrame(workspace.Clothing.NPCArea.CFrame)
Clone.Name = 'NPC'
Clone.Parent = workspace.Clothing.NPCArea
task.wait(.75)
Clone:WaitForChild('HumanoidRootPart', true).Anchored = true
if Clone:FindFirstChildOfClass('ForceField') then
	Clone:FindFirstChildOfClass('ForceField'):Destroy()
end

local NPC = Clone

if NPC:FindFirstChildOfClass('Highlight') then NPC:FindFirstChildOfClass('Highlight'):Destroy() end
if NPC:FindFirstChild('HumanoidRootPart'):FindFirstChild('Shield') then NPC:FindFirstChild('HumanoidRootPart'):FindFirstChild('Shield'):Destroy() end
workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
workspace.CurrentCamera.CFrame = workspace:FindFirstChild('Clothing'):FindFirstChild('Cam').CFrame

if not NPC:FindFirstChildOfClass('Pants') then
	Pants = Instance.new('Pants', NPC)
	Pants.PantsTemplate = OriginalPants
end

if not NPC:FindFirstChildOfClass('Shirt') then
	Shirt = Instance.new('Shirt', NPC)
	Shirt.ShirtTemplate = OriginalShirt
end

NPC:FindFirstChildOfClass('Pants').PantsTemplate = Character:FindFirstChildOfClass('Pants').PantsTemplate
NPC:FindFirstChildOfClass('Shirt').ShirtTemplate = OriginalShirt

Next.MouseButton1Click:Connect(function()
	if Next.Text == 'Shirts' then
		Next.Text = 'Pants'
		Current.Text = 'Shirts'
		NPC:FindFirstChildOfClass('Pants').PantsTemplate = Character:FindFirstChildOfClass('Pants').PantsTemplate
		NPC:FindFirstChildOfClass('Shirt').ShirtTemplate = OriginalShirt
	else
		Next.Text = 'Shirts'
		Current.Text = 'Pants'
		NPC:FindFirstChildOfClass('Pants').PantsTemplate = OriginalPants
		NPC:FindFirstChildOfClass('Shirt').ShirtTemplate = Character:FindFirstChildOfClass('Shirt').ShirtTemplate
	end
	CurrentNumber.Text = '0'
	CurrentPrice.Text = 'FREE'
	CurrentName.Text = 'Default'
	Purchase.Text = 'EQUIP'
end)

Left.MouseButton1Click:Connect(function()
	if (CurrentNumber.Text ~= '1' and CurrentNumber.Text ~= '0') and tonumber(CurrentNumber.Text) ~= nil then 
		CurrentNumber.Text = tostring(tonumber(CurrentNumber.Text) - 1)
		CurrentPrice.Text = '$' .. ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(CurrentNumber.Text):FindFirstChild('Price').Value
		CurrentName.Text = ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value
		Purchase.Text = 'PURCHASE'
		if Current.Text == 'Shirts' then
			NPC:FindFirstChildOfClass('Shirt').ShirtTemplate = ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(CurrentNumber.Text).ShirtTemplate
			if NPC:FindFirstChildOfClass('Shirt').ShirtTemplate == Character:FindFirstChildOfClass('Shirt').ShirtTemplate then
				Purchase.Text = 'EQUIPPED'
			end
		else
			NPC:FindFirstChildOfClass('Pants').PantsTemplate = ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(CurrentNumber.Text).PantsTemplate
			if NPC:FindFirstChildOfClass('Pants').PantsTemplate == Character:FindFirstChildOfClass('Pants').PantsTemplate then
				Purchase.Text = 'EQUIPPED'
			end
		end
	else
		CurrentNumber.Text = '0'
		CurrentPrice.Text = 'FREE'
		CurrentName.Text = 'Default'
		Purchase.Text = 'EQUIP'
		if Current.Text == 'Shirts' then
			NPC:FindFirstChildOfClass('Shirt').ShirtTemplate = OriginalShirt
		else
			NPC:FindFirstChildOfClass('Pants').PantsTemplate = OriginalPants
		end
	end
	if not script.Press.IsPlaying then script.Press:Play() end
end)

Right.MouseButton1Click:Connect(function()
	if CurrentNumber.Text and tonumber(CurrentNumber.Text) ~= nil then 
		if ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(tonumber(CurrentNumber.Text) + 1) then
			CurrentNumber.Text = tostring(tonumber(CurrentNumber.Text) + 1)
			CurrentPrice.Text = '$' .. ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(CurrentNumber.Text):FindFirstChild('Price').Value
			CurrentName.Text = ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(CurrentNumber.Text):FindFirstChild('Name').Value
			Purchase.Text = 'PURCHASE'
			if Current.Text == 'Shirts' then
				NPC:FindFirstChildOfClass('Shirt').ShirtTemplate = ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(CurrentNumber.Text).ShirtTemplate
				if NPC:FindFirstChildOfClass('Shirt').ShirtTemplate == Character:FindFirstChildOfClass('Shirt').ShirtTemplate then
					Purchase.Text = 'EQUIPPED'
				end
			else
				NPC:FindFirstChildOfClass('Pants').PantsTemplate = ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(CurrentNumber.Text).PantsTemplate
				if NPC:FindFirstChildOfClass('Pants').PantsTemplate == Character:FindFirstChildOfClass('Pants').PantsTemplate then
					Purchase.Text = 'EQUIPPED'
				end
			end
		end 
	end
	if not script.Press.IsPlaying then script.Press:Play() end
end)

Purchase.MouseButton1Click:Connect(function()
	if CurrentNumber.Text ~= '0' and Purchase.Text ~= 'EQUIPPED' then
		local CurrentSelected = ClothingFolder:FindFirstChild(Current.Text):FindFirstChild(CurrentNumber.Text)
		local Price, Name = CurrentSelected:FindFirstChild('Price').Value, CurrentSelected:FindFirstChild('Name').Value

		if Money.Value >= Price and Purchase.Text == 'PURCHASE' then
			game:FindService('ReplicatedStorage'):FindFirstChild('BuyClothing'):FireServer(CurrentNumber.Text, Current.Text)
			Purchase.Text = 'EQUIPPED'
			if not script.Kaching.IsPlaying then script.Kaching:Play() end
		else
			if not script.Error.IsPlaying then script.Error:Play() end
		end
	elseif Purchase.Text ~= 'EQUIPPED' then
		game:FindService('ReplicatedStorage'):FindFirstChild('BuyClothing'):FireServer('DEFAULT', Current.Text)
		task.spawn(function()
			if Player.PlayerGui:FindFirstChild('Adder') then Player.PlayerGui:FindFirstChild('Adder'):Destroy() end
			local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
			Adder.Parent = Player.PlayerGui
			Adder.Amount.Text = 'EQUIPPED DEFAULT'
			Adder.Amount.TextColor3 = Color3.fromRGB(2, 209, 255)
			task.wait(1)
			for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
			if Adder then Adder:Destroy() end
		end)
	end
end)