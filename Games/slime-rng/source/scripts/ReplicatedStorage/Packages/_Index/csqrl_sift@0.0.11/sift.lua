-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: sift, time of decompilation: Sun May  3 10:09:47 2026 ]]
require(script.Types)

local t1 = {
	Array = require(script.Array),
	Dictionary = require(script.Dictionary),
	Set = require(script.Set),
	None = require(script.None),
	Types = require(script.Types),
	equalObjects = require(script.Util.equalObjects),
	isEmpty = require(script.Util.isEmpty)
}

t1.List = t1.Array

return t1
