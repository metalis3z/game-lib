local Player = game:FindService('Players').LocalPlayer
local PlayerGui = Player:FindFirstChild('PlayerGui')
local Backpack = Player:FindFirstChild('Backpack')
local InvData = Player:WaitForChild('InvData')
local Character = Player.Character or Player.CharacterAdded:Wait()

local SafeBackpack, SafeInventory = script.Parent.Parent:FindFirstChild('Backpack'), script.Parent:FindFirstChild('Inventory')
local Remote = game:FindService('ReplicatedStorage'):WaitForChild('Inventory')
local Press, Error = script:FindFirstChild('Press'), script:FindFirstChild('ERROR')

local Cant = {'Fist', 'Phone', 'Btools', 'DeliveryFood', 'ArrestTool', 'GrabTool', 'Box', 'CashL', 'CashM', 'CashS', 'CashXL', 'CashXS'}

local Max = 10
if game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 800113546) or game:FindService('MarketplaceService'):UserOwnsGamePassAsync(Player.UserId, 714929470) then 
	Max = 20 
end

local Cooldown = PlayerGui:FindFirstChild('Safe').Frame.Cooldown
script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.Visible and Cooldown.Value == false then
		if InvData and Backpack then
			if table.find(Cant, script.Parent.Text) then return end
			if script.Parent.Parent.Name == 'Backpack' and not Backpack:FindFirstChild(script.Parent.Text):FindFirstChild('POLICE') and not Backpack:FindFirstChild(script.Parent.Text):FindFirstChild('RedeemScript') then
				if #InvData:GetChildren() < Max then
					Cooldown.Value = true
					Press:Play()
					game.ReplicatedStorage.Inventory:FireServer('Change', script.Parent.Text, 'Backpack', Character.HumanoidRootPart)
					script.Parent:Clone().Parent = PlayerGui:FindFirstChild('Safe').Frame:FindFirstChild('Inventory')
					script.Parent:Destroy()
					task.wait(.5)
					Cooldown.Value = false
				else
					Error:Play()
				end
		    elseif script.Parent.Parent.Name == 'Inventory' then
				Cooldown.Value = true
				Press:Play()
				game.ReplicatedStorage.Inventory:FireServer('Change', script.Parent.Text, 'Inv', Character.HumanoidRootPart)
				script.Parent:Clone().Parent = PlayerGui:FindFirstChild('Safe').Frame:FindFirstChild('Backpack')
				script.Parent:Destroy()
				task.wait(.5)
				Cooldown.Value = false
			end
		end
	end
end)