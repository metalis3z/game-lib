--[[ AddSanityController — fila "SANITY" del AdminPanel.
       · Select abre Holder.Select con un boton por cada jugador conectado.
       · Al elegir uno se escribe en Name y se cierra el panel.
       · Give manda al server: AdminAddSanity(nombre, cantidad).

     La cantidad SUMA: 25 sube 25, -25 baja 25. El server clampea 0..100.

     El panel Holder.Select es UNO SOLO y lo comparten varias filas, por eso se
     repuebla al abrirlo. Ademas la lista de jugadores cambia sola (entran y
     salen), asi que no puede estar puesta a mano en la GUI. ]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network

local frame = script.Parent -- AddSanity.Frame
local Select = frame:WaitForChild("Select")
local NameBox = frame:WaitForChild("Name")
local SanityBox = frame:WaitForChild("Sanity")
local Give = frame:WaitForChild("Give")

local adminPanel = script:FindFirstAncestor("AdminPanel")
local selectPanel = adminPanel.Holder:WaitForChild("Select")
local listFrame = selectPanel:WaitForChild("ScrollingFrame")
local selectorLabel = selectPanel:FindFirstChild("SelectorLabel")

local Cooldown = require(adminPanel:WaitForChild("AdminCooldownClient"))

local function notify(message, good)
	local module = adminPanel:FindFirstChild("NotifModule")
	if not module then
		return
	end
	local ok, notif = pcall(require, module)
	if ok and type(notif) == "function" then
		notif(message, good ~= false)
	end
end

-- Plantilla: clonamos un ImageButton existente ANTES de limpiar la lista.
local template = listFrame:FindFirstChildWhichIsA("ImageButton")
template = template and template:Clone()

local function clearList()
	for _, child in ipairs(listFrame:GetChildren()) do
		if child:IsA("ImageButton") then
			child:Destroy()
		end
	end
end

local function makeButton(name)
	local button
	if template then
		button = template:Clone()
	else
		button = Instance.new("ImageButton")
		local label = Instance.new("TextLabel")
		label.Name = "TextLabel"
		label.Size = UDim2.fromScale(1, 1)
		label.BackgroundTransparency = 1
		label.Parent = button
	end
	button.Name = name
	button.Visible = true
	button.ImageTransparency = 1
	button.BackgroundTransparency = 1
	button.AutoButtonColor = false

	local label = button:FindFirstChildWhichIsA("TextLabel")
	if label then
		label.Visible = true
		label.Text = name
	end

	button.Activated:Connect(function()
		NameBox.Text = name
		selectPanel.Visible = false
	end)
	button.Parent = listFrame
end

local function populate()
	clearList()
	if selectorLabel then
		selectorLabel.Text = "SELECT PLAYER"
	end
	for _, player in ipairs(Players:GetPlayers()) do
		makeButton(player.Name)
	end
end

Lib.Buttons.OnActivate(Select, function()
	if selectPanel.Visible then
		selectPanel.Visible = false
	else
		populate()
		selectPanel.Visible = true
	end
end)

Lib.Buttons.OnActivate(Give, function()
	local targetName = NameBox.Text
	local amount = tonumber(SanityBox.Text)
	if targetName == "" then
		notify("Falta el jugador", false)
		return
	end
	if not amount or amount == 0 then
		notify("Poné un numero distinto de 0", false)
		return
	end
	if not Cooldown:Try("AddSanity") then
		return -- el propio modulo ya avisa cuanto falta
	end
	selectPanel.Visible = false
	Network:FireServer("AdminAddSanity", targetName, amount)
	notify(("%s sanity a %s"):format(amount > 0 and ("+" .. amount) or tostring(amount), targetName), true)
end)
