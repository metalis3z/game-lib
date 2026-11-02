--[[ AdminActionsClient — cablea las filas Cash / Speed / Shift (botones Add/Set)
     y el botón NoCooldowns del AdminPanel.
       · Lee el número del TextBox de cada fila.
       · Respeta el cooldown (AdminCooldownClient) — 0 si compraste NoCooldowns.
       · Manda al server:  Network:FireServer("AdminAction", action, mode, value)
     Nota: NotifModule está roto en este juego (pide ServicesLoader.MessagesService,
     que no existe), así que las notis van por SetCore("SendNotification"). ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local StarterGui = game:GetService("StarterGui")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local Prods = require(ReplicatedStorage.Data.Prods)
local LocalPlayer = Players.LocalPlayer

local panel = script.Parent -- el Frame "AdminPanel"
local scroll = panel:WaitForChild("Holder"):WaitForChild("ScrollingFrame")
local Cooldown = require(panel:WaitForChild("AdminCooldownClient"))

local function say(msg, ok)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = (ok == false) and "Admin  ✗" or "Admin  ✓",
			Text = msg,
			Duration = 3,
		})
	end)
end

-- Número escrito en un TextBox (nil si está vacío o no es número).
-- OJO: gsub devuelve (texto, nº) — hay que descartar el 2º valor o se cuela
-- como la "base" de tonumber y crashea.
local function readNum(box)
	local text = ((box and box.Text) or ""):gsub("%s", "")
	return tonumber(text)
end

-- Ejecuta una acción respetando el cooldown propio de esa acción.
local function doAction(action, mode, value)
	local ready, left = Cooldown:Check(action)
	if not ready then
		say(("Cooldown: %ds"):format(left), false)
		return
	end
	Cooldown:Mark(action)
	Network:FireServer("AdminAction", action, mode, value)
	say(("%s %s: %s"):format(action, mode, tostring(value)), true)
end

-- Conecta el par Add/Set de una fila a su acción.
local function wireRow(frameName, boxName, action)
	local frame = scroll:WaitForChild(frameName)
	local box = frame:WaitForChild("Frame"):WaitForChild(boxName)
	local function fire(mode)
		local n = readNum(box)
		if n == nil then
			say("Enter a number first", false)
			return
		end
		doAction(action, mode, n)
	end
	frame:WaitForChild("Add").Activated:Connect(function() fire("add") end)
	frame:WaitForChild("Set").Activated:Connect(function() fire("set") end)
end

wireRow("Cash",  "TextFrame",    "cash")
wireRow("Speed", "TextFrame",    "speed")
wireRow("Shift", "mainMutation", "shift")

-- NoCooldowns: compra el DevProduct (1 sola vez -> sin cooldown para siempre).
do
	local btn = scroll:WaitForChild("AdminPlus"):WaitForChild("NoCooldowns")
	btn.Activated:Connect(function()
		if LocalPlayer:GetAttribute("AdminCooldownEffective") == 0 then
			say("You already have No Cooldowns", true)
			return
		end
		local id = Prods.no_cooldowns and Prods.no_cooldowns.id
		if not id or id == 0 then
			say("No Cooldowns product not set up yet", false)
			return
		end
		MarketplaceService:PromptProductPurchase(LocalPlayer, id)
	end)
end
