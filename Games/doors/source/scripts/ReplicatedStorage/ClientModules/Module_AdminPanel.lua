local module = {
	enable = true,
	always_enable = {"code_return1"},
	gamepass_id = 738967590,
	gamepass_active = true,
	for_everyone = false,
}
local local_module = {}

function local_module:haveAdminPanelGamepass(pt)
	local ret_val = false
	if module.gamepass_active == true then
		ret_val = game.MarketplaceService:UserOwnsGamePassAsync(pt.UserId, module.gamepass_id)
	end

	
	return ret_val
end

function module:haveAccess(pt)
	local val = false
	for i,v in pairs(module.always_enable) do
		if v == pt.Name then
			val = true
		end
	end
	if module.for_everyone == true then
		val = true
	end
	if local_module:haveAdminPanelGamepass(pt) == true then
		val = true
	end
	
	return val
end

return module