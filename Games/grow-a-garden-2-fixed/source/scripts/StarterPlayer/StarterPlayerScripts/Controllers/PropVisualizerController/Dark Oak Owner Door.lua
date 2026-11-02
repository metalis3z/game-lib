--credit to prince games studio
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Trove = require(game.ReplicatedStorage.ClientModules.Trove)
local DoorOpen = game.SoundService.SFX.DoorOpen

return function(p1) --[[ Line: 11 | Upvalues: Players (copy), Trove (copy), CollectionService (copy), DoorOpen (copy), RunService (copy) ]]
	local Core = p1:WaitForChild("Main"):WaitForChild("Core")
	local v1 = Core.Parent
	local v2

	repeat
		v2 = Players:GetPlayerByUserId(p1:GetAttribute("UserId"))

		if v2 then
			continue
		end

		task.wait()
	until v2

	local v3 = Trove.new()

	v3:AttachToInstance(p1)

	local v4 = false
	local v5 = 0

	for v6, v7 in v1:GetChildren() do
		if v7:IsA("BasePart") then
			CollectionService:AddTag(v7, "CrowbarDoor")
			v3:Add(function() --[[ Line: 29 | Upvalues: v7 (copy), CollectionService (ref) ]]
				if not v7.Parent then
					return
				end

				CollectionService:RemoveTag(v7, "CrowbarDoor")
			end)
		end
	end

	local function setDoorState(p1) --[[ setDoorState | Line: 37 | Upvalues: v4 (ref), DoorOpen (ref), v1 (copy) ]]
		if p1 == v4 then
			return
		end

		v4 = p1

		if p1 then
			DoorOpen:Play()
		end

		for v12, v2 in v1:GetChildren() do
			if v2:IsA("BasePart") then
				v2.CanCollide = not p1
				v2.Transparency = if p1 then 0.5 else 0
			end
		end
	end

	local function isNearFace() --[[ isNearFace | Line: 51 | Upvalues: v2 (ref), Core (copy) ]]
		local Character = v2.Character

		if not Character then
			return false
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return false
		end

		local v1 = Core.CFrame:PointToObjectSpace(HumanoidRootPart.Position)
		local v22 = Core.Size / 2

		return if math.abs(v1.Z) <= v22.Z + 2 then if math.abs(v1.X) <= v22.X + 2 then if math.abs(v1.Y) <= v22.Y + 2 then math.abs(v1.Z) >= v22.Z - 2 else false else false else false
	end

	local v8 = 0

	v3:Connect(RunService.Heartbeat, function(p12) --[[ Line: 66 | Upvalues: v8 (ref), Core (copy), p1 (copy), setDoorState (copy), isNearFace (copy), v5 (ref) ]]
		v8 = v8 + p12

		if v8 < 0.1 then
			return
		end

		v8 = 0

		if not Core.Parent then
			return
		end

		if p1:GetAttribute("ForcedOpen") then
			setDoorState(true)

			return
		end

		local v1 = isNearFace()

		if v1 then
			v5 = os.clock()
		end

		setDoorState(if v1 then v1 else os.clock() - v5 < 2.5)
	end)
end