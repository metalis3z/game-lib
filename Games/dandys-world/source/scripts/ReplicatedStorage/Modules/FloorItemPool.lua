--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMgBmlwYWlycwVJdGVtcw5GaW5kRmlyc3RDaGlsZAtJdGVtTW9kdWxlcwR3YXJuS1tGbG9vckl0ZW1Qb29sXSBSZXBsaWNhdGVkU3RvcmFnZS5JdGVtTW9kdWxlcyBtaXNzaW5nOyByZXR1cm5pbmcgZW1wdHkgcG9vbAtHZXRDaGlsZHJlbgxNb2R1bGVTY3JpcHQDSXNBBXBjYWxsB3JlcXVpcmUEdHlwZQV0YWJsZSJbRmxvb3JJdGVtUG9vbF0gRmFpbGVkIHRvIHJlcXVpcmUgBE5hbWUCOiAIdG9zdHJpbmcGUmFyaXR5EFtGbG9vckl0ZW1Qb29sXSAVIGhhcyB1bmtub3duIFJhcml0eTogF1tGbG9vckl0ZW1Qb29sXSBNb2R1bGUgPSBoYXMgbm8gbWF0Y2hpbmcgVG9vbCBpbiBSZXBsaWNhdGVkU3RvcmFnZS5JdGVtcyDigJQgc2tpcHBpbmcGaW5zZXJ0BUJ1aWxkBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQZDb21tb24IVW5jb21tb24EUmFyZQhWZXJ5UmFyZQlVbHRyYVJhcmUAAhIBAgAAAIEB/wEAAAAAAACkAgEAAAAAQPsDAACfAgIEUQIDAP8HAAAAAAAAagcBBm4C/P8CAACA+wIBAG8EAgC8AgIDAwAAAJ8CAwL7AwEAbwUEALwDAwMDAAAAnwMDAisDBQCkBAYAAABQQG8FBwCfBAIBggECAKQEAQAAAABAvAUDaAgAAACfBQIAnwQABFEEWwBvCwkAvAkI/goAAACfCQMCDglWAKQJDAAAALBApAoOAAAA0EBSCwgAnwkDAw4JBwC7KAoDUgwKAKQLEAAAAPBAnwsCAvALDwARAAAApAsGAAAAUEBvDRIATQ4IuhMAAABvDxQAuz8KA1IRCgCkEBYAAABQQZ8QAgJzDA0QnwsCAWUAOgBSCwAATQwIuhMAAABSDQoAnwsDAg4LNABNDAryFwAAAIcLAQwrCw8ApAsGAAAAUEBvDRgATQ4IuhMAAABvDxkATREK8hcAAAC7PxECpBAWAAAAUEGfEAICcwwNEJ8LAgFlACEADgIPAE0NCLoTAAAAvAsCAwMAAACfCwMCKwsJAKQLBgAAAFBAbw0aAE0OCLoTAAAAbw8bAHMMDQ+fCwIBZQARAE0NCvIXAAAAhwwBDeINHABNDgi6EwAAADAODboTAAAATQ4K8hcAAAAwDg3yFwAAAJ40DAMNAAAApAseAAB0EIGfCwMBbgSk/wIAAICCAQIAHwMBBAAAAEADAgMDAwQDBQQAAFBAAwYDBwMIAwkDCgQAALBAAwsEAADQQAMMBAAA8EADDQMOAw8DEAMRBAAAUEEDEgMTAxQDFQMWBQITFwMXBAB0EIEAExgBGAAAAQAAAAABAAD/AAQAAAAAAQAAAAABAQAAAAEDAAAAAAAAAQAAAAACAAAAAAABAAAAAAAAAAEAAAAAAAAAAAAAAAABAwAAAAAAAgAAAAEAAAAAAAAAAAAAAAAAAQMAAAAAAAABAAAAAAAAAAEDAAAAAAAAAAAAAAAAAAAAAOsAGBQAAAAABwAAAQIAGKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwL/AQAABQAAAG8CBABvAwUAbwQGAG8FBwBvBggAxQECBgEAAAD/AgEAAAAAAMADCQASAAEAEgAAADADAk8KAAAAggICAAsDGQQAAABAAxoDGwMcAx0DHgMfAyAGAAMYAQABAAEYAAwAAAAAAAIAAAAAAAAAAAIAAgAAAAAoAQAAAAAB4I05vU6X/GCetyrW1zKNwZCVLsnSSVO8

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = { "Common", "Uncommon", "Rare", "VeryRare", "UltraRare" }

return {
	Build = function(p1) --[[ Build | Line: 19 | Upvalues: t (copy), ReplicatedStorage (copy) ]]
		local t2 = {}

		for i, v in ipairs(t) do
			t2[v] = {}
		end

		local Items = ReplicatedStorage:FindFirstChild("Items")
		local ItemModules = ReplicatedStorage:FindFirstChild("ItemModules")

		if not ItemModules then
			warn("[FloorItemPool] ReplicatedStorage.ItemModules missing; returning empty pool")

			return t2
		end

		for i, v in ipairs(ItemModules:GetChildren()) do
			if v:IsA("ModuleScript") then
				local ok, result = pcall(require, v)

				if ok and type(result) == "table" then
					if p1(v.Name, result) then
						if t2[result.Rarity] then
							if Items and not Items:FindFirstChild(v.Name) then
								warn("[FloorItemPool] Module " .. v.Name .. " has no matching Tool in ReplicatedStorage.Items \226\128\148 skipping")

								continue
							end

							table.insert(t2[result.Rarity], {
								Name = v.Name,
								Rarity = result.Rarity
							})

							continue
						end

						warn("[FloorItemPool] " .. v.Name .. " has unknown Rarity: " .. tostring(result.Rarity))
					end

					continue
				end

				warn("[FloorItemPool] Failed to require " .. v.Name .. ": " .. tostring(result))
			end
		end

		return t2
	end
}