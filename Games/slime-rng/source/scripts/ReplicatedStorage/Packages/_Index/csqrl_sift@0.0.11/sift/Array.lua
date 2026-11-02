-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Array, time of decompilation: Sun May  3 10:09:48 2026 ]]
local t1 = {
	at = require(script.at),
	concat = require(script.concat),
	concatDeep = require(script.concatDeep),
	copy = require(script.copy),
	copyDeep = require(script.copyDeep),
	count = require(script.count),
	create = require(script.create),
	dedupe = require(script.dedupe),
	difference = require(script.difference),
	differenceSymmetric = require(script.differenceSymmetric),
	equals = require(script.equals),
	equalsDeep = require(script.equalsDeep),
	every = require(script.every),
	filter = require(script.filter),
	find = require(script.find),
	findLast = require(script.findLast),
	findWhere = require(script.findWhere),
	findWhereLast = require(script.findWhereLast),
	first = require(script.first),
	flatten = require(script.flatten),
	freeze = require(script.freeze),
	freezeDeep = require(script.freezeDeep),
	includes = require(script.includes),
	insert = require(script.insert),
	is = require(script.is),
	last = require(script.last),
	map = require(script.map),
	pop = require(script.pop),
	push = require(script.push),
	reduce = require(script.reduce),
	reduceRight = require(script.reduceRight),
	removeIndex = require(script.removeIndex),
	removeIndices = require(script.removeIndices),
	removeValue = require(script.removeValue),
	removeValues = require(script.removeValues),
	reverse = require(script.reverse),
	set = require(script.set),
	shift = require(script.shift),
	shuffle = require(script.shuffle),
	slice = require(script.slice),
	some = require(script.some),
	sort = require(script.sort),
	splice = require(script.splice),
	toSet = require(script.toSet),
	unshift = require(script.unshift),
	update = require(script.update),
	zip = require(script.zip),
	zipAll = require(script.zipAll)
}

t1.join = t1.concat
t1.merge = t1.concat
t1.joinDeep = t1.concatDeep
t1.mergeDeep = t1.concatDeep
t1.append = t1.push
t1.prepend = t1.unshift
t1.indexOf = t1.find
t1.has = t1.includes
t1.contains = t1.includes
t1.isArray = t1.is

return t1
