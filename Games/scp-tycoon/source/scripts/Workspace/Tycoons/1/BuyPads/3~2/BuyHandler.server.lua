script.Parent.BillboardGui.NameLabel.Text = script.Parent.Data.ObjectName.Value
script.Parent.BillboardGui.PriceLabel.Text = "$".. script.Parent.Data.Price.Value
local db = false
script.Parent.Touched:Connect(function(Hit)
	if game.Players:FindFirstChild(script.Parent.Parent.Parent.Data.Owner.Value) then
		if Hit.Parent.Name == script.Parent.Parent.Parent.Data.Owner.Value then
			if game.Players:FindFirstChild(script.Parent.Parent.Parent.Data.Owner.Value).Data.Cash.Value >= script.Parent.Data.Price.Value then
				if db == false then
					db = true
					game.Players:FindFirstChild(script.Parent.Parent.Parent.Data.Owner.Value).Data.Cash.Value -= script.Parent.Data.Price.Value
					for i,v in pairs(script.Parent.Data.Object.Value.Parts:GetChildren()) do
						v.Transparency = 0
						v.CanCollide = true
					end
					script.Parent.Data.Object.Value.UpgradePart.Transparency = 0
					script.Parent.Data.Object.Value.Data.Enabled.Value = true
					script.Parent.BillboardGui.Enabled = false
					local Time = 0.8

					local tweenService = game:GetService("TweenService")
					local Properties = {
						Transparency = 1 --in the bracket : EndPosition of the Part
					}
					local TweenInfoo = TweenInfo.new(Time,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
					local tween = tweenService:Create(script.Parent,TweenInfoo,Properties)

					tween:Play()
					wait(Time)
					script.Parent.CanCollide = false
				end
			end
		end
	end
end)