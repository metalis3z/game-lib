--credit to leon games studio
local HttpService = game:GetService("HttpService")

return function (_, url)
	return HttpService:GetAsync(url)
end