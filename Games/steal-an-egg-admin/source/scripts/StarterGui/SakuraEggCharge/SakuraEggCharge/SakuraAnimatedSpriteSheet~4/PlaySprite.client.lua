-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent
local Cells = script:GetAttribute("Cells")
local FPS = script:GetAttribute("FPS")
while task.wait() do
    local v1 = Cells.Y - 1
    for v2 = 0, v1 do
        local v3 = Cells.X - 1
        for v4 = 0, v3 do
            Parent.ImageRectOffset = Vector2.new(Parent.ImageRectSize.X * v4, Parent.ImageRectSize.Y * v2)
            task.wait(1 / FPS)
        end
    end
end
