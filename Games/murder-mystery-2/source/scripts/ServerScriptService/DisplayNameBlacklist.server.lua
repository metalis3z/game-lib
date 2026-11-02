local BlacklistedDisplayNames = {
	"ChampulseV0";
}
local SimilarCharacters = require(script.SimilarCharacters)

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(plr)
	-- Only check if it is different
	if plr.DisplayName ~= plr.Name then
		-- Normalize Name
		local normalizedName = plr.DisplayName
		for auth, fakes in pairs(SimilarCharacters) do
			for _, fake in pairs(fakes) do
				if string.match(fake, "%w") then
					continue
				end
				normalizedName = string.gsub(normalizedName, fake, auth)
			end
		end
		-- Convert capitals in the name to lower case
		normalizedName = string.lower(normalizedName)

		for _, blacklistedName in pairs(BlacklistedDisplayNames) do
			if (string.lower(blacklistedName) == normalizedName) then
				plr:Kick(string.format("Your Display Username Is not Tolerated. Please Remove it and Feel free to Join Back."))
			end
		end
	end
end)

-- ChampulseV0