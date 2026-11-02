--[[ MonetizationBuys — 4 DevProducts: AdminPanel, BuyNPC, sword, boombox.
     Registra los grants en GunService (dueño único del ProcessReceipt) y conecta
     cada ProximityPrompt (Monetization.<prop>.Part.Attachment.ProximityPrompt)
     para lanzar la compra. El giro 360° de cada prop lo hace MonetizationSpins. ]]
-- Product purchase grants and prompts
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MarketplaceService = game:GetService("MarketplaceService")

local Prods = require(ReplicatedStorage.Data.Prods)
local GunService = require(ServerScriptService:WaitForChild("GunService"))
local DataService = require(ServerScriptService:WaitForChild("DataService"))

local Monetization = workspace:WaitForChild("Monetization")

-- El ProximityPrompt de un prop (bajo su Part > Attachment).
local function promptOf(propName)
	local prop = Monetization:FindFirstChild(propName)
	return prop and prop:FindFirstChildWhichIsA("ProximityPrompt", true)
end

-- Conecta el prompt de un prop para lanzar la compra del DevProduct.
-- alreadyOwns(player) -> true bloquea la compra (para productos de 1 sola vez).
local function wirePrompt(propName, productId, actionText, alreadyOwns)
	local pp = promptOf(propName)
	if not pp then
		warn("[MonetizationBuys] sin ProximityPrompt en " .. propName)
		return
	end
	pp.RequiresLineOfSight = false
	if actionText then pp.ActionText = actionText end
	pp.Triggered:Connect(function(player)
		if alreadyOwns and alreadyOwns(player) then
			return -- ya lo compró: no volver a ofrecer la compra
		end
		MarketplaceService:PromptProductPurchase(player, productId)
	end)
end

-- Entrega un Tool de ReplicatedStorage.Items al Backpack (y StarterGear -> respawn).
local function giveTool(player, toolName)
	local template = ReplicatedStorage:WaitForChild("Items"):FindFirstChild(toolName)
	if not template then return false end
	local function has(c) return c and c:FindFirstChild(template.Name) ~= nil end
	local backpack = player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack", 10)
	if backpack and not has(backpack) and not has(player.Character) then
		template:Clone().Parent = backpack
	end
	local sg = player:FindFirstChildOfClass("StarterGear")
	if sg and not has(sg) then template:Clone().Parent = sg end
	return true
end

--------------------------------------------------------------------------------
-- Grants (se conceden vía ProcessReceipt, dueño = GunService)
--------------------------------------------------------------------------------
-- AdminPanel: acceso al panel (atributo + persistido en el perfil).
GunService:RegisterProduct(Prods.adminpanel.id, function(player)
	player:SetAttribute("OwnsAdminPanel", true)
	local data = DataService:Get(player)
	if data then
		data.OwnsAdminPanel = true
		DataService:Save(player)
	end
	return true
end)

-- NoCooldowns: quita el cooldown del AdminPanel (1 sola compra, persistente).
-- Poner AdminCooldownEffective = 0 hace que AdminCooldownClient no espere nada.
GunService:RegisterProduct(Prods.no_cooldowns.id, function(player)
	player:SetAttribute("AdminCooldownEffective", 0)
	local data = DataService:Get(player)
	if data then
		data.NoAdminCooldowns = true
		DataService:Save(player)
	end
	return true
end)

-- sword: entrega ClassicSword (su SwordScript ya hace daño a NPC y jugadores).
GunService:RegisterProduct(Prods.sword.id, function(player)
	return giveTool(player, "ClassicSword")
end)

-- boombox: entrega SuperFlyGoldBoombox.
GunService:RegisterProduct(Prods.boombox.id, function(player)
	return giveTool(player, "SuperFlyGoldBoombox")
end)

-- HD Admin / BeOwner: rango PERMANENTE via el propio HD Admin Classic. HD Admin
-- guarda el rango en SU DataStore (SaveRank=true), se re-aplica solo en cada rejoin.
-- Rango 3 = "Admin"  ·  Rango 5 = "Owner".
local HD_ADMIN_RANK = 3
local HD_OWNER_RANK = 5

-- Otorga un rango de HD Admin (permanente) y marca un atributo para el NameTag.
local function grantHDRank(player, rank, ownAttr)
	local main = _G.HDAdminMain
	local t0 = os.clock()
	while not (main and main.pd and main.pd[player]) and os.clock() - t0 < 15 do
		task.wait(0.2)
		main = _G.HDAdminMain
	end
	if not (main and main.pd and main.pd[player]) then
		warn("[HDbuy] HD Admin no cargo / sin datos de", player.Name, "-> reintento recibo")
		return false
	end
	local ok, err = pcall(function()
		main:GetModule("cf"):SetRank(player, main.ownerId, rank, "Perm")
	end)
	if not ok then
		warn("[HDbuy] SetRank fallo:", err)
		return false
	end
	if ownAttr then player:SetAttribute(ownAttr, true) end
	return true
end

-- HD Admin (rango Admin)
GunService:RegisterProduct(Prods.hd_admin.id, function(player)
	return grantHDRank(player, HD_ADMIN_RANK, "OwnsHDAdmin")
end)

-- BeOwner (rango Owner)
GunService:RegisterProduct(Prods.be_owner.id, function(player)
	return grantHDRank(player, HD_OWNER_RANK, "IsOwner")
end)

-- BuyNPC: (interpretado) spawnea un paciente NPC. Cambialo si querías otro efecto.
GunService:RegisterProduct(Prods.buy_npc.id, function(player)
	local ok, PatientService = pcall(require, ServerScriptService:WaitForChild("PatientService"))
	if ok and PatientService and PatientService.SpawnPatient then
		-- BuyNPC: spawnea 3 pacientes, escalonados para que no salgan todos encimados.
		for i = 1, 3 do
			PatientService:SpawnPatient()
			if i < 3 then task.wait(0.6) end
		end
		return true
	end
	return false
end)

--------------------------------------------------------------------------------
-- Death screen products
--------------------------------------------------------------------------------
local function revivePlayer(player)
	if not (player and player.Parent == Players) then
		return false
	end

	CollectionService:RemoveTag(player, "DeadPlayer")
	local ok, err = pcall(function()
		player:LoadCharacter()
	end)
	if not ok then
		warn("[MonetizationBuys] revive failed for", player.Name, err)
	end
	return ok
end

local function grantSelfRevive(player)
	local revived = revivePlayer(player)
	if revived then
		player:SetAttribute("HasRevivedOnce", true)
	end
	return revived
end

GunService:RegisterProduct(Prods.revive.id, grantSelfRevive)
GunService:RegisterProduct(Prods.revive_second.id, grantSelfRevive)

GunService:RegisterProduct(Prods.revive_all.id, function(_buyer)
	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if CollectionService:HasTag(player, "DeadPlayer") or not humanoid or humanoid.Health <= 0 then
			revivePlayer(player)
		end
	end
	return true
end)

--------------------------------------------------------------------------------
-- Wire physical prompts
--------------------------------------------------------------------------------
wirePrompt("AdminPanel", Prods.adminpanel.id, "Buy Admin Panel", function(player)
	return player:GetAttribute("OwnsAdminPanel") == true
end)
wirePrompt("BuyNPC",     Prods.buy_npc.id,    "Buy NPC")
wirePrompt("sword",      Prods.sword.id,      "Buy Sword")
wirePrompt("boombox",    Prods.boombox.id,    "Buy Boombox")
wirePrompt("HDadmin",    Prods.hd_admin.id,   "Buy HD Admin", function(player)
	-- Ya lo tiene si su rango HD Admin ya es >= el que vendemos (incluye owner).
	local main = _G.HDAdminMain
	local pdata = main and main.pd and main.pd[player]
	return pdata ~= nil and (pdata.Rank or 0) >= HD_ADMIN_RANK
end)

--------------------------------------------------------------------------------
-- Restaurar acceso admin al reingresar (persistido en el perfil).
--------------------------------------------------------------------------------
local function restoreAdmin(player)
	task.spawn(function()
		local data = DataService:Get(player)
		if data then
			if data.OwnsAdminPanel then
				player:SetAttribute("OwnsAdminPanel", true)
			end
			if data.NoAdminCooldowns then
				player:SetAttribute("AdminCooldownEffective", 0)
			end
		end
	end)
end
Players.PlayerAdded:Connect(restoreAdmin)
for _, p in ipairs(Players:GetPlayers()) do restoreAdmin(p) end

-- print("[MonetizationBuys] listo — AdminPanel/BuyNPC/sword/boombox enganchados")
