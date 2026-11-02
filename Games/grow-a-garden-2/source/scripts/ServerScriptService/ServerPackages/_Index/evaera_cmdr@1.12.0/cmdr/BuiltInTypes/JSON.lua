--credit to leon games studio
local HttpService = game:GetService("HttpService")

return function(registry)
	registry:RegisterType("json", {
		Validate = function(text)
			return pcall(HttpService.JSONDecode, HttpService, text)
		end;

		Parse = function(text)
			return HttpService:JSONDecode(text)
		end
	})
end
