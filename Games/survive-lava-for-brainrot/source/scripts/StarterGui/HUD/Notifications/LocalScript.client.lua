-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("TextService")
local v_u_3 = TweenInfo.new(0.1)
local v_u_4 = script:WaitForChild("Message")
function GetScaledTextSize(p5)
	-- upvalues: (copy) v_u_2
	local v6 = p5.Parent.AbsoluteSize.Y * 0.8
	local v7 = math.clamp(v6, 5, 100)
	return v_u_2:GetTextSize(p5.Text, v7, p5.Font, Vector2.new(10000, 10000)), v7
end
function CenterMessage(p8)
	local v9 = p8.PlayerImage
	local v10 = p8.MessageText
	local v11 = p8.AbsoluteSize
	if v11.X ~= 0 and v11.Y ~= 0 then
		local v12, v13 = GetScaledTextSize(v10)
		local v14 = v9.AbsoluteSize.X
		local v15 = v9.AbsoluteSize.Y
		local v16 = v12.X
		local v17 = v12.Y
		local v18 = v14 + 10 + v16
		local v19 = v14 / v11.X
		local v20 = v16 / v11.X
		local v21 = (1 - v18 / v11.X) / 2
		v9.Size = UDim2.new(v19, 0, v9.Size.Y.Scale, 0)
		v9.Position = UDim2.new(v21, 0, 0.5, -v15 / 2)
		v10.Size = UDim2.new(v20, 0, v10.Size.Y.Scale, 0)
		v10.Position = UDim2.new(v21 + v19 + 10 / v11.X, 0, 0.5, -v17 / 2)
		v10.TextSize = v13
	end
end
function MakeMessage(p22, p23)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_3
	local v24 = script.Parent
	local v_u_25 = v_u_4:Clone()
	v_u_25.Visible = false
	v_u_25.Parent = v24
	local v26 = v_u_25.PlayerImage
	local v27 = v_u_25.MessageText
	v26.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p23)
	v27.Text = p22
	v_u_25.AnchorPoint = Vector2.new(0.5, 0.5)
	v_u_25.Position = UDim2.new(0.5, 0, 0.5, 0)
	local v28 = v_u_25.Size
	v_u_25.Size = UDim2.new(0, 0, 0, 0)
	v_u_1:Create(v_u_25, v_u_3, {
		["Size"] = v28
	}):Play()
	task.delay(10, function()
		-- upvalues: (ref) v_u_1, (copy) v_u_25, (ref) v_u_3
		v_u_1:Create(v_u_25, v_u_3, {
			["Size"] = UDim2.fromScale(0, 0)
		}):Play()
		task.wait(v_u_3.Time)
		v_u_25:Destroy()
	end)
	task.delay(0, function()
		-- upvalues: (copy) v_u_25
		v_u_25.Visible = true
	end)
	v_u_25:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) v_u_25
		CenterMessage(v_u_25)
	end)
end
game.ReplicatedStorage.Events.GlobalNotification.OnClientEvent:Connect(function(p29, p30)
	MakeMessage(p29, p30)
end)
