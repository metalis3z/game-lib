--credit to leon games studio
--[[
	AdminBuyClient (MODDED)
	Admin Panel GRATIS: los 4 sets se otorgan sin costo.
	Set1=5min · Set2=10min · Set3=15min · Set4=Permanente (muestra "Owned").
	El botón muestra "FREE" y al darle clic se entrega directo vía
	Networking.DevProducts.InstantGrant (el server cobra 0 para las keys
	"Admin:*" y otorga OwnsAdminPanel / AdminPanelUntil).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))
local LocalPlayer = Players.LocalPlayer

local Buttons = script.Parent:WaitForChild("Buttons")

local SETS = {
	{ set = "Set1", key = "Admin:5" },
	{ set = "Set2", key = "Admin:10" },
	{ set = "Set3", key = "Admin:15" },
	{ set = "Set4", key = "Admin:Permanent", perm = true },
}

local function setText(label, text)
	if not label then return end
	label.Text = text
	local inner = label:FindFirstChild("TextLabel")
	if inner then inner.Text = text end
end

local function ownsPermanent()
	return LocalPlayer:GetAttribute("OwnsAdminPanel") == true
end

-- Entrega gratis (server valida que la key Admin cuesta 0)
local function grantFree(key)
	pcall(function()
		Networking.DevProducts.InstantGrant:Fire(key)
	end)
end

for _, data in ipairs(SETS) do
	local setFrame = Buttons:FindFirstChild(data.set)
	if setFrame then
		local buy = setFrame:FindFirstChild("Buy1Button")
		local gift = setFrame:FindFirstChild("Buy1GiftButton")

		if buy then
			setText(buy:FindFirstChild("Price"), "FREE")
			buy.Activated:Connect(function()
				if data.perm and ownsPermanent() then return end
				grantFree(data.key)
			end)
		end
		if gift then
			-- regalar gratis: sin objetivo se lo da a sí mismo
			gift.Activated:Connect(function()
				grantFree(data.key)
			end)
		end

		-- "Owned" para el set permanente
		if data.perm and buy then
			local function refreshOwned()
				if ownsPermanent() then
					setText(buy:FindFirstChild("TextLabel"), "Owned")
					setText(buy:FindFirstChild("Price"), "Owned")
				end
			end
			refreshOwned()
			LocalPlayer:GetAttributeChangedSignal("OwnsAdminPanel"):Connect(refreshOwned)
		end
	end
end
