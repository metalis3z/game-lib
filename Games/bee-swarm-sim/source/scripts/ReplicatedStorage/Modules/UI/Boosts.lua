local Module = {}; do
	local Hover = require(game.ReplicatedStorage.Modules.InfoHover)
	local Utils = require(game.ReplicatedStorage.Modules.Utils)
	local Player = game.Players.LocalPlayer
	local UI = Player.PlayerGui:WaitForChild("UI")
	local Frame = UI.Boosts
	local Template = UI.Client.Boost
	function Module.Update(Boost: string)
		local PlayerData = _G.PData
		local BoostFrame = Frame:FindFirstChild(Boost)
		local BoostData = require(game.ReplicatedStorage.Boosts[Boost])
		if PlayerData.Boosts[Boost] == nil and BoostFrame ~= nil then
			BoostFrame:TweenSize(UDim2.new(0.07, 0, 0.7, 0), "Out", "Back", 0.2, true)
			BoostFrame.Icon:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.2, true)
			task.delay(0.2, function()
				BoostFrame:Destroy()
			end)
			return
		end

		if not BoostFrame then
			BoostFrame = Template:Clone()
			BoostFrame.Name = Boost
			BoostFrame.Icon.Image = BoostData.BoostImage
			BoostFrame.BackgroundColor3 = BoostData.Color
			BoostFrame.Fill.BackgroundColor3 = BoostData.Color
			BoostFrame.Back.BackgroundColor3 = BoostData.SColor
			BoostFrame.Parent = Frame
			
			local FillConnection = nil
			FillConnection = game["Run Service"].RenderStepped:Connect(function(deltaTime)
				if PlayerData.Boosts and PlayerData.Boosts[Boost] and BoostFrame and BoostFrame.Parent ~= nil then
					local Size = math.clamp((PlayerData.Boosts[Boost].Time - os.time()) / BoostData.Time, 0, 1)
					BoostFrame.Fill.Size = UDim2.fromScale(1, Size)
				else
					FillConnection:Disconnect()
				end
			end)
			
			local Connection = nil
			local Entered = false
			BoostFrame.MouseEnter:Connect(function()
				Entered = true
				BoostFrame:TweenSize(UDim2.new(0.1*1.1, 0, 1*1.1, 0), "Out", "Back", 0.2, true)
				Connection = game["Run Service"].RenderStepped:Connect(function()
					local Scale = UI.AbsoluteSize.Y / 1080 * 1.075 --UI.UIScale.Scale
					local Text = Boost
					if PlayerData.Boosts[Boost] then
						for i, Value in BoostData.Boosts do
							Text = Text.."\n"
							local TotalAmount = Value.Amount * (PlayerData.Boosts[Boost].Amount or 1)
							Text = Text .. string.format("%s%s %s", Value.Mod == "Percent" and "+" or "x", Value.Mod == "Percent" and (TotalAmount.."%") or TotalAmount, BoostData.StringNames[i])
						end
						Text = Text.."\n".. Utils:FormatTime(PlayerData.Boosts[Boost].Time - os.time())
					else
						Connection:Disconnect()
						Hover:Remove()
						return
					end
					Hover:UpdateText(Text)
					Hover:Move(UDim2.new(0, game.UserInputService:GetMouseLocation().X / Scale, 0, game.UserInputService:GetMouseLocation().Y / (Scale * 1.1), 0), Scale, Vector2.new(0,0.22))
				end)
			end)

			BoostFrame.MouseLeave:Connect(function()
				Entered = false
				BoostFrame:TweenSize(UDim2.new(0.1, 0, 1, 0), "Out", "Back", 0.3, true)
				if Connection then
					Connection:Disconnect()
				end
				Hover:Remove()
			end)
		end
		BoostFrame:TweenSize(UDim2.new(0.07, 0, 0.7, 0), "Out", "Back", 0.2, true)
		BoostFrame.Icon:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.2, true)
		spawn(function()
			wait(0.2)
			BoostFrame:TweenSize(UDim2.new(0.1, 0, 1, 0), "Out", "Back", 0.3, true)
			BoostFrame.Icon:TweenSize(UDim2.new(0.9, 0, 0.9, 0), "Out", "Back", 0.3, true)
		end)
		BoostFrame.Amount.Text = "x"..PlayerData.Boosts[Boost].Amount
		BoostFrame.Amount.Amount.Text = "x"..PlayerData.Boosts[Boost].Amount
	end
end

return Module