-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HumanoidRootPart = script.Parent:WaitForChild("HumanoidRootPart")
local v1 = ReplicatedStorage.Assets.Billboards.Billboard_UI:Clone()

v1.Adornee = HumanoidRootPart
v1.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
