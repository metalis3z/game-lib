local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local InterfaceController   = require(ReplicatedStorage.Controllers.InterfaceController)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local SoundController       = require(ReplicatedStorage.Controllers.SoundController)
local AnimatedButton        = require(ReplicatedStorage.Classes.AnimatedButton)
local Synchronizer          = require(ReplicatedStorage.Packages.Synchronizer)
local Observers             = require(ReplicatedStorage.Packages.Observers)
local Trove                 = require(ReplicatedStorage.Packages.Trove)
local Net                   = require(ReplicatedStorage.Packages.Net)
local JumpShopData          = require(ReplicatedStorage.Datas.JumpShopData)
local ZoneNames             = require(ReplicatedStorage.Datas.EggrotZoneNames)

local BuyJumpRemote = Net:RemoteFunction("EggrotHunt/JumpShop/Buy")
local LocalPlayer   = Players.LocalPlayer

local shopGui = LocalPlayer.PlayerGui:WaitForChild("JumpShop"):FindFirstChild("JumpShop")
if not shopGui then
	return function() end
end

local controller = InterfaceController:Register("EggrotJumpShop", shopGui, "TopQuint")
controller:AttachCloseButton(shopGui.Header.Close)
controller:Close()

return {
	Start = function(_)
		local trove = Trove.new()
		local scrollFrame = shopGui.ScrollingFrame
		local template = scrollFrame:FindFirstChild("Template")
		if not template then
			return function() trove:Destroy() end
		end
		template.Visible = false

		local buttonTrove = Trove.new()
		trove:Add(buttonTrove)

		local items = {}

		local function getCurrentLevel()
			local data = Synchronizer:Get(LocalPlayer)
			if not data then return 0 end
			local level = data:Get({"EasterEvent", "JumpShop"})
			return typeof(level) == "number" and level or 0
		end

		local function refreshUI()
			local currentLevel = getCurrentLevel()
			for _, item in ipairs(items) do
				local tierData   = JumpShopData[item.Tier]
				local owned      = item.Tier <= currentLevel
				local claimable  = item.Tier == currentLevel + 1
				local zoneUnlocked = not tierData.Zone

				if not zoneUnlocked then
					local data = Synchronizer:Get(LocalPlayer)
					if data then
						zoneUnlocked = data:Get({"EasterEvent", "VisitedZones", tierData.Zone}) == true
					end
				end

				if item.InfoLabel then
					item.InfoLabel.Visible = owned
				end

				if item.ClaimButton then
					item.ClaimButton.Visible = claimable and zoneUnlocked
				end

				if item.LockedLabel then
					if owned then
						item.LockedLabel.Visible = false
					elseif not zoneUnlocked then
						item.LockedLabel.Visible = true
						item.LockedLabel.Text = ("Reach %s Island first!"):format(ZoneNames[tierData.Zone] or tierData.Zone)
					elseif not claimable then
						item.LockedLabel.Visible = true
						item.LockedLabel.Text = ("Buy Jump %d first!"):format(item.Tier)
					else
						item.LockedLabel.Visible = false
					end
				end

				if item.Icon then
					local locked = not zoneUnlocked and not owned
					item.Icon.Image = locked and tierData.IslandIcon or tierData.JumpIcon
				end
			end
		end

		for tier, tierData in JumpShopData do
			local clone = template:Clone()
			clone.Name = ("Jump_%d"):format(tier)
			clone.LayoutOrder = tier
			clone.Visible = true

			local spacer = clone:FindFirstChild("Spacer")
			if not spacer then
				clone:Destroy()
				continue
			end

			local titleLabel  = spacer:FindFirstChild("Title")
			local infoLabel   = spacer:FindFirstChild("Info")
			local claimButton = spacer:FindFirstChild("Claim")
			local lockedLabel = spacer:FindFirstChild("Locked")
			local iconLabel   = spacer:FindFirstChild("Icon")

			if titleLabel and titleLabel:IsA("TextLabel") then
				titleLabel.Text = ("%d Jumps"):format(tier + 1)
			end
			if infoLabel and infoLabel:IsA("TextLabel") then
				infoLabel.Text = "Owned"
			end
			if claimButton and claimButton:IsA("GuiButton") then
				local txt = claimButton:FindFirstChild("Txt")
				if txt and txt:IsA("TextLabel") then
					txt.Text = tostring(tierData.Price)
				end
				local btn = AnimatedButton.new(claimButton)
				btn:Animate()
				buttonTrove:Add(btn.OnActivated:Connect(function()
					local success, message = BuyJumpRemote:InvokeServer()
					if success then
						NotificationController:Success(message or "Purchased!")
						SoundController:PlaySound("Sounds.Sfx.Success")
						task.defer(refreshUI)
					else
						NotificationController:Error(message or "Purchase failed.")
						SoundController:PlaySound("Sounds.Sfx.Error")
					end
				end))
			end

			local entry = {Tier = tier}
			entry.InfoLabel   = (infoLabel   and infoLabel:IsA("TextLabel"))   and infoLabel   or nil
			entry.ClaimButton = (claimButton and claimButton:IsA("GuiButton")) and claimButton or nil
			entry.LockedLabel = (lockedLabel and lockedLabel:IsA("TextLabel")) and lockedLabel or nil
			entry.Icon        = (iconLabel   and iconLabel:IsA("ImageLabel"))  and iconLabel   or nil

			table.insert(items, entry)
			clone.Parent = scrollFrame
			trove:Add(clone)
		end

		Synchronizer:WaitAndCall(LocalPlayer, function(playerData)
			trove:Add(playerData:OnChanged({"EasterEvent", "JumpShop"},     refreshUI))
			trove:Add(playerData:OnChanged({"EasterEvent", "VisitedZones"}, refreshUI))
			trove:Add(playerData:OnDictionaryInserted({"EasterEvent", "VisitedZones"}, refreshUI))
			task.spawn(refreshUI)
		end)

		trove:Add(Observers.observeTag("EggrotJumpShopPrompt", function(prompt)
			if not prompt:IsA("ProximityPrompt") then return nil end
			local conn = prompt.Triggered:Connect(function()
				refreshUI()
				InterfaceController:Toggle("EggrotJumpShop")
			end)
			return function() conn:Disconnect() end
		end, {workspace}))

		return function() trove:Destroy() end
	end,
}