local Text = script.Parent:WaitForChild("Text")
task.spawn(function()
    local v2 = {
        "",
        ".",
        "..",
        "..."
    }
    local v3 = 1
    while true do
		Text.Text = "WAITING FOR PLAYER" .. v2[v3]
        v3 = v3 % #v2 + 1
        task.wait(0.4)
    end
end)