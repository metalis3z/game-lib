-- Animation d'ouverture de toutes les fenêtres du jeu : la même que Settings (SettingsHandler). La fenêtre apparaît à 80 % de
-- sa taille et grossit jusqu'à sa taille normale en 0,18 s, avec un petit rebond (Back).
-- Une fenêtre = un cadre nommé Main, Window ou Panel, posé dans un ScreenGui (ou dans son premier cadre, comme la fenêtre
-- « Welcome back » dans son voile), d'au moins 320 x 220 (mêmes règles que UIEffects / UIPolish).
-- On anime l'UIScale que la fenêtre a déjà (mise à l'échelle de l'écran) : sa valeur normale est gardée et toujours
-- rendue à la fin. Pas de doublon : Settings a déjà cette animation, le panneau du jardin glisse depuis le bord.
-- Attribut NoOpenFx sur un cadre : pas d'animation pour lui.
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local START = 0.8 -- taille de départ (80 %), comme Settings
local INFO = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local WINDOW_NAMES = {Main = true, Window = true, Panel = true}
local SKIP_GUIS = {SettingsGui = true, GardenPanelGui = true}

local watched = setmetatable({}, {__mode = "k"})

local function plannedSize(frame)
	local parent = frame.Parent
	local around = parent:IsA("GuiObject") and parent.AbsoluteSize or workspace.CurrentCamera.ViewportSize
	local size = frame.Size
	return math.max(frame.AbsoluteSize.X, size.X.Scale * around.X + size.X.Offset), math.max(frame.AbsoluteSize.Y, size.Y.Scale * around.Y + size.Y.Offset)
end

-- l'UIScale de la fenêtre (celui de la mise à l'échelle) ; sinon on en pose un, neutre
local function scaleOf(frame)
	local scale = frame:FindFirstChildOfClass("UIScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "OpenFx"
		scale.Parent = frame
	end
	return scale
end

local function watch(frame)
	if watched[frame] or not WINDOW_NAMES[frame.Name] or frame:GetAttribute("NoOpenFx") then return end
	if not (frame:IsA("Frame") or frame:IsA("ImageLabel") or frame:IsA("CanvasGroup")) then return end
	local layer = frame:FindFirstAncestorWhichIsA("ScreenGui")
	local parent = frame.Parent
	if not layer or not parent or SKIP_GUIS[layer.Name] then return end
	if parent ~= layer and parent.Parent ~= layer then return end
	watched[frame] = true

	local tween, normal -- normal = la vraie taille (Scale) de la fenêtre, pendant qu'on l'anime
	local function play()
		if not frame.Visible or not layer.Enabled then return end
		if parent ~= layer and not parent.Visible then return end
		local x, y = plannedSize(frame)
		if x < 320 or y < 220 then return end
		local scale = scaleOf(frame)
		if tween then tween:Cancel() end
		normal = normal or scale.Scale
		scale.Scale = normal * START
		tween = TweenService:Create(scale, INFO, {Scale = normal})
		local mine = tween
		mine.Completed:Connect(function(state)
			-- (une animation coupée par une réouverture rapide garde la vraie taille en mémoire)
			if state == Enum.PlaybackState.Completed and tween == mine then tween, normal = nil, nil end
		end)
		mine:Play()
	end
	local function shown(prop)
		return function()
			if prop.Visible then task.defer(play) end -- après le script qui ouvre la fenêtre (il peut encore la remplir)
		end
	end
	frame:GetPropertyChangedSignal("Visible"):Connect(shown(frame))
	-- fenêtre dans un voile (Welcome back) : c'est le voile qu'on affiche
	if parent ~= layer then parent:GetPropertyChangedSignal("Visible"):Connect(shown(parent)) end
end

for _, d in playerGui:GetDescendants() do watch(d) end
playerGui.DescendantAdded:Connect(function(d)
	task.defer(watch, d)
end)
