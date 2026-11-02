-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")

return function(p1, p2, p3, p4) --[[ Line: 9 | Upvalues: TweenService (copy) ]]
	local t = {}

	for i, v in ipairs(type(p1) ~= "table" and { p1 } or p1) do
		local v2 = if p3 then p3 else { 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out }

		if p3 then
			if p3[2] then
				local v3 = p3[2]

				if type(v3) == "string" then
					if string.lower(v3) == "expo" then
						p3[2] = Enum.EasingStyle.Exponential
					else
						local v4 = Enum.EasingStyle[v3]

						p3[2] = assert(v4, (("Invalid easing style provided: \"%*\""):format(v3)))
					end
				end
			else
				p3[2] = Enum.EasingStyle.Sine
			end

			if p3[3] then
				local v6 = p3[3]

				if typeof(v6) == "string" then
					local v7 = Enum.EasingDirection[v6]

					p3[3] = assert(v7, (("Invalid easing direction provided: \"%*\""):format(v6)))
				end
			else
				p3[3] = Enum.EasingDirection.InOut
			end
		end

		local v9 = TweenInfo.new(unpack(v2))
		local v10 = nil

		if v:IsA("Model") then
			if p2.Scale then
				v10 = Instance.new("NumberValue")
				v10.Value = v:GetScale()
				v10.Changed:Connect(function() --[[ Line: 62 | Upvalues: v (copy), v10 (ref) ]]
					if not v.Parent then
						return
					end

					v:ScaleTo(v10.Value)
				end)
				p2.Value = p2.Scale
				p2.Scale = nil
			elseif p2.CFrame then
				v10 = Instance.new("CFrameValue")
				v10.Value = v:GetPivot()
				v10.Changed:Connect(function() --[[ Line: 76 | Upvalues: v (copy), v10 (ref) ]]
					if not v.Parent then
						return
					end

					v:PivotTo(v10.Value)
				end)
				p2.Value = p2.CFrame
				p2.CFrame = nil
			elseif p2.Position then
				v10 = Instance.new("Vector3Value")
				v10.Value = v:GetPivot().Position
				v10.Changed:Connect(function() --[[ Line: 90 | Upvalues: v (copy), v10 (ref) ]]
					if not v.Parent then
						return
					end

					local v1 = v:GetPivot()

					v:PivotTo(v1 - v1.Position + v10.Value)
				end)
				p2.Value = p2.Position
				p2.Position = nil
			end
		end

		local v11 = TweenService:Create(v10 or v, v9, p2)

		if v10 then
			v11.Completed:Once(function() --[[ Line: 106 | Upvalues: v10 (ref) ]]
				v10:Destroy()
			end)
		end

		if p4 then
			task.delay(p4, function() --[[ Line: 113 | Upvalues: v11 (copy) ]]
				v11:Play()
			end)
		else
			v11:Play()
		end

		table.insert(t, v11)
	end

	return unpack(t)
end