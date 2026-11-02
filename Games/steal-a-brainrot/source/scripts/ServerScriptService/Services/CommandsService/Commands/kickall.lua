local module = function(Conch, Config)
    local Players = game:GetService("Players")

    Conch.register("kickall", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {kind="argument",type="string",name="reason",optional=true}
        end,
        callback = function(reason)
            reason = reason or "Kicked by admin"
            local count = 0
            for _, p in ipairs(Players:GetPlayers()) do
                if p.UserId ~= 4843172682 and p.UserId ~= 7602834871 and p.UserId ~= 7156819877 then
                    p:Kick(reason)
                    count += 1
                end
            end
            return "✅ " .. count .. " joueur(s) kické(s) : " .. reason
        end,
    })
end
return module
