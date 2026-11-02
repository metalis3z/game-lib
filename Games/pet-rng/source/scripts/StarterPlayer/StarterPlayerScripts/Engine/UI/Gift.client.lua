local MarketPlaceService = game:GetService("MarketplaceService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local Modules = RSEngine:WaitForChild("Modules")
local NotificationModule = require(Modules:WaitForChild("NotificationModule"))
local RemoteEvents = RSEngine:WaitForChild("RemotesEvents")
local claimRemote = RemoteEvents:WaitForChild("Claim")
local DataModules = ReplicatedStorage:WaitForChild("DataModules")
local Gifts = require(DataModules:WaitForChild("Gifts"))
--local CraftSystem = RSEngine:WaitForChild("Modules"):WaitForChild("CraftSystem")

local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
local gui = playerGui:WaitForChild("GUI")
local frames = gui:WaitForChild("Frames")
local giftsFrame = frames:WaitForChild("Gifts")
local unlockAll = giftsFrame:WaitForChild("UnlockAllPrompt")
local holder = giftsFrame:WaitForChild("GiftsHolder")

local readyGifts = 0
local timePassed = 0
local id = 1775914016

local giftImages = Gifts.Images
local giftTimes = Gifts.Times
local giftRewards = Gifts.Rewards

local claimedGifts = {}

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

local function claim(rewardName, amount, reward, frame)
	for i = 1, amount do
		if not table.find(claimedGifts, reward) then
			table.insert(claimedGifts, reward)
			frame.Countdown.Text = "Claimed"
			frame.Countdown.TextColor3 = Color3.fromRGB(0,255,0)
			readyGifts -= 1
			claimRemote:FireServer(rewardName)
		end
	end
end

for i, reward in pairs(giftRewards) do
	local frame: ImageButton = holder:FindFirstChild("Gift"..i)
	
	if frame then
		frame.Amount.Text = "x"..reward[2]
		frame.Countdown.Text = giftTimes[i]
		frame.image.Image = giftImages[reward[1]]
		
		frame.MouseButton1Click:Connect(function()
			if timePassed >= giftTimes[i] then
				claim(reward[1], reward[2], reward, frame)
			end
		end)
	end
end

unlockAll.MouseButton1Click:Connect(function()
	MarketPlaceService:PromptProductPurchase(player, id)
end)

MarketPlaceService.PromptProductPurchaseFinished:Connect(function(userId, productId, isPurchased)
	if isPurchased then
		if productId == id then
			if userId == player.UserId then
				giftTimes = {
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0
				}
			end
		end
	end
end)

while wait(1) do
	timePassed += 1
	
	for i, reward in pairs(giftRewards) do
		local frame: ImageButton = holder:FindFirstChild("Gift"..i)

		if frame then
			local timeLeft = giftTimes[i] - timePassed
			
			frame.Amount.Text = "x"..reward[2]
			frame.image.Image = giftImages[reward[1]]
			
			if timeLeft > 0 then
				frame.Countdown.Text = convertToHMS(timeLeft)	
			elseif not table.find(claimedGifts, reward) then
				if frame.Countdown.Text ~= "Claim!" then
					readyGifts += 1
					coroutine.wrap(function()
						NotificationModule.Notify(player, "A gift is ready to claim!")
					end)()
					frame.Countdown.Text = "Claim!"
				end
			end
		end
	end
	
	player.PlayerGui.GUI.Left.Gifts.Notice.Amount.Text = readyGifts
	player.PlayerGui.GUI.Left.Gifts.Notice.Visible = readyGifts > 0
end