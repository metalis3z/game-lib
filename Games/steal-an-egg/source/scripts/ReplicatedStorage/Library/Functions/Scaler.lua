-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ScaleNumberSequence = require(script.Parent.ScaleNumberSequence)

return function(p1, p2, p3) --[[ Line: 13 | Upvalues: ScaleNumberSequence (copy) ]]
	local t = {}
	local t2 = {}

	local function v1(p12, p22, p32) --[[ scaleObject | Line: 21 | Upvalues: p2 (copy), p3 (copy), t2 (copy), t (copy), p1 (copy), ScaleNumberSequence (ref), v1 (copy) ]]
		if p2 and not p2(p12) then
			return
		end

		if p3 and p12:IsA("Model") then
			local v12 = math.max(0.001, p22)

			if t2[p12] then
				p12:ScaleTo(t2[p12] * v12)
			else
				t2[p12] = v12
				p12:ScaleTo(v12)
			end
		else
			if p12:IsA("BasePart") then
				local v2 = p12:FindFirstAncestorWhichIsA("Model")
				local v3 = if v2 then v2.PrimaryPart else nil

				if not v3 then
					local v4 = p12:FindFirstAncestorWhichIsA("BasePart")

					if v4 then
						v3 = v4
					end

					if not v3 then
						v3 = p12.AssemblyRootPart
					end
				end

				local v5 = v3 or p12
				local Size = v5.Size

				local function getInitialSize() --[[ getInitialSize | Line: 54 | Upvalues: Size (copy) ]]
					return Size
				end

				local v6 = t[v5]

				if not v6 then
					v6 = {}
					t[v5] = v6
				end

				assert(v6, "Assertion failed: pivotCache should not be nil")

				local Size2 = v6.Size

				if Size2 == nil then
					v6.Size = Size
					Size2 = Size
				end

				assert(if Size2 == nil then false else true, "Assertion failed: pivotInitialSize should have been initialized")

				local v8 = Size2 * p22

				if p32 ~= nil then
					local v9 = v5:GetPivot()
					local v10 = v9 * CFrame.new(Size * p32) * CFrame.new(v8 * -p32)
					local v11 = p12:GetPivot()
					local v12

					if p1 then
						v12 = v9:ToObjectSpace(v11)
					else
						local function getObjectPivot() --[[ getObjectPivot | Line: 83 | Upvalues: v9 (copy), v11 (copy) ]]
							return v9:ToObjectSpace(v11)
						end

						local v14 = t[p12]

						if not v14 then
							v14 = {}
							t[p12] = v14
						end

						assert(v14, "Assertion failed: objectCache should not be nil")

						local ObjectCFrame = v14.ObjectCFrame

						if ObjectCFrame == nil then
							ObjectCFrame = v9:ToObjectSpace(v11)
							v14.ObjectCFrame = ObjectCFrame
						end

						assert(if ObjectCFrame == nil then false else true, "Assertion failed: cachedObjectPivot should have been set")
						v12 = ObjectCFrame
					end

					p12:PivotTo(v10:ToWorldSpace(v12 - v12.Position + v12.Position * p22))
				end

				local Size3 = p12.Size

				local function getObjectInitialSize() --[[ getObjectInitialSize | Line: 111 | Upvalues: Size3 (copy) ]]
					return Size3
				end

				local v16 = t[p12]

				if not v16 then
					v16 = {}
					t[p12] = v16
				end

				assert(v16, "Assertion failed: objectCache for object should not be nil")

				local Size4 = v16.Size

				if Size4 == nil then
					v16.Size = Size3
					Size4 = Size3
				end

				assert(if Size4 == nil then false else true, "Assertion failed: cachedObjectSize should have been set")
				p12.Size = Size4 * p22
			elseif p12:IsA("SpecialMesh") then
				local function getMeshScale() --[[ getMeshScale | Line: 131 | Upvalues: p12 (copy) ]]
					return p12.Scale
				end

				local v18 = t[p12]

				if not v18 then
					v18 = {}
					t[p12] = v18
				end

				assert(v18, "Assertion failed: meshCache for SpecialMesh should not be nil")

				local Scale = v18.Scale

				if Scale == nil then
					Scale = p12.Scale
					v18.Scale = Scale
				end

				assert(if Scale == nil then false else true, "Assertion failed: cachedMeshScale should have been set")
				p12.Scale = Scale * p22

				local function getMeshOffset() --[[ getMeshOffset | Line: 148 | Upvalues: p12 (copy) ]]
					return p12.Offset
				end

				local v20 = t[p12]

				if not v20 then
					v20 = {}
					t[p12] = v20
				end

				assert(v20, "Assertion failed: meshCache2 for SpecialMesh should not be nil")

				local Offset = v20.Offset

				if Offset == nil then
					Offset = p12.Offset
					v20.Offset = Offset
				end

				assert(if Offset == nil then false else true, "Assertion failed: cachedMeshOffset should have been set")
				p12.Offset = Offset * p22
			elseif p12:IsA("ParticleEmitter") then
				local v22 = typeof(p22) == "Vector3" and (p22.X + p22.Y + p22.Z) / 3 or p22

				local function getEmitterSize() --[[ getEmitterSize | Line: 169 | Upvalues: p12 (copy) ]]
					return p12.Size
				end

				local v23 = t[p12]

				if not v23 then
					v23 = {}
					t[p12] = v23
				end

				assert(v23, "Assertion failed: emitterCache for ParticleEmitter should not be nil")

				local Size = v23.Size

				if Size == nil then
					Size = p12.Size
					v23.Size = Size
				end

				assert(if Size == nil then false else true, "Assertion failed: cachedEmitterSize should have been set")
				p12.Size = ScaleNumberSequence(Size, v22)

				local function getEmitterDrag() --[[ getEmitterDrag | Line: 186 | Upvalues: p12 (copy) ]]
					return p12.Drag
				end

				local v25 = t[p12]

				if not v25 then
					v25 = {}
					t[p12] = v25
				end

				assert(v25, "Assertion failed: emitterCacheDrag for ParticleEmitter should not be nil")

				local Drag = v25.Drag

				if Drag == nil then
					Drag = p12.Drag
					v25.Drag = Drag
				end

				assert(if Drag == nil then false else true, "Assertion failed: cachedEmitterDrag should have been set")
				p12.Drag = Drag * v22

				local function getVelocityInheritance() --[[ getVelocityInheritance | Line: 203 | Upvalues: p12 (copy) ]]
					return p12.VelocityInheritance
				end

				local v27 = t[p12]

				if not v27 then
					v27 = {}
					t[p12] = v27
				end

				assert(v27, "Assertion failed: emitterCacheVelocity for ParticleEmitter should not be nil")

				local VelocityInheritance = v27.VelocityInheritance

				if VelocityInheritance == nil then
					VelocityInheritance = p12.VelocityInheritance
					v27.VelocityInheritance = VelocityInheritance
				end

				assert(if VelocityInheritance == nil then false else true, "Assertion failed: cachedVelocityInheritance should have been set")
				p12.VelocityInheritance = VelocityInheritance * v22

				local function getEmitterSpeed() --[[ getEmitterSpeed | Line: 226 | Upvalues: p12 (copy) ]]
					return p12.Speed
				end

				local v29 = t[p12]

				if not v29 then
					v29 = {}
					t[p12] = v29
				end

				assert(v29, "Assertion failed: emitterCacheSpeed for ParticleEmitter should not be nil")

				local Speed = v29.Speed

				if Speed == nil then
					Speed = p12.Speed
					v29.Speed = Speed
				end

				assert(if Speed == nil then false else true, "Assertion failed: cachedEmitterSpeed should have been set")
				p12.Speed = NumberRange.new(Speed.Min * v22, Speed.Max * v22)

				local function getEmitterAcceleration() --[[ getEmitterAcceleration | Line: 244 | Upvalues: p12 (copy) ]]
					return p12.Acceleration
				end

				local v31 = t[p12]

				if not v31 then
					v31 = {}
					t[p12] = v31
				end

				assert(v31, "Assertion failed: emitterCacheAcceleration for ParticleEmitter should not be nil")

				local Acceleration = v31.Acceleration

				if Acceleration == nil then
					Acceleration = p12.Acceleration
					v31.Acceleration = Acceleration
				end

				assert(if Acceleration == nil then false else true, "Assertion failed: cachedEmitterAcceleration should have been set")
				p12.Acceleration = Acceleration * p22

				local function getEmitterZOffset() --[[ getEmitterZOffset | Line: 267 | Upvalues: p12 (copy) ]]
					return p12.ZOffset
				end

				local v33 = t[p12]

				if not v33 then
					v33 = {}
					t[p12] = v33
				end

				assert(v33, "Assertion failed: emitterCacheZOffset for ParticleEmitter should not be nil")

				local ZOffset = v33.ZOffset

				if ZOffset == nil then
					ZOffset = p12.ZOffset
					v33.ZOffset = ZOffset
				end

				assert(if ZOffset == nil then false else true, "Assertion failed: cachedEmitterZOffset should have been set")
				p12.ZOffset = ZOffset * v22
			elseif p12:IsA("Attachment") then
				local function getAttachmentCFrame() --[[ getAttachmentCFrame | Line: 287 | Upvalues: p12 (copy) ]]
					return p12.CFrame
				end

				local v35 = t[p12]

				if not v35 then
					v35 = {}
					t[p12] = v35
				end

				assert(v35, "Assertion failed: attachmentCache for Attachment should not be nil")

				local v36 = v35.CFrame

				if v36 == nil then
					v36 = p12.CFrame
					v35.CFrame = v36
				end

				assert(if v36 == nil then false else true, "Assertion failed: cachedAttachmentCFrame should have been set")
				p12.CFrame = v36 - v36.Position + v36.Position * p22
			end

			for i, v in ipairs(p12:GetChildren()) do
				v1(v, p22, p32)
			end
		end
	end

	return function(p1, p2, p3) --[[ Line: 313 | Upvalues: v1 (copy) ]]
		return v1(p1, p2, p3)
	end
end