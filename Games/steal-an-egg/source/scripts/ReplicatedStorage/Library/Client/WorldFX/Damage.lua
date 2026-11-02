-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Functions = require(Library.Functions)
local Assets = ReplicatedStorage:WaitForChild("Assets")
local RunService = game:GetService("RunService")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = Random.new()

return function(p1, p2, p3) --[[ Line: 34 | Upvalues: Constants (copy), Assets (copy), Functions (copy), v1 (copy), RunService (copy) ]]
	local v12 = if p3 == true then true else false
	local RewardBillboard = Instance.new("Part")

	RewardBillboard.Anchored = true
	RewardBillboard.CanCollide = false
	RewardBillboard.Size = Vector3.new(0.05, 0.05, 0.05)
	RewardBillboard.CastShadow = false
	RewardBillboard.Transparency = 1
	RewardBillboard.CFrame = p1
	RewardBillboard.Name = "RewardBillboard"
	RewardBillboard.Parent = workspace:WaitForChild("__DEBRIS", Constants.STUDIO_YIELD_TIMEOUT)

	local v3 = Assets.Billboards:FindFirstChild(if v12 then "Critical" else "Damage"):Clone()

	v3.Parent = RewardBillboard

	local v4 = Functions.Commas(p2 or 0)

	v3.Damage.Text = v4

	for i, v in ipairs(v3.Damage:GetChildren()) do
		if v.ClassName == "TextLabel" then
			v.Text = v4
		end
	end

	coroutine.wrap(function() --[[ Line: 58 | Upvalues: v3 (copy), v12 (copy), Functions (ref) ]]
		local Size = v3.Size
		local v1 = if v12 then 3 else 2

		v3.Size = UDim2.new(v3.Size.X.Scale * v1, v3.Size.X.Offset * v1, v3.Size.Y.Scale * v1, v3.Size.Y.Offset * v1)
		Functions.Wait(if v12 then 0.08 else 0.05)
		Functions.Tween(v3, {
			Size = Size
		}, { 0.1, "Sine", "Out" })
	end)()

	if v12 then
		coroutine.wrap(function() --[[ Line: 72 | Upvalues: v3 (copy), Functions (ref) ]]
			v3.Damage:FindFirstChildOfClass("UIGradient").Enabled = false
			Functions.Wait(0.05)
			v3.Damage:FindFirstChildOfClass("UIGradient").Enabled = true
		end)()
	end

	coroutine.wrap(function() --[[ Line: 79 | Upvalues: v1 (ref), Functions (ref), v3 (copy), RunService (ref) ]]
		local v12 = os.clock()
		local v2 = v1:NextNumber(-3, 3)
		local v32 = v1:NextNumber(3.5, 5)
		local v4 = v1:NextNumber(-3, 3)

		while os.clock() - v12 <= 1.3 do
			local v5 = Functions.Easing((os.clock() - v12) / 1.3, "Sine", "Out")

			v3.StudsOffsetWorldSpace = Vector3.new(v2 * v5, v32 * v5 * math.sin(v5 * math.pi), v4 * v5)
			RunService.RenderStepped:Wait()
		end
	end)()
	Functions.Tween(v3, {
		Size = UDim2.new(0, 0, 0, 0)
	}, { 0.4, "Back", "Out" }, 0.9).Completed:Connect(function() --[[ Line: 96 | Upvalues: RewardBillboard (copy) ]]
		RewardBillboard:Destroy()
	end)
end