local Network = {}; do
    function Network:Send(Remote, ...)
        local Args = {...}

        local Success, Error = pcall(function()
            Remote:InvokeServer(unpack(Args))
        end)

        if not Success then
            Remote:FireServer()
        end
    end
    function Network:Notify(UILib, Title, Content, Duration)
        UILib:Notify({
            Title = Title,
            Content = Content,
            Duration = Duration,
            Image = 4483362458,
         })
    end
end
return Network