if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')

local Stored = Player:WaitForChild('stored')
local BuyRemote = game:FindService('ReplicatedStorage').Buy

local Frame = script.Parent
local Kaching, Error, Press = script:FindFirstChild('Kaching'), script:FindFirstChild('Error'), script:FindFirstChild('Press')

local Prices = {
	['Pizza'] = 3,
	['Water'] = 2,
	['Taco'] = 4,
	['AppleJuice'] = 3,
	['GrapeJuice'] = 3,
	['CherryDrink'] = 5;
}

for _,v in next, Frame:GetChildren() do
	if v:IsA('TextButton') then
		if v.Name ~= 'Close' then
			v.MouseButton1Click:Connect(function()
				if Stored.Money.Value >= Prices[v.Name] then
					BuyRemote:FireServer(v.Name, Prices[v.Name])
					if not Kaching.IsPlaying then Kaching:Play() end
				else
					if not Error.IsPlaying then Error:Play() end
				end
			end)
		end
		v.MouseEnter:Connect(function()
			v.Around.Thickness = 3
			if not Press.IsPlaying then Press:Play() end
		end)
		v.MouseLeave:Connect(function()
			v.Around.Thickness = 2
		end)
	end
end

Frame.Close.MouseButton1Click:Connect(function()
	if not Press.IsPlaying then Press:Play() end
	script.Parent.Object.Value.Enabled = true
	Frame.Parent:Destroy()
end)