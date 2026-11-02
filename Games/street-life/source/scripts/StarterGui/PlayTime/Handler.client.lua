 if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait() 
local Humanoid = Character:WaitForChild('Humanoid', true)

local Level = Player:WaitForChild('stored'):WaitForChild('Level')
local Extra = Player:WaitForChild('Extra')
local PlayTime = Extra:WaitForChild('PlayTime')

script.Parent:FindFirstChild('Interact').MouseButton1Click:Connect(function()
	script.Parent.Main.Visible = not script.Parent.Main.Visible
	script.Parent.All.Visible = script.Parent.Main.Visible
end)

script.Parent.Main:FindFirstChild('Close').MouseButton1Click:Connect(function()
	script.Parent.Main.Visible = false
	script.Parent.All.Visible = false
end)

script.Parent:FindFirstChild('Interact').MouseEnter:Connect(function()
	if not script.Hover.IsPlaying then script.Hover:Play() end
end)

script.Parent.Main:FindFirstChild('Close').MouseEnter:Connect(function()
	if not script.Hover.IsPlaying then script.Hover:Play() end
end)

for _,v in next, script.Parent:FindFirstChild('Main'):GetChildren() do
	if v:IsA('ImageLabel') then
		v:FindFirstChildOfClass('TextButton').MouseEnter:Connect(function()
			if not script.Hover.IsPlaying then script.Hover:Play() end
		end)
		v:FindFirstChildOfClass('TextButton').MouseButton1Click:Connect(function()
			if v:FindFirstChild('Level') then
				if v:FindFirstChild('Level'):FindFirstChild('Amount').Value > Level.Value and PlayTime.Value < 100000 then
					if not script.Error.IsPlaying then script.Error:Play() end
					return
				end
			end
			if v:FindFirstChildOfClass('TextButton').Text == 'REDEEM' then
				if not script.Kaching.IsPlaying then script.Kaching:Play() end
			else
				if not script.Error.IsPlaying then script.Error:Play() end
			end
		end)
	end
end

script.Parent:FindFirstChild('All'):WaitForChild('Purchase').MouseEnter:Connect(function()
	if not script.Hover.IsPlaying then script.Hover:Play() end
end)

script.Parent:FindFirstChild('All'):WaitForChild('Purchase').MouseButton1Click:Connect(function()
	game:FindService('MarketplaceService'):PromptProductPurchase(Player, 1830195396)
end)

local t = 25

local tick = tick
game:GetService("RunService"):BindToRenderStep("Rainbow", 1000, function()
	local hue = tick() % t / t
	local color = Color3.fromHSV(hue, 1, 1)
	script.Parent.Interact.UIStroke.Color = color
end)