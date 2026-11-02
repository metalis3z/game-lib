
local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Debris")
local u3 = game:GetService("RunService")
local u4 = {}
local u5 = require(v1.Packages.Net):RemoteEvent("EventService/TeykxLazer/Hit")
local u6 = nil
local u7 = Vector3.new(0, 0, 0)
local u8 = nil
local u9 = v1.Models.Events["Solar Flare"].SolarFlareBeam.BeamEnd.MainAttachment
local u10 = ColorSequence.new(Color3.new(0, 0, 0))
local function u24(p11) -- name: SpawnSolarEffect
	-- upvalues: (copy) u9, (copy) u10, (copy) u2
	local v12 = Instance.new("Part")
	v12.Anchored = true
	v12.CanCollide = false
	v12.CanQuery = false
	v12.CanTouch = false
	v12.Size = Vector3.new(0.05, 0.05, 0.05)
	v12.Transparency = 1
	v12.CastShadow = false
	v12.Position = p11
	v12.Parent = workspace
	local v13 = u9:Clone()
	v13.Parent = v12
	for _, v14 in ipairs(v13:GetDescendants()) do
		if v14:IsA("ParticleEmitter") then
			v14.Color = u10
			local v15 = v14.Size.Keypoints
			local v16 = {}
			for _, v17 in ipairs(v15) do
				local v18 = NumberSequenceKeypoint.new
				local v19 = v17.Time
				local v20 = v17.Value * 0.175
				local v21 = v17.Envelope * 0.175
				table.insert(v16, v18(v19, v20, v21))
			end
			v14.Size = NumberSequence.new(v16)
			local v22
			if v14.Rate > 0 then
				local v23 = v14.Rate * 0.175
				v22 = math.ceil(v23) or 3
			else
				v22 = 3
			end
			v14:Emit(v22)
			v14.Rate = 0
		end
	end
	u2:AddItem(v12, 3)
end
local function u28(p25, p26) -- name: MakeBeam
	local v27 = Instance.new("Beam")
	v27.Attachment0 = p25
	v27.Attachment1 = p26
	v27.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 220, 255)) })
	v27.Transparency = NumberSequence.new(0)
	v27.Width0 = 1
	v27.Width1 = 0.35
	v27.LightEmission = 1
	v27.LightInfluence = 0
	v27.FaceCamera = true
	v27.Segments = 1
	v27.Parent = p25.Parent
	return v27
end
local function u32() -- name: SetupTracer
	-- upvalues: (ref) u6, (ref) u8, (copy) u3, (ref) u7
	if not u6 then
		u6 = Instance.new("Part")
		u6.Anchored = true
		u6.CanCollide = false
		u6.CanQuery = false
		u6.CanTouch = false
		u6.Size = Vector3.new(0.05, 0.05, 0.05)
		u6.Transparency = 1
		u6.CastShadow = false
		u6.Parent = workspace
		local v29 = Instance.new("Attachment")
		v29.Position = Vector3.new(0, 0.2, 0)
		v29.Parent = u6
		local v30 = Instance.new("Attachment")
		v30.Position = Vector3.new(0, -0.2, 0)
		v30.Parent = u6
		local v31 = Instance.new("Trail")
		v31.Attachment0 = v29
		v31.Attachment1 = v30
		v31.Lifetime = 1.5
		v31.MinLength = 0
		v31.FaceCamera = true
		v31.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
		v31.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
		v31.Color = ColorSequence.new(Color3.new(1, 1, 1))
		v31.LightEmission = 1
		v31.Parent = u6
		u8 = u3.Heartbeat:Connect(function()
			-- upvalues: (ref) u6, (ref) u7
			if u6 and u6.Parent then
				u6.Position = u7
			end
		end)
	end
end
function u4.OnLoad(_) -- name: OnLoad
	-- upvalues: (copy) u5, (ref) u7, (copy) u28, (copy) u24, (copy) u2
	u5.OnClientEvent:Connect(function(p33, p34, p35)
		-- upvalues: (ref) u7, (ref) u28, (ref) u24, (ref) u2
		u7 = p35
		local v36 = Instance.new("Part")
		v36.Anchored = true
		v36.CanCollide = false
		v36.CanQuery = false
		v36.CanTouch = false
		v36.Size = Vector3.new(0.05, 0.05, 0.05)
		v36.Transparency = 1
		v36.CastShadow = false
		v36.Position = p33
		v36.Parent = workspace
		local v37 = Instance.new("Attachment")
		v37.Parent = v36
		local v38 = Instance.new("Part")
		v38.Anchored = true
		v38.CanCollide = false
		v38.CanQuery = false
		v38.CanTouch = false
		v38.Size = Vector3.new(0.05, 0.05, 0.05)
		v38.Transparency = 1
		v38.CastShadow = false
		v38.Position = p34
		v38.Parent = workspace
		local v39 = Instance.new("Attachment")
		v39.Parent = v38
		local v40 = Instance.new("Part")
		v40.Anchored = true
		v40.CanCollide = false
		v40.CanQuery = false
		v40.CanTouch = false
		v40.Size = Vector3.new(0.05, 0.05, 0.05)
		v40.Transparency = 1
		v40.CastShadow = false
		v40.Position = p35
		v40.Parent = workspace
		local v41 = Instance.new("Attachment")
		v41.Parent = v40
		u28(v37, v41)
		u28(v39, v41)
		u24(p35)
		u2:AddItem(v36, 0.12)
		u2:AddItem(v38, 0.12)
		u2:AddItem(v40, 0.12)
	end)
end
function u4.OnStart(_) -- name: OnStart
	-- upvalues: (copy) u4, (copy) u32
	local v42 = game:GetService("Lighting")
	local v43 = script["Teykx Lazer"].Night_Sky_Coldzze
	local v44 = v42:FindFirstChildOfClass("Sky")
	if v44 then
		v44.Parent = game.ReplicatedStorage
	end
	local v45 = v43:Clone()
	v45.Parent = v42
	u4._existingSky = v44
	u4._clonedSky = v45
	u32()
end
function u4.OnStop(_) -- name: OnStop
	-- upvalues: (copy) u4, (ref) u8, (ref) u6
	local v46 = game:GetService("Lighting")
	if u4._clonedSky and u4._clonedSky.Parent then
		u4._clonedSky:Destroy()
		u4._clonedSky = nil
	end
	if u4._existingSky then
		u4._existingSky.Parent = v46
		u4._existingSky = nil
	end
	if u8 then
		u8:Disconnect()
		u8 = nil
	end
	if u6 then
		u6:Destroy()
		u6 = nil
	end
end
return u4