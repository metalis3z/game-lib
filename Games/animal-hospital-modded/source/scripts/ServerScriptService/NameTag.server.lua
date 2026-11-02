--[[ NameTag — rotulo sobre la cabeza.

     SOLO lo ven los jugadores de la lista TAGS. Al resto se le OCULTA el nombre
     por completo (no se les clona el BillboardGui y se les apaga el nombre/salud
     por defecto de Roblox con DisplayDistanceType = None).

     Cada entrada define el TEXTO del rotulo de abajo y su ESTILO de color, que
     anima el cliente (StarterPlayerScripts.NameTagColors):
       · "rainbow" -> arcoiris en loop
       · "pink"    -> rosas brillantes en loop (premium); ademas tiñe el nombre
       · nil       -> color fijo (campo `color`)

     La lista va por UserId a proposito: los nicks de Roblox tienen mayusculas
     raras (ClaraSigm1 con S mayuscula) y `TAGS[player.Name]` fallaba en silencio.

     Template: script.NameTag (BillboardGui con UpperText / LowerText). ]]
local Players = game:GetService("Players")
local template = script:WaitForChild("NameTag")
local cmdr = require(game.ReplicatedStorage:WaitForChild("Configs"):WaitForChild("Cmdr"))

-- Jugadores con nombre visible sobre la cabeza. El resto: sin nada.
local TAGS = {
	[cmdr.Admins[1]] = { text = "Admin",   style = "rainbow" },
	[cmdr.Admins[2]] = { text = "Admin",   style = "rainbow" },       
	[cmdr.Admins[3]] = { text = "Admin",   style = "rainbow" },       
}

-- Apaga el nombre/salud por defecto de Roblox sobre la cabeza.
local function hideDefaultDisplay(char)
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		hum.NameDisplayDistance = 0
		hum.HealthDisplayDistance = 0
	end
end

local function applyTag(player)
	local char = player.Character
	if not char then return end

	-- Todos, tambien los que tienen tag: fuera el nombre por defecto de Roblox.
	hideDefaultDisplay(char)

	local head = char:FindFirstChild("Head")
	local existing = head and head:FindFirstChild("NameTag")
	local cfg = TAGS[player.UserId]

	if not cfg then
		if existing then existing:Destroy() end
		return
	end

	if not head then return end
	-- Ya lo tiene: no reconstruir (reiniciaria la animacion de color).
	if existing then return end

	local tag = template:Clone()
	tag:WaitForChild("UpperText").Text = player.Name

	local lower = tag:WaitForChild("LowerText")
	lower.Text = cfg.text
	lower.TextColor3 = cfg.color or Color3.fromRGB(255, 255, 255)
	lower.Visible = true
	-- Lo lee el cliente (NameTagColors) para animar el color.
	lower:SetAttribute("Style", cfg.style)

	tag.Adornee = head
	tag.Parent = head
end

local function hookPlayer(player)
	player.CharacterAdded:Connect(function(char)
		applyTag(player)
		-- El morph reemplaza el personaje (y sus partes) un rato despues, y el
		-- Humanoid del rig puede traer su propio DisplayDistanceType -> se
		-- re-aplica un par de veces para que nunca reaparezca un nombre.
		task.spawn(function()
			for _ = 1, 6 do
				task.wait(1)
				if player.Character == char then
					applyTag(player)
				else
					break
				end
			end
		end)
	end)
	if player.Character then applyTag(player) end
end

Players.PlayerAdded:Connect(hookPlayer)
for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end