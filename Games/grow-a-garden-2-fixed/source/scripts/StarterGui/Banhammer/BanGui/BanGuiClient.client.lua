--credit to quartz games studio
--[[
	BanGuiClient (MODDED)
	Va dentro de la ScreenGui StarterGui.Banhammer.BanGui.
	El servidor (BanHammerService) dispara BanHammerState:
	  (true, bannerUserId, endTime)  -> mostrar GUI de baneo
	  (false)                        -> ocultar
	  • TimeLeft: cuenta atrás (2 min).
	  • Avatar: cara del jugador que baneó (+ Username).
	  • Eyes: oculta/muestra la GUI (toggle), dejando el botón visible.
	  • BanOpen (Revenge): COMPRA de Robux (devproduct 3604872275). Al pagar,
	    DevProductService -> GameServerAPI.DoBanRevenge te libera y banea al otro.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local gui = script.Parent -- ScreenGui BanGui
gui.Enabled = false

local ProductIds = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("ProductIds"))
local REVENGE_ID = (ProductIds.Products and ProductIds.Products.BanHammerRevenge) or 3604872275

local remotes = ReplicatedStorage:WaitForChild("RemoteEvents")
local StateRemote = remotes:WaitForChild("BanHammerState")

local blackFrame = gui:WaitForChild("BlackFrame")
local black2 = blackFrame:WaitForChild("BlackFrame2")
local timeLeftLabel = black2:WaitForChild("TimeLeft")
local eyes = black2:WaitForChild("Eyes")
local revenge2 = black2:WaitForChild("Revenge"):WaitForChild("Revenge2")
local banOpen = revenge2:WaitForChild("BanOpen")
local avatar = revenge2:WaitForChild("Avatar")

local currentEndTime = nil

local function fmt(sec: number): string
	sec = math.max(0, math.floor(sec))
	return string.format("%d:%02d", math.floor(sec / 60), sec % 60)
end

----------------------------------------------------------------------
-- Estado de baneo
----------------------------------------------------------------------
StateRemote.OnClientEvent:Connect(function(banned, bannerUserId, endTime)
	if banned then
		currentEndTime = endTime
		gui.Enabled = true
		if bannerUserId and bannerUserId > 0 then
			avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(bannerUserId) .. "&w=150&h=150"
			local uname = avatar:FindFirstChild("Username")
			if uname and uname:IsA("TextLabel") then
				task.spawn(function()
					local ok, name = pcall(function()
						return Players:GetNameFromUserIdAsync(bannerUserId)
					end)
					if ok and name then
						uname.Text = name
					end
				end)
			end
		end
		timeLeftLabel.Text = fmt((endTime or os.time()) - os.time())
	else
		currentEndTime = nil
		gui.Enabled = false
	end
end)

----------------------------------------------------------------------
-- Cuenta atrás
----------------------------------------------------------------------
task.spawn(function()
	while true do
		task.wait(0.25)
		if currentEndTime and gui.Enabled then
			timeLeftLabel.Text = fmt(currentEndTime - os.time())
		end
	end
end)

----------------------------------------------------------------------
-- Eyes: ocultar/mostrar todo MENOS el propio botón Eyes
----------------------------------------------------------------------
local toggleTargets = {}
for _, c in black2:GetChildren() do
	if c ~= eyes and c:IsA("GuiObject") then
		table.insert(toggleTargets, c)
	end
end
local shown = true
local origBg = blackFrame.BackgroundTransparency
eyes.Activated:Connect(function()
	shown = not shown
	for _, c in toggleTargets do
		c.Visible = shown
	end
	blackFrame.BackgroundTransparency = if shown then origBg else 1
end)

----------------------------------------------------------------------
-- Revenge = compra de Robux
----------------------------------------------------------------------
banOpen.Activated:Connect(function()
	if REVENGE_ID and REVENGE_ID > 0 then
		require(game:GetService("ReplicatedStorage").SharedModules.FakeBuy).Product(REVENGE_ID)
	end
end)
