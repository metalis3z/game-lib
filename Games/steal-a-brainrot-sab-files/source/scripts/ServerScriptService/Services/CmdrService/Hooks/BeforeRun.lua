return function(registry)
	registry:RegisterHook("BeforeRun", function(context)
		local RunService = game:GetService("RunService")
		local player = context.Executor

		if context.Group == "DefaultUtil" or context.Group == "Help" then
			return nil
		end

		if RunService:IsServer() then
			local CmdrService = _G.CmdrService
			if CmdrService and not CmdrService:IsAuthorized(player) then
				return "You are not authorized to use Conch 4.0."
			end
		end

		return nil
	end, 0)
end 