-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local v2 = Random.new()
local v3 = RaycastParams.new()

v3.FilterType = Enum.RaycastFilterType.Exclude

local t = {}

local function createCraterPart() --[[ createCraterPart | Line: 75 ]]
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.CastShadow = true
	Part.Material = Enum.Material.Slate
	Part.Size = Vector3.new(1.6, 2.2, 2)
	Part.TopSurface = Enum.SurfaceType.Smooth
	Part.BottomSurface = Enum.SurfaceType.Smooth

	return Part
end

local function resolveGround(p1, p2, p3) --[[ resolveGround | Line: 89 | Upvalues: v3 (copy), Workspace (copy) ]]
	v3.FilterDescendantsInstances = if p2 then p2 else {}

	local v32 = Color3.fromRGB(108, 59, 19)
	local Slate = Enum.Material.Slate
	local v4 = Workspace:Raycast(p1 + Vector3.new(0, 5, 0), Vector3.new(0, -100, 0), v3)
	local v5

	if v4 == nil then
		v5 = p1
	else
		local v6, v7 = v4.Instance.Color:ToHSV()
		local v8 = Color3.fromHSV(v6, v7, 0.8)

		v5 = v4.Position
		Slate = v4.Instance.Material
		v32 = v8
	end

	return v5, p3 or v32, Slate
end

local function fadePart(p1, p2, p3) --[[ fadePart | Line: 114 | Upvalues: v2 (copy), TweenService (copy), Debris (copy) ]]
	task.delay(p3 * v2:NextNumber(0.75, 1.25), function() --[[ Line: 115 | Upvalues: TweenService (ref), p1 (copy), p2 (copy), Debris (ref) ]]
		TweenService:Create(p1, TweenInfo.new(0.3333333333333333), {
			Transparency = 1,
			CFrame = p2
		}):Play()
		Debris:AddItem(p1, 0.4)
	end)
end

function t.Play(p1, p2, p3, p4, p5, p6, p7) --[[ Play | Line: 128 | Upvalues: Asserts (copy), resolveGround (copy), v2 (copy), Workspace (copy), TweenService (copy), Debris (copy) ]]
	Asserts.Vector3(p1)
	Asserts.number(p2)
	Asserts.optional.boolean(p3)
	Asserts.optional.number(p4)
	Asserts.optional.number(p5)
	Asserts.optional.table(p6)

	local v1, v22 = resolveGround(p1, p6, p7)

	for i = 1, 10 do
		local v3 = v2:NextNumber(-2, 2)
		local v4 = v2:NextNumber(0, 0.75)
		local v5 = v2
		local v6 = Vector3.new(v3, v4, v5:NextNumber(0, 1))
		local v7 = i / 10 * 6.283185307179586
		local v10 = Vector3.new(math.cos(v7) * p2, 0, math.sin(v7) * p2)
		local Part = Instance.new("Part")

		Part.Anchored = true
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.CastShadow = true
		Part.Material = Enum.Material.Slate
		Part.Size = Vector3.new(1.6, 2.2, 2)
		Part.TopSurface = Enum.SurfaceType.Smooth
		Part.BottomSurface = Enum.SurfaceType.Smooth

		local v11 = Part
		local v12 = (v11.Size + v6) * (p5 or 1)

		v11.Size = v12
		v11.Color = v22

		local v13 = CFrame.new(v1 + v10, v1)
		local Angles = CFrame.Angles
		local v14 = v2:NextInteger(-25, 25)
		local v15 = v13 * Angles(-0.3490658503988659, math.rad(v14), 0)
		local v16 = v15 * CFrame.new(0, -v12.Y, 0)

		v11.CFrame = v16
		v11.Parent = Workspace:WaitForChild("__DEBRIS")

		if p3 then
			v11.CFrame = v15 * CFrame.new(0, v12.Y / 2, 0)
			v11.CanCollide = true
			v11.Anchored = false

			local v17 = math.cos(v7) * 8

			v11.AssemblyLinearVelocity = Vector3.new(v17, 35, math.sin(v7) * 8)
			task.delay(p4 or 1.5, function() --[[ Line: 169 | Upvalues: v11 (copy), TweenService (ref), v16 (copy) ]]
				v11.Anchored = true

				local v1 = TweenService:Create(v11, TweenInfo.new(0.3333333333333333), {
					Transparency = 1,
					CFrame = CFrame.new(v11.Position.X, v16.Y, v11.Position.Z) * v11.CFrame.Rotation
				})

				v1.Completed:Once(function() --[[ Line: 175 | Upvalues: v11 (ref) ]]
					v11:Destroy()
				end)
				v1:Play()
			end)

			continue
		end

		local v19 = TweenService:Create(v11, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			CFrame = v15
		})

		v19.Completed:Once(function() --[[ Line: 188 | Upvalues: v11 (copy), v16 (copy), p4 (copy), v2 (ref), TweenService (ref), Debris (ref) ]]
			local v1 = v11
			local v22 = v16

			task.delay((p4 or 1) * v2:NextNumber(0.75, 1.25), function() --[[ Line: 115 | Upvalues: TweenService (ref), v1 (copy), v22 (copy), Debris (ref) ]]
				TweenService:Create(v1, TweenInfo.new(0.3333333333333333), {
					Transparency = 1,
					CFrame = v22
				}):Play()
				Debris:AddItem(v1, 0.4)
			end)
		end)
		v19:Play()
	end
end
function t.PlayDirectionalFling(p1, p2, p3) --[[ PlayDirectionalFling | Line: 196 | Upvalues: Asserts (copy), Constants (copy), v1 (copy), resolveGround (copy), Workspace (copy), v2 (copy), TweenService (copy) ]]
	Asserts.Vector3(p1)
	Asserts.Vector3(p2)
	Asserts.optional.table(p3)

	local v12 = Vector3.new(p2.X, 0, p2.Z)

	if v12.Magnitude <= 0.001 then
		local v22 = ("Crater PlayDirectionalFling requires a non vertical direction. Received direction: %*"):format(p2)

		if Constants.IS_STUDIO then
			error(v22)
		end

		v1:AtWarning():Log(v22)
	else
		local v3 = if p3 == nil then nil else p3.ColorOverride
		local v4 = if p3 == nil or p3.FadeDelay == nil then 0.7 else p3.FadeDelay
		local v5 = if p3 == nil or p3.GroundOffset == nil then 0 else p3.GroundOffset
		local v6 = if p3 == nil then nil else p3.IgnoredInstances
		local v7 = if p3 == nil or p3.LateralSpread == nil then 1.75 else p3.LateralSpread
		local v8 = if p3 == nil or p3.PartCount == nil then 5 else p3.PartCount
		local v9 = if p3 == nil or p3.Scale == nil then 0.65 else p3.Scale
		local v10 = if p3 == nil or p3.SpawnOffset == nil then 1.4 else p3.SpawnOffset
		local v11 = if p3 == nil or p3.ThrowVelocity == nil then 18 else p3.ThrowVelocity
		local v122 = if p3 == nil or p3.ThrowUpVelocity == nil then 24 else p3.ThrowUpVelocity
		local Unit = v12.Unit
		local v13 = -Unit
		local v15 = Vector3.new(-Unit.Z, 0, Unit.X)
		local v16, v17, v18 = resolveGround(p1 + v13 * v10 + Vector3.new(0, v5, 0), v6, v3)
		local __DEBRIS = Workspace:WaitForChild("__DEBRIS")

		for i = 1, v8 do
			local v20 = v13 * v2:NextNumber(0, 0.65)
			local Part = Instance.new("Part")

			Part.Anchored = true
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.CastShadow = true
			Part.Material = Enum.Material.Slate
			Part.Size = Vector3.new(1.6, 2.2, 2)
			Part.TopSurface = Enum.SurfaceType.Smooth
			Part.BottomSurface = Enum.SurfaceType.Smooth

			local v21 = Part
			local v25 = Vector3.new(v2:NextNumber(1.05, 1.85), v2:NextNumber(0.7, 1.3), v2:NextNumber(0.9, 1.5)) * v9

			v21.Size = v25
			v21.Color = v17
			v21.Material = v18
			v21.CanCollide = true
			v21.Anchored = false

			local v26 = v16 + v15 * ((if v8 == 1 then 0 else (i - 1) / (v8 - 1) - 0.5) * v7 * 2) + v20
			local v27 = CFrame.lookAt(v26, v26 + v13, Vector3.new(0, 1, 0))

			v21.CFrame = v27 * CFrame.Angles(v2:NextNumber(-0.45, -0.15), math.rad((v2:NextInteger(-35, 35))), (math.rad((v2:NextInteger(-35, 35)))))
			v21.Parent = __DEBRIS
			v21.AssemblyAngularVelocity = Vector3.new(v2:NextNumber(-10, 10), v2:NextNumber(-8, 8), v2:NextNumber(-10, 10))

			local v35 = v13 * v2:NextNumber(v11 * 0.85, v11 * 1.15)
			local v36 = v2:NextNumber(v122 * 0.85, v122 * 1.15)

			v21.AssemblyLinearVelocity = v35 + Vector3.new(0, v36, 0) + v15 * v2:NextNumber(-1.25, 1.25)
			task.delay(v4 * v2:NextNumber(0.9, 1.15), function() --[[ Line: 273 | Upvalues: v21 (copy), TweenService (ref), v16 (copy), v25 (copy) ]]
				if v21.Parent ~= nil then
					v21.Anchored = true

					local v1 = TweenService:Create(v21, TweenInfo.new(0.3333333333333333), {
						Transparency = 1,
						CFrame = CFrame.new(v21.Position.X, v16.Y - v25.Y, v21.Position.Z) * v21.CFrame.Rotation
					})

					v1.Completed:Once(function() --[[ Line: 284 | Upvalues: v21 (ref) ]]
						v21:Destroy()
					end)
					v1:Play()
				end
			end)
		end
	end
end
function t.PlayLine(p1, p2, p3) --[[ PlayLine | Line: 292 | Upvalues: Asserts (copy), Constants (copy), v1 (copy), resolveGround (copy), t (copy), v2 (copy), Workspace (copy), TweenService (copy), Debris (copy) ]]
	Asserts.Vector3(p1)
	Asserts.Vector3(p2)

	local v12 = Vector3.new(p2.X, 0, p2.Z)

	if v12.Magnitude <= 0.001 then
		local v22 = ("Crater PlayLine requires a non vertical direction. Received direction: %*"):format(p2)

		if Constants.IS_STUDIO then
			error(v22)
		end

		v1:AtWarning():Log(v22)
	else
		local v3 = if p3 == nil or p3.Gap == nil then 3.25 else p3.Gap
		local v4 = if p3 == nil or p3.HalfWidth == nil then 3 else p3.HalfWidth
		local v5 = if p3 == nil or p3.Scale == nil then 0.75 else p3.Scale
		local v6 = if p3 == nil or p3.Spacing == nil then 3 else p3.Spacing
		local v7 = if p3 == nil or p3.FadeDelay == nil then 0.65 else p3.FadeDelay
		local v8 = if p3 == nil then nil else p3.FlingOptions
		local v9 = if p3 == nil then nil else p3.IgnoredInstances
		local v10 = if p3 == nil then nil else p3.ColorOverride
		local Unit = v12.Unit
		local v122 = Vector3.new(-Unit.Z, 0, Unit.X)
		local v13, v14 = resolveGround(p1, v9, v10)

		if v8 ~= nil then
			local v15 = table.clone(v8)

			v15.ColorOverride = if v15.ColorOverride == nil then v14 else v15.ColorOverride
			v15.IgnoredInstances = if v15.IgnoredInstances == nil then v9 else v15.IgnoredInstances
			t.PlayDirectionalFling(v13, Unit, v15)
		end

		for i, v in ipairs({ -1, 1 }) do
			local Part = Instance.new("Part")

			Part.Anchored = true
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.CastShadow = true
			Part.Material = Enum.Material.Slate
			Part.Size = Vector3.new(1.6, 2.2, 2)
			Part.TopSurface = Enum.SurfaceType.Smooth
			Part.BottomSurface = Enum.SurfaceType.Smooth

			local v18 = Part
			local v19 = v2:NextNumber(-0.25, 0.55)
			local v20 = v2:NextNumber(-0.25, 0.35)
			local v21 = v2
			local v22 = Vector3.new(v19, v20, v21:NextNumber(-0.3, 0.5))
			local v23 = (Vector3.new(v6 * 0.9, 1.7, v4) + v22) * v5

			v18.Size = v23
			v18.Color = v14

			local v24 = v13 + v122 * v * (v3 * 0.5 + v4 * 0.5)
			local v25 = CFrame.lookAt(v24, v24 + Unit, Vector3.new(0, 1, 0)) * CFrame.Angles(-0.3490658503988659, 0, (math.rad(12 * -v)))
			local v26 = v25 * CFrame.new(0, -v23.Y, 0)

			v18.CFrame = v26
			v18.Parent = Workspace:WaitForChild("__DEBRIS")

			local v27 = TweenService:Create(v18, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				CFrame = v25
			})

			v27.Completed:Once(function() --[[ Line: 360 | Upvalues: v18 (copy), v26 (copy), v7 (copy), v2 (ref), TweenService (ref), Debris (ref) ]]
				local v1 = v18
				local v22 = v26

				task.delay(v7 * v2:NextNumber(0.75, 1.25), function() --[[ Line: 115 | Upvalues: TweenService (ref), v1 (copy), v22 (copy), Debris (ref) ]]
					TweenService:Create(v1, TweenInfo.new(0.3333333333333333), {
						Transparency = 1,
						CFrame = v22
					}):Play()
					Debris:AddItem(v1, 0.4)
				end)
			end)
			v27:Play()
		end
	end
end

return setmetatable(t, {
	__call = function(p1, ...) --[[ __call | Line: 368 | Upvalues: t (copy) ]]
		return t.Play(...)
	end
})