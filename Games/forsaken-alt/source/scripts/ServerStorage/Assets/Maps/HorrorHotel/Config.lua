local v7 = {
    ["DisplayName"] = "joshman601 horror hotel",
    ["Description"] = "mashup of spooky guys or something",
	["Ambience"] = "rbxassetid://94471333771408",
    ["AmbienceProperties"] = {
        ["Volume"] = 1
    },
    ["Created"] = function(p1) --[[Function name: Created, line 14]]
        local v2 = p1.Map.Slowdown.Arms
        local v3 = require(game.ReplicatedStorage.Modules.Util):LoadAnimationFromID(v2, "rbxassetid://140558747821559")
        v3.Looped = true
        v3:Play(0)
        for _, v4 in pairs(v2:GetChildren()) do
            if v4.Name:find("ArmGrab") then
                v4.Touched:Connect(function(p5) --[[Anonymous function at line 26]]
                    local v6 = p5.Parent
                    if v6:FindFirstChild("Humanoid") then
                        require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(v6, "Slowness", {
                            ["Level"] = 3,
                            ["Duration"] = 2
                        })
                    end
                end)
            end
        end
    end
}
return v7