--credit to quartz games studio
--[[
	SocialPopupClient  (MODDED v2)
	====================================================================
	Se dispara al USAR el ProximityPrompt del SeedShop (NPC "Sam"), NO por timer.

	  • Favorito  -> panel NATIVO de Roblox (AvatarEditorService:PromptSetFavorite).
	    Ya no hay tarjeta custom para favorito: sale el dialogo nativo.
	  • Grupo 730315894 -> Roblox NO expone API para abrir un panel nativo de
	    "unirse al grupo" desde codigo (no existe PromptJoinGroup), asi que se
	    muestra un boton minimo. Si el jugador YA esta en el grupo (IsInGroup)
	    no aparece.
	  • Si ya favorito Y ya esta en el grupo, no aparece nada.
	  • Por disparo se muestra UNA cosa: prioriza favorito; cuando ya favorito,
	    el siguiente uso del SeedShop muestra el grupo.
	  • Cooldown: si aparece y el jugador lo IGNORA, no vuelve a salir hasta que
	    pasen 5 MINUTOS y vuelva a usar el SeedShop.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local AvatarEditorService = game:GetService("AvatarEditorService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

----------------------------------------------------------------------
-- CONFIG
----------------------------------------------------------------------
local GROUP_ID = 730315894
local COOLDOWN = 300 -- 5 minutos

local remote = ReplicatedStorage:WaitForChild("SocialPopupRemote")
local USocialEvent = ReplicatedStorage:WaitForChild("USocialEvent") -- RemoteEvent (server -> cliente, "Favorite")
local SocialEvent = ReplicatedStorage:WaitForChild("SocialEvent")   -- BindableEvent (cliente, "Favorite")

----------------------------------------------------------------------
-- Estado
----------------------------------------------------------------------
local function hasFavorited(): boolean
	return LocalPlayer:GetAttribute("FavoritedGame") == true
end

local function isInGroup(): boolean
	local ok, res = pcall(function()
		return LocalPlayer:IsInGroup(GROUP_ID)
	end)
	return ok and res == true
end

----------------------------------------------------------------------
-- UI minima SOLO para el grupo (el favorito usa el panel nativo)
----------------------------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "SocialPopup"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 500
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Enabled = false
gui.Parent = PlayerGui

local overlay = Instance.new("Frame")
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundColor3 = Color3.new(0, 0, 0)
overlay.BackgroundTransparency = 0.45
overlay.BorderSizePixel = 0
overlay.Parent = gui

local card = Instance.new("Frame")
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.fromScale(0.5, 0.5)
card.Size = UDim2.fromOffset(420, 230)
card.BackgroundColor3 = Color3.fromRGB(34, 40, 49)
card.BorderSizePixel = 0
card.Parent = overlay
do
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 16)
	c.Parent = card
	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(70, 130, 230)
	s.Thickness = 2
	s.Parent = card
end

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(0, 18)
title.Size = UDim2.new(1, 0, 0, 38)
title.Font = Enum.Font.GothamBold
title.Text = "Join our Group!"
title.TextColor3 = Color3.fromRGB(150, 190, 255)
title.TextSize = 26
title.Parent = card

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.fromOffset(24, 62)
subtitle.Size = UDim2.new(1, -48, 0, 60)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "Join the group for updates, rewards and giveaways! Search the group and join, then come back."
subtitle.TextColor3 = Color3.fromRGB(220, 224, 230)
subtitle.TextSize = 16
subtitle.TextWrapped = true
subtitle.Parent = card

local closeBtn = Instance.new("TextButton")
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.Position = UDim2.new(1, -10, 0, 10)
closeBtn.Size = UDim2.fromOffset(30, 30)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = card
do
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(1, 0)
	c.Parent = closeBtn
end

local groupBtn = Instance.new("TextButton")
groupBtn.Name = "GroupButton"
groupBtn.AnchorPoint = Vector2.new(0.5, 1)
groupBtn.Position = UDim2.new(0.5, 0, 1, -24)
groupBtn.Size = UDim2.fromOffset(360, 54)
groupBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 230)
groupBtn.Text = "Join the Group"
groupBtn.Font = Enum.Font.GothamBold
groupBtn.TextSize = 20
groupBtn.TextColor3 = Color3.new(1, 1, 1)
groupBtn.AutoButtonColor = true
groupBtn.Parent = card
do
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 10)
	c.Parent = groupBtn
end

----------------------------------------------------------------------
-- Logica
----------------------------------------------------------------------
local groupCardOpen = false

local function closeGroupCard()
	groupCardOpen = false
	gui.Enabled = false
end

local function openGroupCard()
	if groupCardOpen then
		return
	end
	groupCardOpen = true
	gui.Enabled = true
	card.Size = UDim2.fromOffset(0, 0)
	TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.fromOffset(420, 230),
	}):Play()
end

-- Panel NATIVO de favorito. En el juego publicado abre el dialogo de favoritos
-- de la experiencia; en Studio puede no mostrar nada.
local favoritePromptOpen = false
local function promptFavorite()
	if hasFavorited() or favoritePromptOpen then
		return
	end
	favoritePromptOpen = true
	local ok = pcall(function()
		AvatarEditorService:PromptSetFavorite(game.PlaceId, Enum.AvatarItemType.Asset, true)
	end)
	if not ok then
		favoritePromptOpen = false
	end
end

-- Resultado del prompt: solo persistimos si el jugador CONFIRMO el favorito.
AvatarEditorService.PromptSetFavoriteCompleted:Connect(function(result)
	favoritePromptOpen = false
	if result == Enum.AvatarPromptResult.Success then
		remote:FireServer("Favorited")
		LocalPlayer:SetAttribute("FavoritedGame", true)
	end
end)

-- Los remotes del usuario tambien disparan el panel nativo de favorito.
USocialEvent.OnClientEvent:Connect(function(action)
	if action == "Favorite" then
		promptFavorite()
	end
end)
SocialEvent.Event:Connect(function(action)
	if action == "Favorite" then
		promptFavorite()
	end
end)

-- Best-effort: si Roblox ya reporta el juego como favorito (lo marco por fuera),
-- lo persistimos para no volver a pedirlo.
task.spawn(function()
	local ok, fav = pcall(function()
		return AvatarEditorService:GetFavorite(game.PlaceId, Enum.AvatarItemType.Asset)
	end)
	if ok and fav == true and not hasFavorited() then
		remote:FireServer("Favorited")
		LocalPlayer:SetAttribute("FavoritedGame", true)
	end
end)

closeBtn.Activated:Connect(closeGroupCard)
groupBtn.Activated:Connect(function()
	-- Roblox no permite unirse al grupo por codigo; cerramos y el chequeo
	-- IsInGroup deja de pedirlo en cuanto el jugador se una (al reingresar).
	closeGroupCard()
end)

----------------------------------------------------------------------
-- Disparador: ProximityPrompt del SeedShop (NPC "Sam") + cooldown 5 min
----------------------------------------------------------------------
local lastShown = -math.huge

local function onSeedShopUsed()
	if (os.clock() - lastShown) < COOLDOWN then
		return -- aun en cooldown: lo ignoro
	end

	local needFav = not hasFavorited()
	local needGrp = not isInGroup()
	if not needFav and not needGrp then
		return -- ya favorito y ya esta en el grupo: nada que pedir
	end

	lastShown = os.clock() -- arranca el cooldown aunque lo ignore

	if needFav then
		promptFavorite() -- panel nativo (prioridad)
	elseif needGrp then
		openGroupCard()
	end
end

task.spawn(function()
	local npcs = Workspace:WaitForChild("NPCS")
	local sam = npcs:WaitForChild("Sam")
	local hrp = sam:WaitForChild("HumanoidRootPart")
	local prompt = hrp:WaitForChild("ProximityPrompt")
	prompt.Triggered:Connect(function(plr)
		if plr == LocalPlayer then
			onSeedShopUsed()
		end
	end)
end)
