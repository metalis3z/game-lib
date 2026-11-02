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
-- CQMVBXBhaXJzDkdldERlc2NlbmRhbnRzCE1lc2hQYXJ0A0lzQRhyYnhhc3NldGlkOi8vMTc2NzYwOTcyNDYJVGV4dHVyZUlEDlJvcGVDb25zdHJhaW50CkJyaWNrQ29sb3IDbmV3DFJlYWxseSBibGFjawVDb2xvcgZDb25maWcMV2FpdEZvckNoaWxkC0h1cnRUZXh0dXJlGHJieGFzc2V0aWQ6Ly8xNzY3NjA5OTk0MQdUZXh0dXJlDU5vcm1hbFRleHR1cmUJQXBwbHlTa2luClVzZUFiaWxpdHkMVmludGFnZSBHb29iBE5hbWUAAwkBAAAAADCkAQEAAAAAQLwCAEcCAAAAnwICAJ8BAAQXARQAbwgDALwGBf4EAAAAnwYDAg4GBABvBgUAMAYFhAYAAABlAAsAbwgHALwGBf4EAAAAnwYDAg4GBgCkBgoAACSAgG8HCwCfBgICMAYFpAwAAABuAev/AgAAAG8DDQC8AQDTDgAAAJ8BAwJvBA8AvAIB0w4AAACfAgMCbwMQADADAk8RAAAAbwUSALwDAdMOAAAAnwMDAm8EBQAwBANPEQAAAIIAAQATAwEEAAAAQAMCAwMDBAMFAwYDBwMIAwkEACSAgAMKAwsDDAMNAw4DDwMQAxEABhIBGAAAAAAAAAABAAAAAAEAAAABAAAAAAEAAAAAAPwACAAAAAEAAAACAAACAAAAAgAAAQcAAAAACQEAAAAAHqQBAQAAAABAvAIARwIAAACfAgIAnwEABBcBFABvCAMAvAYF/gQAAACfBgMCDgYEAG8GBQAwBgWEBgAAAGUACwBvCAcAvAYF/gQAAACfBgMCDgYGAKQGCgAAJICAbwcLAJ8GAgIwBgWkDAAAAG4B6/8CAAAAggABAA0DAQQAAABAAwIDAwMEAwUDBgMHAwgDCQQAJICAAwoDCwAZEwEYAAAAAAAAAAEAAAAAAQAAAAEAAAAAAQAAAAAA/AAHGgAAAAACAAABAgANowAAAP8AAwAAAAAAbwEAADABALoBAAAAwAECADABAOkDAAAAwAEEADABALIFAAAAggACAAYDFAMVBgADEgYBAxMCAAEBAAEYAAAAAgAAAwAAEwAADAEAAAAAAmtyF5sZmCY2FKZxRXagK5wbagDvWbZ9mg==

-- https://lua.expert/
return {
	Name = "Vintage Goob",
	ApplySkin = function(p1) --[[ ApplySkin | Line: 6 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://17676097246"

				continue
			end

			if v:IsA("RopeConstraint") then
				v.Color = BrickColor.new("Really black")
			end
		end

		local Config = p1:WaitForChild("Config")

		Config:WaitForChild("HurtTexture").Texture = "rbxassetid://17676099941"
		Config:WaitForChild("NormalTexture").Texture = "rbxassetid://17676097246"
	end,
	UseAbility = function(p1) --[[ UseAbility | Line: 25 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("MeshPart") then
				v.TextureID = "rbxassetid://17676097246"

				continue
			end

			if v:IsA("RopeConstraint") then
				v.Color = BrickColor.new("Really black")
			end
		end
	end
}