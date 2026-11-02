-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local Avalog = require(script.Parent.Parent.Avalog)
local Config = require(script.Parent.Config)
local TopbarPlus = require(script.Parent.Parent.Avalog.Packages.TopbarPlus)

if not Avalog.Started then
    Avalog.Config:Update(Config)
    Avalog:Start()
end
local v1 = TopbarPlus.new():setImage("rbxassetid://109049301067448"):setLeft():setImageScale(0.55)
v1.toggled:Connect(function() -- line 10 | captures: Avalog
    Avalog:ToggleOpen()
end)

local function refresh() -- line 11 | captures: Players, v1
    v1:setEnabled(Players.LocalPlayer:GetAttribute("AvalogTopbarHidden") ~= true)
end

Players.LocalPlayer:GetAttributeChangedSignal("AvalogTopbarHidden"):Connect(refresh)
v1:setEnabled(Players.LocalPlayer:GetAttribute("AvalogTopbarHidden") ~= true)
