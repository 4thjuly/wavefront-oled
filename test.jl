const OledLib = "liboled"

@ccall OledLib.DEV_ModuleInit()::Cvoid
@ccall OledLib.OLED_Init(0::Cint)::Cvoid	

@ccall OledLib.OLED_Clear(0xFF::Cushort)::Cvoid
@ccall OledLib.OLED_Display()::Cvoid

sleep(1)

@ccall OledLib.OLED_Clear(0x00::Cushort)::Cvoid
@ccall OledLib.OLED_Display()::Cvoid

sleep(1)

@ccall OledLib.OLED_Clear(0x00::Cushort)::Cvoid
FONT12 = cglobal((:Font12, OledLib), Cvoid)
FONT24 = cglobal((:Font24, OledLib), Cvoid)
@ccall OledLib.GUI_DisString_EN(0::Cushort, 0::Cushort, "Test1"::Cstring, FONT24::Ptr{Cvoid}, 0x00::Cushort, 0xFF::Cushort)::Cvoid
@ccall OledLib.GUI_DisString_EN(0::Cushort, 20::Cushort, "Test2"::Cstring, FONT12::Ptr{Cvoid}, 0x00::Cushort, 0xFF::Cushort)::Cvoid
@ccall OledLib.OLED_Display()::Cvoid
