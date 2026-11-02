-- EventScheduleServer : events automatiques calés sur l'HORLOGE (comme le Huge Egg) : à chaque :00 et :30
-- (16h00, 16h30, 17h00...), l'event du créneau démarre pour 10 minutes, puis 20 minutes de pause.
-- Tous les serveurs calculent la même chose à partir de l'heure : un serveur qui démarre au milieu d'un event le lance
-- tout de suite pour le temps qui reste. Rien à faire quand personne n'est connecté : l'horloge continue de tourner.
-- Le HUD (EventStack, au-dessus du Huge Egg) lit : ReplicatedStorage.NextEventName / NextEventAt / NextEventIcon,
-- et ScheduledEventName / ScheduledEventEnd pendant l'event.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EVERY = 30 * 60 -- un event toutes les 30 minutes, à :00 et :30
local LENGTH = 10 * 60 -- il dure 10 minutes
-- events à tour de rôle (un par créneau). Ajoute "Ufo", "BloodMoon", "Galaxy" ou "Hacker" pour les faire tourner.
local SCHEDULE = {"Disco"}
local ICONS = {Disco = "Disco", Ufo = "Alien", BloodMoon = "Blood", Galaxy = "Galaxy", Hacker = "Hacked"} -- mutation dont l'icône représente l'event
local TITLES = {Disco = "DISCO", Ufo = "UFO", BloodMoon = "BLOOD MOON", Galaxy = "GALAXY", Hacker = "HACKER"}

local runSky = game:GetService("ServerStorage"):WaitForChild("GameBindables"):WaitForChild("RunSkyEvent")

local function eventOf(slot) return SCHEDULE[slot % #SCHEDULE + 1] end

local startedSlot = nil
while true do
	local now = workspace:GetServerTimeNow()
	local slot = math.floor(now / EVERY)
	local slotStart = slot * EVERY
	local current = eventOf(slot)
	local running = now < slotStart + LENGTH
	-- lancement du créneau en cours (une seule fois par créneau)
	if running and startedSlot ~= slot then
		startedSlot = slot
		local left = math.floor(slotStart + LENGTH - now)
		if left >= 10 then runSky:Fire(current, "start", left) end
	end
	ReplicatedStorage:SetAttribute("ScheduledEventName", running and current or nil)
	ReplicatedStorage:SetAttribute("ScheduledEventEnd", running and (slotStart + LENGTH) or nil)
	ReplicatedStorage:SetAttribute("ScheduledEventTitle", running and TITLES[current] or nil)
	-- le prochain
	local nextName = eventOf(slot + 1)
	ReplicatedStorage:SetAttribute("NextEventName", TITLES[nextName] or string.upper(nextName))
	ReplicatedStorage:SetAttribute("NextEventIcon", ICONS[nextName])
	ReplicatedStorage:SetAttribute("NextEventAt", slotStart + EVERY)
	ReplicatedStorage:SetAttribute("ScheduledEventIcon", running and ICONS[current] or nil)
	task.wait(1)
end
