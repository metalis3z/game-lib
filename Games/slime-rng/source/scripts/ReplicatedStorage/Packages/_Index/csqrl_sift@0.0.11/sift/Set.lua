-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Set, time of decompilation: Sun May  3 10:10:21 2026 ]]
local t1 = {
	add = require(script.add),
	copy = require(script.copy),
	count = require(script.count),
	delete = require(script.delete),
	difference = require(script.difference),
	differenceSymmetric = require(script.differenceSymmetric),
	filter = require(script.filter),
	fromArray = require(script.fromArray),
	has = require(script.has),
	intersection = require(script.intersection),
	isSubset = require(script.isSubset),
	isSuperset = require(script.isSuperset),
	map = require(script.map),
	merge = require(script.merge),
	toArray = require(script.toArray)
}

t1.fromList = t1.fromArray
t1.join = t1.merge
t1.subtract = t1.delete
t1.union = t1.merge

return t1
