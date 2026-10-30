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

local httpFn
local _candidates = {"syn", "request", "http_request", "fluxus_request"}
for _, name in ipairs(_candidates) do
    local ok, fn = pcall(function()
        local g = getfenv and getfenv(0) or _G
        local v = g[name]
        if type(v) == "table" and v.request then return v.request end
        if type(v) == "function" then return v end
    end)
    if ok and fn then httpFn = fn break end
end

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
