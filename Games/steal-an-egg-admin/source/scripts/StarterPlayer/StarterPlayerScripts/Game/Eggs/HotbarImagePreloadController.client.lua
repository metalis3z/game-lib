-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HotbarImagePreloadController = require(ReplicatedStorage.Client.HotbarImagePreloadController)
local v1 = require(ReplicatedStorage.Packages.Trove).new()
v1:Add(HotbarImagePreloadController.new()):Start()
v1:AttachToInstance(script)
