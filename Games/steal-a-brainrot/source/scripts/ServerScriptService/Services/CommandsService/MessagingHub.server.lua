-- MessagingHub : UN seul SubscribeAsync pour toutes les commandes globales
local MessagingService = game:GetService("MessagingService")
local HUB_CHANNEL = "GYK_GLOBAL_HUB"
local handlers = {}

-- Queue rate-limitée : max 1 message toutes les 0.2s (~300/min, limite = 600/min)
local publishQueue = {}
local queueRunning = false
local function startQueue()
    if queueRunning then return end
    queueRunning = true
    task.spawn(function()
        while true do
            task.wait(0.2)
            if #publishQueue > 0 then
                local payload = table.remove(publishQueue, 1)
                local ok, err = pcall(MessagingService.PublishAsync, MessagingService, HUB_CHANNEL, payload)
                if not ok then warn("[MessagingHub] Publish error: " .. tostring(err)) end
            end
        end
    end)
end

_G.MessagingHub = {
    Register = function(msgType, callback)
        handlers[msgType] = callback
    end,
    Publish = function(msgType, data)
        if data ~= nil and typeof(data) ~= "table" then
            warn("[MessagingHub] data doit être une table, reçu: " .. typeof(data))
            return
        end
        data = data or {}
        data._type = msgType
        data._jobId = game.JobId
        startQueue()
        table.insert(publishQueue, data)
    end,
}

local ok, err = pcall(function()
    MessagingService:SubscribeAsync(HUB_CHANNEL, function(message)
        local data = message.Data
        if typeof(data) ~= "table" then return end
        local msgType = data._type
        if not msgType then return end
        local handler = handlers[msgType]
        if handler then task.spawn(handler, data) end
    end)
end)

if ok then
    print("[MessagingHub] ✅ Hub actif avec queue rate-limitée")
else
    warn("[MessagingHub] ❌ Erreur: " .. tostring(err))
end
