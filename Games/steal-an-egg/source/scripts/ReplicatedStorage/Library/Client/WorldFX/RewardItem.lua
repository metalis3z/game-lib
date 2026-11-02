-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Library = ReplicatedStorage:WaitForChild("Library")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local __DEBRIS = workspace:WaitForChild("__DEBRIS")
local Functions = require(Library.Functions)
local ItemUI = require(ReplicatedStorage.Library.Client.UI.ItemUI)
local Player = require(ReplicatedStorage.Library.Player)

return function(p1, p2, p3) --[[ createRewardItemBillboard | Line: 11 | Upvalues: Player (copy), Assets (copy), __DEBRIS (copy), ItemUI (copy), Functions (copy), RunService (copy) ]]
	if typeof(p1) == "Instance" and p1:IsA("Player") then
		local v1 = Player.Optional.PrimaryPart(p1)

		assert(v1)

		local v2 = 3 + math.random() * 3
		local v3 = math.random() * 2 * math.pi

		p1 = CFrame.new(v1.Position + v2 * Vector3.new(math.cos(v3), 0, (math.sin(v3))))
	elseif typeof(p1) == "Vector3" then
		p1 = CFrame.new(p1)
	elseif typeof(p1) ~= "CFrame" then
		p1 = nil
	end

	assert(p1)

	local v10 = (p3 or {}).time or 3
	local v11 = Assets.Billboards:FindFirstChild("RewardItem"):Clone()
	local RewardBillboard = Instance.new("Part")

	RewardBillboard.Anchored = true
	RewardBillboard.CanCollide = false
	RewardBillboard.Size = Vector3.new()
	RewardBillboard.Transparency = 1
	RewardBillboard.CFrame = p1
	RewardBillboard.Name = "RewardBillboard"
	RewardBillboard.Parent = __DEBRIS

	local t = {
		HideStrength = true,
		NoOverlay = true,
		NoScribble = true
	}

	t.HideQuantity = p2:GetAmount() == 1

	local v13 = ItemUI.Create(p2, t)

	v13.BackgroundTransparency = 1
	v13.AnchorPoint = Vector2.new(0.5, 0.5)
	v13.Size = UDim2.new(0.35, 0, 0.35, 0)
	v13.Position = UDim2.new(0.5, 0, 0.5, 0)
	v13.Parent = v11
	v11.Parent = RewardBillboard
	coroutine.wrap(function() --[[ Line: 47 | Upvalues: v11 (copy), Functions (ref) ]]
		local Size = v11.Size

		v11.Size = UDim2.new(v11.Size.X.Scale * 1.3, v11.Size.X.Offset * 1.3, v11.Size.Y.Scale * 1.3, v11.Size.Y.Offset * 1.3)
		Functions.Wait(0.05)
		Functions.Tween(v11, {
			Size = Size
		}, { 0.1, "Sine", "Out" })
	end)()
	coroutine.wrap(function() --[[ Line: 60 | Upvalues: v11 (copy), v10 (copy), Functions (ref), RunService (ref) ]]
		local v1 = os.clock()
		local StudsOffsetWorldSpace = v11.StudsOffsetWorldSpace

		while os.clock() - v1 <= v10 do
			v11.StudsOffsetWorldSpace = StudsOffsetWorldSpace + Vector3.new(0, 3 * Functions.Easing((os.clock() - v1) / v10, "Linear", "InOut"), 0)
			RunService.RenderStepped:Wait()
		end
	end)()

	local v14 = nil

	for i, v in ipairs(v11:GetDescendants()) do
		if v.ClassName == "TextLabel" then
			v14 = Functions.Tween(v, {
				TextTransparency = 1,
				TextStrokeTransparency = 1
			}, { 0.5, "Linear", "Out" }, v10 - 0.5)

			continue
		end

		if v.ClassName == "ImageLabel" then
			v14 = Functions.Tween(v, {
				ImageTransparency = 1
			}, { 0.5, "Linear", "Out" }, v10 - 0.5)

			continue
		end

		if v.ClassName == "UIStroke" then
			Functions.Tween(v, {
				Transparency = 1
			}, { 0.5, "Linear", "Out" }, v10 - 0.5)
		end
	end

	v14.Completed:Connect(function() --[[ Line: 86 | Upvalues: RewardBillboard (copy) ]]
		RewardBillboard:Destroy()
	end)

	return v11
end