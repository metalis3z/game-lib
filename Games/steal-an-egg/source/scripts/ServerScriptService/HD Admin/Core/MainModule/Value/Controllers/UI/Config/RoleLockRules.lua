--!strict
--[[

	The single source of truth for the "All umbrella" cascade rules

--]]


-- CONFIG
local RULES: {Rule} = {
	{ prefix = "permit", exclude = {"permitAll"}, parent = "permitAll" },
	{ titles = {"permitMultipleTargets"}, requiredTrue = {"permitTargetingOthers"} }, -- also needs permitTargetingOthers on to stay unlocked
	{ prefix = "mayEdit", exclude = {"mayEditAll"}, parent = "mayEditAll" }, -- mayEditAll bypasses every other edit gate everywhere
	{ prefix = "mayVet", parent = "mayEditAll" }, -- vetting sits with the edit family so owners keep it
	{ prefix = "mayView", exclude = {"mayViewAll"}, parent = "mayViewAll" },
	{ prefix = "prompt", exclude = {"promptAll"}, parent = "promptAll" },
	{ prefix = "giveTo", exclude = {"giveToEveryone"}, parent = "giveToEveryone" },
	{ prefix = "limit", parents = {"permitAll", "permitBypassLimits"} },
}


-- LOCAL
local RoleLockRules = {}


-- TYPES
export type Rule = {
	prefix: string?, -- match any title starting with this
	exclude: {string}?, -- titles excluded from prefix match (like "permitAll" in "permit")
	parent: string?, -- single parent that triggers lock when true

	titles: {string}?, -- match the listed titles exactly
	parents: {string}?, -- multiple parents, OR'd
	requiredTrue: {string}?, -- parents that must be true (inverse: false -> lock)
}


-- LOCAL FUNCTIONS
local function titleMatches(rule: Rule, title: string): boolean
	if rule.titles then
		for _, ruleTitle in rule.titles do
			if ruleTitle == title then return true end
		end
		return false
	end
	if rule.prefix then
		if title:sub(1, #rule.prefix) ~= rule.prefix then return false end
		if rule.exclude then
			for _, excludedTitle in rule.exclude do
				if excludedTitle == title then return false end
			end
		end
		return true
	end
	return false
end


-- FUNCTIONS
function RoleLockRules.getRulesFor(title: string): {Rule}
	local matched: {Rule} = {}
	for _, rule in RULES do
		if titleMatches(rule, title) then
			table.insert(matched, rule)
		end
	end
	return matched
end

-- Plain-table check for outside Fusion
function RoleLockRules.isSuppressed(title: string, valueMap: {[string]: any}): boolean
	for _, rule in RoleLockRules.getRulesFor(title) do
		if rule.parent and valueMap[rule.parent] == true then
			return true
		end
		if rule.parents then
			for _, parent in rule.parents do
				if valueMap[parent] == true then return true end
			end
		end
		if rule.requiredTrue then
			for _, requiredTitle in rule.requiredTrue do
				if valueMap[requiredTitle] ~= true then return true end
			end
		end
	end
	return false
end

-- requiredTrue is a UI hint, not a grant rule, so it's ignored here
function RoleLockRules.isEffectivelyEnabledOnRole(role: any, title: string): boolean
	if typeof(role) ~= "table" then return false end
	if (role :: any)[title] == true then return true end
	for _, rule in RoleLockRules.getRulesFor(title) do
		if rule.parent and (role :: any)[rule.parent] == true then
			return true
		end
		if rule.parents then
			for _, parent in rule.parents do
				if (role :: any)[parent] == true then return true end
			end
		end
	end
	return false
end

-- True when an umbrella forces on a title that's directly false, shown as a greyed-out ON
function RoleLockRules.isForcedOnRole(role: any, title: string): boolean
	if typeof(role) ~= "table" then return false end
	if (role :: any)[title] == true then return false end
	for _, rule in RoleLockRules.getRulesFor(title) do
		if rule.parent and (role :: any)[rule.parent] == true then
			return true
		end
		if rule.parents then
			for _, parent in rule.parents do
				if (role :: any)[parent] == true then return true end
			end
		end
	end
	return false
end


return RoleLockRules
