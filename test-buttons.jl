const KEY_UP_PIN      = 6
const KEY_DOWN_PIN    = 19
const KEY_LEFT_PIN    = 5
const KEY_RIGHT_PIN   = 26
const KEY_PRESS_PIN   = 13
const KEY1_PIN        = 21
const KEY2_PIN        = 20
const KEY3_PIN        = 16

@ccall OledLib.DEV_Digital_Read(KEY_UP_PIN::Cuint)::Cchar
@ccall OledLib.DEV_Digital_Read(KEY_DOWN_PIN::Cuint)::Cchar
@ccall OledLib.DEV_Digital_Read(KEY_LEFT_PIN::Cuint)::Cchar
@ccall OledLib.DEV_Digital_Read(KEY_RIGHT_PIN::Cuint)::Cchar
@ccall OledLib.DEV_Digital_Read(KEY_PRESS_PIN::Cuint)::Cchar
@ccall OledLib.DEV_Digital_Read(KEY1_PIN::Cuint)::Cchar
@ccall OledLib.DEV_Digital_Read(KEY2_PIN::Cuint)::Cchar
@ccall OledLib.DEV_Digital_Read(KEY3_PIN::Cuint)::Cchar

function test_pins(seconds)
    start = time()
    while time() - start < seconds
        val = @ccall OledLib.DEV_Digital_Read(KEY_UP_PIN::Cuint)::Cchar
        @show val
        sleep(0.1)
    end
end

function pinRead(pin)
    val = @ccall OledLib.DEV_Digital_Read(pin::Cuint)::Cchar
    @show val
end