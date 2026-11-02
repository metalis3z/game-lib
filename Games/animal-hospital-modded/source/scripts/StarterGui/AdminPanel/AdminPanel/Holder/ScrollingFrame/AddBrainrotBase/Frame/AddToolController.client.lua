--[[ AddToolController — fila "ADD TOOL" del AdminPanel.
       · Select abre Holder.Select con un boton por cada tool del juego.
       · Al elegir una se escribe en ToolName y se cierra el panel.
       · Give manda al server: AdminGiveTool(nombreJugador, nombreTool).

     OJO: el TextBox del jugador se llama "Playerame" (le falta la N), no
     "PlayerName". Es el nombre real de la instancia en la GUI, no un typo mio.

     El panel Holder.Select es UNO SOLO y lo comparten varias filas (esta, la de
     AddSanity y GiveBrainrot). Por eso cada una lo repuebla al abrirlo en vez de
     dejar hijos fijos. ]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network
local GiveableTools = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("GiveableTools"))

local frame = script.Parent -- AddBrainrotBase.Frame
local Select = frame:WaitForChild("Select")
local ToolName = frame:WaitForChild("ToolName")
local PlayerBox = frame:WaitForChild("Playerame")
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

-- Plantilla: clonamos un ImageButton existente ANTES de limpiar la lista, para
-- que los botones nuevos salgan con el estilo del panel.
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
	button.ImageTransparency = 1 -- boton invisible: solo se ve el texto
	button.BackgroundTransparency = 1
	button.AutoButtonColor = false

	local label = button:FindFirstChildWhichIsA("TextLabel")
	if label then
		label.Visible = true
		label.Text = name
	end

	button.Activated:Connect(function()
		ToolName.Text = name
		selectPanel.Visible = false
	end)
	button.Parent = listFrame
end

local function populate()
	clearList()
	if selectorLabel then
		selectorLabel.Text = "SELECT TOOL"
	end
	for _, tool in ipairs(GiveableTools.list()) do
		makeButton(tool.Name)
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
	local targetName = PlayerBox.Text
	local toolName = ToolName.Text
	if targetName == "" or toolName == "" then
		notify("Falta el jugador o la tool", false)
		return
	end
	if not GiveableTools.find(toolName) then
		notify("No existe la tool " .. toolName, false)
		return
	end
	if not Cooldown:Try("AddTool") then
		return -- el propio modulo ya avisa cuanto falta
	end
	selectPanel.Visible = false
	Network:FireServer("AdminGiveTool", targetName, toolName)
	notify(("%s -> %s"):format(toolName, targetName), true)
end)
