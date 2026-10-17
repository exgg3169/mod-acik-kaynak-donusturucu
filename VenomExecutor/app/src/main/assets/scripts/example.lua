-- Venom Executor — örnek script
-- Hedef: com.sandboxol.blockymods

local pid = get_pid()
log("Blockymods PID: " .. tostring(pid))

local function test_loop()
    for i = 1, 5 do
        log("tick " .. i)
        sleep(200)
    end
end

test_loop()

return "script tamam"
