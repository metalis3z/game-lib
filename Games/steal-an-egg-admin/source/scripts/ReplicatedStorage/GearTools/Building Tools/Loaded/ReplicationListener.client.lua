-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent
local Parent_2 = Parent.Parent
local Value = Parent:WaitForChild("DescendantCount").Value
while true do
    if Value <= #Parent_2:GetDescendants() then
        break
    end
    wait(0.1)
end
Parent.Value = true
