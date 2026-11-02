local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")

	-- NOT: ReplicatedStorage içinde "FlashbangEvent" adında bir RemoteEvent olmalı.
	-- Eğer yoksa kodun başına oluşturma satırı ekleyebiliriz.
	local FlashbangEvent = ReplicatedStorage:FindFirstChild("FlashbangEvent") or Instance.new("RemoteEvent", ReplicatedStorage)
	FlashbangEvent.Name = "FlashbangEvent"

	Conch.register("flashbang", {
		permissions = { Config.RequiredRole or "admin" }, -- Yetki seviyesi

		arguments = function()
			return {
				kind = "argument",
				type = "player", -- Hedef oyuncu
				name = "Target",
			},
			{
				kind = "argument",
				type = "number",
				name = "Duration", -- Ne kadar süre beyaz kalsın?
				optional = true
			}
		end,

		callback = function(targetPlayer, duration)
			if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
				return false, "Geçersiz oyuncu."
			end

			local flashDuration = tonumber(duration) or 3 -- Varsayılan 3 saniye

			-- Client tarafındaki efekti tetiklemek için RemoteEvent gönderiyoruz
			FlashbangEvent:FireClient(targetPlayer, flashDuration)

			return targetPlayer.Name .. " başarıyla flashbanglendi! 🕶️"
		end
	})
end

return module