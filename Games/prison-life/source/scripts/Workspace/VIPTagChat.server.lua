local gamepassId = 18330994 -- ID of your gamepass
local service = game:GetService("MarketplaceService") --  Buy the gamepass  ( Dont delete  )
game.Players.PlayerAdded:Connect(function(player)
    if (service:UserOwnsGamePassAsync(player.UserId, gamepassId)) then -- If you buy the gamepass playing the game
        local tags = {
            {
                TagText = "VIP", -- Change this to your gamepass name or tag name!
                TagColor = Color3.fromRGB(0, 255, 255) -- Change this to your color tag!
            }
        }
        local ChatService = require(game:GetService("ServerScriptService"):WaitForChild("ChatServiceRunner").ChatService)
        local speaker = nil
        while speaker == nil do
            speaker = ChatService:GetSpeaker(player.Name)
            if speaker ~= nil then break end
            wait(0.01) -- Dont change this or ur game can crash!
        end
        speaker:SetExtraData("Tags",tags) -- Extra data  ( Extra data is roblox filtering  chat "#" this  is t h e color of   chat tags)
        speaker:SetExtraData("ChatColor",Color3.fromRGB(255, 255, 0)) -- Change this to  your color texts and tags!
    end
end)