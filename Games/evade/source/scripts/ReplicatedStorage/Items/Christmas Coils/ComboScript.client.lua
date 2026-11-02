-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v1 = script.Parent
v1.Equipped:Connect(function()
    workspace.Gravity = 29.429999999999996
end)
v1.Unequipped:Connect(function()
    workspace.Gravity = 196.2
end)