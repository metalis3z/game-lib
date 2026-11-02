-- Relief des boutons de tout le jeu. Un bouton « maison » (fond en dégradé + contour noir) reçoit ici :
--   * un bord inférieur : une bande de sa couleur, plus sombre, sous son contour, elle aussi cernée de noir (le bouton a l'air épais)
--   * un filet clair à l'intérieur, qui fait ressortir sa couleur
-- Rien n'est ajouté aux boutons qui ont déjà leur relief (enfant "Lip"), ni à ceux marqués de l'attribut NoPolish ou NoFx.
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local BLACK, WHITE = Color3.new(0, 0, 0), Color3.new(1, 1, 1)
local DEPTH = 4          -- hauteur de la bande, en pixels
local DARKEN = 0.42      -- part de noir dans la bande
local done = setmetatable({}, {__mode = "k"})

local function borderStroke(button)
	for _, c in button:GetChildren() do
		if c:IsA("UIStroke") and c.Enabled and (c.ApplyStrokeMode == Enum.ApplyStrokeMode.Border or c.Name == "Outline") then return c end
	end
end

local function setup(button)
	if done[button] or not button:IsA("GuiButton") then return end
	if button:GetAttribute("NoPolish") or button:GetAttribute("NoFx") or button:FindFirstChild("Lip") then return end
	if button.BackgroundTransparency > 0.5 then return end
	local gradient = button:FindFirstChildOfClass("UIGradient")
	local stroke = borderStroke(button)
	if not gradient or not stroke then return end
	done[button] = true
	local thickness = math.max(2, math.floor(stroke.Thickness + 0.5))

	if not button:FindFirstChild("Lip3D") then
		local lip = Instance.new("Frame")
		lip.Name = "Lip3D"
		lip.BorderSizePixel = 0
		lip.Position = UDim2.new(0, 0, 1, thickness) -- juste sous le contour du bouton
		lip.Size = UDim2.new(1, 0, 0, DEPTH)
		lip.ZIndex = button.ZIndex
		local edge = Instance.new("UIStroke")
		edge.Thickness = thickness
		edge.Color = BLACK
		edge.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		edge.Parent = lip
		local function tint()
			local keys = gradient.Color.Keypoints
			local bottom = keys[#keys].Value
			local base = button.BackgroundColor3
			lip.BackgroundColor3 = Color3.new(bottom.R * base.R, bottom.G * base.G, bottom.B * base.B):Lerp(BLACK, DARKEN)
		end
		gradient:GetPropertyChangedSignal("Color"):Connect(tint)
		button:GetPropertyChangedSignal("BackgroundColor3"):Connect(tint)
		tint()
		lip.Parent = button
	end

	if not (button:FindFirstChild("Inner3D") or button:FindFirstChild("Inner") or button:FindFirstChild("FxStitch")) and button.AbsoluteSize.Y >= 30 then
		local inner = Instance.new("Frame")
		inner.Name = "Inner3D"
		inner.BackgroundTransparency = 1
		inner.Position = UDim2.fromOffset(thickness, thickness)
		inner.Size = UDim2.new(1, -2 * thickness, 1, -2 * thickness)
		inner.ZIndex = button.ZIndex
		local line = Instance.new("UIStroke")
		line.Thickness = 2
		line.Color = WHITE
		line.Transparency = 0.58
		line.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		line.Parent = inner
		inner.Parent = button
	end
end

local function check(instance)
	if instance:IsA("GuiButton") then
		task.defer(setup, instance)
	elseif (instance:IsA("UIGradient") or instance:IsA("UIStroke")) and instance.Parent and instance.Parent:IsA("GuiButton") then
		task.defer(setup, instance.Parent) -- le dégradé ou le contour est arrivé après le bouton
	end
end
for _, d in playerGui:GetDescendants() do check(d) end
playerGui.DescendantAdded:Connect(check)
