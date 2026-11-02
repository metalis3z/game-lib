-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local function mergeTables(p1, ...) --[[ mergeTables | Line: 8 ]]
	local t = {}

	for v1, v2 in { p1, ... } do
		for v3, v4 in v2 do
			t[v3] = v4
		end
	end

	return t
end

local function evalNumberSequence(p1, p2) --[[ evalNumberSequence | Line: 18 ]]
	if p2 == 0 then
		return p1.Keypoints[1].Value
	end

	if p2 == 1 then
		return p1.Keypoints[#p1.Keypoints].Value
	end

	for i = 1, #p1.Keypoints - 1 do
		local v1 = p1.Keypoints[i]
		local v2 = p1.Keypoints[i + 1]

		if v1.Time <= p2 and p2 < v2.Time then
			return v1.Value + (v2.Value - v1.Value) * ((p2 - v1.Time) / (v2.Time - v1.Time))
		end
	end

	return 0
end

local function decompressFilter(p1) --[[ decompressFilter | Line: 36 | Upvalues: HttpService (copy) ]]
	local t = {}

	for v1, v2 in HttpService:JSONDecode(p1) do
		t[v1] = {}

		for v3, v4 in v2 do
			t[v1][v3] = {}

			for v5, v6 in v4 do
				table.insert(t[v1][v3], NumberSequenceKeypoint.new(v6[1], v6[2]))
			end

			t[v1][v3] = NumberSequence.new(t[v1][v3])
		end
	end

	return t
end

local v1 = decompressFilter("{\"Bloom\":{\"Threshold\":[[0,5],[1,5]]},\"Camera\":{\"RotationZ\":[[0,0.537],[0.07,0.537],[0.199,0.474],[0.301,0.512],[0.499,0.5],[1,0.5]],\"Multiplier\":[[0,0.256],[0.102,0.243],[0.5,0.5],[1,0.5]],\"RotationY\":[[0,0.5],[1,0.5]]},\"Blur\":{\"Size\":[[0,1],[0.198,1],[0.5,0],[1,0]]},\"ColorCorrection\":{\"Contrast\":[[0,1],[0.098,1],[0.701,0],[1,0]],\"Brightness\":[[0,0.45],[0.1,0.45],[0.293,0],[1,0]]}}")

local function renderCameraSequence(p1, p2, p3, p4) --[[ renderCameraSequence | Line: 56 | Upvalues: evalNumberSequence (copy) ]]
	local v1 = 0
	local v2 = 0
	local v3 = 1
	local Camera = p4.Camera

	if Camera then
		if Camera.RotationZ then
			v1 = (evalNumberSequence(Camera.RotationZ, p1) - 0.5) * 180
		end

		if Camera.RotationY then
			v2 = (evalNumberSequence(Camera.RotationY, p1) - 0.5) * 180
		end

		if Camera.Multiplier then
			v3 = 1 + (evalNumberSequence(Camera.Multiplier, p1) - 0.5)
		end
	end

	return p3 * CFrame.Angles(math.rad(v2), 0, 0) * CFrame.Angles(0, 0, (math.rad(v1))), p2 * v3
end

local function applyBloomSettings(p1, p2) --[[ applyBloomSettings | Line: 77 | Upvalues: evalNumberSequence (copy) ]]
	local v1 = 0
	local v2 = 2
	local v3 = 0
	local v4 = 0
	local v5 = 0
	local v6 = 0

	if p2.Bloom then
		if p2.Bloom.Threshold then
			v2 = 2 * evalNumberSequence(p2.Bloom.Threshold, p1)
		end

		if p2.Bloom.Size then
			v1 = evalNumberSequence(p2.Bloom.Size, p1)
		end
	end

	if p2.Blur and p2.Blur.Size then
		v3 = 24 * evalNumberSequence(p2.Blur.Size, p1)
	end

	if p2.ColorCorrection then
		if p2.ColorCorrection.Brightness then
			v4 = evalNumberSequence(p2.ColorCorrection.Brightness, p1)
		end

		if p2.ColorCorrection.Contrast then
			v5 = evalNumberSequence(p2.ColorCorrection.Contrast, p1)
		end

		if p2.ColorCorrection.Saturation then
			v6 = evalNumberSequence(p2.ColorCorrection.Saturation, p1)
		end
	end

	return {
		bloomSize = v1,
		bloomThreshold = v2,
		blur = v3,
		brightness = v4,
		contrast = v5,
		saturation = v6
	}
end

local function pulseZoomTransform(p1, p2, p3, p4) --[[ pulseZoomTransform | Line: 120 | Upvalues: renderCameraSequence (copy), v1 (copy), applyBloomSettings (copy), mergeTables (copy) ]]
	if p4 then
		local v12 = math.clamp(p2 % 0.4 / 0.4, 0, 1)

		return mergeTables({
			cameraCFrameOverwriteFunction = function(p1, p2) --[[ cameraCFrameOverwriteFunction | Line: 130 | Upvalues: renderCameraSequence (ref), v12 (copy), v1 (ref) ]]
				local v13, v2 = renderCameraSequence(v12, p2, p1, v1)

				return v13, v2
			end
		}, (applyBloomSettings(v12, v1)))
	end

	return {}
end

local t = {
	connection = nil,
	startTime = 0,
	colorCorrection = nil,
	bloom = nil,
	blur = nil,
	previousCameraOverride = nil,
	useGlobalCameraOverride = false,
	baseCameraCFrame = nil,
	baseFieldOfView = nil,
	lastPulseIndex = -1,
	onPulseEnd = nil
}

local function ensureLightingEffects() --[[ ensureLightingEffects | Line: 154 | Upvalues: t (copy), Lighting (copy) ]]
	if not t.colorCorrection then
		local PulseZoomColorCorrection = Instance.new("ColorCorrectionEffect")

		PulseZoomColorCorrection.Name = "PulseZoomColorCorrection"
		PulseZoomColorCorrection.Parent = Lighting
		t.colorCorrection = PulseZoomColorCorrection
	end

	if not t.bloom then
		local PulseZoomBloom = Instance.new("BloomEffect")

		PulseZoomBloom.Name = "PulseZoomBloom"
		PulseZoomBloom.Parent = Lighting
		t.bloom = PulseZoomBloom
	end

	if t.blur then
		return
	end

	local PulseZoomBlur = Instance.new("BlurEffect")

	PulseZoomBlur.Name = "PulseZoomBlur"
	PulseZoomBlur.Parent = Lighting
	t.blur = PulseZoomBlur
end

local function clearLightingEffects() --[[ clearLightingEffects | Line: 175 | Upvalues: t (copy) ]]
	if t.colorCorrection then
		t.colorCorrection:Destroy()
		t.colorCorrection = nil
	end

	if t.bloom then
		t.bloom:Destroy()
		t.bloom = nil
	end

	if not t.blur then
		return
	end

	t.blur:Destroy()
	t.blur = nil
end

local function applyLightingSettings(p1) --[[ applyLightingSettings | Line: 190 | Upvalues: t (copy) ]]
	if t.colorCorrection then
		t.colorCorrection.Brightness = p1.brightness or 0
		t.colorCorrection.Contrast = p1.contrast or 0
		t.colorCorrection.Saturation = p1.saturation or 0
	end

	if t.bloom then
		t.bloom.Intensity = 1
		t.bloom.Size = p1.bloomSize or 24
		t.bloom.Threshold = p1.bloomThreshold or 2
	end

	if not t.blur then
		return
	end

	t.blur.Size = p1.blur or 0
end

local function applyCameraSettings(p1, p2, p3, p4) --[[ applyCameraSettings | Line: 206 ]]
	if not p2 then
		return
	end

	local cameraCFrameOverwriteFunction = p1.cameraCFrameOverwriteFunction

	if not cameraCFrameOverwriteFunction then
		return
	end

	local v3, v4 = cameraCFrameOverwriteFunction(if p3 then p3 else p2.CFrame, if p4 then p4 else p2.FieldOfView)

	if v3 then
		p2.CFrame = v3
	end

	if not v4 then
		return
	end

	p2.FieldOfView = v4
end

return {
	Play = function(p1) --[[ Play | Line: 225 | Upvalues: t (copy), ensureLightingEffects (copy), RunService (copy), pulseZoomTransform (copy), applyLightingSettings (copy), Workspace (copy) ]]
		if t.connection then
			return
		end

		local v1 = p1 or {}
		local v2 = if v1.applyLighting == nil then true else v1.applyLighting
		local v3 = if v1.useGlobalCameraOverride == true then true else false
		local v4 = if v1.applyCamera == nil then not v3 else v1.applyCamera

		t.startTime = tick()
		t.useGlobalCameraOverride = v3
		t.baseCameraCFrame = nil
		t.baseFieldOfView = nil
		t.lastPulseIndex = -1
		t.onPulseEnd = v1.onPulseEnd

		if v2 then
			ensureLightingEffects()
		end

		if not v3 then
			t.connection = RunService.RenderStepped:Connect(function() --[[ Line: 247 | Upvalues: t (ref), pulseZoomTransform (ref), v2 (copy), applyLightingSettings (ref), v3 (copy), v4 (copy), v1 (copy), Workspace (ref) ]]
				local v12 = tick() - t.startTime
				local v22 = math.floor(v12 / 0.4)

				if v22 ~= t.lastPulseIndex then
					if t.lastPulseIndex >= 0 and t.onPulseEnd then
						t.onPulseEnd()
					end

					t.lastPulseIndex = v22
				end

				local v32 = pulseZoomTransform(nil, v12, nil, true)

				if v2 then
					applyLightingSettings(v32)
				end

				if v3 then
					_G.cameraCFrameOverwriteFunction = v32.cameraCFrameOverwriteFunction

					return
				end

				if not v4 then
					return
				end

				local v42 = v1.camera or Workspace.CurrentCamera

				if v42 and not t.baseCameraCFrame then
					t.baseCameraCFrame = v42.CFrame
					t.baseFieldOfView = v42.FieldOfView
				end

				local baseCameraCFrame = t.baseCameraCFrame
				local baseFieldOfView = t.baseFieldOfView

				if not v42 then
					return
				end

				local cameraCFrameOverwriteFunction = v32.cameraCFrameOverwriteFunction

				if not cameraCFrameOverwriteFunction then
					return
				end

				local v7, v8 = cameraCFrameOverwriteFunction(if baseCameraCFrame then baseCameraCFrame else v42.CFrame, if baseFieldOfView then baseFieldOfView else v42.FieldOfView)

				if v7 then
					v42.CFrame = v7
				end

				if not v8 then
					return
				end

				v42.FieldOfView = v8
			end)

			return
		end

		t.previousCameraOverride = _G.cameraCFrameOverwriteFunction
		t.connection = RunService.RenderStepped:Connect(function() --[[ Line: 247 | Upvalues: t (ref), pulseZoomTransform (ref), v2 (copy), applyLightingSettings (ref), v3 (copy), v4 (copy), v1 (copy), Workspace (ref) ]]
			local v12 = tick() - t.startTime
			local v22 = math.floor(v12 / 0.4)

			if v22 ~= t.lastPulseIndex then
				if t.lastPulseIndex >= 0 and t.onPulseEnd then
					t.onPulseEnd()
				end

				t.lastPulseIndex = v22
			end

			local v32 = pulseZoomTransform(nil, v12, nil, true)

			if v2 then
				applyLightingSettings(v32)
			end

			if v3 then
				_G.cameraCFrameOverwriteFunction = v32.cameraCFrameOverwriteFunction

				return
			end

			if not v4 then
				return
			end

			local v42 = v1.camera or Workspace.CurrentCamera

			if v42 and not t.baseCameraCFrame then
				t.baseCameraCFrame = v42.CFrame
				t.baseFieldOfView = v42.FieldOfView
			end

			local baseCameraCFrame = t.baseCameraCFrame
			local baseFieldOfView = t.baseFieldOfView

			if not v42 then
				return
			end

			local cameraCFrameOverwriteFunction = v32.cameraCFrameOverwriteFunction

			if not cameraCFrameOverwriteFunction then
				return
			end

			local v7, v8 = cameraCFrameOverwriteFunction(if baseCameraCFrame then baseCameraCFrame else v42.CFrame, if baseFieldOfView then baseFieldOfView else v42.FieldOfView)

			if v7 then
				v42.CFrame = v7
			end

			if not v8 then
				return
			end

			v42.FieldOfView = v8
		end)
	end,
	Stop = function() --[[ Stop | Line: 273 | Upvalues: t (copy) ]]
		if t.connection then
			t.connection:Disconnect()
			t.connection = nil
		end

		if t.useGlobalCameraOverride then
			_G.cameraCFrameOverwriteFunction = t.previousCameraOverride
			t.previousCameraOverride = nil
			t.useGlobalCameraOverride = false
		end

		t.baseCameraCFrame = nil
		t.baseFieldOfView = nil
		t.lastPulseIndex = -1
		t.onPulseEnd = nil

		if t.colorCorrection then
			t.colorCorrection:Destroy()
			t.colorCorrection = nil
		end

		if t.bloom then
			t.bloom:Destroy()
			t.bloom = nil
		end

		if not t.blur then
			return
		end

		t.blur:Destroy()
		t.blur = nil
	end,
	transform = pulseZoomTransform
}