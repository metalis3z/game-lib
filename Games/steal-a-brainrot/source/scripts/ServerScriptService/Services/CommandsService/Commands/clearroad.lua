local module = function(Conch, Config)
    local CollectionService = game:GetService("CollectionService")

    Conch.register("clearroad", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function() return nil end,
        callback = function()
            local movingAnimals = workspace:FindFirstChild("MovingAnimals")
            if not movingAnimals then return false, "MovingAnimals introuvable" end
            local count = #movingAnimals:GetChildren()
            for _, a in ipairs(movingAnimals:GetChildren()) do
                pcall(function() a:Destroy() end)
            end
            return "✅ " .. count .. " brainrot(s) supprimé(s) de la route"
        end,
    })
end
return module
