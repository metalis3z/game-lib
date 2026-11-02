local lolcat = require(script.Parent.Parent.Parent.MainUI.Initiator.Main_Game)
local l__TweenService__2 = game:GetService("TweenService");

game.ReplicatedStorage.ClientBricks:FindFirstChild("GoldAnimation").OnClientEvent:Connect(function(run_id, object, number)
	
	for v14 = 1, math.ceil(math.clamp(number / 6, 1, 25)) do
		local u6 = 0
		task.delay(v14 / 60, function()
			u6 = u6 + 0.1
			local v10 = script.Parent.Parent.Gold:Clone()

			local mth1 = math.random(100, 145)/1000 * math.random(1,3) / math.random(1, 2) -- x
			local mth2 = math.random(150, 225)/1000 * math.random(1,3) / math.random(1, 2) -- y
			local pos1 = script.Parent.Parent.Parent.PermUI.Topbar.Position + UDim2.fromOffset(script.Parent.Parent.Parent.PermUI.Topbar.Gold.Position.X.Offset,script.Parent.Parent.Parent.PermUI.Topbar.Gold.Position.Y.Offset)
			local pos2 = workspace.CurrentCamera:WorldToScreenPoint(object.Position)
			local default = 45
			
			if lolcat.platform == "pc" then
				default = 45
			elseif lolcat.platform == "mobile" then
				default = 55
			else
				default = default or 45
			end
			
			v10.Size = UDim2.new(0, math.random(default - math.random(5, 15), default), 0, math.random(default - math.random(5, 15), default))
			
			v10.Parent = script.Parent.Parent
			v10.Visible = true
			v10.Position = UDim2.new(0, pos2.X, -0.05, pos2.Y)
			script.Parent.Parent.Gold.Sound:Play()
			
			l__TweenService__2:Create(v10, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.fromScale(mth1 + 0.1, mth2 + 0.1),
				--Position = UDim2.new(0, tonumber(v1d), -0.05, tonumber(v2d)),
				AnchorPoint = Vector2.new(0, 0)
			}):Play();
			task.delay(u6, function()
				script.Parent.Parent.Gold.Sound:Play()
				script.Parent.Parent.Gold.Sound.Pitch = 1 + math.random(-100, 100) / 1000;
				u6 = u6 - 0.1
			end)
			task.wait(0.2);
			l__TweenService__2:Create(v10, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position =  pos1,
				ImageTransparency = 1,
			}):Play();
			
			task.wait(0.25);
			
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://138129320"
			sound.Volume = 0.4
			sound.Parent = script
			sound.Pitch = 1 + math.random(-100, 100) / 1000;
			sound:Play()

			sound.Ended:Connect(function()
				sound:Destroy()
			end)

			if run_id ~= "Admin Panel" then
				game.ReplicatedStorage.EntityInfo.GiveGolded:FireServer(5, game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
			end

			v10:Destroy()
		end)
	end
end)
