local MessagingService = game:GetService("MessagingService")

return function (context, message: string)
    if message then
        local data = {message = message, userid = context.Executor.UserId, name = context.Executor.DisplayName}
        MessagingService:PublishAsync("GlobalNotify", data)
    end
end