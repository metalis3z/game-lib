--credit to quartz games studio
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local v1 = script.Name
local t = {}
local t2 = {}
local t3 = {}

for v2, v3 in CollectionService:GetTagged(v1) do
	if v3:IsA("BasePart") then
		table.insert(t, v3)
	end
end

CollectionService:GetInstanceAddedSignal(v1):Connect(function(p1) --[[ Line: 17 | Upvalues: t (copy) ]]
	if not p1:IsA("BasePart") then
		return
	end

	table.insert(t, p1)
end)
function t3.Start(p1) --[[ Start | Line: 30 | Upvalues: t (copy), t2 (copy), TweenService (copy) ]]
	task.spawn(function() --[[ Line: 32 | Upvalues: t (ref), t2 (ref), TweenService (ref) ]]
		while true do
			local v1 = (1 / 0)

			for v2, v3 in t do
				if v3.Position.Y < v1 then
					v1 = v3.Position.Y
				end
			end

			for v4, v5 in t do
				if v5.Parent then
					if not t2[v5] then
						t2[v5] = v5.Color
					end

					local v6 = t2[v5]
					local v7, v8, v9 = v6:ToHSV()
					local v10 = Color3.fromHSV(v7, v8, (math.clamp(v9 * 1.5, 0, 1)))

					task.delay((v5.Position.Y - v1) * 0.5, function() --[[ Line: 59 | Upvalues: TweenService (ref), v5 (copy), v10 (copy), v6 (copy) ]]
						local v1 = TweenService:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
							Color = v10
						})
						local v2 = TweenService:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
							Color = v6
						})

						v1:Play()
						v1.Completed:Wait()
						v2:Play()
					end)
				end
			end

			task.wait(2)
		end
	end)
end

return t3