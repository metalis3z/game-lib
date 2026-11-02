-- CowboyEventClient : HUD en bas a droite pendant l'event COWBOY
-- Image du cow-boy (le vrai modele en studs, dans un ViewportFrame) + nom de l'event + timer jusqu'a la fin.
-- Pilote par l'attribut CowboyEventEnd de ReplicatedStorage (pose par CowboyEventServer).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local GOLD = Color3.fromRGB(255, 205, 60)

local hud = Instance.new("Frame")
hud.Name = "CowboyHud"
hud.BackgroundTransparency = 1
hud.Size = UDim2.fromOffset(170, 54)
hud.Visible = false
hud:GetPropertyChangedSignal("Visible"):Connect(function() -- le dernier event arrive se place au-dessus des autres
	if hud.Visible then hud.LayoutOrder = -math.floor(os.clock() * 10) end
end)

-- image du cow-boy : son buste en studs, vu de face
local view = Instance.new("ViewportFrame")
view.Name = "CowboyIcon"
view.BackgroundTransparency = 1
view.Size = UDim2.fromOffset(54, 54)
view.Ambient = Color3.fromRGB(200, 190, 180)
view.LightColor = Color3.fromRGB(255, 245, 230)
view.LightDirection = Vector3.new(-0.3, -0.5, 1)
view.Parent = hud
task.spawn(function()
	local template = ReplicatedStorage:WaitForChild("CowboyIcon", 30)
	if not template then return end
	local model = template:Clone()
	model:PivotTo(CFrame.new())
	model.Parent = view
	-- revolver leve a cote du visage, pour qu'on le voie sur l'image
	local arm, torso = model:FindFirstChild("RightArm"), model:FindFirstChild("Torso")
	if arm and torso then
		local pivot = torso.CFrame * CFrame.new(1.5, 0.8, 0)
		local rotate = pivot * CFrame.Angles(math.rad(150), 0, math.rad(-12)) * pivot:Inverse()
		for _, d in model:GetDescendants() do
			if d:IsA("BasePart") and (d == arm or d.Name == "RightHand" or d:IsDescendantOf(model:FindFirstChild("Revolver") or arm)) then
				d.CFrame = rotate * d.CFrame
			end
		end
	end
	local cam = Instance.new("Camera")
	cam.FieldOfView = 40
	cam.CFrame = CFrame.lookAt(Vector3.new(-2.2, 5.2, -9.5), Vector3.new(0, 4.4, 0))
	cam.Parent = view
	view.CurrentCamera = cam
end)

local function label(text, pos, size, color, thickness)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Position, l.Size = pos, size
	l.FontFace = FONT
	l.Text = text
	l.TextScaled = true
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextColor3 = color
	local s = Instance.new("UIStroke")
	s.Thickness = thickness
	s.Color = Color3.new(0, 0, 0)
	s.Parent = l
	l.Parent = hud
	return l
end
label("COWBOY TIME", UDim2.fromOffset(58, 5), UDim2.new(1, -58, 0, 15), GOLD, 2)
local timer = label("00:00", UDim2.fromOffset(58, 20), UDim2.new(1, -58, 0, 30), Color3.new(1, 1, 1), 3)

task.spawn(function()
	hud.Parent = playerGui:WaitForChild("EventStackGui"):WaitForChild("Stack")
end)

-- l'image se balance doucement
RunService.RenderStepped:Connect(function()
	if hud.Visible then view.Rotation = math.sin(os.clock() * 2.2) * 6 end
end)

local function clock(seconds)
	seconds = math.max(0, math.ceil(seconds))
	local h, m, s = seconds // 3600, seconds % 3600 // 60, seconds % 60
	return h > 0 and string.format("%d:%02d:%02d", h, m, s) or string.format("%02d:%02d", m, s)
end

while true do
	local endAt = ReplicatedStorage:GetAttribute("CowboyEventEnd")
	local left = type(endAt) == "number" and endAt - workspace:GetServerTimeNow() or 0
	if left > 0 then
		timer.Text = clock(left)
		hud.Visible = true
	else
		hud.Visible = false
	end
	task.wait(0.2)
end
