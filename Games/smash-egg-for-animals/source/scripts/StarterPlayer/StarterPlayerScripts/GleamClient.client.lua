-- GleamClient : le reflet ("Gleam") qui traverse les boutons et les fenêtres, pour TOUT le jeu.
--   * chaque calque nommé "Gleam" (créé par le shop, le panneau admin, le sondage...) est piloté d'ici, à chaque image :
--     la bande de lumière traverse le bouton en 2 s, à vitesse régulière, puis 3 s de pause, et ça recommence
--   * la bande est large et douce : un cœur blanc lumineux entouré d'un halo qui s'estompe, plus un petit trait fin juste derrière
--   * un reflet est ajouté sur tous les boutons des menus (sauf l'inventaire et les réglages)
--   * de gauche à droite, les boutons partent avec un léger décalage : une vague de lumière balaie l'écran
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local SWEEP, PAUSE = 2, 3
local CYCLE = SWEEP + PAUSE
local EXCLUDED = {PetInventoryGui = true, SettingsGui = true, InventoryButtonGui = true, TopBarGui = true, Freecam = true}
local BAND = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 1),
	NumberSequenceKeypoint.new(0.4, 0.8), NumberSequenceKeypoint.new(0.47, 0.48), NumberSequenceKeypoint.new(0.5, 0.25),
	NumberSequenceKeypoint.new(0.53, 0.48), NumberSequenceKeypoint.new(0.58, 0.82), NumberSequenceKeypoint.new(0.6, 1),
	NumberSequenceKeypoint.new(0.63, 0.55), NumberSequenceKeypoint.new(0.645, 1), -- le petit trait fin derrière
	NumberSequenceKeypoint.new(1, 1)})

local gleams = {} -- [UIGradient] = layer
local function track(layer)
	local g = layer:FindFirstChildOfClass("UIGradient")
	if not g or gleams[g] then return end
	g.Transparency = BAND
	g.Rotation = 18
	gleams[g] = layer
end
local function addTo(button)
	local screen = button:FindFirstAncestorWhichIsA("ScreenGui")
	if not screen or EXCLUDED[screen.Name] or button.AbsoluteSize.X < 30 then return end
	-- la surface colorée : le bouton, ou sa face s'il est transparent (Index, Shop, Auto Swing...)
	local surface = button
	if button.BackgroundTransparency > 0.5 then
		surface = button:FindFirstChild("Face")
		if not surface or not surface:IsA("GuiObject") or surface.BackgroundTransparency > 0.5 then return end
	end
	if surface:FindFirstChild("Gleam") then return end
	local layer = Instance.new("Frame")
	layer.Name = "Gleam"
	layer.BackgroundColor3 = Color3.new(1, 1, 1)
	layer.BorderSizePixel = 0
	layer.Size = UDim2.fromScale(1, 1)
	layer.ZIndex = surface.ZIndex + 1
	layer.Active = false
	layer.Interactable = false
	local corner = surface:FindFirstChildOfClass("UICorner")
	if corner then corner:Clone().Parent = layer end
	local g = Instance.new("UIGradient")
	g.Offset = Vector2.new(-1.3, 0)
	g.Parent = layer
	layer.Parent = surface
end
local function check(d)
	if d.Name == "Gleam" and d:IsA("GuiObject") then
		task.defer(track, d)
	elseif d:IsA("GuiButton") then
		task.delay(0.3, function() if d.Parent then addTo(d) end end)
	end
end
for _, d in playerGui:GetDescendants() do check(d) end
playerGui.DescendantAdded:Connect(check)
task.delay(6, function() for _, d in playerGui:GetDescendants() do if d:IsA("GuiButton") then addTo(d) end end end)

local function ease(u) return u * u * (3 - 2 * u) end
-- (après les autres scripts : c'est ce moteur qui décide de la position du reflet)
RunService:BindToRenderStep("GleamClient", Enum.RenderPriority.Last.Value + 5, function()
	local t = os.clock()
	for g, layer in gleams do
		if not layer.Parent then
			gleams[g] = nil
		elseif layer.AbsoluteSize.X > 0 then
			local delay = (layer.AbsolutePosition.X / 1920) * 0.6 -- la vague de gauche à droite
			local k = (t - delay) % CYCLE
			-- (vitesse régulière, et seulement sur la partie où la bande est visible : elle met bien 2 s à traverser)
			local x = k < SWEEP and (-0.8 + (k / SWEEP) * 1.6) or 1.3
			g.Offset = Vector2.new(x, 0)
		end
	end
end)
