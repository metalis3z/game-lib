

local v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("HDAdminSetup", 999)):GetMain(true)
local _ = script.Parent.HDAdminStarterCharacter
local _ = game:GetService("Players").LocalPlayer
v1:Initialize("Client")
v1:GetModule("GUIs"):UpdateFont()
v1:GetModule("PageAbout"):UpdateRankName()
v1:GetModule("PageAbout"):UpdateProfileIcon()
v1:GetModule("PageAbout"):CreateUpdates()
v1:GetModule("PageAbout"):UpdateContributors()
v1:GetModule("PageAbout"):CreateCredits()
v1:GetModule("PageCommands"):CreateCommands()
v1:GetModule("PageCommands"):CreateMorphs()
v1:GetModule("PageCommands"):CreateDetails()
v1:GetModule("PageModeration"):SetupRanks()