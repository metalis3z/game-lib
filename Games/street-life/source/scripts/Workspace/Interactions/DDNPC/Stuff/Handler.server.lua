local Settings = {
	Cooldown = {
		Min = 180 * 2,
		Max = 220 * 2,
	},
	Money = {
		Min = 225 * 4,
		Max = 350 * 4
	}
}

local ProximityPart = script.Parent:FindFirstChild('Proximity')
local Sound = script.Parent.Proximity:FindFirstChild('ScaredSound')
local Animation = script.Parent:FindFirstChild('Animation')

local NPCHumanoid, NPCHead = script.Parent.Parent:FindFirstChild('Humanoid'), script.Parent.Parent:FindFirstChild('Head')

Cooldown = false
ProximityPart.Touched:Connect(function(Hit)
	if not Cooldown then
		local Player = game:FindService('Players'):GetPlayerFromCharacter(Hit.Parent)
		if Player and Player:IsDescendantOf(game:FindService('Players')) then
			if Player.Character then
				local Stored = Player:FindFirstChild('stored')
				if Player.Character:FindFirstChildOfClass('Tool') and Player.Character.Humanoid.Health > 0 and Stored then
					if Player.Character:FindFirstChildOfClass('Tool'):FindFirstChild('CanRob') then
						Cooldown = true
						script.Parent.Parent.UpperTorso.Store.Enabled = false
						task.wait(.2)
						Sound:Play()
						local Animation = NPCHumanoid:LoadAnimation(Animation) Animation.Priority = Enum.AnimationPriority.Action4
						Animation:Play()
						NPCHead.Face.Transparency = 1
						NPCHead.Scared.Transparency = 0
						task.wait(3)
						local Amount = math.random(Settings.Money.Min, Settings.Money.Max)
						local MoneyClone = game.ReplicatedStorage.Misc.Money:Clone()
						MoneyClone.CFrame = script.Parent.MPart.CFrame
						MoneyClone.Parent = script.Parent
						MoneyClone.BillboardGui.TextLabel.Text = '$' .. tostring(Amount)
						MoneyClone.Handler.Triggered:Connect(function()
							MoneyClone:Destroy()
							local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
							Adder.Parent = Player.PlayerGui
							Adder.Amount.Text = '+$' .. tostring(Amount)
							Stored.Money.Value += Amount
							task.wait(3)
							for _ = 1, 100 do if Adder then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
							Adder:Destroy()
						end)
						task.wait(5)
						NPCHead.Scared.Transparency = 1
						NPCHead.Face.Transparency = 0
						Animation:Stop()
						script.Parent.Parent.UpperTorso.Store.Enabled = true
						task.wait(math.random(Settings.Cooldown.Min, Settings.Cooldown.Max))
						Cooldown = false
					end
				end
			end
		end
	end
end)