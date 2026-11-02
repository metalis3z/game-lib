-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Library = ReplicatedStorage:WaitForChild("Library")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local __DEBRIS = workspace:WaitForChild("__DEBRIS")
local Functions = require(Library.Functions)

return function(p1, p2, p3, p4) --[[ RewardBillboard | Line: 8 | Upvalues: __DEBRIS (copy), Assets (copy), Functions (copy), RunService (copy) ]]
	if typeof(p1) == "Vector3" then
		p1 = CFrame.new(p1) or p1
	end

	local v1 = p4 or 2
	local RewardBillboard = Instance.new("Part")

	RewardBillboard.Anchored = true
	RewardBillboard.CanCollide = false
	RewardBillboard.Size = Vector3.new(0.05, 0.05, 0.05)
	RewardBillboard.Transparency = 1
	RewardBillboard.CFrame = p1
	RewardBillboard.Name = "RewardBillboard"
	RewardBillboard.Parent = __DEBRIS

	local v2 = Assets.Billboards:FindFirstChild(p3):Clone()
	local v3 = v2:GetDescendants()

	if p2 then
		for i, v in ipairs(v3) do
			if v:IsA("TextLabel") then
				v.Text = p2
			end
		end
	end

	local Size = v2.Size

	v2.Size = UDim2.new(v2.Size.X.Scale * 0.5, v2.Size.X.Offset * 0.5, v2.Size.Y.Scale * 0.5, v2.Size.Y.Offset * 0.5)
	Functions.Tween(v2, {
		Size = Size
	}, { 0.5, "Expo", "Out" })
	v2.Parent = RewardBillboard
	task.spawn(function() --[[ Line: 41 | Upvalues: v2 (copy), v1 (copy), Functions (ref), RunService (ref) ]]
		local v12 = os.clock()
		local StudsOffsetWorldSpace = v2.StudsOffsetWorldSpace

		while v2 and (v2.Parent and os.clock() - v12 <= v1) do
			v2.StudsOffsetWorldSpace = StudsOffsetWorldSpace + Vector3.new(0, 3 * Functions.Easing((os.clock() - v12) / v1, "Linear", "InOut"), 0)
			RunService.RenderStepped:Wait()
		end
	end)

	local v4 = nil

	for i, v in ipairs(v2:GetDescendants()) do
		if v.ClassName == "TextLabel" then
			v4 = Functions.Tween(v, {
				TextTransparency = 1,
				TextStrokeTransparency = 1
			}, { 0.5, "Linear", "Out" }, v1 - 0.5)

			continue
		end

		if v.ClassName == "ImageLabel" then
			v4 = Functions.Tween(v, {
				ImageTransparency = 1
			}, { 0.5, "Linear", "Out" }, v1 - 0.5)

			continue
		end

		if v.ClassName == "UIStroke" then
			Functions.Tween(v, {
				Transparency = 1
			}, { 0.5, "Linear", "Out" }, v1 - 0.5)
		end
	end

	v4.Completed:Connect(function() --[[ Line: 67 | Upvalues: RewardBillboard (copy) ]]
		RewardBillboard:Destroy()
	end)

	return v2, RewardBillboard
end