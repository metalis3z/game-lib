--[[ AdminPanelPromptOpen — el ProximityPrompt físico del AdminPanel
     (Workspace.Monetization.AdminPanel.Part.Attachment.ProximityPrompt) ABRE el
     panel si el jugador YA lo posee (OwnsAdminPanel). La COMPRA para quien no lo
     tiene la lanza el server (MonetizationBuys); ambos casos son excluyentes, así
     que no hay doble prompt. Antes: siendo dueño, presionar el prompt no hacía nada. ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")

local Lib         = require(ReplicatedStorage:WaitForChild("Lib"))
local LocalPlayer = Players.LocalPlayer

local monet     = workspace:WaitForChild("Monetization")
local adminProp = monet:WaitForChild("AdminPanel")

-- Espera el ProximityPrompt (puede no haber replicado aún al arrancar).
local prompt = adminProp:FindFirstChildWhichIsA("ProximityPrompt", true)
while not prompt do
	task.wait(0.25)
	prompt = adminProp:FindFirstChildWhichIsA("ProximityPrompt", true)
end

-- El texto del prompt refleja el estado local: dueño = Abrir, si no = Comprar.
local function updateText()
	prompt.ActionText = LocalPlayer:GetAttribute("OwnsAdminPanel") and "Open Admin Panel" or "Buy Admin Panel"
end
updateText()
LocalPlayer:GetAttributeChangedSignal("OwnsAdminPanel"):Connect(updateText)

prompt.Triggered:Connect(function(player)
	if player ~= LocalPlayer then return end
	if not LocalPlayer:GetAttribute("OwnsAdminPanel") then
		return -- no es dueño: la compra la ofrece el server
	end
	local gui = LocalPlayer.PlayerGui:WaitForChild("AdminPanel")
	Lib.Buttons.ChangeVisibility(gui:WaitForChild("AdminPanel"))
end)
