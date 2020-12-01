program WifiZero;

{$mode objfpc}{$H+}
{$hints off}
{$notes off}

{ Raspberry Pi Zero Application                                                }
{  Add your program code below, add additional units to the "uses" section if  }
{  required and create new units by selecting File, New Unit from the menu.    }
{                                                                              }
{  To compile your program select Run, Compile (or Run, Build) from the menu.  }

uses
  RaspberryPi,
  GlobalConfig,
  GlobalConst,
  GlobalTypes,
  Platform,
  Threads,
  SysUtils,
  Classes,
  Console,
  SysCalls,
  Ultibo
  { Add additional units here };


var
  Console1 : TWindowHandle;

{$linklib Wifi}

function scan_main : integer; cdecl; external;



function ustimeout (var tickp : integer; usec : integer) : integer; cdecl; public;
var
  t : int64;
begin
  t := ClockGetTotal () div CLOCK_CYCLES_PER_MICROSECOND;
  if (usec = 0) or (t - tickp >= usec) then
    begin
      tickp := t;
      Result := 1;
    end
  else
    Result := 0;
end;

procedure usdelay (usec : integer); cdecl; public;
var
  ticks : integer;
begin
  ticks := 0;
  ustimeout(ticks, 0);
  while ustimeout (ticks, usec) = 0 do;
//  usleep (usec);
end;
(*
{
    int t = *USEC_REG();

    if (usec == 0 || t - *tickp >= usec)
    {
        *tickp = t;
        return (1);
    }
    return (0);
}


function gettime:int64; inline;

begin
result:=PLongWord($3F003004)^;
end;

vinmc42 said (which is 100% correct) both GetTickCount64 and GetTickCount return milliseconds, if you want higher resolution you can use ClockGetTotal which is based on the system timer and returns a value in clock cycles.

To obtain a microsecond counter from ClockGetTotal you simply divide by the system specific value CLOCK_CYCLES_PER_MICROSECOND which is set during boot by the platform support module.

*)

procedure Log (s : string);
begin
  ConsoleWindowWriteLn (Console1, s);
end;

procedure WaitForSDDrive;
begin
  while not DirectoryExists ('C:\') do sleep (500);
end;

begin
  Console1 := ConsoleWindowCreate (ConsoleDeviceGetDefault, CONSOLE_POSITION_FULL, true);
  Log ('WIFI Demo #1 Pi Zero.');

  WaitForSDDrive;

  scan_main;
  ThreadHalt (0);
end.

