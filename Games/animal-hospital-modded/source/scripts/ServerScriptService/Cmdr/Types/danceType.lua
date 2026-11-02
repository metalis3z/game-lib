local DANCE_NAMES = {
	"salute", "applaud", "tilt",
	"hello", "shrug", "stadium", "point2",
}

return function(registry)
	registry:RegisterType("dance", registry.Cmdr.Util.MakeEnumType("dance", DANCE_NAMES))
end