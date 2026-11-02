--[[ NameTagColors — anima el color de TODOS los rotulos de cabeza.

     Antes esto lo hacia un LocalScript dentro del propio template
     (NameTag.LowerText.RainbowOwner). Problema: un LocalScript solo corre dentro
     del personaje del jugador LOCAL, asi que el arcoiris/rosa solo se veia uno
     mismo; los demas veian el texto con el color fijo que dejo el servidor.

     Este script vive en StarterPlayerScripts y busca cualquier BillboardGui
     llamado "NameTag" que aparezca en Workspace, lee el atributo "Style" del
     LowerText (lo pone ServerScriptService.NameTag) y lo anima:
       · "rainbow" -> arcoiris en loop
       · "pink"    -> premium: pulsa entre rosa claro y magenta, y tiñe el nombre
       · otro/nil  -> se ignora (color fijo). ]]

local RunService = game:GetService("RunService")

local STYLE_WAIT = 3        -- s de gracia por si el atributo replica tarde
local HUE_MIN, HUE_MAX = 0.83, 0.97
local SAT_MIN, SAT_MAX = 0.45, 1

local active = {}           -- [BillboardGui] = { label, upper, style }

local function register(gui)
	if not gui:IsA("BillboardGui") or gui.Name ~= "NameTag" then return end
	if active[gui] then return end

	local label = gui:WaitForChild("LowerText", STYLE_WAIT)
	if not label then return end

	local style = label:GetAttribute("Style")
	if style == nil then
		-- El atributo puede llegar un instante despues que el Gui.
		local t = 0
		while style == nil and t < STYLE_WAIT and gui.Parent do
			t += task.wait(0.1)
			style = label:GetAttribute("Style")
		end
	end
	if style ~= "rainbow" and style ~= "pink" then return end

	active[gui] = {
		label = label,
		upper = gui:FindFirstChild("UpperText"),
		style = style,
	}
end

for _, d in ipairs(workspace:GetDescendants()) do
	task.spawn(register, d)
end
workspace.DescendantAdded:Connect(function(d)
	task.spawn(register, d)
end)

local t = 0
RunService.Heartbeat:Connect(function(dt)
	t += dt

	for gui, entry in pairs(active) do
		if not gui.Parent or not entry.label.Parent then
			active[gui] = nil
		elseif entry.style == "rainbow" then
			entry.label.TextColor3 = Color3.fromHSV((t * 0.33) % 1, 1, 1)
		else
			local phase = t * 1.5
			local wave = (math.sin(phase) + 1) / 2
			local pulse = (math.sin(phase * 1.7) + 1) / 2
			local color = Color3.fromHSV(
				HUE_MIN + (HUE_MAX - HUE_MIN) * wave,
				SAT_MIN + (SAT_MAX - SAT_MIN) * pulse,
				1
			)
			entry.label.TextColor3 = color
			if entry.upper then
				entry.upper.TextColor3 = color
			end
		end
	end
end)