-- Content Creator Panel — effects seen by EVERY player (the panel itself is CreatorPanelClient, for creators only).
--   * my character ragdolled by the server (attribute CreatorRagdoll) : my humanoid goes into Physics, then gets up again ;
--   * my character frozen (CreatorFrozen) : my animations pause ;
--   * notices ("You got ragdolled!") and the jumpscare (only for the target) ;
--   * animations of the visible effects : disco colors, disco ball spin, jail glow, countdown labels.
-- Nothing here touches the camera permanently, saved data or other players.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local folder = ReplicatedStorage:WaitForChild("CreatorPanel")
local event = folder:WaitForChild("Event")
local rgb = Color3.fromRGB
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local FONT = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in props do o[k] = v end
	o.Parent = parent
	return o
end
local function tween(o, t, props, style, dir)
	local tw = TweenService:Create(o, TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local gui = new("ScreenGui", {Name = "CreatorEffectsGui", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 900}, player:WaitForChild("PlayerGui"))

---------------------------------------------------------------- my character : ragdoll / freeze
local function watchCharacter(character)
	local humanoid = character:WaitForChild("Humanoid", 10)
	if not humanoid then return end
	local ragdolled = false
	local frozenTracks = {}
	local function setRagdoll(on)
		if on == ragdolled then return end
		ragdolled = on
		if on then
			humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
			local root = character:FindFirstChild("HumanoidRootPart")
			if root and not root.Anchored then -- a little push so the body really falls over
				root.AssemblyAngularVelocity = Vector3.new(math.random(-6, 6), 0, math.random(-6, 6))
				root.AssemblyLinearVelocity += root.CFrame.LookVector * -6 + Vector3.new(0, 4, 0)
			end
		else
			humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
			if humanoid.Health > 0 then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
		end
	end
	local function setFrozen(on)
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if on then
			for _, track in animator and animator:GetPlayingAnimationTracks() or {} do
				frozenTracks[track] = track.Speed
				track:AdjustSpeed(0)
			end
		else
			for track, speed in frozenTracks do if track.IsPlaying then track:AdjustSpeed(speed) end end
			table.clear(frozenTracks)
		end
	end
	character:GetAttributeChangedSignal("CreatorRagdoll"):Connect(function() setRagdoll(character:GetAttribute("CreatorRagdoll") == true) end)
	character:GetAttributeChangedSignal("CreatorFrozen"):Connect(function() setFrozen(character:GetAttribute("CreatorFrozen") == true) end)
	-- while ragdolled, another script may try to change the state : stay in Physics (and always get up once it's over)
	local connection
	connection = RunService.Heartbeat:Connect(function()
		if not character.Parent then connection:Disconnect() return end
		if ragdolled and humanoid:GetState() ~= Enum.HumanoidStateType.Physics and humanoid.Health > 0 then
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		end
	end)
	setRagdoll(character:GetAttribute("CreatorRagdoll") == true)
end
player.CharacterAdded:Connect(watchCharacter)
if player.Character then task.spawn(watchCharacter, player.Character) end

---------------------------------------------------------------- notices (top of the screen)
local stack = new("Frame", {Name = "Notices", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 120),
	Size = UDim2.fromOffset(560, 300)}, gui)
new("UIListLayout", {Padding = UDim.new(0, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}, stack)
local order = 0
local function notice(text, kind)
	order += 1
	local colors = kind == "troll" and {rgb(190, 110, 255), rgb(90, 40, 200)} or {rgb(90, 200, 255), rgb(40, 90, 210)}
	local card = new("CanvasGroup", {BackgroundColor3 = WHITE, Size = UDim2.fromOffset(520, 52), LayoutOrder = order, GroupTransparency = 1}, stack)
	new("UICorner", {CornerRadius = UDim.new(0, 14)}, card)
	new("UIGradient", {Rotation = 0, Color = ColorSequence.new(colors[1], colors[2])}, card)
	new("UIStroke", {Thickness = 2.5, Color = BLACK, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, card)
	local label = new("TextLabel", {BackgroundTransparency = 1, Position = UDim2.fromOffset(14, 6), Size = UDim2.new(1, -28, 1, -12), Text = text, FontFace = FONT,
		TextScaled = true, TextColor3 = WHITE}, card)
	new("UIStroke", {Thickness = 2, Color = BLACK}, label)
	local scale = new("UIScale", {Scale = 0.7}, card)
	tween(card, 0.25, {GroupTransparency = 0})
	tween(scale, 0.35, {Scale = 1}, Enum.EasingStyle.Back)
	task.delay(3.2, function()
		tween(card, 0.35, {GroupTransparency = 1})
		task.wait(0.4)
		card:Destroy()
	end)
end

---------------------------------------------------------------- jumpscare (only the target sees it)
local scaring = false
local function jumpscare()
	if scaring then return end
	scaring = true
	local holder = new("Frame", {Name = "Jumpscare", BackgroundColor3 = rgb(20, 0, 6), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 50}, gui)
	-- dark red vignette (no flashing)
	local vignette = new("ImageLabel", {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Image = "rbxassetid://4509687978", ImageColor3 = rgb(120, 0, 10),
		ImageTransparency = 1, ScaleType = Enum.ScaleType.Stretch, ZIndex = 51}, holder)
	local view = new("ViewportFrame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.2, 0.2),
		Ambient = rgb(160, 120, 110), LightColor = rgb(255, 200, 150), LightDirection = Vector3.new(0, -1, -0.6), ZIndex = 52}, holder)
	new("UIAspectRatioConstraint", {AspectRatio = 1}, view)
	local template = folder:FindFirstChild("JumpscareModel")
	if template then
		local model = template:Clone()
		model:PivotTo(CFrame.new())
		model.Parent = view
		local cf, size = model:GetBoundingBox()
		local cam = new("Camera", {FieldOfView = 40}, view)
		-- close on the face : the camera looks at the top of the model, from the front (+Z side)
		local face = cf.Position + Vector3.new(0, size.Y * 0.08, 0)
		cam.CFrame = CFrame.lookAt(face + Vector3.new(0, size.Y * 0.05, size.Z * 0.5 + size.Y * 0.7), face)
		view.CurrentCamera = cam
	end
	local boo = new("TextLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.86), Size = UDim2.fromScale(0.5, 0.14),
		Text = "BOO!", FontFace = FONT, TextScaled = true, TextColor3 = rgb(255, 150, 40), TextTransparency = 1, ZIndex = 53}, holder)
	local booStroke = new("UIStroke", {Thickness = 4, Color = BLACK, Transparency = 1}, boo)
	local roar = new("Sound", {SoundId = "rbxassetid://9125467833", Volume = 1.6, PlaybackSpeed = 0.8}, SoundService)
	roar:Play()
	tween(holder, 0.12, {BackgroundTransparency = 0.35})
	tween(vignette, 0.15, {ImageTransparency = 0.15})
	tween(view, 0.22, {Size = UDim2.fromScale(1.15, 1.15)}, Enum.EasingStyle.Back)
	tween(boo, 0.2, {TextTransparency = 0})
	tween(booStroke, 0.2, {Transparency = 0})
	-- small shake (position only, no flashing) for 1.1 s
	local t0 = os.clock()
	local shake = RunService.RenderStepped:Connect(function()
		local k = math.max(0, 1 - (os.clock() - t0) / 1.1)
		view.Position = UDim2.new(0.5, math.random(-14, 14) * k, 0.55, math.random(-10, 10) * k)
	end)
	task.wait(1.4)
	shake:Disconnect()
	tween(holder, 0.4, {BackgroundTransparency = 1})
	tween(vignette, 0.4, {ImageTransparency = 1})
	tween(view, 0.4, {Size = UDim2.fromScale(0.05, 0.05)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	tween(boo, 0.3, {TextTransparency = 1})
	tween(booStroke, 0.3, {Transparency = 1})
	task.wait(0.45)
	holder:Destroy()
	task.delay(2, function() roar:Destroy() end)
	scaring = false
end

event.OnClientEvent:Connect(function(kind, a, b)
	if kind == "Notice" then notice(tostring(a), b)
	elseif kind == "Jumpscare" then task.spawn(jumpscare) end
end)
-- also used by the panel for its own success / error messages
_G.CreatorNotice = notice

---------------------------------------------------------------- animations of the visible effects (all clients)
local RAINBOW = {rgb(255, 90, 90), rgb(255, 200, 60), rgb(90, 240, 130), rgb(80, 180, 255), rgb(200, 110, 255), rgb(255, 120, 230)}
local function rainbow(t)
	local n = #RAINBOW
	local x = (t % n)
	local i = math.floor(x)
	return RAINBOW[i + 1]:Lerp(RAINBOW[(i + 1) % n + 1], x - i)
end
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	for _, h in CollectionService:GetTagged("CreatorDisco") do
		if h:IsA("Highlight") then h.FillColor = rainbow(t * 3) h.OutlineColor = rainbow(t * 3 + 2) end
	end
	for _, w in CollectionService:GetTagged("CreatorDiscoBall") do
		if w:IsA("Weld") then
			w.C0 = CFrame.new(0, 3.2 + math.sin(t * 4) * 0.25, 0) * CFrame.Angles(0, t * 3, 0)
			local ball = w.Part1
			local light = ball and ball:FindFirstChild("DiscoLight")
			if light then light.Color = rainbow(t * 4) end
		end
	end
	for _, sign in CollectionService:GetTagged("CreatorDiscoSign") do
		local label = sign:FindFirstChild("Label")
		local g = label and label:FindFirstChildOfClass("UIGradient")
		if g then g.Offset = Vector2.new(math.sin(t * 2) * 0.5, 0) end
		if label then label.Rotation = math.sin(t * 6) * 6 end
	end
	for _, cage in CollectionService:GetTagged("CreatorJail") do
		local k = 0.15 + 0.25 * (math.sin(t * 5) * 0.5 + 0.5)
		for _, p in cage:GetChildren() do
			if p:IsA("BasePart") and (p.Name == "PostGlow" or p.Name == "FloorGlow" or p.Name == "RoofGlow") then p.Transparency = k end
		end
	end
end)
-- countdown labels above frozen / jailed players (attribute Ends = server time)
local function countdown(tag)
	if tag:FindFirstChild("Text") then return end
	local label = new("TextLabel", {Name = "Text", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), FontFace = FONT, TextScaled = true, TextColor3 = WHITE}, tag)
	new("UIStroke", {Thickness = 3, Color = BLACK}, label)
	task.spawn(function()
		while tag.Parent do
			local left = math.max(0, (tag:GetAttribute("Ends") or 0) - workspace:GetServerTimeNow())
			label.Text = (tag:GetAttribute("Label") or "") .. "  " .. math.ceil(left)
			label.TextColor3 = left <= 2 and rgb(255, 230, 120) or WHITE
			task.wait(0.1)
		end
	end)
end
CollectionService:GetInstanceAddedSignal("CreatorCountdown"):Connect(countdown)
for _, tag in CollectionService:GetTagged("CreatorCountdown") do countdown(tag) end
