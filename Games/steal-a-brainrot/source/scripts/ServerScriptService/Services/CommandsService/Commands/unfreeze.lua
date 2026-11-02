local module = function(Conch, Config)
    local Players = game:GetService("Players")
    Conch.register("unfreeze", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {kind="argument",type="string",name="player"}
        end,
        callback = function(playerName)
            local target
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Name:lower() == tostring(playerName):lower() then target = p break end
            end
            if not target then return false, "Joueur introuvable" end
            local char = target.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = 35
                hum.JumpPower = 50
                target:SetAttribute("Frozen", false)
            end
            return "✅ " .. target.Name .. " est unfreeze"
        end,
    })
end
return module
