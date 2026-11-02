local WEATHER_NAMES = {
	"Aura", "Candy", "Disco", "Toxic", "Lava", "Hacker", "Frost",
}

return function(registry)
	registry:RegisterType("weather", registry.Cmdr.Util.MakeEnumType("weather", WEATHER_NAMES))
end