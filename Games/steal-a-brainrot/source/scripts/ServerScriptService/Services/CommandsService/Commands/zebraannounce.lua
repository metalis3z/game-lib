local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local MSG_TYPE = "ZebraAnnounce"

-- Enregistrer le handler via MessagingHub
local function registerHandler()
    if not _G.MessagingHub then return end
    
    _G.MessagingHub.Register(MSG_TYPE, function(data)
        if not data or not data.Text then return end
        for _, p in ipairs(Players:GetPlayers()) do
            NotificationEvent:FireClient(p, string.format("<zebra>%s</zebra>", data.Text), 5, nil, "Top")
        end
    end)
end

-- Attendre que MessagingHub soit prêt
task.spawn(function()
    while not _G.MessagingHub do
        task.wait(0.5)
    end
    registerHandler()
end)

local module = function(_, Config)
    Conch.register("zebraannounce", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {kind="argument",type="string",name="text"},
                   {kind="argument",type="string",name="mode",optional=true,typeHint="local|global"}
        end,
        callback = function(text, mode)
            if not text or text == "" then return "Texte requis" end
            local gradientText = string.format("<zebra>%s</zebra>", text)
            for _, p in ipairs(Players:GetPlayers()) do
                NotificationEvent:FireClient(p, gradientText, 5, nil, "Top")
            end
            if mode == "global" then
                if _G.MessagingHub then
                    _G.MessagingHub.Publish(MSG_TYPE, {Text=text})
                end
                return "zebra announce global : " .. text
            end
            return "zebra announce local : " .. text
        end,
    })
end
return module
