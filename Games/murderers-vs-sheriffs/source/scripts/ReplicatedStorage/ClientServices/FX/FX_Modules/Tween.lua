local v_u_1 = game:GetService("TweenService")
return function(p2, p3, p4, p5)
	local v6 = type(p2) == "table" and p2 and p2 or { p2 }
	local v7 = {}
	for _, v_u_8 in ipairs(v6) do
		local v9
		if p4 == nil then
			v9 = { 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out }
		else
			if p4[2] == nil then
				p4[2] = Enum.EasingStyle.Sine
			else
				local v10 = p4[2]
				if type(v10) == "string" then
					if string.lower(p4[2]) == "expo" then
						p4[2] = Enum.EasingStyle.Exponential
					else
						p4[2] = Enum.EasingStyle[p4[2]]
					end
				end
			end
			if p4[3] == nil then
				p4[3] = Enum.EasingDirection.InOut
				v9 = p4
			else
				local v11 = p4[3]
				if type(v11) == "string" then
					p4[3] = Enum.EasingDirection[p4[3]]
					v9 = p4
				else
					v9 = p4
				end
			end
		end
		local v12 = TweenInfo.new(unpack(v9))
		local v_u_13 = nil
		if p3.Scale and v_u_8:IsA("Model") then
			v_u_13 = Instance.new("NumberValue")
			v_u_13.Value = v_u_8:GetScale()
			v_u_13.Changed:Connect(function()
				if v_u_8.Parent then
					v_u_8:ScaleTo(v_u_13.Value)
				end
			end)
			p3.Value = p3.Scale
			p3.Scale = nil
		elseif p3.CFrame and v_u_8:IsA("Model") then
			v_u_13 = Instance.new("CFrameValue")
			v_u_13.Value = v_u_8:GetPivot()
			v_u_13.Changed:Connect(function()
				if v_u_8.Parent then
					v_u_8:PivotTo(v_u_13.Value)
				end
			end)
			p3.Value = p3.CFrame
			p3.CFrame = nil
		elseif p3.Position and v_u_8:IsA("Model") then
			v_u_13 = Instance.new("Vector3Value")
			v_u_13.Value = v_u_8:GetPivot().Position
			v_u_13.Changed:Connect(function()
				if v_u_8.Parent then
					local v14 = v_u_8:GetPivot()
					v_u_8:PivotTo(v14 - v14.Position + v_u_13.Value)
				end
			end)
			p3.Value = p3.Position
			p3.Position = nil
		elseif p3.Transparency and (v_u_8:IsA("UIGradient") or v_u_8:IsA("ParticleEmitter")) then
			v_u_13 = Instance.new("NumberValue")
			v_u_13.Value = v_u_8.Transparency.Keypoints[1].Value
			v_u_13.Changed:Connect(function()
				if v_u_8.Parent then
					v_u_8.Transparency = NumberSequence.new(v_u_13.Value)
				end
			end)
			p3.Value = p3.Transparency
			p3.Transparency = nil
		end
		local v_u_15 = v_u_1:Create(v_u_13 or v_u_8, v12, p3)
		if v_u_13 then
			v_u_15.Completed:Once(function()
				v_u_13:Destroy()
			end)
		end
		if p5 then
			task.delay(p5, function()
				v_u_15:Play()
			end)
		else
			v_u_15:Play()
		end
		table.insert(v7, v_u_15)
	end
	return unpack(v7)
end
