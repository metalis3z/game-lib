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
-- CQMKFVByb21wdFByb2R1Y3RQdXJjaGFzZQRnYW1lEk1hcmtldHBsYWNlU2VydmljZQpHZXRTZXJ2aWNlB1BsYXllcnMLTG9jYWxQbGF5ZXIGc2NyaXB0BlBhcmVudAlBY3RpdmF0ZWQHQ29ubmVjdAACBAACAAAAB/sAAAD7AgEAbwMAALwAAGkBAAAAnwAEAYIAAQACAgAAwBEJaNxBAwEACAABGAAAAAAAAAEJAAAAAAYAAAECAByjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCTQEBMQUAAACkAgcAAABgQE0CAiQIAAAATQMCHgkAAADABQoAEgAAABIAAQC8AwPHCwAAAJ8DAwGCAAEADAMCBAAAAEADAwMEAwUDBgMHBAAAYEADCAMJBgADCgEAAQABGAAAAAAAAAABAAAAAAAAAAQAAAACAAAAAAAAAAIBAAAAAAE0thbyRin4ohKCADNLZOOxRK4BhgZyfPM=

-- https://lua.expert/
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = game:GetService("Players").LocalPlayer

script.Parent.Activated:Connect(function() --[[ Line: 8 | Upvalues: MarketplaceService (copy), LocalPlayer (copy) ]]
	MarketplaceService:PromptProductPurchase(LocalPlayer, 1906320455)
end)