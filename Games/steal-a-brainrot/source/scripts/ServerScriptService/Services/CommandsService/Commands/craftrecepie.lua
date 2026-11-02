local module = function(Conch, Config)
    local RS = game:GetService("ReplicatedStorage")
    local SS = game:GetService("ServerScriptService")
    local SStorage = game:GetService("ServerStorage")
    local Players = game:GetService("Players")
    local MS = game:GetService("MessagingService")

    local Net = require(RS.Packages.Net)
    local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
    local CraftingMachineService = require(SS.Services.CraftingMachineService)
    local AnimalsDB = require(RS.Datas.Animals)
    local RaritiesDB = require(RS.Datas.Rarities)

    local BRAINROT_GOD_COLOR = "#FF00DD"

    local function getRarityColorHex(rarity)
        local r = RaritiesDB[rarity]
        if r and r.Color then
            local c = r.Color
            return string.format("#%02X%02X%02X",
                math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
        end
        return "#00FF00"
    end

    local function applyRecipe(resultBrainrot, ingredients, limit)
        local resultData = AnimalsDB[resultBrainrot]
        if not resultData then return false, "Animal introuvable: '"..tostring(resultBrainrot).."'" end

        for i, ing in ipairs(ingredients) do
            if not AnimalsDB[ing] then
                return false, "Ingrédient "..i.." introuvable: '"..tostring(ing).."'"
            end
        end

        local rarity = resultData.Rarity
        if not rarity then return false, "Rareté manquante pour '"..resultBrainrot.."'" end

        local ok, CraftingData = pcall(require, SStorage.Modules.CraftingData)
        if ok and CraftingData then
            if not CraftingData.Rarities[rarity] then
                CraftingData.Rarities[rarity] = { CraftTime = 900, Brainrots = {} }
            end
            local found = false
            for _, rec in ipairs(CraftingData.Rarities[rarity].Brainrots) do
                if rec.Name == resultBrainrot then
                    rec.Recipe = ingredients
                    rec.Cost = rec.Cost or 1000000
                    rec.Limit = limit
                    rec.CraftedCount = 0
                    found = true; break
                end
            end
            if not found then
                table.insert(CraftingData.Rarities[rarity].Brainrots, {
                    Name = resultBrainrot, Recipe = ingredients,
                    Cost = 1000000, Limit = limit, CraftedCount = 0
                })
            end
        end

        local craftTime = (ok and CraftingData and CraftingData.Rarities[rarity] and CraftingData.Rarities[rarity].CraftTime) or 900
        local limitedStock = (type(limit) == "number" and limit > 0) and limit or nil

        CraftingMachineService.setCustomRecipe(rarity, {
            Name = resultBrainrot,
            Recipe = ingredients,
            Cost = 1000000,
            CraftTime = craftTime,
        }, limitedStock)

        local colorHex = getRarityColorHex(rarity)
        local limitText = limitedStock
            and " <font color='"..BRAINROT_GOD_COLOR.."'>(LIMITED: "..limitedStock.." uses)</font>"
            or ""
        local msg = "<font color='"..colorHex.."'><b>"..resultBrainrot.."</b></font> ajouté au Craft Machine!"..limitText

        for _, p in ipairs(Players:GetPlayers()) do
            pcall(NotificationEvent.FireClient, NotificationEvent, p, msg, 5, "Sounds.Sfx.Success")
        end

        return true, "✅ Recette '"..resultBrainrot.."' ("..rarity..") | Ingrédients: "
            ..table.concat(ingredients, ", ")
            ..(limitedStock and " | LIMITÉ: "..limitedStock.." uses" or " | Illimité")
    end

    -- Broadcast global
    if not _G._sub_craftrecepie then
        _G._sub_craftrecepie = true
        pcall(function()
            MS:SubscribeAsync("CraftRecepie_v1", function(msg)
                local d = msg.Data
                if type(d) ~= "table" then return end
                if d.jobId == game.JobId then return end
                applyRecipe(d.result, d.ingredients, d.limit)
            end)
        end)
    end

    Conch.register("craftrecepie", {
        description = "Ajoute une recette au Craft Machine avec quantité limitée optionnelle.",
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return
                { kind="argument", type="Brainrot", name="Résultat" },
                { kind="argument", type="Brainrot", name="Ingrédient 1" },
                { kind="argument", type="Brainrot", name="Ingrédient 2", optional=true },
                { kind="argument", type="Brainrot", name="Ingrédient 3", optional=true },
                { kind="argument", type="Brainrot", name="Ingrédient 4", optional=true },
                { kind="argument", type="number",   name="Limite (0 = illimité)", optional=true }
        end,
        callback = function(result, ing1, ing2, ing3, ing4, limit)
            if not result or result == "" then return "❌ Résultat requis" end
            if not ing1  or ing1  == "" then return "❌ Ingrédient 1 requis" end

            local ingredients = {ing1}
            if ing2 and ing2 ~= "" then table.insert(ingredients, ing2) end
            if ing3 and ing3 ~= "" then table.insert(ingredients, ing3) end
            if ing4 and ing4 ~= "" then table.insert(ingredients, ing4) end

            local limitedStock = (type(limit) == "number" and limit > 0) and limit or nil

            local ok, msg = applyRecipe(result, ingredients, limitedStock)
            if not ok then return "❌ "..msg end

            -- Broadcaster aux autres serveurs
            pcall(MS.PublishAsync, MS, "CraftRecepie_v1", {
                jobId = game.JobId,
                result = result,
                ingredients = ingredients,
                limit = limitedStock,
            })

            return msg
        end,
    })
end

return module
