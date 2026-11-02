


local v1 = script.Parent
local v_u_2 = v1:WaitForChild("Spin")
local v_u_3 = v1:WaitForChild("Text")
task.spawn(function()
    while true do
        v_u_2.Rotation = (v_u_2.Rotation + 180 * task.wait()) % 360
    end
end)
task.spawn(function()
    local v4 = {
        "",
        ".",
        "..",
        "..."
    }
    local v5 = 1
    while true do
        v_u_3.Text = "Generating AI" .. v4[v5]
        v5 = v5 % #v4 + 1
        task.wait(0.4)
    end
end)