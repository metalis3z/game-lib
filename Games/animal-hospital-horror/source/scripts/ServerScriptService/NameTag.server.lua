--[[ NameTag — pone un nametag SOLO a quienes tienen acceso admin:
       · Owner  (compro BeOwner / rango HD Admin 5)        -> "Owner"
       · Admin  (compro AdminPanel o HD Admin, rango >= 3) -> "Admin"
     El resto de jugadores NO lleva nametag.
     Template: script.NameTag (BillboardGui con UpperText / LowerText). ]]
local Players = game:GetService("Players")
local template = script:WaitForChild("NameTag")

local TIERS = {
	Owner = { text = "Owner", color = Color3.fromRGB(255, 170, 0) },
	Admin = { text = "Admin", color = Color3.fromRGB(0, 170, 255) },
}

-- Devuelve "Owner", "Admin" o nil segun lo que tenga el jugador.
local function getTier(player)
	local main = _G.HDAdminMain
	local rank = 0
	if main and main.pd and main.pd[player] then
		rank = main.pd[player].Rank or 0
	end
	if player:GetAttribute("IsOwner") or rank >= 5 then
		return "Owner"
	elseif player:GetAttribute("OwnsHDAdmin") or player:GetAttribute("OwnsAdminPanel") or rank >= 3 then
		return "Admin"
	end
	return nil
end

local function applyTag(player)
	local char = player.Character
	local head = char and char:FindFirstChild("Head")
	if not head then return end

	local old = head:FindFirstChild("NameTag")
	if old then old:Destroy() end

	local tier = getTier(player)
	if not tier then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end

	local tag = template:Clone()
	tag:WaitForChild("UpperText").Text = player.Name
	local lower = tag:WaitForChild("LowerText")
	lower.Text = TIERS[tier].text
	lower.TextColor3 = TIERS[tier].color
	tag.Adornee = head
	tag.Parent = head
end

local function hookPlayer(player)
	-- Re-aplicar al comprar en vivo (los grants setean estos atributos).
	for _, attr in ipairs({ "OwnsAdminPanel", "OwnsHDAdmin", "IsOwner" }) do
		player:GetAttributeChangedSignal(attr):Connect(function()
			applyTag(player)
		end)
	end
	player.CharacterAdded:Connect(function()
		-- El rango de HD Admin puede tardar unos segundos en cargar; reintentar.
		task.spawn(function()
			for _ = 1, 30 do
				applyTag(player)
				if getTier(player) then break end
				task.wait(0.5)
			end
		end)
	end)
	if player.Character then applyTag(player) end
end

Players.PlayerAdded:Connect(hookPlayer)
for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end
