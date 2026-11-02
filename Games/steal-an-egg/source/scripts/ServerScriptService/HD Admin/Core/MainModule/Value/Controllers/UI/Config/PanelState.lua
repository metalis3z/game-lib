--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local PanelState = {}
PanelState.__index = PanelState


-- CONSTRUCTOR
function PanelState.new(scope: Fusion.Scope)
	local self = {
		page = scope:Value("Menu") :: Fusion.Value<string>,
		pageHistory = scope:Value({ "Menu" }) :: Fusion.Value<{ string }>,
		prevPage = scope:Value(nil :: string?) :: Fusion.Value<string?>,
		navDirection = scope:Value(1) :: Fusion.Value<number>,
	}
	self.canGoBack = scope:Computed(function(use)
		return #use(self.pageHistory) > 1
	end)
	setmetatable(self, PanelState)
	return self
end


-- CLASS
export type Class = typeof(PanelState.new(...))


-- METHODS
function PanelState.toPage(self: Class, id: string)
	local hist = Fusion.peek(self.pageHistory)
	if hist[#hist] == id then
		return
	end
	local newHist = table.clone(hist)
	table.insert(newHist, id)
	self.prevPage:set(Fusion.peek(self.page))
	self.navDirection:set(1)
	self.pageHistory:set(newHist)
	self.page:set(id)
	-- Clear prevPage after spring settles so the old slide hides
	task.delay(0.6, function()
		if Fusion.peek(self.page) == id then
			self.prevPage:set(nil)
		end
	end)
end

function PanelState.goBack(self: Class)
	local hist = Fusion.peek(self.pageHistory)
	if #hist <= 1 then
		return
	end
	local newHist = table.clone(hist)
	table.remove(newHist, #newHist)
	self.prevPage:set(Fusion.peek(self.page))
	self.navDirection:set(-1)
	self.pageHistory:set(newHist)
	self.page:set(newHist[#newHist])
	local targetId = newHist[#newHist]
	task.delay(0.6, function()
		if Fusion.peek(self.page) == targetId then
			self.prevPage:set(nil)
		end
	end)
end


return PanelState
