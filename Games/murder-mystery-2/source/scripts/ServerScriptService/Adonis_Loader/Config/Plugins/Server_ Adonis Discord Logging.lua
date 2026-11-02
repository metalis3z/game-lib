--[[

Thank you for getting this! Put this script in Adonis_Loader > Config > Plugins

Don't forget to fill in the variables below!

]]

local WebhookURL = "https://discord.com/api/webhooks/REDACTED" -- Put this with your full Webhook URL

--[[

Do not edit below this unless you know what you are doing!

Made by happxiier - Contact happxiier#6085 if you have any concerns!

]]

WebhookURL = string.gsub(WebhookURL, "https://discord.com", "https://hooks.hyra.io") --Converts the discord part to using Hyra to proxy the request


server = nil 
service = nil

local PlaceName = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name -- Gets place name
local HTTPS = game:GetService("HttpService")

return function()
    service.Events.CommandRan:Connect(function(player, Data) -- Runs when a command is run

        local Level = nil
        local command = nil
        local success = nil

        for i,v in pairs(Data) do
            if i == "Success" then
                success = v
            end
            if i == "Message" then
                command = v
            end
            if type(v) == "table" then
                for e,n in pairs(v) do
                    if e == "Level" then
                        if n == 4 then 
                            Level = "Creator"
                        elseif n == 3 then
                            Level = "Owner"
                        elseif n == 2 then
                            Level = "Admin"
                        elseif n == 1 then
                            Level = "Mod"
                        else
                            Level = "Player"
                        end
                    end
                end
            end
        end

        local WebhookMessage = {
            ["username"] = "Adonis Admin Logs",
            ["avatar_url"] = "",
            ["content"] = "",
            ["embeds"] = {{
                ["title"] = "An Admin has used a Command!",
                ["description"] = "",
                ["type"] = "rich",
				["color"] = tonumber(0xFFFFDF),
                ["fields"] = {
                    {
                        ["name"] = "User",
                        ["value"] = tostring(player.Name),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Admin Level",
                        ["value"] = tostring(Level),
                        ["inline"] = true
                    },

                    {
                        ["name"] = "Command",
                        ["value"] = tostring(command),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Timestamp",
                        ["value"] = tostring(service.GetTime()),
                        ["inline"] = true
                    },
                }
            }
            }

        }
        WebhookMessage = HTTPS:JSONEncode(WebhookMessage)
        if success then
            HTTPS:PostAsync(WebhookURL, WebhookMessage)
        end
    end)
end