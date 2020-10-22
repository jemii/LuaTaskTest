-- LuaTaskTest
-- Author:LuatTest
-- CreateDate:20200716
-- UpdateDate:20200918

PROJECT = "LuaTaskTest"
VERSION = "2.0.0"
PRODUCT_KEY = "LMe0gb26NhPbBZ7t3mSk3dxA8f4ZZmM1"

-- 测试配置 设置为true代表开启此项测试
local LuatTaskTestConfig = {
    baseTest            = false,
    httpTest            = false,
    socketTest          = false,
    mqttTest            = false,
    audioTest           = true,
    gpioTest            = false,
    fsTest              = false,
    callTest            = false,
    dispTest            = false,
    lbsLocTest          = false,
    keyPadTest          = false,
    uartTransferTest    = false,
    cryptoTest          = false
}

require "log"
LOG_LEVEL = log.LOGLEVEL_TRACE

-- require "console"
-- console.setup(2, 115200)

require "netLed"
pmd.ldoset(2, pmd.LDO_VLCD)
netLed.setup(true, pio.P0_1, pio.P0_4)
-- netLed.updateBlinkTime("GPRS", 500, 500)

-- require "errDump"
-- errDump.request("udp://ota.airm2m.com:9072")

require "update"
update.request(nil, "http://117.51.140.119:8000/jeremy.bin")
-- update.request()

-- 屏幕驱动文件管理
-- require "color_lcd_spi_ILI9341"
-- require "color_lcd_spi_gc9106l"
-- require "color_lcd_spi_st7735"

-- lib依赖管理
require "sys"
require "led"
require "net"
require "common"
require "utils"
require "misc"
require "ntp"
require "http"
require "socket"
require "mqtt"
require "audio"
require "pins"
require "record"
require "cc"
require "uiWin"
require "scanCode"
require"lbsLoc"
require "pm"
require "nvm"
require "powerKey"

-- 保持唤醒
-- pm.wake("LuaTaskTest")

if LuatTaskTestConfig.baseTest then
    require "BaseTest"
end

if LuatTaskTestConfig.httpTest then
    require "HttpTest"
end

if LuatTaskTestConfig.socketTest then
    require "SocketTest"
end

if LuatTaskTestConfig.mqttTest then
    require "MqttTest"
end

if LuatTaskTestConfig.audioTest then
    require "AudioTest"
end

if LuatTaskTestConfig.gpioTest then
    require "GpioTest"
end

if LuatTaskTestConfig.fsTest then
    require "FsTest"
end

if LuatTaskTestConfig.callTest then
    require "CallTest"
end

if LuatTaskTestConfig.dispTest then
    require "DispTest"
end

if LuatTaskTestConfig.lbsLocTest then
    require "LbsLocTest"
end

if LuatTaskTestConfig.keyPadTest then
    require "KeyPadTest"
end

if LuatTaskTestConfig.uartTransferTest then
    require "UartTransferTest"
end

if LuatTaskTestConfig.cryptoTest then
    require "CryptoTest"
end


sys.taskInit(
            function()
                while true do
                    log.info("VERSION", rtos.get_version(), VERSION)
				    log.info("FSFREESIZE", rtos.get_fs_free_size() .. " Bytes")
                    log.info("RAMUSEAGE", collectgarbage("count") .. " KB")
                    sys.wait(30000)
                end
            end
)

-- 自动校准时间
ntp.timeSync(
            1, 
            function()
                log.info("ntp.timeSync", "AutoTimeSync is Done !")
            end
)

-- 死机断言
ril.request("AT*EXASSERT=1")

--启动系统框架
sys.init(0, 0)
sys.run()
