-- CryptoTest
-- Author:LuatTest
-- CreateDate:20201016
-- UpdateDate:20201027

module(..., package.seeall)

--[[
加解密算法结果，可对照
http://tool.oschina.net/encrypt?type=2
http://www.ip33.com/crc.html
http://tool.chacuo.net/cryptaes
进行测试
]]

-- 测试配置 设置为true代表开启此项测试
local cryptoTestConfig = {
    base64Test     = true,
    hmacMd5Test    = true,
    xxteaTest      = true,
    flowMd5Test    = true,
    md5Test        = true,
    hmacSha1Test   = true,
    sha1Test       = true,
    sha256Test     = true,
    hmacSha256Test = true,
    crcTest        = true,
    aesTest        = true,
    rsaTest        = true
}

local slen = string.len

local loopTime = 60000

--- base64加解密算法测试
local function base64Test()
    pcall(rsaTest)
    local originStr = "123456crypto.base64_encodemodule(...,package.seeall)sys.timerStart(test,5000)jdklasdjklaskdjklsa"
    local encodeStr = crypto.base64_encode(originStr, slen(originStr))
    log.info("CryptoTest.base64.encode", encodeStr)
    log.info("CryptoTest.base64.decode", crypto.base64_decode(encodeStr, slen(encodeStr)))
end

if cryptoTestConfig.base64Test == true then
    sys.timerLoopStart(base64Test, loopTime)
end


--- hmac_md5算法测试
local function hmacMd5Test()
    local originStr = "asdasdsadas"
    local signKey = "123456"
    log.info("CryptoTest.hmac_md5", crypto.hmac_md5(originStr, slen(originStr), signKey, slen(signKey)))
end

if cryptoTestConfig.hmacMd5Test == true then
    sys.timerLoopStart(hmacMd5Test, loopTime)
end

--- xxtea算法测试
local function xxteaTest()
    if crypto.xxtea_encrypt then
        local text = "Hello World!"
        local key = "07946"
        local encrypt_data = crypto.xxtea_encrypt(text, key)
        log.info("CryptoTest.xxteaTest.encrypt", encrypt_data)
        local decrypt_data = crypto.xxtea_decrypt(encrypt_data, key)
        log.info("CryptoTest.xxteaTest.decrypt_data", decrypt_data)
    end
end

if cryptoTestConfig.xxteaTest == true then
    sys.timerLoopStart(xxteaTest, loopTime)
end


--- 流式md5算法测试
local function flowMd5Test()
    local fmd5Obj = crypto.flow_md5()
    local testTable={"lqlq666lqlq946", "07946lq94607946", "lq54075407540707946"}
    for i=1, #(testTable) do
        fmd5Obj:update(testTable[i])
    end
    log.info("CryptoTest.flowMd5Test", fmd5Obj:hexdigest())
end

if cryptoTestConfig.flowMd5Test == true then
    sys.timerLoopStart(flowMd5Test, loopTime)
end


--- md5算法测试
local function md5Test()
    -- 计算字符串的md5值
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    log.info("CryptoTest.text_md5Test", crypto.md5(originStr, slen(originStr)))
    -- crypto.md5，第一个参数为文件路径，第二个参数必须是"file"
	log.info("CryptoTest.file_md5Test", crypto.md5("/lua/sys.lua", "file"))
end

if cryptoTestConfig.md5Test == true then
    sys.timerLoopStart(md5Test, loopTime)
end

--- hmac_sha1算法测试
local function hmacSha1Test()
    local originStr = "asdasdsadasweqcdsjghjvcb"
    local signKey = "12345689012345"
    log.info("CryptoTest.hmacSha1Test", crypto.hmac_sha1(originStr, slen(originStr), signKey, slen(signKey)))
end

if cryptoTestConfig.hmacSha1Test == true then
    sys.timerLoopStart(hmacSha1Test, loopTime)
end

--- sha1算法测试
local function sha1Test()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    log.info("CryptoTest.sha1Test", crypto.sha1(originStr, slen(originStr)))
end

if cryptoTestConfig.sha1Test == true then
    sys.timerLoopStart(sha1Test, loopTime)
end

--- sha256算法测试
local function sha256Test()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    log.info("CryptoTest.sha256Test", crypto.sha256(originStr, slen(originStr)))
end

if cryptoTestConfig.sha256Test == true then
    sys.timerLoopStart(sha256Test, loopTime)
end

local function hmacSha256Test()
    if type(crypto.hmac_sha256) == "function" then
        local originStr = "asdasdsadasweqcdsjghjvcb"
        local signKey = "12345689012345"
        log.info("CryptoTest.hmacSha256Test", crypto.hmac_sha256(originStr, signKey))
    end
end

if cryptoTestConfig.hmacSha256Test == true then
    sys.timerLoopStart(hmacSha256Test, loopTime)
end


--- crc算法测试
local function crcTest()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    --crypto.crc16()第一个参数是校验方法，必须为以下几个；第二个参数为计算校验的字符串
    log.info("CryptoTest.crc16_MODBUS", string.format("%04X", crypto.crc16("MODBUS", originStr)))
    log.info("CryptoTest.crc16_IBM", string.format("%04X", crypto.crc16("IBM", originStr)))
    log.info("CryptoTest.crc16_X25", string.format("%04X", crypto.crc16("X25", originStr)))
    log.info("CryptoTest.crc16_MAXIM", string.format("%04X", crypto.crc16("MAXIM", originStr)))
    log.info("CryptoTest.crc16_USB", string.format("%04X", crypto.crc16("USB", originStr)))
    log.info("CryptoTest.crc16_CCITT", string.format("%04X", crypto.crc16("CCITT", originStr)))
    log.info("CryptoTest.crc16_CCITT-FALSE", string.format("%04X", crypto.crc16("CCITT-FALSE", originStr)))
    log.info("CryptoTest.crc16_XMODEM", string.format("%04X", crypto.crc16("XMODEM", originStr)))
    log.info("CryptoTest.crc16_DNP", string.format("%04X", crypto.crc16("DNP", originStr)))
    log.info("CryptoTest.USER-DEFINED", string.format("%04X", crypto.crc16("USER-DEFINED", originStr, 0x8005, 0x0000, 0x0000, 0, 0)))
    -- log.info("CryptoTest.crc16_modbus",string.format("%04X",crypto.crc16_modbus(originStr,slen(originStr))))
    -- log.info("CryptoTest.crc32",string.format("%08X",crypto.crc32(originStr,slen(originStr))))
end

if cryptoTestConfig.crcTest == true then
    sys.timerLoopStart(crcTest, loopTime)
end

--- aes算法测试（参考http://tool.chacuo.net/cryptaes）
local function aesTest()
    local originStr = "AES128 ECB ZeroP"
    --加密模式：ECB；填充方式：ZeroPadding；密钥：1234567890123456；密钥长度：128 bit
    local encodeStr = crypto.aes_encrypt("ECB", "ZERO", originStr, "1234567890123456")
    print(originStr, "encrypt", string.toHex(encodeStr))
    log.info("CryptoTest.decrypt", crypto.aes_decrypt("ECB", "ZERO", encodeStr, "1234567890123456"))

    originStr = "AES128 ECB ZeroP"
    --加密模式：ECB；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit
    encodeStr = crypto.aes_encrypt("ECB","PKCS5",originStr,"1234567890123456")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("ECB","PKCS5",encodeStr,"1234567890123456"))

    originStr = "AES128 ECB ZeroPt"
    --加密模式：ECB；填充方式：Pkcs7Padding；密钥：1234567890123456；密钥长度：128 bit
    encodeStr = crypto.aes_encrypt("ECB","PKCS7",originStr,"1234567890123456")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("ECB","PKCS7",encodeStr,"1234567890123456"))

    originStr = "AES192 ECB ZeroPadding test"
    --加密模式：ECB；填充方式：ZeroPadding；密钥：123456789012345678901234；密钥长度：192 bit
    local encodeStr = crypto.aes_encrypt("ECB","ZERO",originStr,"123456789012345678901234")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("ECB","ZERO",encodeStr,"123456789012345678901234"))

    originStr = "AES192 ECB Pkcs5Padding test"
    --加密模式：ECB；填充方式：Pkcs5Padding；密钥：123456789012345678901234；密钥长度：192 bit
    encodeStr = crypto.aes_encrypt("ECB","PKCS5",originStr,"123456789012345678901234")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("ECB","PKCS5",encodeStr,"123456789012345678901234"))

    originStr = "AES192 ECB Pkcs7Padding test"
    --加密模式：ECB；填充方式：Pkcs7Padding；密钥：123456789012345678901234；密钥长度：192 bit
    encodeStr = crypto.aes_encrypt("ECB","PKCS7",originStr,"123456789012345678901234")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("ECB","PKCS7",encodeStr,"123456789012345678901234"))

    originStr = "AES256 ECB ZeroPadding test"
    --加密模式：ECB；填充方式：ZeroPadding；密钥：12345678901234567890123456789012；密钥长度：256 bit
    local encodeStr = crypto.aes_encrypt("ECB","ZERO",originStr,"12345678901234567890123456789012")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("ECB","ZERO",encodeStr,"12345678901234567890123456789012"))

    originStr = "AES256 ECB Pkcs5Padding test"
    --加密模式：ECB；填充方式：Pkcs5Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit
    encodeStr = crypto.aes_encrypt("ECB","PKCS5",originStr,"12345678901234567890123456789012")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("ECB","PKCS5",encodeStr,"12345678901234567890123456789012"))

    originStr = "AES256 ECB Pkcs7Padding test"
    --加密模式：ECB；填充方式：Pkcs7Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit
    encodeStr = crypto.aes_encrypt("ECB","PKCS7",originStr,"12345678901234567890123456789012")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("ECB","PKCS7",encodeStr,"12345678901234567890123456789012"))

    originStr = "AES128 CBC ZeroPadding test"
    --加密模式：CBC；填充方式：ZeroPadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CBC","ZERO",originStr,"1234567890123456","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CBC","ZERO",encodeStr,"1234567890123456","1234567890666666"))

    originStr = "AES128 CBC Pkcs5Padding test"
    --加密模式：CBC；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC","PKCS5",originStr,"1234567890123456","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CBC","PKCS5",encodeStr,"1234567890123456","1234567890666666"))

    originStr = "AES128 CBC Pkcs7Padding test"
    --加密模式：CBC；填充方式：Pkcs7Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC","PKCS7",originStr,"1234567890123456","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CBC","PKCS7",encodeStr,"1234567890123456","1234567890666666"))

    originStr = "AES192 CBC ZeroPadding test"
    --加密模式：CBC；填充方式：ZeroPadding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CBC","ZERO",originStr,"123456789012345678901234","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CBC","ZERO",encodeStr,"123456789012345678901234","1234567890666666"))

    originStr = "AES192 CBC Pkcs5Padding test"
    --加密模式：CBC；填充方式：Pkcs5Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC","PKCS5",originStr,"123456789012345678901234","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CBC","PKCS5",encodeStr,"123456789012345678901234","1234567890666666"))

    originStr = "AES192 CBC Pkcs7Padding test"
    --加密模式：CBC；填充方式：Pkcs7Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC","PKCS7",originStr,"123456789012345678901234","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CBC","PKCS7",encodeStr,"123456789012345678901234","1234567890666666"))

    originStr = "AES256 CBC ZeroPadding test"
    --加密模式：CBC；填充方式：ZeroPadding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CBC","ZERO",originStr,"12345678901234567890123456789012","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CBC","ZERO",encodeStr,"12345678901234567890123456789012","1234567890666666"))

    originStr = "AES256 CBC Pkcs5Padding test"
    --加密模式：CBC；填充方式：Pkcs5Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC","PKCS5",originStr,"12345678901234567890123456789012","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CBC","PKCS5",encodeStr,"12345678901234567890123456789012","1234567890666666"))

    originStr = "AES256 CBC Pkcs7Padding test"
    --加密模式：CBC；填充方式：Pkcs7Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC","PKCS7",originStr,"12345678901234567890123456789012","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CBC","PKCS7",encodeStr,"12345678901234567890123456789012","1234567890666666"))

    originStr = "AES128 CTR ZeroPadding test"
    --加密模式：CTR；填充方式：ZeroPadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CTR","ZERO",originStr,"1234567890123456","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","ZERO",encodeStr,"1234567890123456","1234567890666666"))

    originStr = "AES128 CTR Pkcs5Padding test"
    --加密模式：CTR；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR","PKCS5",originStr,"1234567890123456","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","PKCS5",encodeStr,"1234567890123456","1234567890666666"))

    originStr = "AES128 CTR Pkcs7Padding test"
    --加密模式：CTR；填充方式：Pkcs7Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR","PKCS7",originStr,"1234567890123456","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","PKCS7",encodeStr,"1234567890123456","1234567890666666"))

    originStr = "AES128 CTR NonePadding test"
    --加密模式：CTR；填充方式：NonePadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR","NONE",originStr,"1234567890123456","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","NONE",encodeStr,"1234567890123456","1234567890666666"))

    originStr = "AES192 CTR ZeroPadding test"
    --加密模式：CTR；填充方式：ZeroPadding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CTR","ZERO",originStr,"123456789012345678901234","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","ZERO",encodeStr,"123456789012345678901234","1234567890666666"))

    originStr = "AES192 CTR Pkcs5Padding test"
    --加密模式：CTR；填充方式：Pkcs5Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR","PKCS5",originStr,"123456789012345678901234","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","PKCS5",encodeStr,"123456789012345678901234","1234567890666666"))

    originStr = "AES192 CTR Pkcs7Padding test"
    --加密模式：CTR；填充方式：Pkcs7Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR","PKCS7",originStr,"123456789012345678901234","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","PKCS7",encodeStr,"123456789012345678901234","1234567890666666"))

    originStr = "AES192 CTR NonePadding test"
    --加密模式：CTR；填充方式：NonePadding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR","NONE",originStr,"123456789012345678901234","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","NONE",encodeStr,"123456789012345678901234","1234567890666666"))

    originStr = "AES256 CTR ZeroPadding test"
    --加密模式：CTR；填充方式：ZeroPadding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CTR","ZERO",originStr,"12345678901234567890123456789012","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","ZERO",encodeStr,"12345678901234567890123456789012","1234567890666666"))

    originStr = "AES256 CTR Pkcs5Padding test"
    --加密模式：CTR；填充方式：Pkcs5Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR","PKCS5",originStr,"12345678901234567890123456789012","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","PKCS5",encodeStr,"12345678901234567890123456789012","1234567890666666"))

    originStr = "AES256 CTR Pkcs7Padding test"
    --加密模式：CTR；填充方式：Pkcs7Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR","PKCS7",originStr,"12345678901234567890123456789012","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","PKCS7",encodeStr,"12345678901234567890123456789012","1234567890666666"))

    originStr = "AES256 CTR NonePadding test"
    --加密模式：CTR；填充方式：NonePadding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR","NONE",originStr,"12345678901234567890123456789012","1234567890666666")
    print(originStr,"encrypt",string.toHex(encodeStr))
    log.info("CryptoTest.decrypt",crypto.aes_decrypt("CTR","NONE",encodeStr,"12345678901234567890123456789012","1234567890666666"))
end

if cryptoTestConfig.aesTest == true then
    sys.timerLoopStart(aesTest, loopTime)
end

--rsa算法测试
local function rsaTest()
    --local plainStr = "1234567890asdfghjklzxcvbnm"
    local plainStr = "firmId=10015&model=zw-sp300&sn=W01201910300000108&version=1.0.0"

    --公钥加密(2048bit，这个bit与实际公钥的bit要保持一致)
    local encryptStr = crypto.rsa_encrypt("PUBLIC_KEY",io.readFile("/lua/public.key"),2048,"PUBLIC_CRYPT",plainStr)
    log.info("rsaTest.encrypt",encryptStr:toHex())
    --私钥解密(2048bit，这个bit与实际私钥的bit要保持一致)
    local decryptStr = crypto.rsa_decrypt("PRIVATE_KEY",io.readFile("/lua/private.key"),2048,"PRIVATE_CRYPT",encryptStr)
    log.info("rsaTest.decrypt",decryptStr) --此处的decryptStr应该与plainStr相同


    --私钥签名(2048bit，这个bit与实际私钥的bit要保持一致)
    local signStr = crypto.rsa_sha256_sign("PRIVATE_KEY",io.readFile("/lua/private.key"),2048,"PRIVATE_CRYPT",plainStr)
    log.info("rsaTest.signStr",signStr:toHex())
    --公钥验签(2048bit，这个bit与实际公钥的bit要保持一致)
    local verifyResult = crypto.rsa_sha256_verify("PUBLIC_KEY",io.readFile("/lua/public.key"),2048,"PUBLIC_CRYPT",signStr,plainStr)
    log.info("rsaTest.verify",verifyResult)



    --私钥解密某个客户的公钥加密密文
    encryptStr = string.fromHex("af750a8c95f9d973a033686488197cffacb8c1b2b5a15ea8779a48a72a1cdb2f9c948fe5ce0ac231a16de16b5fb609f62ec81c7646c1f018e333860627b5d4853cfe77f71ea7e4573323905faf0a759d59729d2afb80e46ff1f1b715227b599a14f3b9feb676f1feb1c2acd97f4d494124237a720ca781a16a2b600c17e348a5fdd3c374384276147b93ce93cc5a005a0aaf1581cdb7d58bfa84b4e4d7263efc02bf7ad80b15937ce8b37ced4e1ef8899be5c2a7d338cb5c4784c6b8a1cb31e7ecd1ec48597a02050b1190a3e13f2253a35e8cbc094c0af28b968f05a7f946a7a8cf3f9da2013d53ee51ca74279f8f36662e093b37db83caef5b18b666d405d4")
    decryptStr = crypto.rsa_decrypt("PRIVATE_KEY",io.readFile("/lua/private.key"),2048,"PRIVATE_CRYPT",encryptStr)
    log.info("rsaTest.decrypt",decryptStr)

    --公钥验签某个客户的私钥签名密文
    signStr = string.fromHex("7251fd625c01ac41e277d11b5b795962ba42d89a645eb9fe2241b2d8a9b6b5b6ea70e23e6933ef1324495749abde0e31eaf4fefe6d09f9270c0510790bd6075595717522539b7b70b798bdc216dae3873389644d73b04ecaeb01b25831904955a891d2459334a3f9f1e4558f7f99906c35f94c377f7f95cf0d3e062d8eb513fd723ad8b3981027b09126fbeb72d5fe4554a32b9c270f8f46032ede59387769b1fb090f0b4be15aaac2744a666dfbde7c04e02979f1c1b4e4c0f23c6bb9f60941312850caf41442d68ad7c9e939b7305ac6712ad31427f1c1d7b4f68001df9ce03367bd35e401a420f526aee3c96c2caaccb9a8db09b30930172b4c2847725d05")
    verifyResult = crypto.rsa_sha256_verify("PUBLIC_KEY",io.readFile("/lua/public.key"),2048,"PUBLIC_CRYPT",signStr,"firmId=10015&model=zw-sp300&sn=W01201910300000108&version=1.0.0")
    log.info("rsaTest.verifyResult customer",verifyResult)
end

if cryptoTestConfig.rsaTest == true then
    sys.timerLoopStart(rsaTest, loopTime)
end
