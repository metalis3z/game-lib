--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  With Script + GUI
  Discord: https://discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Velocity Script Decompiler
local v1 = game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(3, Enum.EasingStyle.Linear), {
    ["Position"] = UDim2.new(0.5, 32, 0.5, 0)
})
while true do
    script.Parent.Position = UDim2.new(0.5, 0, 0.5, 0)
    v1:Play()
    v1.Completed:Wait()
end