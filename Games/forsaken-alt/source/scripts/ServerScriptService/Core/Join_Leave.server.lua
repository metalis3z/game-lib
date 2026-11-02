--!strict

-- <- Services -> --
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- <- Constants -> --
local WEBHOOK_URL: string = "https://discord.com/api/webhooks/REDACTED"

-- <- Functions -> --
local function createPayload(player: Player, leaving: boolean): { [string]: any }
	return {
		content = `{player.DisplayName} ({player.Name}) {if leaving then "left" else "joined"} Forsaken Testing!`,
		username = "i feel so sigma", -- rgheighwsvbvbasdvbcbdgbjdsbdcxzmvbcxvdabvsdbviwbeuiwuweeiuwuie
		avatar_url = `https://www.roblox.com/Thumbs/Avatar.ashx?x=500&y=500&Format=Png&userId={player.UserId}`
	}
end

local function sendWebhook(player: Player, leaving: boolean)
	local payload: { [string]: any } = createPayload(player, leaving)
	local success, response = pcall(function()
		HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(payload))
	end)

	if not success then
		task.defer(function()
			pcall(function()
				HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(payload)) -- try again lalalalalalalalalala
			end)
		end)
	end
end

-- <- Events -> --
Players.PlayerAdded:Connect(function(player: Player)
	sendWebhook(player, false)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	sendWebhook(player, true)
end)