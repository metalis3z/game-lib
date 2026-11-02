--credit to prince games studio
-- TEMPORAL: diagnóstico del lado servidor. Bórrame cuando todo funcione.
task.delay(15, function()
	local HttpService = game:GetService("HttpService")
	local p = game.Players:GetPlayers()[1]
	if not p then
		warn("[DIAG-S] sin jugador")
		return
	end
	local plotId = p:GetAttribute("PlotId")
	local plot = plotId and workspace.Gardens:FindFirstChild("Plot" .. plotId)
	local ls = p:FindFirstChild("leaderstats")
	warn("[DIAG-S] " .. HttpService:JSONEncode({
		player = p.Name,
		character = p.Character ~= nil,
		plotId = plotId,
		plotAttrs = plot and plot:GetAttributes() or "SIN PLOT",
		isInOwnGarden = p:GetAttribute("IsInOwnGarden"),
		dataLoaded = p:HasTag("DataLoaded"),
		sheckles = ls and ls:FindFirstChild("Sheckles") and ls.Sheckles.Value or "FALTA",
		distSpawn = (p.Character and plot) and math.floor((p.Character:GetPivot().Position - plot.SpawnPoint.Position).Magnitude) or -1,
	}))
end)