-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {
    script.Parent.Static1,
    script.Parent.Static2,
    script.Parent.Static3,
    script.Parent.Static4
}
for v_u_2, v_u_3 in ipairs(v1) do
    task.spawn(function()
        task.wait(v_u_2 * 0.01)
        while true do
            v_u_3.Rotation = math.random(0, 1) * 180
            task.wait(math.random() * 0.03 + 0.02)
        end
    end)
end
