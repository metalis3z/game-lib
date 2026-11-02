local module = function(Conch, Config)
    local sss = game:GetService("ServerScriptService")
    local rs = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")

    Conch.register("givemoney", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {kind="argument",type="string",name="player"},
                   {kind="argument",type="number",name="amount"}
        end,
        callback = function(playerName, amount)
            local target
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Name:lower() == tostring(playerName):lower() then target = p break end
            end
            if not target then return false, "Joueur introuvable" end
            amount = tonumber(amount)
            if not amount then return false, "Montant invalide" end
            local ok, err = pcall(function()
                local MoneyService = require(sss.Services.MoneyService)
                MoneyService:Add(target, amount)
            end)
            if ok then return "✅ +" .. amount .. "$ donné à " .. target.Name
            else return false, "Erreur : " .. tostring(err) end
        end,
    })
end
return module
