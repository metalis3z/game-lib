--!strict
-- CONFIG
local BANNER_LIFETIME = 4 * 7 * 24 * 60 * 60
local SHOW_IN_STUDIO = true


-- LOCAL
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Banner = require(frontend.Components.Banner)
local UpdateLog = require(frontend.Config.UpdateLog)
local Remote = require(modules.Objects.Remote)
local MONTHS = {
	January = 1, February = 2, March = 3, April = 4, May = 5, June = 6,
	July = 7, August = 8, September = 9, October = 10, November = 11, December = 12,
}


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>


-- TYPES (props)
type Props = {
	pageVisible: UsedAs<boolean>,
	onView: () -> (),
	visibleValue: Fusion.Value<boolean>?, -- updated on change
	layoutOrder: UsedAs<number>?,
}


-- LOCAL FUNCTIONS
-- Roblox reads this table as UTC, so every client lands on the same stamp
local function readEntryTime(entry: UpdateLog.UpdateEntry): number?
	local day, monthName, year = string.match(entry.Date, "^(%d+)%s+(%a+)%s+(%d+)$")
	local month = if monthName then MONTHS[monthName] else nil
	if not (day and month and year) then
		return nil
	end
	return os.time({
		year = tonumber(year) :: number,
		month = month,
		day = tonumber(day) :: number,
		hour = 0,
	})
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local entry = UpdateLog[1]
	local entryTime = if entry and entry.Banner then readEntryTime(entry) else nil
	local isEligible = entryTime ~= nil
		and (SHOW_IN_STUDIO or not RunService:IsStudio())
		and os.time() - entryTime <= BANNER_LIFETIME

	local seenFuse: any = (scope :: any):Fuse("perm", "SeenUpdateTime")
	local isDismissed: Fusion.Value<boolean> = scope:Value(false)

	local function dismiss()
		if Fusion.peek(isDismissed) then
			return
		end
		isDismissed:set(true)
		task.spawn(function()
			local dismissRemote: any = Remote.get("DismissUpdate")
			if dismissRemote then
				dismissRemote:invokeServerAsync(entryTime)
			end
		end)
	end

	local isVisible = scope:Computed(function(use)
		if not isEligible or use(isDismissed) or not use(props.pageVisible) then
			return false
		end
		-- Staying hidden until their data lands stops the banner flashing up for someone who already closed it
		local seen = use(seenFuse)
		return typeof(seen) == "number" and seen < (entryTime :: number)
	end)

	local visibleValue = props.visibleValue
	if visibleValue then
		scope:Observer(isVisible):onChange(function()
			visibleValue:set(Fusion.peek(isVisible))
		end)
		visibleValue:set(Fusion.peek(isVisible))
	end

	return Banner(scope, {
		name = "UpdateBanner",
		text = if entry and entry.Banner then entry.Banner else "",
		buttonLabel = "View",
		onButton = function()
			dismiss()
			props.onView()
		end,
		onClose = dismiss,
		visible = isVisible,
		layoutOrder = props.layoutOrder,
	})
end
