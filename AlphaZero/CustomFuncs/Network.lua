local NotificationLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sw1ndlerScripts/RobloxScripts/main/Notification%20Library/main.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Network = {}; do
    function Network:Send(Remote, ...)
        local Args = {...}

        local Success, Error = pcall(function()
            Remote:FireServer(unpack(Args))
        end)

        if not Success then
            Remote:FireServer()
        end
    end
    function Network:Invoke(Remote, ...)
        local Args = {...}

        local Success, Error = pcall(function()
            Remote:InvokeServer(unpack(Args))
        end)

        if not Success then
            error(Error)
        end
    end
    function Network:Receive(Remote, Callback)
        Remote.OnClientEvent:Connect(Callback)
    end
    function Network:Notify(Title, Content, Duration)
        NotificationLib:CreateDefaultNotif({
            TweenSpeed = 1,
            Title = Title,
            Text = Content,
            Duration = Duration
        })
    end
    function Network:NotifyPrompt(Title, Content, Duration, Callback)
        NotificationLib:CreatePromptNotif({
            TweenSpeed = 1,
            Title = Title,
            Text = Content,
            Duration = Duration,
            Callback = Callback,
            TrueText = "Yes",
            FalseText = "No"
        })
    end
    function Network:TweenTo(CFrame, Time)
        local TweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local Tween = TweenService:Create(HumanoidRootPart, TweenInfo, {CFrame = CFrame})
        Tween:Play()
        Tween.Completed:Wait()
    end
    function Network:MoveTo(CFrame)
        local PathfindingService = game:GetService("PathfindingService")
        local Path = PathfindingService:CreatePath()
        Path:ComputeAsync(HumanoidRootPart.Position, CFrame.Position)
        local Waypoints = Path:GetWaypoints()

        for _, Waypoint in next, Waypoints do
            Humanoid:MoveTo(Waypoint.Position)
        end
    end
    function Network:TeleportTo(CFrame)
        Character:PivotTo(CFrame)
    end
end
return Network