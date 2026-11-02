---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = script.Parent.AnimationController.FlagWind
local v2 = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(v1)
v2.Looped = true
v2:Play()
v2:AdjustSpeed(0.9)
