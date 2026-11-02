local _call3 = game:GetService('ReplicatedStorage')

game:GetService('Workspace')

local _call7 = game:GetService('Players')
local _call12 = require(_call3.Packages.Net):RemoteEvent('NotificationService/Notify')
local _call18 = workspace:WaitForChild('Events'):WaitForChild('Fishing'):WaitForChild('Model')

_call7.PlayerAdded:Connect(function(_26, _26_2, _26_3, _26_4, _26_5)
	_26.CharacterAdded:Connect(function(_30, _30_2, _30_3) end)
end)

return {
	OnStop = function()
		_call18:PivotTo(CFrame.new(Vector3.new(-379.134, -810.16, 35.574)))

		for _38, _38_2 in ipairs(_call7:GetPlayers())do
			_38_2:FindFirstChild('Backpack'):FindFirstChild('Fishing Rod'):Destroy()

			local _ = _38_2.Character

			_38_2.Character:FindFirstChild('Fishing Rod'):Destroy()
			_38_2:SetAttribute('EquippedFishingRod', nil)
		end
	end,
	OnStart = function(_53)
		_call18:PivotTo(CFrame.new(Vector3.new(-379.134, -10.065, 35.574)))

		for _60, _60_2 in ipairs(_call7:GetPlayers())do
			local _call68 = _call3:WaitForChild('Items'):FindFirstChild('Fishing Rod'):Clone()

			_call68.Parent = _60_2:FindFirstChild('Backpack')

			_60_2:SetAttribute('EquippedFishingRod', 'Starter Rod')
			_call12:FireClient(_60_2, "You got a <font color='#019cfb'>Fishing Rod</font>!", 5, 'Sounds.Sfx.Success')
		end
	end,
}
