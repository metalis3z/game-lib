local HttpService = game:GetService("HttpService")

local Settings = {
	url = "https://discord.com/api/webhooks/REDACTED",
	url2 = "https://discord.com/api/webhooks/REDACTED",
	abuse = {':script', ':dex', ':cs', ':dexnew', ':btools', ':shutdown', ':changestat', ':changevalue', ':s', ':shutdown'}
}

local function FindInArray(arr, obj)
	for i = 1, #arr do
		if arr[i] == obj then
			return i
		end
	end
	return nil
end

return function()
	service.Events.CommandRan:Connect(function(plr, data)
		local msg = data.Message
		local cmd = data.Matched
		local args = data.Args
		
		local pLevel = data.PlayerData.Level
		local Level = server.Admin.LevelToListName(pLevel)
		
		if FindInArray(Settings.abuse, string.lower(cmd)) and Level then
			local data = {
				['embeds'] = {{
					['title'] = "**New Command Log**",
					['description'] = "Player Who ran command: " .. plr.Name,
					['color'] = 16777215,
					['url'] = "https://www.roblox.com/users/" .. plr.UserId .. "/profile",
					['fields'] = {
						{
							['name'] = "Command Ran",
							['value'] = msg,
							['inline'] = true
						},
						{
							['name'] = "Account Level",
							['value'] = (Level or "Guest"),
							['inline'] = true
						}
					}
				}}
			}

			local success, encodedData = pcall(function()
				return HttpService:JSONEncode(data)
			end)

			if success then
				local successPost, response = pcall(function()
					return HttpService:PostAsync(Settings.url2, encodedData)
				end)
			end
			return
		end

		if Level then
			local data = {
				['embeds'] = {{
					['title'] = "**New Command Log**",
					['description'] = "Player Who ran command: " .. plr.Name,
					['color'] = 2303786,
					['url'] = "https://www.roblox.com/users/" .. plr.UserId .. "/profile",
					['fields'] = {
						{
							['name'] = "Command Ran",
							['value'] = msg,
							['inline'] = true
						},
						{
							['name'] = "Account Level",
							['value'] = (Level or "Guest"),
							['inline'] = true
						}
					}
				}}
			}

			local success, encodedData = pcall(function()
				return HttpService:JSONEncode(data)
			end)

			if success then
				local successPost, response = pcall(function()
					return HttpService:PostAsync(Settings.url, encodedData)
				end)
			end
		end
	end)
end