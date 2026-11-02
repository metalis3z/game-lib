--!strict


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local frontend = modules.Parent.Controllers.UI
local Segmenter = require(frontend.Util.Cmdbar.Segmenter)
local Resolver = {}


-- TYPES
type Scan = Segmenter.Scan
type Item = Segmenter.Item
export type ActiveField = {
	kind: "command" | "arg" | "capsuleArg",
	argIndex: number?,
	query: string,
	replaceStart: number,
	replaceFinish: number,
}


-- LOCAL FUNCTIONS
local function caretInSpan(caret: number, start: number, finish: number): boolean
	return caret >= start and caret <= finish + 1
end


-- FUNCTIONS
function Resolver.resolve(scan: Scan, cursor: number, text: string): ActiveField
	local caret = if cursor < 1 then #text + 1 else math.clamp(cursor, 1, #text + 1)
	local clampQuery = function(start: number): string
		local stop = caret - 1
		if stop < start then
			return ""
		end
		return text:sub(start, stop)
	end

	if scan.commandText == nil then
		return {
			kind = "command",
			query = "",
			replaceStart = caret,
			replaceFinish = caret - 1,
		}
	end

	for _, token in scan.tokens do
		if token.kind == "command" and caretInSpan(caret, token.start, token.finish) then
			-- A command token can carry a capsule (;message(#ffffff) all). Inside it
			-- the active field is the command's capsule arg, before it the name
			local openRelative = token.text:find("(", 1, true)
			if openRelative then
				local openPos = token.start + openRelative - 1
				if caret > openPos then
					-- Comma separated capsule slots map to the command's capsule args
					-- in order (;message(yellow,0) has colour then duration)
					local closeRelative = token.text:find(")", openRelative + 1, true)
					local interiorFinish = if closeRelative then token.start + closeRelative - 2 else token.finish
					local interiorText = text:sub(openPos + 1, math.max(interiorFinish, openPos))
					local activeItem: Item? = nil
					local activeIndex = 1
					for itemIndex, capsuleItem in Segmenter.listItems(interiorText, openPos + 1) do
						if caretInSpan(caret, capsuleItem.start, capsuleItem.finish) then
							activeItem = capsuleItem
							activeIndex = itemIndex
							break
						end
					end
					local item = activeItem or { text = interiorText, start = openPos + 1, finish = math.max(interiorFinish, openPos) }
					return {
						kind = "capsuleArg",
						argIndex = activeIndex,
						query = clampQuery(item.start),
						replaceStart = item.start,
						replaceFinish = item.finish,
					}
				end
				return {
					kind = "command",
					query = clampQuery(token.start),
					replaceStart = token.start,
					replaceFinish = openPos - 1,
				}
			end
			return {
				kind = "command",
				query = clampQuery(token.start),
				replaceStart = token.start,
				replaceFinish = math.max(token.finish, token.start - 1),
			}
		end
	end

	for _, token in scan.tokens do
		if token.kind == "arg" and caretInSpan(caret, token.start, token.finish) then
			local activeItem: Item? = nil
			for _, item in Segmenter.listItems(token.text, token.start) do
				if caretInSpan(caret, item.start, item.finish) then
					activeItem = item
					break
				end
			end
			local item = activeItem or { text = token.text, start = token.start, finish = token.finish }
			return {
				kind = "arg",
				argIndex = token.argIndex,
				query = clampQuery(item.start),
				replaceStart = item.start,
				replaceFinish = item.finish,
			}
		end
	end

	return {
		kind = "arg",
		argIndex = scan.argCount + 1,
		query = "",
		replaceStart = caret,
		replaceFinish = caret - 1,
	}
end

function Resolver.apply(text: string, field: ActiveField, insert: string, advance: boolean?, caretBack: number?): (string, number)
	local doAdvance = advance ~= false
	local pullBack = caretBack or 0
	local before = text:sub(1, field.replaceStart - 1)
	local after = text:sub(field.replaceFinish + 1)
	local needsSpace = doAdvance and after:sub(1, 1) ~= " "
	local suffix = if needsSpace then " " else ""
	local newText = before .. insert .. suffix .. after
	local newCursor = #before + #insert + #suffix + 1 - pullBack
	return newText, newCursor
end


return Resolver
