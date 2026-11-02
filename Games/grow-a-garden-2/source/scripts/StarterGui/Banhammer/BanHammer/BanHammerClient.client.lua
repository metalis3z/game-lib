--credit to quartz games studio
--[[
	BanHammerClient (MODDED)
	Va dentro de la ScreenGui StarterGui.Banhammer.BanHammer.
	  • Muestra la GUI cuando el jugador entra al Part Workspace.BanHammerFolder.GuiEnabled
	    (y la oculta al alejarse).
	  • MoneyButton -> compra con 20M sheckles (remote BanHammerBuyMoney).
	  • RobuxButton -> dev product 5 R$ (ProductIds.BanHammer = 3604869556).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = script.Parent -- ScreenGui BanHammer
gui.Enabled = false

local ProductIds = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("ProductIds"))
local ROBUX_ID = (ProductIds.Products and ProductIds.Products.BanHammer) or 3604869556

local remotes = ReplicatedStorage:WaitForChild("RemoteEvents")
local BuyMoney = remotes:WaitForChild("BanHammerBuyMoney")

-- precio del botón de Robux ("5")
local robuxFrame = gui:FindFirstChild("RobuxButton") and gui.RobuxButton:FindFirstChild("Frame")
if robuxFrame then
	for _, lbl in robuxFrame:GetDescendants() do
		if lbl:IsA("TextLabel") then
			lbl.Text = "5"
		end
	end
end

----------------------------------------------------------------------
-- Mostrar / ocultar según el Part GuiEnabled
----------------------------------------------------------------------
local triggerFolder = workspace:WaitForChild("BanHammerFolder")
local guiEnabled = triggerFolder:WaitForChild("GuiEnabled")

guiEnabled.Touched:Connect(function(hit)
	local char = player.Character
	if char and hit:IsDescendantOf(char) then
		gui.Enabled = true
	end
end)

-- ocultar automáticamente al alejarse del part
RunService.Heartbeat:Connect(function()
	if not gui.Enabled then
		return
	end
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp and (hrp.Position - guiEnabled.Position).Magnitude > 22 then
		gui.Enabled = false
	end
end)

----------------------------------------------------------------------
-- Botones de compra
----------------------------------------------------------------------
local moneyButton = gui:WaitForChild("MoneyButton")
local robuxButton = gui:WaitForChild("RobuxButton")

local buying = false
moneyButton.Activated:Connect(function()
	if buying then return end
	buying = true
	BuyMoney:FireServer()
	task.delay(0.5, function() buying = false end)
end)

robuxButton.Activated:Connect(function()
	if ROBUX_ID and ROBUX_ID > 0 then
		require(game:GetService("ReplicatedStorage").SharedModules.FakeBuy).Product(ROBUX_ID)
	end
end)
