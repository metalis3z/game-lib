-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: src, time of decompilation: Sun May  3 10:10:41 2026 ]]
local atom = require(script.atom)
local computed = require(script.computed)
local effect = require(script.effect)
local mapped = require(script.mapped)
local observe = require(script.observe)
local store = require(script.store)
local subscribe = require(script.subscribe)

require(script.types)

return {
	atom = atom,
	computed = computed,
	effect = effect,
	mapped = mapped,
	observe = observe,
	subscribe = subscribe,
	batch = store.batch,
	capture = store.capture,
	isAtom = store.isAtom,
	notify = store.notify,
	peek = store.peek
}
