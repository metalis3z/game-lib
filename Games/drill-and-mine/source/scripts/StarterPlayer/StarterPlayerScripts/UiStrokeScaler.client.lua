task.wait(1)

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local function scalestroke(stroke)
	-- Originaldicke einmalig als Attribut speichern — verhindert doppeltes Skalieren
	local base = stroke:GetAttribute("__BaseThickness")
	if not base then
		base = stroke.Thickness
		stroke:SetAttribute("__BaseThickness", base)
	end
	local scaleFactor = camera.ViewportSize.X / 1920
	stroke.Thickness = base * scaleFactor
end

local function autoscalestroke()
	for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
		if gui:IsA("UIStroke") then
			scalestroke(gui)
		end
	end
end

-- Neu hinzugefügte Strokes skalieren
player.PlayerGui.DescendantAdded:Connect(function(d)
	if d:IsA("UIStroke") then
		task.defer(scalestroke, d)
	end
end)

-- Bei Fenstergröße-Änderung neu skalieren (z.B. Fullscreen toggle)
camera:GetPropertyChangedSignal("ViewportSize"):Connect(autoscalestroke)

autoscalestroke()
