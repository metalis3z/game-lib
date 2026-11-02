--[[ GiveController — selector de jugador + dar Cash a un jugador objetivo.
       · Select abre el panel Holder.Select con un boton por cada jugador (solo el nombre).
       · Al elegir un nombre se escribe en PlayerName y se cierra el panel.
       · Give manda al server: AdminGiveCash(nombre, cantidad). ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Network = Lib.Network

local frame = script.Parent -- GiveBrainrot.Frame
local Select = frame:WaitForChild("Select")
local PlayerName = frame:WaitForChild("PlayerName")
local Cash = frame:WaitForChild("Cash")
local Give = frame:WaitForChild("Give")

local adminPanel = script:FindFirstAncestor("AdminPanel") -- el Frame AdminPanel
local selectPanel = adminPanel.Holder:WaitForChild("Select")
local listFrame = selectPanel:WaitForChild("ScrollingFrame")

-- Plantilla: clonamos un ImageButton existente (antes de limpiar la lista).
local template = listFrame:FindFirstChildWhichIsA("ImageButton")
template = template and template:Clone()

selectPanel.Visible = false

local function clearList()
	for _, c in ipairs(listFrame:GetChildren()) do
		if c:IsA("ImageButton") then c:Destroy() end
	end
end

local function makeNameButton(plr)
	local btn
	if template then
		btn = template:Clone()
	else
		btn = Instance.new("ImageButton")
		local tl = Instance.new("TextLabel")
		tl.Name = "TextLabel"
		tl.Size = UDim2.fromScale(1, 1)
		tl.BackgroundTransparency = 1
		tl.Parent = btn
	end
	btn.Name = plr.Name
	btn.Visible = true
	btn.ImageTransparency = 1       -- boton invisible: solo se ve el nombre
	btn.BackgroundTransparency = 1
	btn.AutoButtonColor = false
	local label = btn:FindFirstChildWhichIsA("TextLabel")
	if label then
		label.Visible = true
		label.Text = plr.Name
	end
	btn.Activated:Connect(function()
		PlayerName.Text = plr.Name
		selectPanel.Visible = false
	end)
	btn.Parent = listFrame
end

local function populate()
	clearList()
	for _, plr in ipairs(Players:GetPlayers()) do
		makeNameButton(plr)
	end
end

-- Abrir / cerrar el selector
Lib.Buttons.OnActivate(Select, function()
	if selectPanel.Visible then
		selectPanel.Visible = false
	else
		populate()
		selectPanel.Visible = true
	end
end)

-- Dar el cash al jugador escrito en PlayerName
Lib.Buttons.OnActivate(Give, function()
	local name = PlayerName.Text
	local amount = tonumber(Cash.Text)
	if not name or name == "" or not amount then return end
	Network:FireServer("AdminGiveCash", name, amount)
end)
