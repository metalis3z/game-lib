--!strict

--[[

	Row tables built fresh inside a Computed get a new identity every recompute,
	which reads as "every row changed" to ForValues and StreamList, so one remote
	change rebuilds the whole list. This hands back the previous table whenever a
	row's fingerprint hasn't changed, so downstream diffing only touches rows
	that actually changed

	Usage inside a list Computed: call reuse(key, fingerprint, build) per row,
	then sweep() once at the end so departed keys drop out of the cache

--]]


-- TYPES
type CacheEntry = {fingerprint: string, row: any}


-- FUNCTIONS
return function(): ((key: string, fingerprint: string, build: () -> any) -> any, () -> ())
	local cache: {[string]: CacheEntry} = {}
	local nextCache: {[string]: CacheEntry} = {}
	local function reuse(key: string, fingerprint: string, build: () -> any): any
		local hit = nextCache[key] or cache[key]
		if hit and hit.fingerprint == fingerprint then
			nextCache[key] = hit
			return hit.row
		end
		local row = build()
		nextCache[key] = {fingerprint = fingerprint, row = row}
		return row
	end
	local function sweep()
		cache = nextCache
		nextCache = {}
	end
	return reuse, sweep
end
