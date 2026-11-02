--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  With Script + GUI
  Discord: https://discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Velocity Script Decompiler
local v1 = script.OrbAnimation
local v2 = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(v1)
v2.Looped = true
v2:Play()