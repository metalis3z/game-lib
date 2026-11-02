local module = function(Conch, Config)
    local Players = game:GetService("Players")
    Conch.register("freeze", {
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
                hum.WalkSpeed = 0
                hum.JumpPower = 0
                target:SetAttribute("Frozen", true)
            end
            return "🧊 " .. target.Name .. " est frozen"
        end,
    })
end
return module
