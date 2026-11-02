local module = function(Conch, Config)
    local Players = game:GetService("Players")
    Conch.register("setspeed", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {kind="argument",type="string",name="player"},
                   {kind="argument",type="number",name="speed"}
        end,
        callback = function(playerName, speed)
            local target
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Name:lower() == tostring(playerName):lower() then target = p break end
            end
            if not target then return false, "Joueur introuvable" end
            speed = math.clamp(tonumber(speed) or 16, 0, 500)
            local char = target.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = speed end
            target:SetAttribute("ForcedSpeed", speed)
            return "✅ Speed de " .. target.Name .. " → " .. speed
        end,
    })
end
return module
