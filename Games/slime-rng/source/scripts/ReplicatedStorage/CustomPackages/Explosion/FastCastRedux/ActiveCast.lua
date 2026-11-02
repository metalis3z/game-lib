-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ActiveCast, time of decompilation: Sun May  3 10:09:18 2026 ]]
require(script.Parent.TypeDefinitions)

local TypeMarshaller = require(script.Parent.TypeMarshaller)
local t1 = {}

t1.__index = t1
t1.__type = "ActiveCast"

local RunService = game:GetService("RunService")
local Table = require(script.Parent.Table)
local u5 = nil

function DbgVisualizeSegment(cFrame: CFrame, n1: number) -- line: 86
	-- upvalues: u5 (ref)
	if u5.VisualizeCasts ~= true then
		return nil
	end

	local ConeHandleAdornment = Instance.new("ConeHandleAdornment")

	ConeHandleAdornment.Adornee = workspace.Terrain
	ConeHandleAdornment.CFrame = cFrame
	ConeHandleAdornment.Height = n1
	ConeHandleAdornment.Color3 = Color3.new()
	ConeHandleAdornment.Radius = 0.25
	ConeHandleAdornment.Transparency = 0.5

	local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")

	if FastCastVisualizationObjects ~= nil then
	else
		FastCastVisualizationObjects = Instance.new("Folder")
		FastCastVisualizationObjects.Name = "FastCastVisualizationObjects"
		FastCastVisualizationObjects.Archivable = false
		FastCastVisualizationObjects.Parent = workspace.Terrain
	end

	ConeHandleAdornment.Parent = FastCastVisualizationObjects

	return ConeHandleAdornment
end
function DbgVisualizeHit(cFrame: CFrame, b1: boolean) -- line: 100
	-- upvalues: u5 (ref)
	if u5.VisualizeCasts ~= true then
		return nil
	end

	local SphereHandleAdornment = Instance.new("SphereHandleAdornment")

	SphereHandleAdornment.Adornee = workspace.Terrain
	SphereHandleAdornment.CFrame = cFrame
	SphereHandleAdornment.Radius = 0.4
	SphereHandleAdornment.Transparency = 0.25
	SphereHandleAdornment.Color3 = b1 == false and Color3.new(0.2, 1, 0.5) or Color3.new(1, 0.2, 0.2)

	local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")

	if FastCastVisualizationObjects ~= nil then
	else
		FastCastVisualizationObjects = Instance.new("Folder")
		FastCastVisualizationObjects.Name = "FastCastVisualizationObjects"
		FastCastVisualizationObjects.Archivable = false
		FastCastVisualizationObjects.Parent = workspace.Terrain
	end

	SphereHandleAdornment.Parent = FastCastVisualizationObjects

	return SphereHandleAdornment
end

local function GetTrajectoryInfo(p1, n2: number) -- line: 130
	assert(p1.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	local v30 = p1.StateInfo.Trajectories[n2]
	local v31 = v30.EndTime - v30.StartTime
	local Origin = v30.Origin
	local InitialVelocity = v30.InitialVelocity
	local Acceleration = v30.Acceleration
	local t2 = {}
	local vector3 = Vector3.new(Acceleration.X * v31 ^ 2 / 2, Acceleration.Y * v31 ^ 2 / 2, Acceleration.Z * v31 ^ 2 / 2)
	local v37 = Origin + InitialVelocity * v31 + vector3
	local v38 = InitialVelocity + Acceleration * v31

	t2[1] = v37
	t2[2] = v38

	return t2
end
local function SimulateCast(p2, n3: number, b2: boolean) -- line: 173
	-- upvalues: u5 (ref), Table (copy)
	assert(p2.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	local g111 = nil

	if u5.DebugLogging == true then
		print("Casting for frame.")
	end

	local v59 = p2.StateInfo.Trajectories[#p2.StateInfo.Trajectories]
	local Origin = v59.Origin
	local v61 = p2.StateInfo.TotalRuntime - v59.StartTime
	local InitialVelocity = v59.InitialVelocity
	local Acceleration = v59.Acceleration
	local vector3 = Vector3.new(Acceleration.X * v61 ^ 2 / 2, Acceleration.Y * v61 ^ 2 / 2, Acceleration.Z * v61 ^ 2 / 2)
	local v65 = Origin + InitialVelocity * v61 + vector3
	local _ = InitialVelocity + Acceleration * v61
	local v67 = p2.StateInfo.TotalRuntime - v59.StartTime
	local StateInfo = p2.StateInfo

	StateInfo.TotalRuntime = StateInfo.TotalRuntime + n3

	local v69 = p2.StateInfo.TotalRuntime - v59.StartTime
	local vector3_2 = Vector3.new(Acceleration.X * v69 ^ 2 / 2, Acceleration.Y * v69 ^ 2 / 2, Acceleration.Z * v69 ^ 2 / 2)
	local v71 = Origin + InitialVelocity * v69 + vector3_2
	local v72 = InitialVelocity + Acceleration * v69
	local v73 = (v71 - v65).Unit * v72.Magnitude * n3
	local WorldRoot = p2.RayInfo.WorldRoot
	local raycastResult = WorldRoot:Raycast(v65, v73, p2.RayInfo.Parameters)
	local v76 = v71
	local Instance2 = nil
	local Air = Enum.Material.Air

	Vector3.new()

	if raycastResult ~= nil then
		v76 = raycastResult.Position
		Instance2 = raycastResult.Instance
		Air = raycastResult.Material

		local _ = raycastResult.Normal
	end

	local Magnitude = (v76 - v65).Magnitude
	local Unit = v73.Unit
	local CosmeticBulletObject = p2.RayInfo.CosmeticBulletObject

	p2.Caster.LengthChanged:Fire(p2, v65, Unit, Magnitude, v72, CosmeticBulletObject)

	local StateInfo2 = p2.StateInfo

	StateInfo2.DistanceCovered = StateInfo2.DistanceCovered + Magnitude

	local v84 = nil

	if n3 > 0 then
		v84 = DbgVisualizeSegment(CFrame.new(v65, v65 + v73), Magnitude)
	end

	if Instance2 and Instance2 ~= p2.RayInfo.CosmeticBulletObject then
		tick()

		if u5.DebugLogging == true then
			print("Hit something, testing now.")
		end

		if p2.RayInfo.CanPierceCallback ~= nil then
			if b2 == false and p2.StateInfo.IsActivelySimulatingPierce then
				p2:Terminate()
				error("ERROR: The latest call to CanPierceCallback took too long to complete! This cast is going to suffer desyncs which WILL cause unexpected behavior and errors. Please fix your performance problems, or remove statements that yield (e.g. wait() calls)")
			end

			p2.StateInfo.IsActivelySimulatingPierce = true
		end

		if p2.RayInfo.CanPierceCallback == nil or p2.RayInfo.CanPierceCallback ~= nil and p2.RayInfo.CanPierceCallback(p2, raycastResult, v72, p2.RayInfo.CosmeticBulletObject) == false then
			if u5.DebugLogging == true then
				print("Piercing function is nil or it returned FALSE to not pierce this hit.")
			end

			p2.StateInfo.IsActivelySimulatingPierce = false

			if p2.StateInfo.HighFidelityBehavior == 2 and v59.Acceleration ~= Vector3.new() and p2.StateInfo.HighFidelitySegmentSize ~= 0 then
				p2.StateInfo.CancelHighResCast = false

				if p2.StateInfo.IsActivelyResimulating then
					p2:Terminate()
					error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
				end

				p2.StateInfo.IsActivelyResimulating = true

				if u5.DebugLogging == true then
					print("Hit was registered, but recalculation is on for physics based casts. Recalculating to verify a real hit...")
				end

				local v85 = math.floor(Magnitude / p2.StateInfo.HighFidelitySegmentSize)
				local _ = Magnitude / v85
				local v87 = n3 / v85

				for i = 1, v85 do
					if p2.StateInfo.CancelHighResCast then
						p2.StateInfo.CancelHighResCast = false

						break
					end

					local v89 = v67 + v87 * i
					local vector3_3 = Vector3.new(Acceleration.X * v89 ^ 2 / 2, Acceleration.Y * v89 ^ 2 / 2, Acceleration.Z * v89 ^ 2 / 2)
					local v91 = Origin + InitialVelocity * v89 + vector3_3
					local v92 = InitialVelocity + Acceleration * (v67 + v87 * i)
					local raycastResult2 = WorldRoot:Raycast(v91, v92 * n3, p2.RayInfo.Parameters)
					local Magnitude2 = (v91 - (v91 + v92)).Magnitude

					if raycastResult2 ~= nil then
						local Magnitude3 = (v91 - raycastResult2.Position).Magnitude
						local v96 = DbgVisualizeSegment(CFrame.new(v91, v91 + v92), Magnitude3)

						if v96 ~= nil then
							v96.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
						end

						if p2.RayInfo.CanPierceCallback == nil or p2.RayInfo.CanPierceCallback ~= nil and p2.RayInfo.CanPierceCallback(p2, raycastResult2, v92, p2.RayInfo.CosmeticBulletObject) == false then
							p2.StateInfo.IsActivelyResimulating = false

							local CosmeticBulletObject2 = p2.RayInfo.CosmeticBulletObject

							p2.Caster.RayHit:Fire(p2, raycastResult2, v92, CosmeticBulletObject2)
							p2:Terminate()

							local v98 = DbgVisualizeHit(CFrame.new(v76), false)

							if v98 ~= nil then
								v98.Color3 = Color3.new(0.0588235, 0.87451, 1)
							end

							return
						end

						local CosmeticBulletObject3 = p2.RayInfo.CosmeticBulletObject

						p2.Caster.RayPierced:Fire(p2, raycastResult2, v92, CosmeticBulletObject3)

						local v100 = DbgVisualizeHit(CFrame.new(v76), true)

						if v100 ~= nil then
							v100.Color3 = Color3.new(1, 0.113725, 0.588235)
						end

						if v96 ~= nil then
							v96.Color3 = Color3.new(0.305882, 0.243137, 0.329412)
						end

						continue
					end

					local v101 = DbgVisualizeSegment(CFrame.new(v91, v91 + v92), Magnitude2)

					if v101 ~= nil then
						v101.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
					end
				end

				p2.StateInfo.IsActivelyResimulating = false
			else
				if p2.StateInfo.HighFidelityBehavior == 1 or p2.StateInfo.HighFidelityBehavior == 3 then
					if u5.DebugLogging == true then
						print("Hit was successful. Terminating.")
					end

					local CosmeticBulletObject4 = p2.RayInfo.CosmeticBulletObject

					p2.Caster.RayHit:Fire(p2, raycastResult, v72, CosmeticBulletObject4)
					p2:Terminate()
					DbgVisualizeHit(CFrame.new(v76), false)

					return
				end

				p2:Terminate()
				error("Invalid value " .. p2.StateInfo.HighFidelityBehavior .. " for HighFidelityBehavior.")
			end
		else
			if u5.DebugLogging == true then
				print("Piercing function returned TRUE to pierce this part.")
			end

			if v84 ~= nil then
				v84.Color3 = Color3.new(0.4, 0.05, 0.05)
			end

			DbgVisualizeHit(CFrame.new(v76), true)

			local Parameters = p2.RayInfo.Parameters
			local t3 = {}
			local n4 = 0
			local FilterDescendantsInstances = Parameters.FilterDescendantsInstances
			local v107 = false

			repeat
				if raycastResult.Instance:IsA("Terrain") then
					if Air == Enum.Material.Water then
						p2:Terminate()
						error("Do not add Water as a piercable material. If you need to pierce water, set cast.RayInfo.Parameters.IgnoreWater = true instead", 0)
					end

					warn("WARNING: The pierce callback for this cast returned TRUE on Terrain! This can cause severely adverse effects.")
				end

				if Parameters.FilterType == Enum.RaycastFilterType.Blacklist then
					local FilterDescendantsInstances2 = Parameters.FilterDescendantsInstances

					Table.insert(FilterDescendantsInstances2, raycastResult.Instance)
					Table.insert(t3, raycastResult.Instance)
					Parameters.FilterDescendantsInstances = FilterDescendantsInstances2
				else
					local FilterDescendantsInstances3 = Parameters.FilterDescendantsInstances

					Table.removeObject(FilterDescendantsInstances3, raycastResult.Instance)
					Table.insert(t3, raycastResult.Instance)
					Parameters.FilterDescendantsInstances = FilterDescendantsInstances3
				end

				local CosmeticBulletObject5 = p2.RayInfo.CosmeticBulletObject

				p2.Caster.RayPierced:Fire(p2, raycastResult, v72, CosmeticBulletObject5)
				raycastResult = WorldRoot:Raycast(v65, v73, Parameters)

				if raycastResult == nil then
					g111 = true
				end

				if g111 then
					break
				end

				if n4 >= 100 then
					warn("WARNING: Exceeded maximum pierce test budget for a single ray segment (attempted to test the same segment " .. 100 .. " times!)")
					g111 = true
				end

				if g111 then
					break
				end

				n4 += 1
			until p2.RayInfo.CanPierceCallback(p2, raycastResult, v72, p2.RayInfo.CosmeticBulletObject) == false

			if not g111 then
				if not g111 then
					v107 = true
				end
			end

			g111 = false
			p2.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances
			p2.StateInfo.IsActivelySimulatingPierce = false

			if v107 then
				local v112 = "Broke because the ray hit something solid (" .. tostring(raycastResult.Instance) .. ") while testing for a pierce. Terminating the cast."

				if u5.DebugLogging == true then
					print(v112)
				end

				local CosmeticBulletObject6 = p2.RayInfo.CosmeticBulletObject

				p2.Caster.RayHit:Fire(p2, raycastResult, v72, CosmeticBulletObject6)
				p2:Terminate()
				DbgVisualizeHit(CFrame.new(raycastResult.Position), false)

				return
			end
		end
	end

	if p2.StateInfo.DistanceCovered >= p2.RayInfo.MaxDistance then
		p2:Terminate()
		DbgVisualizeHit(CFrame.new(v71), false)
	end
end

function t1.new(p3, vector3: Vector3, vector3_4: Vector3, p4, p5) -- line: 422
	-- upvalues: TypeMarshaller (copy), Table (copy), RunService (copy), t1 (copy), u5 (ref), SimulateCast (copy)
	if TypeMarshaller(p4) == "number" then
		p4 = vector3_4.Unit * p4
	end

	if p5.HighFidelitySegmentSize <= 0 then
		error("Cannot set FastCastBehavior.HighFidelitySegmentSize <= 0!", 0)
	end

	local t4 = {
		Caster = p3,
		StateInfo = {
			UpdateConnection = nil,
			Paused = false,
			TotalRuntime = 0,
			DistanceCovered = 0,
			IsActivelySimulatingPierce = false,
			IsActivelyResimulating = false,
			CancelHighResCast = false,
			HighFidelitySegmentSize = p5.HighFidelitySegmentSize,
			HighFidelityBehavior = p5.HighFidelityBehavior,
			Trajectories = {{
				StartTime = 0,
				EndTime = -1,
				Origin = vector3,
				InitialVelocity = p4,
				Acceleration = p5.Acceleration
			}}
		},
		RayInfo = {
			Parameters = p5.RaycastParams,
			WorldRoot = workspace,
			MaxDistance = p5.MaxDistance or 1000,
			CosmeticBulletObject = p5.CosmeticBulletTemplate,
			CanPierceCallback = p5.CanPierceFunction
		},
		UserData = {}
	}

	if t4.StateInfo.HighFidelityBehavior == 2 then
		t4.StateInfo.HighFidelityBehavior = 3
	end

	if t4.RayInfo.Parameters ~= nil then
		local RayInfo = t4.RayInfo
		local Parameters = t4.RayInfo.Parameters
		local raycastParams = RaycastParams.new()

		raycastParams.CollisionGroup = Parameters.CollisionGroup
		raycastParams.FilterType = Parameters.FilterType
		raycastParams.FilterDescendantsInstances = Parameters.FilterDescendantsInstances
		raycastParams.IgnoreWater = Parameters.IgnoreWater
		RayInfo.Parameters = raycastParams
	else
		t4.RayInfo.Parameters = RaycastParams.new()
	end

	local v123 = false

	if p5.CosmeticBulletProvider == nil then
		if t4.RayInfo.CosmeticBulletObject ~= nil then
			t4.RayInfo.CosmeticBulletObject = t4.RayInfo.CosmeticBulletObject:Clone()
			t4.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(vector3, vector3 + vector3_4)
			t4.RayInfo.CosmeticBulletObject.Parent = p5.CosmeticBulletContainer
		end
	elseif TypeMarshaller(p5.CosmeticBulletProvider) == "PartCache" then
		if t4.RayInfo.CosmeticBulletObject ~= nil then
			warn("Do not define FastCastBehavior.CosmeticBulletTemplate and FastCastBehavior.CosmeticBulletProvider at the same time! The provider will be used, and CosmeticBulletTemplate will be set to nil.")
			t4.RayInfo.CosmeticBulletObject = nil
			p5.CosmeticBulletTemplate = nil
		end

		t4.RayInfo.CosmeticBulletObject = p5.CosmeticBulletProvider:GetPart()
		t4.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(vector3, vector3 + vector3_4)
		v123 = true
	else
		warn("FastCastBehavior.CosmeticBulletProvider was not an instance of the PartCache module (an external/separate model)! Are you inputting an instance created via PartCache.new? If so, are you on the latest version of PartCache? Setting FastCastBehavior.CosmeticBulletProvider to nil.")
		p5.CosmeticBulletProvider = nil
	end

	local v124 = if not v123 then p5.CosmeticBulletContainer else p5.CosmeticBulletProvider.CurrentCacheParent

	if p5.AutoIgnoreContainer == true and v124 ~= nil then
		local FilterDescendantsInstances = t4.RayInfo.Parameters.FilterDescendantsInstances

		if Table.find(FilterDescendantsInstances, v124) == nil then
			Table.insert(FilterDescendantsInstances, v124)
			t4.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances
		end
	end

	local v126 = if not RunService:IsClient() then RunService.Heartbeat else RunService.RenderStepped

	setmetatable(t4, t1)
	t4.StateInfo.UpdateConnection = v126:Connect(function(p6) -- line: 535
		-- upvalues: t4 (copy), u5 (ref), SimulateCast (copy)
		if t4.StateInfo.Paused then
			return
		end

		if u5.DebugLogging == true then
			print("Casting for frame.")
		end

		local v164 = t4.StateInfo.Trajectories[#t4.StateInfo.Trajectories]

		if t4.StateInfo.HighFidelityBehavior == 3 and v164.Acceleration ~= Vector3.new() and t4.StateInfo.HighFidelitySegmentSize > 0 then
			local timestamp = tick()

			if t4.StateInfo.IsActivelyResimulating then
				t4:Terminate()
				error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
			end

			t4.StateInfo.IsActivelyResimulating = true

			local Origin = v164.Origin
			local v167 = t4.StateInfo.TotalRuntime - v164.StartTime
			local InitialVelocity = v164.InitialVelocity
			local Acceleration = v164.Acceleration
			local vector3_5 = Vector3.new(Acceleration.X * v167 ^ 2 / 2, Acceleration.Y * v167 ^ 2 / 2, Acceleration.Z * v167 ^ 2 / 2)
			local v171 = Origin + InitialVelocity * v167 + vector3_5
			local _ = InitialVelocity + Acceleration * v167
			local _ = t4.StateInfo.TotalRuntime - v164.StartTime
			local StateInfo = t4.StateInfo

			StateInfo.TotalRuntime = StateInfo.TotalRuntime + p6

			local v175 = t4.StateInfo.TotalRuntime - v164.StartTime
			local vector3_6 = Vector3.new(Acceleration.X * v175 ^ 2 / 2, Acceleration.Y * v175 ^ 2 / 2, Acceleration.Z * v175 ^ 2 / 2)
			local v177 = Origin + InitialVelocity * v175 + vector3_6
			local v178 = InitialVelocity + Acceleration * v175
			local v179 = (v177 - v171).Unit * v178.Magnitude * p6
			local raycastResult = t4.RayInfo.WorldRoot:Raycast(v171, v179, t4.RayInfo.Parameters)

			if raycastResult ~= nil then
				v177 = raycastResult.Position
			end

			local Magnitude = (v177 - v171).Magnitude
			local StateInfo3 = t4.StateInfo

			StateInfo3.TotalRuntime = StateInfo3.TotalRuntime - p6

			local v183 = math.floor(Magnitude / t4.StateInfo.HighFidelitySegmentSize)

			if v183 == 0 then
				v183 = 1
			end

			local v184 = p6 / v183

			for i = 1, v183 do
				if getmetatable(t4) == nil then
					return
				end

				if t4.StateInfo.CancelHighResCast then
					t4.StateInfo.CancelHighResCast = false

					break
				end

				local v186 = "[" .. i .. "] Subcast of time increment " .. v184

				if u5.DebugLogging == true then
					print(v186)
				end

				SimulateCast(t4, v184, true)
			end

			if getmetatable(t4) == nil then
				return
			end

			t4.StateInfo.IsActivelyResimulating = false

			if tick() - timestamp > 0.08 then
				warn("Extreme cast lag encountered! Consider increasing HighFidelitySegmentSize.")

				return
			end
		else
			SimulateCast(t4, p6, false)
		end
	end)

	return t4
end
function t1.SetStaticFastCastReference(p7) -- line: 619
	-- upvalues: u5 (ref)
	u5 = p7
end

local function ModifyTransformation(p8, vector3: Vector3?, vector3_7: Vector3?, vector3_8: Vector3?) -- line: 625
	-- upvalues: GetTrajectoryInfo (copy), Table (copy)
	local Trajectories = p8.StateInfo.Trajectories
	local v133 = Trajectories[#Trajectories]

	if v133.StartTime == p8.StateInfo.TotalRuntime then
		if vector3 == nil then
			vector3 = v133.InitialVelocity
		end

		if vector3_7 == nil then
			vector3_7 = v133.Acceleration
		end

		if vector3_8 == nil then
			vector3_8 = v133.Origin
		end

		v133.Origin = vector3_8
		v133.InitialVelocity = vector3
		v133.Acceleration = vector3_7

		return
	end

	v133.EndTime = p8.StateInfo.TotalRuntime
	assert(p8.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	local v134, v135 = unpack((GetTrajectoryInfo(p8, #p8.StateInfo.Trajectories)))

	if vector3 == nil then
		vector3 = v135
	end

	if vector3_7 == nil then
		vector3_7 = v133.Acceleration
	end

	if vector3_8 == nil then
		vector3_8 = v134
	end

	Table.insert(p8.StateInfo.Trajectories, {
		EndTime = -1,
		StartTime = p8.StateInfo.TotalRuntime,
		Origin = vector3_8,
		InitialVelocity = vector3,
		Acceleration = vector3_7
	})
	p8.StateInfo.CancelHighResCast = true
end

function t1.SetVelocity(t5: {[any]: any}, vector3: Vector3) -- line: 671
	-- upvalues: t1 (copy), ModifyTransformation (copy)
	assert(getmetatable(t5) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetVelocity", "ActiveCast.new(...)"))
	assert(t5.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	ModifyTransformation(t5, vector3, nil, nil)
end
function t1.SetAcceleration(t6: {[any]: any}, vector3: Vector3) -- line: 677
	-- upvalues: t1 (copy), ModifyTransformation (copy)
	assert(getmetatable(t6) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetAcceleration", "ActiveCast.new(...)"))
	assert(t6.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	ModifyTransformation(t6, nil, vector3, nil)
end
function t1.SetPosition(t7: {[any]: any}, vector3: Vector3) -- line: 683
	-- upvalues: t1 (copy), ModifyTransformation (copy)
	assert(getmetatable(t7) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetPosition", "ActiveCast.new(...)"))
	assert(t7.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	ModifyTransformation(t7, nil, nil, vector3)
end
function t1.GetVelocity(p9) -- line: 689
	-- upvalues: t1 (copy)
	assert(getmetatable(p9) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetVelocity", "ActiveCast.new(...)"))
	assert(p9.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	local v143 = p9.StateInfo.Trajectories[#p9.StateInfo.Trajectories]
	local v144 = p9.StateInfo.TotalRuntime - v143.StartTime

	return v143.InitialVelocity + v143.Acceleration * v144
end
function t1.GetAcceleration(p10) -- line: 696
	-- upvalues: t1 (copy)
	assert(getmetatable(p10) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetAcceleration", "ActiveCast.new(...)"))
	assert(p10.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	return p10.StateInfo.Trajectories[#p10.StateInfo.Trajectories].Acceleration
end
function t1.GetPosition(p11) -- line: 703
	-- upvalues: t1 (copy)
	assert(getmetatable(p11) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPosition", "ActiveCast.new(...)"))
	assert(p11.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	local v147 = p11.StateInfo.Trajectories[#p11.StateInfo.Trajectories]
	local v148 = p11.StateInfo.TotalRuntime - v147.StartTime
	local Origin = v147.Origin
	local InitialVelocity = v147.InitialVelocity
	local Acceleration = v147.Acceleration
	local vector3 = Vector3.new(Acceleration.X * v148 ^ 2 / 2, Acceleration.Y * v148 ^ 2 / 2, Acceleration.Z * v148 ^ 2 / 2)

	return Origin + InitialVelocity * v148 + vector3
end
function t1.AddVelocity(t8: {[any]: any}, vector3: Vector3) -- line: 712
	-- upvalues: t1 (copy)
	assert(getmetatable(t8) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("AddVelocity", "ActiveCast.new(...)"))
	assert(t8.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	t8:SetVelocity(t8:GetVelocity() + vector3)
end
function t1.AddAcceleration(t9: {[any]: any}, vector3: Vector3) -- line: 718
	-- upvalues: t1 (copy)
	assert(getmetatable(t9) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("AddAcceleration", "ActiveCast.new(...)"))
	assert(t9.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	t9:SetAcceleration(t9:GetAcceleration() + vector3)
end
function t1.AddPosition(t10: {[any]: any}, vector3: Vector3) -- line: 724
	-- upvalues: t1 (copy)
	assert(getmetatable(t10) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("AddPosition", "ActiveCast.new(...)"))
	assert(t10.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	t10:SetPosition(t10:GetPosition() + vector3)
end
function t1.Pause(p12) -- line: 732
	-- upvalues: t1 (copy)
	assert(getmetatable(p12) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Pause", "ActiveCast.new(...)"))
	assert(p12.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	p12.StateInfo.Paused = true
end
function t1.Resume(p13) -- line: 738
	-- upvalues: t1 (copy)
	assert(getmetatable(p13) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Resume", "ActiveCast.new(...)"))
	assert(p13.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
	p13.StateInfo.Paused = false
end
function t1.Terminate(p14) -- line: 744
	-- upvalues: t1 (copy)
	assert(getmetatable(p14) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Terminate", "ActiveCast.new(...)"))
	assert(p14.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

	local Trajectories = p14.StateInfo.Trajectories

	Trajectories[#Trajectories].EndTime = p14.StateInfo.TotalRuntime
	p14.StateInfo.UpdateConnection:Disconnect()
	p14.Caster.CastTerminating:Fire(p14)
	p14.StateInfo.UpdateConnection = nil
	p14.Caster = nil
	p14.StateInfo = nil
	p14.RayInfo = nil
	p14.UserData = nil
	setmetatable(p14, nil)
end

return t1
