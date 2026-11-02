--credit to prince games studio
local t = {}

t.__index = t

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local t2 = {
	List = nil,
	Fetched = false
}

local function FetchFriendList(p1) --[[ FetchFriendList | Line: 18 | Upvalues: t2 (copy), Players (copy) ]]
	if t2.Fetched then
		return t2.List
	end

	t2.Fetched = true

	local LocalPlayer = Players.LocalPlayer

	if not LocalPlayer then
		t2.List = {}

		return t2.List
	end

	local ok, result = pcall(function() --[[ Line: 29 | Upvalues: Players (ref), LocalPlayer (copy) ]]
		return Players:GetFriendsAsync(LocalPlayer.UserId)
	end)

	if not (ok and result) then
		t2.List = {}

		return t2.List
	end

	local count = 0
	local t = {}

	repeat
		if not (count < p1) then
			break
		end

		local ok2, result2 = pcall(function() --[[ Line: 41 | Upvalues: result (copy) ]]
			return result:GetCurrentPage()
		end)

		if not (ok2 and result2) then
			break
		end

		for v1, v2 in result2 do
			table.insert(t, v2)
			count = count + 1

			if p1 <= count then
				break
			end
		end
	until result.IsFinished or not pcall(function() --[[ Line: 51 | Upvalues: result (copy) ]]
		result:AdvanceToNextPageAsync()
	end)

	t2.List = t

	return t
end

function t.new(p1) --[[ new | Line: 60 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Plot = p1.Plot
	v2.PlayerModel = p1.PlayerModel
	v2.PlayerHumanoid = p1.PlayerHumanoid
	v2.Camera = p1.Camera
	v2.Trove = p1.Trove
	v2.GearData = p1.GearData
	v2.Options = p1.Options
	v2.ActiveTracks = {}
	v2.ActiveCameraTween = nil
	v2.Trove:Add(function() --[[ Line: 73 | Upvalues: v2 (copy) ]]
		for v1, v22 in v2.ActiveTracks do
			if v22 then
				v22:Stop(0)
			end
		end

		v2.ActiveTracks = {}

		if not v2.ActiveCameraTween then
			return
		end

		v2.ActiveCameraTween:Cancel()
		v2.ActiveCameraTween = nil
	end)

	return v2
end
function t.SpawnDummy(p1, p2, p3) --[[ SpawnDummy | Line: 88 | Upvalues: ReplicatedStorage (copy) ]]
	local v1

	if typeof(p2) == "string" then
		local SceneAssets = ReplicatedStorage:FindFirstChild("SceneAssets")

		if SceneAssets then
			SceneAssets = SceneAssets:FindFirstChild("Dummies")
		end

		v1 = if SceneAssets then SceneAssets:FindFirstChild(p2) else p2
	else
		v1 = p2
	end

	if not v1 then
		return nil
	end

	local v3 = v1:Clone()

	v3.Parent = p1.Plot

	if p3 then
		local v4 = if typeof(p3) == "CFrame" and p3 then p3 else CFrame.new(p3)

		if v3.PrimaryPart then
			v3:PivotTo(v4)
		end
	end

	p1.Trove:Add(v3)

	return v3
end
function t.PlayAnimation(p1, p2, p3, p4) --[[ PlayAnimation | Line: 114 ]]
	local v1 = if p3 then p3 else p1.PlayerHumanoid

	if not v1 then
		return nil
	end

	local v2, v3

	if typeof(p2) == "Instance" then
		v2 = p2
		v3 = false
	else
		local Animation = Instance.new("Animation")

		v3 = true

		if typeof(p2) == "number" then
			Animation.AnimationId = ("rbxassetid://%*"):format(p2)
		else
			Animation.AnimationId = tostring(p2)
		end

		v2 = Animation
	end

	local v4 = v1:LoadAnimation(v2)
	local v5

	if not v3 then
		v4:Play(p4 or 0.1)
		v5 = p1.ActiveTracks
		table.insert(v5, v4)
		p1.Trove:Add(function() --[[ Line: 141 | Upvalues: v4 (copy) ]]
			if not v4 then
				return
			end

			v4:Stop(0)
		end)

		return v4
	end

	v2:Destroy()
	v4:Play(p4 or 0.1)
	v5 = p1.ActiveTracks
	table.insert(v5, v4)
	p1.Trove:Add(function() --[[ Line: 141 | Upvalues: v4 (copy) ]]
		if not v4 then
			return
		end

		v4:Stop(0)
	end)

	return v4
end
function t.SpawnProp(p1, p2, p3) --[[ SpawnProp | Line: 149 | Upvalues: ReplicatedStorage (copy) ]]
	local v1

	if typeof(p2) == "string" then
		local SceneAssets = ReplicatedStorage:FindFirstChild("SceneAssets")

		if SceneAssets then
			SceneAssets = SceneAssets:FindFirstChild("Props")
		end

		v1 = if SceneAssets then SceneAssets:FindFirstChild(p2) else p2
	else
		v1 = p2
	end

	if not v1 then
		return nil
	end

	local v3 = v1:Clone()

	v3.Parent = p1.Plot

	if p3 then
		local v4 = if typeof(p3) == "CFrame" and p3 then p3 else CFrame.new(p3)

		if v3:IsA("Model") then
			if v3.PrimaryPart then
				v3:PivotTo(v4)
			end
		elseif v3:IsA("BasePart") then
			v3.CFrame = v4
		end
	end

	p1.Trove:Add(v3)

	return v3
end
function t.SetCamera(p1, p2, p3) --[[ SetCamera | Line: 179 ]]
	p1.Camera.CameraType = Enum.CameraType.Scriptable
	p1.Camera.CFrame = p2

	if not p3 then
		return
	end

	p1.Camera.FieldOfView = p3
end
function t.CameraShot(p1, p2, p3) --[[ CameraShot | Line: 189 | Upvalues: TweenService (copy) ]]
	local v1 = if p3 then p3 else {}

	p1.Camera.CameraType = Enum.CameraType.Scriptable

	if p1.ActiveCameraTween then
		p1.ActiveCameraTween:Cancel()
		p1.ActiveCameraTween = nil
	end

	local v6 = TweenInfo.new(v1.Duration or 1, v1.EasingStyle or Enum.EasingStyle.Quad, v1.EasingDirection or Enum.EasingDirection.InOut)
	local t = {
		CFrame = p2
	}

	if v1.FieldOfView then
		t.FieldOfView = v1.FieldOfView
	end

	local v7 = TweenService:Create(p1.Camera, v6, t)

	p1.ActiveCameraTween = v7
	v7:Play()

	return v7
end
function t.OrbitCamera(p1, p2, p3) --[[ OrbitCamera | Line: 216 | Upvalues: RunService (copy) ]]
	local v1 = p3 or {}
	local v2 = v1.Radius or 8
	local v3 = v1.Height or 4
	local v4 = v1.Speed or 0.4
	local FieldOfView = v1.FieldOfView

	p1.Camera.CameraType = Enum.CameraType.Scriptable

	if FieldOfView then
		p1.Camera.FieldOfView = FieldOfView
	end

	local v5 = 0
	local v6 = RunService.RenderStepped:Connect(function(p12) --[[ Line: 229 | Upvalues: v5 (ref), v4 (copy), p2 (copy), v2 (copy), v3 (copy), p1 (copy) ]]
		v5 = v5 + p12 * v4
		p1.Camera.CFrame = CFrame.lookAt(p2 + Vector3.new(math.cos(v5) * v2, v3, math.sin(v5) * v2), p2)
	end)

	p1.Trove:Add(v6)

	return v6
end
function t.Wait(p1, p2) --[[ Wait | Line: 239 ]]
	task.wait(p2)
end
function t.GetGearModel(p1) --[[ GetGearModel | Line: 244 ]]
	return p1.GearData and (p1.GearData.Model or p1.GearData.Tool)
end
function t.ApplyRandomFriendAppearance(p1, p2, p3) --[[ ApplyRandomFriendAppearance | Line: 249 | Upvalues: FetchFriendList (copy), Players (copy) ]]
	if not p2 then
		return false
	end

	local Humanoid = p2:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return false
	end

	local v1 = FetchFriendList(p3 or 50)

	if not v1 or #v1 == 0 then
		return false
	end

	local v2 = v1[math.random(1, #v1)]

	if not (v2 and v2.Id) then
		return false
	end

	local ok, result = pcall(function() --[[ Line: 260 | Upvalues: Players (ref), v2 (copy) ]]
		return Players:GetHumanoidDescriptionFromUserIdAsync(v2.Id)
	end)

	if ok and result then
		return pcall(function() --[[ Line: 265 | Upvalues: Humanoid (copy), result (copy) ]]
			Humanoid:ApplyDescriptionResetAsync(result)
		end)
	end

	return false
end

return t