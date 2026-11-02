-- Marteau côté joueur : quand il est sorti (attribut HammerOut), un clic, F, la gâchette ou le bouton HIT frappe l'œuf
-- le plus proche. Le geste (élan au-dessus de l'épaule, coup vers le bas) est calculé ici, sur les articulations du bras.
-- Aussi : la boutique du stand HAMMERS.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local eggSystem = ReplicatedStorage:WaitForChild("EggSystem")
local EggConfig = require(eggSystem:WaitForChild("EggConfig"))
local hitRemote = eggSystem:WaitForChild("Remotes"):WaitForChild("HitEgg")
local system = ReplicatedStorage:WaitForChild("HammerSystem")
local HammerConfig = require(system:WaitForChild("HammerConfig"))
local models = system:WaitForChild("Models")
local SWING_TIME = 0.5  -- secondes entre deux coups
local IMPACT = 0.24     -- moment du coup dans le geste
local REACH = 9         -- distance max du bord de l'œuf
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local STUDS = "rbxassetid://7447638591"
local rad = math.rad

local function hammerOut() return player:GetAttribute("HammerOut") == true end
local function batOut() return player.Character ~= nil and player.Character:FindFirstChild("Bat") ~= nil end
local BAT_TIME = 0.75   -- secondes entre deux coups de batte
local BAT_IMPACT = 0.3  -- moment où la batte touche

---------------------------------------------------------------- cible : l'œuf le plus proche à portée
local function nearestEgg()
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local folder = workspace:FindFirstChild("ZoneEggs")
	if not root or not folder then return nil end
	local best, bestGap
	for _, zone in folder:GetChildren() do
		for _, egg in zone:GetChildren() do
			if egg:IsA("Model") and egg:GetAttribute("MaxHp") and not egg:GetAttribute("Hatching") then
				local center = egg:GetPivot().Position
				local flat = Vector3.new(root.Position.X - center.X, 0, root.Position.Z - center.Z).Magnitude
				if flat < 60 then
					local size = egg:GetExtentsSize()
					local gap = flat - math.max(size.X, size.Z) / 2
					if gap <= REACH and (not bestGap or gap < bestGap) then best, bestGap = egg, gap end
				end
			end
		end
	end
	return best
end

---------------------------------------------------------------- le geste : élan en arrière, coup vers le bas, retour
-- angles (degrés) à chaque instant du geste : épaule, coude, buste ; interpolés en douceur
-- Marteau : élan derrière l'épaule, puis il s'abat devant. Batte : élan sur le côté, grand coup à l'horizontale.
-- On tient l'outil d'une main ; pendant le coup la main gauche vient serrer le manche (IKControl vers l'attache OffHand).
local HAMMER_KEYS = {
	{t = 0.00, shoulder = 0, elbow = 0, waist = 0, twist = 0, wrist = 0},
	{t = 0.13, shoulder = 32, elbow = 12, waist = -12, twist = -16, wrist = 42, inward = -40, roll = 25},   -- élan : le marteau part à l'horizontale derrière l'épaule
	{t = 0.24, shoulder = -40, elbow = 0, waist = 24, twist = 12, wrist = -112, inward = -50, roll = -45},   -- coup : le marteau s'abat devant, la tête vers le bas
	{t = 0.31, shoulder = -46, elbow = 0, waist = 28, twist = 14, wrist = -118, inward = -50, roll = -45},   -- il s'écrase
	{t = 0.50, shoulder = 0, elbow = 0, waist = 0, twist = 0, wrist = 0},
}
local BAT_KEYS = {
	{t = 0.00, shoulder = 0, elbow = 0, waist = 0, twist = 0, wrist = 0},
	{t = 0.18, shoulder = 10, elbow = 16, waist = -6, twist = -58, wrist = -84, inward = -34},   -- élan : le buste tourne, la batte passe derrière
	{t = 0.30, shoulder = -8, elbow = 0, waist = 10, twist = 62, wrist = -100, inward = -48},     -- coup : la batte balaie devant, à l'horizontale
	{t = 0.40, shoulder = -8, elbow = 6, waist = 10, twist = 74, wrist = -102, inward = -48},    -- fin du geste
	{t = 0.70, shoulder = 0, elbow = 0, waist = 0, twist = 0, wrist = 0},
}
local CHANNELS = {"shoulder", "elbow", "waist", "twist", "wrist", "inward", "roll"}
local swingStart, swingKeys, swingIk
local function pose(keys, t)
	local out = {}
	for i = 2, #keys do
		local a, b = keys[i - 1], keys[i]
		if t <= b.t then
			local u = (t - a.t) / (b.t - a.t)
			u = i == 3 and u * u or u * u * (3 - 2 * u) -- le coup accélère
			for _, name in CHANNELS do out[name] = (a[name] or 0) + ((b[name] or 0) - (a[name] or 0)) * u end
			return out
		end
	end
	for _, name in CHANNELS do out[name] = 0 end
	return out
end
local function endSwing()
	swingStart = nil
	if swingIk then swingIk:Destroy() swingIk = nil end
end
-- la main gauche rejoint le manche le temps du coup
local function grabWithLeftHand(tool)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local chain, hand = character and character:FindFirstChild("LeftUpperArm"), character and character:FindFirstChild("LeftHand")
	local target = tool and tool:FindFirstChild("Handle") and tool.Handle:FindFirstChild("OffHand")
	if swingIk then swingIk:Destroy() swingIk = nil end
	if not humanoid or not chain or not hand or not target then return end
	local ik = Instance.new("IKControl")
	ik.Name = "SwingGrip"
	ik.Type = Enum.IKControlType.Position
	ik.ChainRoot, ik.EndEffector, ik.Target = chain, hand, target
	ik.SmoothTime = 0 -- la main suit le manche sans retard
	ik.Parent = humanoid
	swingIk = ik
end
-- après les animations de Roblox (qui écrivent Motor6D.Transform), on ajoute le geste par-dessus
RunService.Stepped:Connect(function()
	if not swingStart then return end
	local t = os.clock() - swingStart
	local character = player.Character
	if t >= swingKeys[#swingKeys].t or not character then endSwing() return end
	if swingIk then swingIk.Weight = math.clamp(math.min(t / 0.05, (swingKeys[#swingKeys].t - t) / 0.12), 0, 1) end -- la main vient puis lâche
	local p = pose(swingKeys, t)
	local upperArm, lowerArm, hand, upperTorso = character:FindFirstChild("RightUpperArm"), character:FindFirstChild("RightLowerArm"), character:FindFirstChild("RightHand"), character:FindFirstChild("UpperTorso")
	local j1 = upperArm and upperArm:FindFirstChild("RightShoulder")
	local j2 = lowerArm and lowerArm:FindFirstChild("RightElbow")
	local j3 = upperTorso and upperTorso:FindFirstChild("Waist")
	local j4 = hand and hand:FindFirstChild("RightWrist")
	if j1 then j1.Transform = j1.Transform * CFrame.Angles(rad(p.shoulder), 0, rad(p.inward)) end -- le bras se lève / s'abat et vient devant le buste
	if j2 then j2.Transform = j2.Transform * CFrame.Angles(rad(p.elbow), 0, 0) end
	if j3 then j3.Transform = j3.Transform * CFrame.Angles(rad(p.waist), rad(p.twist), 0) end
	if j4 then j4.Transform = j4.Transform * CFrame.Angles(rad(p.wrist), rad(p.roll), 0) end -- roll : garde le marteau dans l'axe quand le bras vient devant le buste
	if not j1 then -- R6 : une seule articulation
		local torso = character:FindFirstChild("Torso")
		local joint = torso and torso:FindFirstChild("Right Shoulder")
		if joint then joint.Transform = joint.Transform * CFrame.Angles(0, 0, rad(-p.wrist * 0.6)) end
	end
end)

-- choc : étincelles sur l'œuf et petite secousse de caméra
local function sparks(position)
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Transparency = true, false, false, false, 1
	part.Size = Vector3.one
	part.CFrame = CFrame.new(position)
	part.Parent = workspace
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 200, 80))
	e.LightEmission = 1
	e.Rate = 0
	e.Lifetime = NumberRange.new(0.25, 0.5)
	e.Speed = NumberRange.new(12, 26)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Drag = 4
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.1), NumberSequenceKeypoint.new(1, 0)})
	e.Parent = part
	e:Emit(20)
	game:GetService("Debris"):AddItem(part, 1)
end

local function impactFx(egg)
	if not egg.Parent then return end
	local center = egg:GetPivot().Position
	local part = Instance.new("Part")
	part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Transparency = true, false, false, false, 1
	part.Size = Vector3.one
	part.CFrame = CFrame.new(center + Vector3.new(0, egg:GetExtentsSize().Y * 0.35, 0))
	part.Parent = workspace
	local e = Instance.new("ParticleEmitter")
	e.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	e.Color = ColorSequence.new(Color3.fromRGB(255, 244, 190), Color3.fromRGB(255, 180, 60))
	e.LightEmission = 1
	e.Rate = 0
	e.Lifetime = NumberRange.new(0.25, 0.5)
	e.Speed = NumberRange.new(10, 22)
	e.SpreadAngle = Vector2.new(180, 180)
	e.Drag = 4
	e.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 0)})
	e.Parent = part
	e:Emit(16)
	game:GetService("Debris"):AddItem(part, 1)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		task.spawn(function()
			local t = 0
			while t < 0.16 do
				t += RunService.RenderStepped:Wait()
				humanoid.CameraOffset = Vector3.new(math.random() - 0.5, math.random() - 0.5, 0) * 0.35 * (1 - t / 0.16)
			end
			humanoid.CameraOffset = Vector3.zero
		end)
	end
end

local lastSwing = 0
local function swing()
	local character = player.Character
	if not character then return end
	if batOut() then -- batte : un coup toutes les 0,75 s sur le joueur devant soi
		if os.clock() - lastSwing < BAT_TIME then return end
		lastSwing = os.clock()
		swingKeys, swingStart = BAT_KEYS, os.clock()
		grabWithLeftHand(character:FindFirstChild("Bat"))
		task.delay(BAT_IMPACT, function() system.BatHit:FireServer() end)
		return
	end
	if not hammerOut() or os.clock() - lastSwing < SWING_TIME then return end
	lastSwing = os.clock()
	swingKeys, swingStart = HAMMER_KEYS, os.clock()
	grabWithLeftHand(character:FindFirstChild("Hammer"))
	local egg = nearestEgg()
	if egg then
		local root = character:FindFirstChild("HumanoidRootPart")
		if root then -- on se tourne vers l'œuf
			local center = egg:GetPivot().Position
			local look = Vector3.new(center.X, root.Position.Y, center.Z)
			if (look - root.Position).Magnitude > 0.5 then root.CFrame = CFrame.lookAt(root.Position, look) end
		end
		task.delay(IMPACT, function()
			hitRemote:FireServer(egg)
			impactFx(egg)
		end)
	end
end

-- coup de batte reçu : c'est ce joueur qui est projeté et tombe un instant ; les étincelles du choc sont pour tout le monde
system:WaitForChild("Knock").OnClientEvent:Connect(function(velocity, position)
	if position then sparks(position) return end
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not root or not humanoid or typeof(velocity) ~= "Vector3" then return end
	humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
	root.AssemblyLinearVelocity = velocity
	task.delay(0.9, function()
		if humanoid.Parent and humanoid.Health > 0 then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
	end)
end)

---------------------------------------------------------------- commandes : clic, appui, bouton HIT
local holding = false
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.F or input.KeyCode == Enum.KeyCode.ButtonR2 then
		holding = true
		swing()
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.F or input.KeyCode == Enum.KeyCode.ButtonR2 then holding = false end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "HammerGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 6
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")
local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local hitButton = new("TextButton", {Name = "Hit", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -150, 1, -150), Size = UDim2.fromOffset(104, 104),
	BackgroundColor3 = Color3.fromRGB(235, 70, 60), Text = "HIT", FontFace = FONT, TextSize = 30, TextColor3 = Color3.new(1, 1, 1), Visible = false}, gui)
new("UICorner", {CornerRadius = UDim.new(0.5, 0)}, hitButton)
new("UIStroke", {Thickness = 4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, hitButton)
new("UIStroke", {Thickness = 3}, hitButton)
local touchHold = false
hitButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then touchHold = true swing() end
end)
hitButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then touchHold = false end
end)
local function refreshHitButton()
	local armed = hammerOut() or batOut()
	hitButton.Visible = armed and UserInputService.TouchEnabled
	if not armed then holding, touchHold = false, false end
end
player:GetAttributeChangedSignal("HammerOut"):Connect(refreshHitButton)
refreshHitButton()

---------------------------------------------------------------- boucle : coups enchaînés, arêtes arc-en-ciel du dernier marteau
while true do
	task.wait(0.05)
	if (holding or touchHold) and (hammerOut() or batOut()) then swing() end
	if hitButton.Visible ~= ((hammerOut() or batOut()) and UserInputService.TouchEnabled) then refreshHitButton() end
	local tool = player.Character and player.Character:FindFirstChild("Hammer")
	if tool then
		local color = Color3.fromHSV((os.clock() * 0.3) % 1, 0.55, 1)
		for _, p in tool:GetChildren() do if p.Name == "Prism" then p.Color = color end end
	end
end
