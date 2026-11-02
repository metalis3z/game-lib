--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  Includes: Script & GUI
  Discord: discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Velocity Script Decompiler
local v_u_1 = script.Parent:WaitForChild("Text")
task.spawn(function()
    -- upvalues: (copy) v_u_1
    local v2 = {
        "",
        ".",
        "..",
        "..."
    }
    local v3 = 1
    while true do
        v_u_1.Text = "WAITING FOR PLAYER" .. v2[v3]
        v3 = v3 % #v2 + 1
        task.wait(0.4)
    end
end)