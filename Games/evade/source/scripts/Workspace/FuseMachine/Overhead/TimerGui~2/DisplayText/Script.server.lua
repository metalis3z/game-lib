--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  With Script + GUI
  Discord: https://discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v1 = require(v_replicatedstorage.Shared.Updates)
local v2 = require(v_replicatedstorage.Utils.TimeUtils)
while true do
	script.Parent.Text = ("Gone in %*"):format((v2:E(v1.Methods.GetTimeLeft("Update-01/03/2026") or 0)))
	task.wait(1)
end