-- IMPORTANT: Replace GROUP_ID with your actual group ID
local GROUP_ID = 0 -- <-- CHANGE THIS TO YOUR GROUP ID

local button = script.Parent

button.MouseButton1Click:Connect(function()
	if GROUP_ID > 0 then
		-- Open the group page in the Roblox browser
		local MarketPlaceService = game:GetService("MarketplaceService")
		-- Use the generic approach to open a group page
		game:GetService("GuiService"):OpenBrowserWindow("https://www.roblox.com/groups/" .. tostring(GROUP_ID))
	end
end)
