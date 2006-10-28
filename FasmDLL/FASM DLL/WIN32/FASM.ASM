
; flat assembler interface for Win32
; Copyright (c) 1999-2006, Tomasz Grysztar.
; All rights reserved.
format PE GUI 4.0 DLL
entry DllEntryPoint
	;format  PE console
include 'win32ax.inc'

proc DllEntryPoint hinstDLL,fdwReason,lpvReserved
	mov	eax,TRUE
	ret
endp

stock_ebp dd ?

proc GenerateIt par:DWORD

	mov	[stock_ebp],ebp
	mov	esi,_logo
	mov	eax,[par]
	mov	[input_file],eax
	mov	[memory_setting],0
	mov	[passes_limit],100

	;call   get_params
	;jc      information

	call	init_memory

	call	[GetTickCount]
	mov	[start_time],eax

	call	preprocessor
	call	parser
	call	assembler
	call	formatter

	;call    display_user_messages


	xor	al,al
	mov	ebp,[stock_ebp]
	mov	esp,ebp
	pop	ebp
	retn

endp

include 'system.inc'

include '..\version.inc'

_copyright db 'Copyright (c) 1999-2005, Tomasz Grysztar',0Dh,0Ah,0

_logo db 'flat assembler  version ',VERSION_STRING,0
_usage db 0Dh,0Ah
       db 'usage: fasm <source> [output]',0Dh,0Ah
       db 'optional settings:',0Dh,0Ah
       db ' -m <limit>  set the limit in kilobytes for the memory available to assembler',0Dh,0Ah
       db ' -p <limit>  set the maximum allowed number of passes',0D,0Ah
       db 0
_memory_prefix db '  (',0
_memory_suffix db ' kilobytes memory)',0Dh,0Ah,0
_passes_suffix db ' passes, ',0
_seconds_suffix db ' seconds, ',0
_bytes_suffix db ' bytes.',0Dh,0Ah,0

include '..\errors.inc'
include '..\expressi.inc'
include '..\preproce.inc'
include '..\parser.inc'
include '..\assemble.inc'
include '..\formats.inc'
include '..\x86_64.inc'
include '..\tables.inc'

align 4

include '..\variable.inc'

memory_setting dd ?
start_time dd ?

params rb 1000h
buffer rb 4000h

stack 10000h

section '.idata' import data readable writeable

  dd 0,0,0,rva kernel_name,rva kernel_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dd rva _ExitProcess
    CreateFile dd rva _CreateFileA
    ReadFile dd rva _ReadFile
    WriteFile dd rva _WriteFile
    CloseHandle dd rva _CloseHandle
    SetFilePointer dd rva _SetFilePointer
    GetCommandLine dd rva _GetCommandLineA
    GetEnvironmentVariable dd rva _GetEnvironmentVariable
    GetStdHandle dd rva _GetStdHandle
    VirtualAlloc dd rva _VirtualAlloc
    GetTickCount dd rva _GetTickCount
    GetSystemTime dd rva _GetSystemTime
    GlobalMemoryStatus dd rva _GlobalMemoryStatus
    dd 0

  kernel_name db 'KERNEL32.DLL',0

  _ExitProcess dw 0
    db 'ExitProcess',0
  _CreateFileA dw 0
    db 'CreateFileA',0
  _ReadFile dw 0
    db 'ReadFile',0
  _WriteFile dw 0
    db 'WriteFile',0
  _CloseHandle dw 0
    db 'CloseHandle',0
  _SetFilePointer dw 0
    db 'SetFilePointer',0
  _GetCommandLineA dw 0
    db 'GetCommandLineA',0
  _GetEnvironmentVariable dw 0
    db 'GetEnvironmentVariableA',0
  _GetStdHandle dw 0
    db 'GetStdHandle',0
  _VirtualAlloc dw 0
    db 'VirtualAlloc',0
  _GetTickCount dw 0
    db 'GetTickCount',0
  _GetSystemTime dw 0
    db 'GetSystemTime',0
  _GlobalMemoryStatus dw 0
    db 'GlobalMemoryStatus',0

section '.edata' export data readable

  export 'FASM.DLL',\
	 GenerateIt,'GenerateIt'


section '.reloc' fixups data readable discardable
