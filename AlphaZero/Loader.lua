local Network = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Uvxtq/Project-AlphaZero/main/AlphaZero/CustomFuncs/Network.lua"))()
local Client = {
    Github = "https://raw.githubusercontent.com/Uvxtq/Project-AlphaZero/main/AlphaZero/Supported%20Games/",
    Games = {
        ["8069117419"] = "Demon%20Soul%20Simulator";
        ["10898965735"] = "Mine%20Racer";
    },
}

local MarketplaceService = game:GetService("MarketplaceService")
local MSName = MarketplaceService:GetProductInfo(game.PlaceId).Name

function GetGame()
    for PlaceId, GameName in next, Client.Games do
        if tostring(game.PlaceId) == PlaceId then
            return GameName
        end
    end
end

function LoadScript()
    local GameName = GetGame()
    if GameName then
        local Success, Error = pcall(function()
            loadstring(game:HttpGet(string.format("%s%s%s", Client.Github, GameName, ".lua")))()
        end)
        if not Success then
            warn(string.format('Failed to load script for game: "%s", Error: %s', string.gsub(GameName, "%%20", " "), Error))
        end
    else
        Network:Notify("Unsupported Game", MSName .. " is not Supported", 3)
        task.wait(1)
        Network:NotifyPrompt("Universal", "Would you like to load the universal script?", 30, function(Value)
            if Value then
                loadstring(game:HttpGet(string.format("%s%s", Client.Github, "Universal.lua")))()
            elseif not Value then
                return;
            end
        end)
    end
end

LoadScript()
