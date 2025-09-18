workspace "NavMeshScene"
    configurations { "Debug", "Release" }
    platforms { "x32", "x64" }
    targetdir "../bin/"
    language "C++"
    includedirs {
        "..",
		"../RecastNavigation/Common",
        "../RecastNavigation/Detour/Include",
        "../RecastNavigation/DetourTileCache/Include",
		"../RecastNavigation/DetourCrowd/Include",
		"../RecastNavigation/Recast/Include",
        "../RecastNavigation/Contrib/fastlz",
    }
    flags {
        "C++11",
        "StaticRuntime",
    }

    filter "configurations:Debug"
    defines { "_DEBUG" }
    flags { "Symbols" }
    libdirs { }
    filter "configurations:Release"
    defines { "NDEBUG" }
    libdirs { }
    optimize "On"
    filter { }  
    
    
    
project "NavMeshScene"
    kind "StaticLib"
    targetname "NavMeshScene"
    files {
        "../*.h",
        "../*.cpp",
        "../RecastNavigation/Common/**",
		"../RecastNavigation/Detour/**",
        "../RecastNavigation/DetourTileCache/**",
		"../RecastNavigation/DetourCrowd/**",
		"../RecastNavigation/Recast/**",
        "../RecastNavigation/Contrib/fastlz/**",
        "../aoi/impl/*.h",
        "../aoi/*.h",
    }
    
project "example1"
    kind "ConsoleApp"
    targetname "example1"
    libdirs { "../bin" }
    links { "NavMeshScene" }
    files {
        "../example1/*.h",
        "../example1/*.cpp",
    }
    

if os.is("windows") then
    
project "example2"
    kind "ConsoleApp"
    targetname "example2"
    includedirs {
        "../example2/Contrib/SDL/include/",
        "../example2/Contrib/",
        "../example2/DebugUtils/Include/",
        -- "../example2/Recast/Include/",
        -- "../example2/Detour/Include/",
        -- "../example2/DetourCrowd/Include/",
        -- "../example2/DetourTileCache/Include/",
        "../example2/RecastDemo/Include/",
    }
    libdirs { "../bin" }
    links { "NavMeshScene" }
    files {
        "../example2/**",
    }
    defines { "WIN32", "_WINDOWS", "_CRT_SECURE_NO_WARNINGS", "_HAS_EXCEPTIONS=0" }


    configuration { "linux", "gmake" }
	buildoptions { 
		"`pkg-config --cflags sdl2`",
		"`pkg-config --cflags gl`",
		"`pkg-config --cflags glu`" 
	}
	linkoptions { 
		"`pkg-config --libs sdl2`",
		"`pkg-config --libs gl`",
		"`pkg-config --libs glu`" 
	}


    configuration { "windows" }
	includedirs {
            "../example2/Contrib/SDL/include",
            -- "../example2/Contrib/fastlz",
        }
        
	links { 
		"glu32",
		"opengl32",
		"SDL2",
		"SDL2main",
	}
        filter { "platforms:x32" }
            libdirs { "../example2/Contrib/SDL/lib/x86" }
            postbuildcommands {
                -- Copy the SDL2 dll to the Bin folder.
                '{COPY} "%{wks.location}../example2/Contrib/SDL/lib/x86/SDL2.dll" "%{cfg.targetdir}"'
            }
        filter { "platforms:x64" }
            libdirs { "../example2/Contrib/SDL/lib/x64" }
            postbuildcommands {
                -- Copy the SDL2 dll to the Bin folder.
                '{COPY} "%{wks.location}../example2/Contrib/SDL/lib/x64/SDL2.dll" "%{cfg.targetdir}"'
            }
end


project "test1"
    kind "ConsoleApp"
    targetname "test1"
    libdirs { "../bin" }
    links { "NavMeshScene" }
    files {
        "../tests/test1/*.h",
        "../tests/test1/*.cpp",
    }
