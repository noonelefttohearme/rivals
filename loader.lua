-- kamidere loader

local KEY = _G.KAMI_KEY or "KAMI-XXXX-XXXX-XXXX"
local API = "https://kamidere-api.fly.dev/verify"

local function getHWID()
    if syn and syn.request then
        return tostring(game:GetService("RbxAnalyticsService"):GetClientId())
    end
    if rconsoleinfo then return rconsoleinfo() end
    if identifyexecutor then return identifyexecutor() end
    return tostring(game.PlaceId) .. tostring(game:GetService("Players").LocalPlayer.UserId)
end

local hwid = getHWID()

local httpFn = rawget(_G,"syn") and rawget(_G,"syn").request
    or rawget(_G,"request")
    or rawget(_G,"http_request")
    or rawget(_G,"fluxus_request")

local ok, response = pcall(function()
    return httpFn({
        Url    = API,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body   = game:GetService("HttpService"):JSONEncode({ key = KEY, hwid = hwid }),
    })
end)

if not ok or not response then
    error("[kamidere] could not reach auth server.", 0)
end

local body = game:GetService("HttpService"):JSONDecode(response.Body)

if not body.valid then
    error("Invalid key\nMake a support ticket", 0)
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/iwishpeoplelovedmeforme/kami/main/kami.lua"))()
