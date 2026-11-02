local module = function(Conch, Config)
    local SS  = game:GetService("ServerScriptService")
    local RS  = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local MS  = game:GetService("MessagingService")

    local TOPIC = "GlobalAutoSkipCraft_v1"
    local AUTO_SKIP_INTERVAL = 35

    -- Handler local: skip craft de tous les joueurs de CE serveur
    local function skipAllLocal()
        local Sync = require(RS.Packages.Synchronizer)
        local Net  = require(RS.Packages.Net)
        local CraftNow = Net:RemoteEvent("CraftingMachineService/CraftNow")
        local NS = require(SS.Services.NotificationService)
        local count = 0
        for _, player in ipairs(Players:GetPlayers()) do
            local ok, data = pcall(Sync.Get, Sync, player)
            if ok and data then
                local craftData = data:Get("CraftingMachine")
                if craftData and craftData.Rarity and craftData.FinishTime then
                    if workspace:GetServerTimeNow() < craftData.FinishTime then
                        craftData.FinishTime = workspace:GetServerTimeNow() - 1
                        data:Set("CraftingMachine", craftData)
                        CraftNow:FireClient(player, craftData.Rarity)
						NS.Notify(player, '<font color="#00BFFF">⏩ <b>badr & Zynna skip Craft auto!</b></font>', 4, RS.Sounds.Sfx.Success)
                        count += 1
                    end
                end
            end
        end
        return count
    end

    -- Subscribe pour recevoir les broadcasts des autres serveurs
    if not _G._sub_autoskipcraftglobal then
        _G._sub_autoskipcraftglobal = true
        pcall(function()
            MS:SubscribeAsync(TOPIC, function(msg)
                local data = msg.Data
                if type(data) ~= "table" then return end
                if data.jobId == game.JobId then return end -- ignorer nos propres messages
                if data.action == "skip" then
                    skipAllLocal()
                elseif data.action == "stop" then
                    _G._autoskipcraftglobal_enabled = false
                end
            end)
        end)
    end

    Conch.register("autoskipcraftglobal", {
        description = "Auto skip le craft sur tous les serveurs toutes les 35s. On/Off",
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {
                kind = "argument",
                type = "string",
                name = "State",
                description = "on ou off",
            }
        end,
        callback = function(state)
            state = string.lower(tostring(state or ""))

            if state == "on" then
                if _G._autoskipcraftglobal_enabled then
                    return "⚠️ Auto skip craft global déjà actif!"
                end
                _G._autoskipcraftglobal_enabled = true

                task.spawn(function()
                    while _G._autoskipcraftglobal_enabled do
                        -- Skip local
                        local count = skipAllLocal()
                        -- Broadcast aux autres serveurs
                        pcall(MS.PublishAsync, MS, TOPIC, {
                            jobId  = game.JobId,
                            action = "skip",
                        })
                        print("[AutoSkipCraftGlobal] Skip global - "..count.." joueurs locaux")
                        task.wait(AUTO_SKIP_INTERVAL)
                    end
                end)

                return "✅ Auto skip craft global ACTIVÉ (toutes les "..AUTO_SKIP_INTERVAL.."s)"

            elseif state == "off" then
                if not _G._autoskipcraftglobal_enabled then
                    return "⚠️ Auto skip craft global déjà désactivé!"
                end
                _G._autoskipcraftglobal_enabled = false
                -- Broadcaster le stop aux autres serveurs
                pcall(MS.PublishAsync, MS, TOPIC, {
                    jobId  = game.JobId,
                    action = "stop",
                })
                return "✅ Auto skip craft global DÉSACTIVÉ"

            else
                return "⚠️ Usage: autoskipcraftglobal on / off"
            end
        end,
    })
end

return module
