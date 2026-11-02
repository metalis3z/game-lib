-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local t1 = {}

return {
	WaitForAssetId = function(_: {[any]: any}, s1: string)
		while not t1[s1] do
			task.wait()
		end
	end,
	Start = function(_)
		task.spawn(function()
			for v8, v9 in Net:Invoke("EncryptedAssetsService/Load") do
				task.spawn(function()
					ContentProvider:RegisterSessionEncryptedAsset(v8, v9)
					t1[v8] = true
				end)
			end
		end)
	end
}
