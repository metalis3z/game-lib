-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = TweenInfo.new(10, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local AddDebris = require(ReplicatedStorage.Library.Functions.AddDebris)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local FuncWrapper = require(ReplicatedStorage.Library.Modules.FuncWrapper)
local t = {}

t.__index = t
function t.new() --[[ new | Line: 78 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.LengthSegments = 1000
	v2.Length = 0

	local t2 = {
		UpdatedBindable = Instance.new("BindableEvent")
	}

	v2._Bindables = t2
	v2.Updated = t2.UpdatedBindable.Event
	v2._LengthCache = {}

	return v2
end
function t.DebugDrawSpline(p1, p2, p3, p4, p5) --[[ DebugDrawSpline | Line: 100 | Upvalues: AddDebris (copy) ]]
	local v2 = if p3 then p3 else workspace:WaitForChild("__DEBRIS")
	local v3 = if p4 then p4 else Color3.new(255/255, 0/255, 0/255)
	local SplineDebug = Instance.new("Folder")

	SplineDebug.Name = "SplineDebug"
	SplineDebug.Parent = v2

	local list, v4 = {}, v3

	for i = 0, p2 do
		table.insert(list, p1:Position(i / p2))
	end

	for i, v in ipairs(list) do
		local Part = Instance.new("Part")

		Part.Shape = Enum.PartType.Ball
		Part.Size = Vector3.new(0.2, 0.2, 0.2)
		Part.Anchored = true
		Part.CanCollide = false
		Part.Material = Enum.Material.Neon
		Part.Color = v4
		Part.CFrame = CFrame.new(v)
		Part.Parent = SplineDebug
	end

	for j = 1, #list - 1 do
		local v5 = list[j]
		local v6 = list[j + 1]
		local Part = Instance.new("Part")

		Part.Size = Vector3.new(0.1, 0.1, (v5 - v6).Magnitude)
		Part.Anchored = true
		Part.CanCollide = false
		Part.Material = Enum.Material.Neon
		Part.Color = v4
		Part.CFrame = CFrame.lookAt((v5 + v6) / 2, v6) * CFrame.Angles(1.5707963267948966, 0, 0)
		Part.Parent = SplineDebug
	end

	for v7, v8 in p1.Points do
		if typeof(v8) ~= "number" then
			local Part = Instance.new("Part")

			Part.Position = typeof(v8) == "Instance" and v8.Position or v8
			Part.Shape = Enum.PartType.Ball
			Part.CanCollide = false
			Part.CanQuery = false
			Part.Anchored = true
			Part.Material = Enum.Material.Neon
			Part.Color = Color3.fromRGB(255, 0, 0)
			Part.Parent = SplineDebug
		end
	end

	AddDebris(SplineDebug, p5 or 60)

	return SplineDebug
end
function t.Position(p1, p2) --[[ Position | Line: 169 ]]
	error("This is a prototype function, it should never be called from the BaseSpline!")
end
function t.Velocity(p1, p2) --[[ Velocity | Line: 178 ]]
	error("This is a prototype function, it should never be called from the BaseSpline!")
end
function t.Acceleration(p1, p2) --[[ Acceleration | Line: 187 ]]
	error("This is a prototype function, it should never be called from the BaseSpline!")
end
function t.Normal(p1, p2) --[[ Normal | Line: 196 ]]
	local v1 = p1:Acceleration(p2)

	if typeof(v1) == "Vector3" then
		return v1.Unit
	end

	error("BaseSpline:Normal() only works with Vector3 constructed splines!")
end
function t.Curvature(p1, p2) --[[ Curvature | Line: 209 ]]
	local v1 = p1:Velocity(p2)
	local v2 = p1:Acceleration(p2)

	if typeof(v1) ~= "Vector3" or typeof(v2) ~= "Vector3" then
		error("BaseSpline:Curvature() only works with Vector3 constructed splines!")
	end

	return v1:Cross(v2).Magnitude / v1.Magnitude ^ 3
end
function t._UpdateLength(p1) --[[ _UpdateLength | Line: 224 ]]
	local LengthSegments = p1.LengthSegments
	local v1 = 1 / (LengthSegments + 1)
	local sum = 0
	local t = {}

	for i = 0, LengthSegments + 1 do
		local v2 = p1:Position(i * v1)
		local v3 = p1:Position((i + 1) * v1)

		table.insert(t, {
			t = v1 * i,
			l = sum
		})

		if i == LengthSegments + 1 then
			break
		end

		sum = sum + (type(v3 - v2) == "number" and math.abs(v3 - v2) or (v3 - v2).Magnitude)
	end

	p1.Length = sum
	p1._LengthCache = t
	p1._Bindables.UpdatedBindable:Fire()
end
function t.ArcLength(p1, p2) --[[ ArcLength | Line: 254 ]]
	local _LengthCache = p1._LengthCache

	if #_LengthCache == 0 then
		return 0
	end

	local v1 = nil
	local v2 = nil

	if p2 < 0 then
		v1 = _LengthCache[1]
		v2 = _LengthCache[2]
	elseif p2 > 1 then
		v1 = _LengthCache[#_LengthCache - 1]
		v2 = _LengthCache[#_LengthCache]
	else
		for i = 1, #_LengthCache - 1 do
			local v3 = _LengthCache[i]
			local v4 = _LengthCache[i + 1]

			if v3.t <= p2 and p2 <= v4.t then
				v1 = v3
				v2 = v4

				break
			end
		end
	end

	return v1.l + (v2.l - v1.l) * ((p2 - v1.t) / (v2.t - v1.t))
end
function t.TransformRelativeToLength(p1, p2) --[[ TransformRelativeToLength | Line: 288 ]]
	local _LengthCache = p1._LengthCache

	if #_LengthCache == 0 then
		return 0
	end

	local v1 = nil
	local v2 = nil
	local v3 = p1.Length * p2

	if v3 < 0 then
		v1 = _LengthCache[0]
		v2 = _LengthCache[1]
	elseif _LengthCache[#_LengthCache].l < v3 then
		v1 = _LengthCache[#_LengthCache - 1]
		v2 = _LengthCache[#_LengthCache]
	else
		for i = 1, #_LengthCache - 1 do
			local v4 = _LengthCache[i]
			local v5 = _LengthCache[i + 1]

			if v4.l <= v3 and v3 <= v5.l then
				v1 = v4
				v2 = v5

				break
			end
		end
	end

	return v1.t + (v2.t - v1.t) * ((v3 - v1.l) / (v2.l - v1.l))
end

local t2 = {}

t2.__index = t2
function t2.new(p1, p2, p3, p4, p5) --[[ new | Line: 354 | Upvalues: Asserts (copy), t2 (copy), FuncWrapper (copy), Trove (copy), v1 (copy), Signal (copy) ]]
	Asserts.table(p2)
	Asserts.BasePart(p1)
	Asserts.optional.TweenInfo(p3)
	Asserts.optional.func(p4)
	Asserts.optional.boolean(p5)

	local v2 = setmetatable({}, t2)

	v2._funcWrapper = FuncWrapper.CreateWrapper(v2)
	v2._trove = Trove.new()
	v2.TweenInfo = if p3 then p3 else v1
	v2.Completed = v2._trove:Add(Signal.new())
	v2.Started = v2._trove:Add(Signal.new())
	v2.Playing = false
	v2.Object = p1
	v2.RenderCFrame = p1.CFrame
	v2.AnimationCFrame = v2.RenderCFrame
	v2.Destroyed = false
	v2._spline = p2
	v2._relativeToLength = p5
	v2._transformFn = p4
	v2._progress = 0
	v2._nextParentCheck = 0
	v2:_init()

	return v2
end
function t2.is(p1) --[[ is | Line: 394 | Upvalues: t2 (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == t2 else false
end
function t2.GetProgress(p1) --[[ GetProgress | Line: 398 ]]
	return p1._progress
end
function t2.Step(p1, p2) --[[ Step | Line: 402 | Upvalues: TweenService (copy) ]]
	p1._progress = p1._progress + p2

	if not p1.Playing or (not p1.Object or p1.Destroyed) then
		return false
	end

	if p1._progress >= p1.TweenInfo.Time then
		p1.Playing = false
		p1.Completed:Fire(Enum.PlaybackState.Completed)

		return false
	end

	if p1._nextParentCheck <= p1._progress then
		p1._nextParentCheck = p1._progress + 2.5 + 5 * math.random()

		if not p1.Object.Parent then
			return false
		end
	end

	local v1 = TweenService:GetValue(p1._progress / p1.TweenInfo.Time, p1.TweenInfo.EasingStyle, p1.TweenInfo.EasingDirection)
	local v2 = p1._relativeToLength and p1._spline:TransformRelativeToLength(v1) or v1
	local v3 = p1._spline:Position(v2)
	local Unit = p1._spline:Velocity(v2).Unit
	local v4 = p1._spline:Normal(v2)
	local v5 = CFrame.lookAt(v3, v3 + Unit, v4)

	if p1._transformFn then
		v5 = p1._transformFn(v5, v2, {
			Position = v3,
			Direction = Unit,
			Normal = v4,
			Progress = p1._progress,
			Dt = p2
		})
	end

	p1.AnimationCFrame = v5

	return true
end
function t2.Play(p1) --[[ Play | Line: 450 ]]
	assert(not p1.Destroyed, "Attempt to play a destroyed catmull rom spline tween wrapper")
	assert(p1.Object, "Tweened object missing or nil")
	assert(p1.Object.Parent, "Tweened object parent, is nil, tween operation declined")

	if not p1.Playing then
		p1._progress = 0
		p1.Playing = true
		p1.Started:Fire()
	end
end
function t2.Cancel(p1) --[[ Cancel | Line: 464 ]]
	if p1.Playing then
		p1.Playing = false
		p1.Completed:Fire(Enum.PlaybackState.Cancelled)
	end
end
function t2.Destroy(p1) --[[ Destroy | Line: 472 ]]
	if not p1.Destroyed then
		p1.Destroyed = true
		p1:Cancel()
		p1._trove:Destroy()
	end
end
function t2._init(p1) --[[ _init | Line: 482 ]]
	p1._trove:Connect(p1.Object.Destroying, p1._funcWrapper(p1.Destroy))
end
function t.CreateTween(p1, p2, p3, p4, p5) --[[ CreateTween | Line: 486 | Upvalues: t2 (copy) ]]
	return t2.new(p2, p1, p3, p5, p4)
end

return t