

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetService = game:GetService("AssetService")
local RunService = game:GetService("RunService")
local Observers = require(ReplicatedStorage.Packages.Observers)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local CurrentCamera = workspace.CurrentCamera
local color3 = Color3.fromRGB(0, 0, 0)
local color3_2 = Color3.fromRGB(255, 255, 255)
local ok, result = pcall(function()
	return AssetService:CreateEditableImage({
		Size = Vector2.new(1, 1)
	})
end)

if not ok then
	warn("[PhantomSequence] failed to initialize alpha image")
end

local ok2, result2 = pcall(function()
	return AssetService:CreateEditableImage({
		Size = Vector2.new(1, 1)
	})
end)

if not ok2 then
	warn("[PhantomSequence] failed to initialize color image")
end

local ok3, result3 = pcall(function()
	return AssetService:CreateSurfaceAppearanceAsync({
		ColorMap = Content.fromObject(result),
		EmissiveMask = Content.fromObject(result2)
	})
end)

if not ok3 then
	warn("[PhantomSequence] failed to initialize base surface")
elseif result3 then
	result3.AlphaMode = Enum.AlphaMode.Transparency
end

local function setEyeWave(n1: number)
	local v26 = (1 - n1) * 0.9 * 255 // 1
	local v27 = math.lerp(0, 255, n1) // 1

	if ok2 and result2 then
		local buf = buffer.create(4)

		buffer.writeu8(buf, 0, v27)
		buffer.writeu8(buf, 1, v27)
		buffer.writeu8(buf, 2, v27)
		buffer.writeu8(buf, 3, v27)
		result2:WritePixelsBuffer(Vector2.zero, Vector2.new(1, 1), buf)
	end

	if ok and result then
		local buf = buffer.create(4)

		buffer.writeu8(buf, 0, 255 - v26)
		buffer.writeu8(buf, 1, 255 - v26)
		buffer.writeu8(buf, 2, 255 - v26)
		buffer.writeu8(buf, 3, 255 - v26)
		result:WritePixelsBuffer(Vector2.zero, Vector2.new(1, 1), buf)
	end
end
local function getBodyWave(n2: number)
	if n2 < 2 then
		return (1 - math.cos(n2 / 2 * 3.141592653589793 * 2 * 2)) / 2
	end

	if n2 < 3.9 then
		return 0
	end

	return (1 - math.cos((n2 - 2 - 1 - 0.8999999999999999) / 2 * 3.141592653589793 * 2 * 2)) / 2
end
local function getUpdateInterval(n3: number, b1: boolean)
	if b1 then
		if n3 < 50 then
			return 0.001
		end

		if n3 < 140 then
			return 0.03333333333333333
		end

		if n3 < 220 then
			return 0.2
		end
	end

	return 1
end
local function applyBodyWave(t1: {[any]: any}, n4: number)
	local instance = t1.instance

	instance.Transparency = math.lerp(t1.restTransparency, t1.activeTransparency, n4)

	if not t1.noColor then
		instance.Color = t1.restColor:Lerp(t1.activeColor, n4)
	end
end

local t2 = {}

local function siftUp(n5: number)
	while n5 > 1 do
		local v37 = n5 // 2

		if not (t2[n5].nextUpdate < t2[v37].nextUpdate) then
			return
		end

		local v38 = t2
		local v39 = t2
		local v40 = t2[v37]
		local v41 = t2[n5]

		v38[n5] = v40
		v39[v37] = v41
		n5 = v37
	end
end
local function siftDown(n6: number)
	local v43 = #t2

	while true do
		local v44 = n6
		local v45 = n6 * 2
		local v46 = v45 + 1

		if v45 <= v43 and t2[v45].nextUpdate < t2[v44].nextUpdate then
			v44 = v45
		end

		if v46 <= v43 and t2[v46].nextUpdate < t2[v44].nextUpdate then
			v44 = v46
		end

		if v44 == n6 then
			break
		end

		local v47 = t2
		local v48 = t2
		local v49 = t2[v44]
		local v50 = t2[n6]

		v47[n6] = v49
		v48[v44] = v50
		n6 = v44
	end
end
local function heapPush(t3: {[any]: any})
	local v52 = #t2 + 1

	t2[v52] = t3
	siftUp(v52)
end
local function heapPop()
	local v53 = #t2
	local v54 = t2[1]
	local v55 = t2[v53]

	t2[v53] = nil

	if v53 > 1 then
		t2[1] = v55
		siftDown(1)
	end

	return v54
end

local n7 = 0

RunService.Heartbeat:Connect(function()
	local elapsed = os.clock()
	local v57 = workspace:GetServerTimeNow() % 5.9
	local v58 = if not (v57 < 2) then if not (v57 < 3.9) then (1 - math.cos((v57 - 2 - 1 - 0.8999999999999999) / 2 * 3.141592653589793 * 2 * 2)) / 2 else 0 else (1 - math.cos(v57 / 2 * 3.141592653589793 * 2 * 2)) / 2
		local n8 = 0

		if v57 >= 2 and v57 < 3.9 then
			local v60 = v57 - 2 - 1

			if v60 >= 0 and v60 % 0.3 < 0.15 then
				n8 = 1
			end
		elseif v57 >= 3.9 then
			n8 = v58
		end

		if n8 ~= n7 then
			n7 = n8
			setEyeWave(n8)
		end

		local Instant = FFlags:GetInstant("Phantom.DistributeLoad", true)
		local v62 = not Instant and 1e999 or FFlags:GetInstant("Phantom.DistributeLoadBudget", 0.00125)
		local v63 = not Instant and 1e999 or FFlags:GetInstant("Phantom.MaxUpdatesPerFrame", 200)
		local CurrentCameraCFrame = CurrentCamera.CFrame
		local CurrentCameraCFramePosition = CurrentCameraCFrame.Position
		local LookVector = CurrentCameraCFrame.LookVector
		local v67 = math.rad(CurrentCamera.FieldOfView / 2) + 0.20943951023931956

		debug.profilebegin("PhantomSequence:Body")

		local n9 = 0

		while n9 < v63 and v62 > 0 do
			local v69 = t2[1]

			if not v69 or elapsed < v69.nextUpdate then
				break
			end

			local v70 = #t2
			local _ = t2[1]
			local v72 = t2[v70]

			t2[v70] = nil

			if v70 > 1 then
				t2[1] = v72
				siftDown(1)
			end

			if not v69.removed then
				local elapsed2 = os.clock()
				local v74 = CurrentCameraCFramePosition - v69.instance.Position
				local Magnitude = v74.Magnitude
				local v76 = math.acos((LookVector:Dot(v74.Unit)))
				local v77 = if not v69.useEyeWave then v58 else n8

				if v77 ~= v69.lastWave then
					v69.lastWave = v77

					local instance = v69.instance

					instance.Transparency = math.lerp(v69.restTransparency, v69.activeTransparency, v77)

					if not v69.noColor then
						instance.Color = v69.restColor:Lerp(v69.activeColor, v77)
					end
				end

				v69.nextUpdate = elapsed + (not (v67 <= v76) and 1 or if not (Magnitude < 50) then if not (Magnitude < 140) then not (Magnitude < 220) and 1 or 0.2 else 0.03333333333333333 else 0.001)

				local v79 = #t2 + 1

				t2[v79] = v69
				siftUp(v79)
				v62 -= os.clock() - elapsed2
				n9 += 1
			end
		end

		debug.profileend()
	end)
Observers.observeTag("PhantomPart", function(p1)
	local p1Color = p1.Color
	local p1Transparency = p1.Transparency
	local SurfaceAppearance = p1:FindFirstChildWhichIsA("SurfaceAppearance")
	local t4 = {
		useEyeWave = false,
		nextUpdate = 0,
		lastWave = -1,
		removed = false,
		instance = p1,
		restTransparency = math.random(60, 90) / 100,
		restColor = p1Color:Lerp(color3, 0.7),
		activeTransparency = p1Transparency,
		activeColor = p1Color,
		surface = SurfaceAppearance,
		activeStrength = not SurfaceAppearance and 0 or 1000,
		noColor = p1:GetAttribute("PhantomNoColor") == true
	}
	local v85 = #t2 + 1

	t2[v85] = t4
	siftUp(v85)

	return function()
		t4.removed = true
	end
end)
Observers.observeTag("PhantomEyesPart", function(p2)
	if not p2:IsA("MeshPart") or (not ok3 or not result3) then
		local DefaultTransparency = p2:GetAttribute("DefaultTransparency")
		local t5 = {
			restTransparency = 0.9,
			surface = nil,
			activeStrength = 0,
			noColor = false,
			useEyeWave = true,
			nextUpdate = 0,
			lastWave = -1,
			removed = false,
			instance = p2,
			restColor = color3,
			activeTransparency = DefaultTransparency or 0,
			activeColor = color3_2
		}
		local v89 = #t2 + 1

		t2[v89] = t5
		siftUp(v89)

		return function()
			t5.removed = true
		end
	end

	p2.Transparency = 0

	local SurfaceAppearance = p2:FindFirstChildWhichIsA("SurfaceAppearance")

	if SurfaceAppearance then
		SurfaceAppearance.Parent = nil
	end

	local clone = result3:Clone()

	clone.Parent = p2

	return function()
		clone:Destroy()

		if SurfaceAppearance then
			if p2.Parent then
				pcall(function()
					SurfaceAppearance.Parent = p2
				end)
			else
				SurfaceAppearance:Destroy()
			end

			SurfaceAppearance = nil
		end
	end
end)
