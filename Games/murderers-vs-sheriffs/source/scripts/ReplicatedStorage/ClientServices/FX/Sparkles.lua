local v_u_1 = {}
local v2 = {}
for _, v3 in pairs(script.Parent.FX_Modules:GetChildren()) do
	if v3:IsA("ModuleScript") then
		v_u_1[v3.Name] = require(v3)
	end
end
local v_u_4 = Random.new()
function v2.Play(p_u_5, p6, p7, p8, p_u_9)
	local v_u_10 = p6 or 1
	local v_u_11 = p8 or 1
	local v_u_12 = p_u_5:FindFirstAncestorOfClass("ScreenGui") or (p_u_5:FindFirstAncestorOfClass("BillboardGui") or p_u_5:FindFirstAncestorOfClass("SurfaceGui"))
	if not v_u_12 then
		return function() end
	end
	assert(v_u_12)
	local function v_u_15()
		local v_u_13 = script.Sparkle:Clone()
		v_u_13.Position = UDim2.new(v_u_4:NextNumber(), 0, v_u_4:NextNumber(), 0)
		v_u_13.Size = UDim2.new(0, 0, 0, 0)
		v_u_13.ZIndex = 99
		v_u_13.Parent = p_u_5
		local v14 = v_u_4:NextNumber(0.15 * v_u_10, 0.2 * v_u_10)
		v_u_1.Tween(v_u_13, {
			["Size"] = UDim2.new(v14, 0, v14, 0)
		}, { v_u_4:NextNumber(0.75, 1) * 1 / v_u_11, "Quad", "Out" }).Completed:Connect(function()
			v_u_1.Tween(v_u_13, {
				["Size"] = UDim2.new(0, 0, 0, 0)
			}, { v_u_4:NextNumber(1.75, 2.5) * 1 / v_u_11, "Sine", "InOut" }).Completed:Wait()
			v_u_13:Destroy()
		end)
	end
	local v16 = p7 or 0
	local v17 = typeof(v16) == "number"
	assert(v17)
	local v_u_18 = false
	for _ = 1, 1 + v16 do
		task.spawn(function()
			while not v_u_18 and (p_u_5 and p_u_5.Parent) do
				if v_u_12.Enabled then
					v_u_15()
				end
				if p_u_9 and p_u_9:FindFirstChild("Shimmer") == nil then
					break
				end
				wait(v_u_4:NextNumber(1, 2.5))
			end
		end)
	end
	return function()
		v_u_18 = true
	end
end
return v2
