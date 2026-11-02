local module = function(Conch, Config)
    local sss = game:GetService("ServerScriptService")
    local PlotService = require(sss.Services.PlotService)
    local Players = game:GetService("Players")

    Conch.register("nukebase", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {kind="argument",type="string",name="player",typeHint="Username"},
                   {kind="argument",type="string",name="action",optional=true,typeHint="nuke|restore|reset"}
        end,
        callback = function(playerName, action)
            action = action or "nuke"
            local target
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Name:lower() == playerName:lower() or p.DisplayName:lower() == playerName:lower() then
                    target = p break
                end
            end
            if not target then return false, "Joueur introuvable : " .. playerName end

            local plot = _G.playerPlots and _G.playerPlots[target.UserId]
            if not plot then return false, "Base introuvable pour " .. target.Name end

            if action == "reset" then
                pcall(function() PlotService.resetPlot(plot) end)
                return "✅ Base de " .. target.Name .. " reset !"
            elseif action == "restore" then
                return "❌ restore uniquement via l'admin panel"
            else
                for _, part in ipairs(plot:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local exp = Instance.new("Explosion")
                        exp.Position = part.Position
                        exp.BlastRadius = 6
                        exp.BlastPressure = 0
                        exp.DestroyJointRadiusPercent = 0
                        exp.Parent = workspace
                        part.Anchored = false
                        part.AssemblyLinearVelocity = Vector3.new(
                            math.random(-40,40), math.random(60,180), math.random(-40,40))
                    end
                end
                return "💥 Base de " .. target.Name .. " nukée !"
            end
        end,
    })
end
return module
