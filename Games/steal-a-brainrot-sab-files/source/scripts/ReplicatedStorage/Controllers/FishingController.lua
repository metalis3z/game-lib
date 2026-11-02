-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.VFX)
local AssetLibrary = require(ReplicatedStorage.Shared.BrainrotAssets)
local t1 = {}
local t2 = {}

local function loadAnimation(p1, p2, p3)
	local track = p1:LoadAnimation(p2)

	p3:Add(function()
		track:Stop(0)
		track:Destroy()
	end)

	return track
end
local function PointInTriangleXZ(p4, p5, p6, p7)
	local v19 = vector.create(p4.X, 0, p4.Z)
	local v20 = vector.create(p5.X, 0, p5.Z)
	local v21 = vector.create(p6.X, 0, p6.Z)
	local v22 = vector.create(p7.X, 0, p7.Z) - v20
	local v23 = v21 - v20
	local v24 = v19 - v20
	local v25 = v22:Dot(v22)
	local v26 = v22:Dot(v23)
	local v27 = v22:Dot(v24)
	local v28 = v23:Dot(v23)
	local v29 = v23:Dot(v24)
	local v30 = v25 * v28 - v26 * v26

	if v30 == 0 then
		return false
	end

	local v31 = (v28 * v27 - v26 * v29) / v30
	local v32 = (v25 * v29 - v26 * v27) / v30

	return v31 >= 0 and (v32 >= 0 and v31 + v32 <= 1)
end
local function ProjectPointOntoTriangle(p8, p9, p10, p11)
	local Unit = (p10 - p9):Cross(p11 - p9).Unit

	return p8 - Unit * (p8 - p9):Dot(Unit)
end

function t2.WaterSurfacePoint(_: {[any]: any}, vector3: Vector3)
	for _, v41 in t1 do
		local v42, v43, v44 = unpack(v41)
		local WorldPosition = v42.WorldPosition
		local WorldPosition2 = v43.WorldPosition
		local WorldPosition3 = v44.WorldPosition

		if PointInTriangleXZ(vector3, WorldPosition, WorldPosition2, WorldPosition3) then
			local v48 = v42.Bone.WorldPosition + v42.Bone.Transform.Position
			local v49 = v43.Bone.WorldPosition + v43.Bone.Transform.Position
			local v50 = v44.Bone.WorldPosition + v44.Bone.Transform.Position
			local Unit = (v49 - v48):Cross(v50 - v48).Unit

			return vector3 - Unit * (vector3 - v48):Dot(Unit)
		end
	end

	return vector3
end
function t2.Start(_)
	Observers.observeTag("FishingCatchZone", function(p13)
		task.wait(1)

		local v54 = Trove.new()

		if p13:FindFirstChild("PoolVFX") then
			p13:FindFirstChild("PoolVFX"):Destroy()
		end

		local Pool = p13:GetAttribute("Pool")
		local Pool2 = script.PoolVFX:FindFirstChild(Pool)

		Pool2.Name = "PoolVFX"
		Pool2:PivotTo(p13.CFrame * CFrame.Angles(1.5707963267948966, 0, 0))
		Pool2.Parent = p13
		v54:Add(function()
			VFX.disable(Pool2)
			task.wait(2)
			Pool2:Destroy()
		end)

		local Pool3 = AssetLibrary.getModel(Pool)

		if Pool3 and Pool2:FindFirstChild("Animation") then
			local clone = v54:Clone(Pool3)

			clone.PrimaryPart.Anchored = true
			clone:PivotTo(CFrame.new(p13.Position))
			clone.Parent = p13

			local Animator = clone:FindFirstChildWhichIsA("Animator", true)

			if Animator then
				local track = Animator:LoadAnimation(Pool2.Animation)

				v54:Add(function()
					track:Stop(0)
					track:Destroy()
				end)

				local v61 = track

				v61.Looped = true
				v61:Play()
			end
		end

		return v54:WrapClean()
	end)
	Observers.observeTag("FishingWater", function(p14)
		local t4 = {}

		for _, child in p14:GetChildren() do
			if child:IsA("Bone") then
				local Order = child:GetAttribute("Order")
				local t5 = {
					Order = Order,
					X = (Order - 1) % 5 + 1,
					Y = math.floor((Order - 1) / 5) + 1,
					WorldPosition = child.WorldPosition,
					Bone = child
				}

				t4[vector.create(t5.X, t5.Y)] = t5
			end
		end

		local t6 = {}

		for _, v70 in t4 do
			local X = v70.X
			local Y = v70.Y

			if X < 5 then
				local v73 = t4[vector.create(X, Y)]
				local v74 = t4[vector.create(X + 1, Y)]
				local v75 = t4[vector.create(X, Y + 1)]
				local v76 = t4[vector.create(X + 1, Y + 1)]

				if v73 and v74 and v75 and v76 then
					table.insert(t6, {
						v73,
						v74,
						v75
					})
					table.insert(t6, {
						v74,
						v76,
						v75
					})
				end
			end
		end

		t1 = t6

		return function()
			t1 = nil
		end
	end)
	Observers.observeTag("FishingBobber", function(p15)
		local RopeConstraint = p15:WaitForChild("RopeConstraint", 30)
		local Beam = Instance.new("Beam")

		Beam.Attachment0 = RopeConstraint.Attachment0
		Beam.Attachment1 = RopeConstraint.Attachment1
		Beam.TextureSpeed = 0
		Beam.Segments = 1
		Beam.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
		Beam.Width0 = 0.04
		Beam.Width1 = 0.04
		Beam.Transparency = NumberSequence.new(0)
		Beam.Parent = p15

		local clone = nil
		local connection = nil

		local function removeBubbles()
			if connection then
				connection:Disconnect()
			end

			if clone then
				clone:Destroy()
			end
		end
		local function addBubbles()
			if connection then
				connection:Disconnect()
			end

			if clone then
				clone:Destroy()
			end

			clone = script.catchbubbles:Clone()
			clone.Parent = p15
			connection = RunService.RenderStepped:Connect(function()
				if not p15:IsDescendantOf(workspace) then
					if connection then
						connection:Disconnect()
					end

					if clone then
						clone:Destroy()

						return
					end
				else
					clone.CFrame = CFrame.new(p15.PrimaryPart.Position)
				end
			end)
		end

		p15:GetAttributeChangedSignal("bite"):Connect(function()
			if p15:GetAttribute("bite") then
				if connection then
					connection:Disconnect()
				end

				if clone then
					clone:Destroy()
				end

				clone = script.catchbubbles:Clone()
				clone.Parent = p15
				connection = RunService.RenderStepped:Connect(function()
					if not p15:IsDescendantOf(workspace) then
						if connection then
							connection:Disconnect()
						end

						if clone then
							clone:Destroy()

							return
						end
					else
						clone.CFrame = CFrame.new(p15.PrimaryPart.Position)
					end
				end)

				return
			end

			if connection then
				connection:Disconnect()
			end

			if clone then
				clone:Destroy()
			end
		end)

		return function()
			Beam:Destroy()
		end
	end)
end

return t2