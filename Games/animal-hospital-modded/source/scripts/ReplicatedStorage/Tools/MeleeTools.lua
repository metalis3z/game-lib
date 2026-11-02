local CollectionService = game.CollectionService
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

game:GetService("RunService")
game:GetService("Debris")

local v1 = nil
local v2 = nil
local v3 = nil
local LocalPlayer = game.Players.LocalPlayer
local Handle = script.Parent.Handle

Tool = script.Parent

local function createDebugRaycast(p1, p2, p3) --[[ createDebugRaycast | Line: 18 ]] end

local function raycastDetection(p1) --[[ raycastDetection | Line: 39 | Upvalues: v1 (ref), v2 (ref), Handle (copy), CollectionService (copy), Lib (copy) ]]
	local t = {}
	local t2 = {}
	local t3 = {}
	local t4 = {}
	local v12 = p1 or v1 or v2

	for i, v in ipairs(Handle:GetChildren()) do
		if v:IsA("Attachment") and v.Name == "MeleeAt" then
			table.insert(t3, v)
			t[v] = v.WorldPosition
		end
	end

	local v22 = RaycastParams.new()

	v22.FilterType = Enum.RaycastFilterType.Include
	v22.FilterDescendantsInstances = CollectionService:GetTagged("Zombie")
	task.wait(0.2)

	local v3 = nil

	v3 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 61 | Upvalues: v12 (copy), v3 (ref), t (ref), t2 (ref), t3 (ref), t4 (ref), v22 (copy), Lib (ref), Handle (ref) ]]
		if v12.IsPlaying then
			for i, v in ipairs(t3) do
				local WorldPosition = v.WorldPosition
				local v1 = t[v]

				if v1 then
					local v2 = WorldPosition - v1

					if v2.Magnitude > 0.1 then
						local v32 = workspace:Raycast(v1, v2, v22)

						if v32 then
							local v4 = v32.Instance.Parent

							if v4 and (v4:HasTag("Zombie") and not t2[v4]) then
								t2[v4] = true
								Lib.Network:FireServer("HitZombie", v4, Handle, v32.Position)
								_ = true
							end
						end

						local v5 = nil

						if v5 then
							table.insert(t4, v5)
						end

						for v7, v8 in t2 do
							Lib.RedFlashModel(v7)
						end
					end
				end

				t[v] = WorldPosition
			end
		else
			v3:Disconnect()
			t = {}
			t2 = {}
			t3 = {}

			for i, v in ipairs(t4) do
				if v and v.Parent then
					v:Destroy()
				end
			end

			t4 = {}
		end
	end)
end

local v4 = OverlapParams.new()
local t = {}

local function hitBoxDetection(p1) --[[ hitBoxDetection | Line: 118 | Upvalues: t (ref), LocalPlayer (copy), v4 (copy), CollectionService (copy), Lib (copy), Handle (copy) ]]
	local Part = Instance.new("Part")

	Part.Size = Vector3.new(5, 7, 5)
	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 1
	task.wait(0.2)
	t = {}
	Part.Parent = workspace

	while p1.IsPlaying do
		Part.CFrame = LocalPlayer.Character.PrimaryPart.CFrame + LocalPlayer.Character.PrimaryPart.CFrame.lookVector * 2.5 - Vector3.new(0, 1, 0)
		v4.FilterDescendantsInstances = CollectionService:GetTagged("Zombie")
		v4.FilterType = Enum.RaycastFilterType.Include

		local t2 = {}

		for i, v in ipairs((workspace:GetPartsInPart(Part, v4))) do
			local Humanoid = v.Parent:FindFirstChild("Humanoid")

			if Humanoid and not t[Humanoid] then
				t2[#t2 + 1] = v.Parent
				t[Humanoid] = true
				Lib.RedFlashModel(Humanoid.Parent)
			end
		end

		if #t2 > 0 then
			Lib.Network:FireServer("HitMultipleZombies", t2, Handle)
		end

		task.wait(0.03)
	end

	Part:Destroy()
end

local v5 = 1

local function attack() --[[ attack | Line: 167 | Upvalues: v2 (ref), v5 (ref), v1 (ref), Handle (copy), hitBoxDetection (copy) ]]
	local v12 = v2

	if v5 == 1 then
		v12 = v1
	end

	v12:Play()
	v5 = (v5 + 1) % 2
	Handle.Woosh:Play()
	hitBoxDetection(v12)

	return v12
end

Tool.Enabled = true

local function onActivated() --[[ onActivated | Line: 184 | Upvalues: v2 (ref), v5 (ref), v1 (ref), Handle (copy), hitBoxDetection (copy) ]]
	if not Tool.Enabled then
		return
	end

	Tool.Enabled = false

	local v12 = v2

	if v5 == 1 then
		v12 = v1
	end

	v12:Play()
	v5 = (v5 + 1) % 2
	Handle.Woosh:Play()
	hitBoxDetection(v12)
	task.wait(v12.Length / v12.Speed - 0.2)
	Tool.Enabled = true
end

local function onEquipped() --[[ onEquipped | Line: 199 | Upvalues: v1 (ref), v3 (ref), v2 (ref) ]]
	if not v1 then
		v1 = Tool.Parent:WaitForChild("Humanoid"):LoadAnimation(game.ReplicatedStorage.Animations.Tools.Slash)
		v2 = Tool.Parent:WaitForChild("Humanoid"):LoadAnimation(game.ReplicatedStorage.Animations.Tools.Slash2)
		v3 = Tool.Parent:WaitForChild("Humanoid"):LoadAnimation(game.ReplicatedStorage.Animations.Tools.EquipMelee)
	end

	Tool.Handle.UnsheathSound:Play()
	v3:Play()
end

script.Parent.Activated:connect(onActivated)
script.Parent.Equipped:connect(onEquipped)

return {}