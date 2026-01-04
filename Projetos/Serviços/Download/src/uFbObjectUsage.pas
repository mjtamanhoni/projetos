unit uFbObjectUsage;

interface

uses
  SysUtils, Classes;

type
  TDbObjectType = (otTable, otProcedure, otTrigger);
  TExecExistsFunc = function(const SQL: string): Boolean of object;
  TExecScalarStringFunc = function(const SQL: string): string of object;

function FbIsObjectInUse(ExecExists: TExecExistsFunc; const ObjectName: string; ObjType: TDbObjectType; ExecScalar: TExecScalarStringFunc = nil): Boolean;
function FbIsObjectInUseByType(ExecExists: TExecExistsFunc; const ObjectName: string; const ObjTypeStr: string = ''): Boolean;

implementation

function EscapeSingleQuotes(const S: string): string;
begin
  Result := StringReplace(S, '''', '''''', [rfReplaceAll]);
end;

function BuildTableInUseSQL(const TableName: string): string;
var
  NameU: string;
begin
  NameU := UpperCase(TableName);
  Result :=
    'select first 1 1 ' +
    'from mon$statements s ' +
    'where s.mon$state <> 0 ' +
    '  and upper(coalesce(s.mon$sql_text, '''')) like ''%' + EscapeSingleQuotes(NameU) + '%''';
end;

function BuildProcedureInUseSQL(const ProcName: string): string;
var
  NameU: string;
begin
  NameU := UpperCase(ProcName);
  Result :=
    'select first 1 1 ' +
    'from mon$statements s ' +
    'where s.mon$state <> 0 ' +
    '  and upper(coalesce(s.mon$sql_text, '''')) like ''%' + EscapeSingleQuotes(NameU) + '%''';
end;

function GetTriggerBaseRelationSQL(const TriggerName: string): string;
begin
  Result :=
    'select rdb$relation_name ' +
    'from rdb$triggers ' +
    'where rdb$trigger_name = ''' + EscapeSingleQuotes(TriggerName) + '''';
end;

function FbIsObjectInUse(ExecExists: TExecExistsFunc; const ObjectName: string; ObjType: TDbObjectType; ExecScalar: TExecScalarStringFunc): Boolean;
var
  Sql: string;
  RelName: string;
begin
  Result := False;
  case ObjType of
    otTable:
      begin
        Sql := BuildTableInUseSQL(ObjectName);
        Result := ExecExists(Sql);
      end;
    otProcedure:
      begin
        Sql := BuildProcedureInUseSQL(ObjectName);
        Result := ExecExists(Sql);
      end;
    otTrigger:
      begin
        Sql := 'select first 1 1 from mon$statements s where s.mon$state <> 0 ' +
               'and upper(coalesce(s.mon$sql_text, '''')) like ''%' + EscapeSingleQuotes(UpperCase(ObjectName)) + '%''';
        if ExecExists(Sql) then
        begin
          Result := True;
          Exit;
        end;
        if Assigned(ExecScalar) then
        begin
          RelName := ExecScalar(GetTriggerBaseRelationSQL(ObjectName));
          RelName := Trim(RelName);
          if RelName <> '' then
          begin
            Sql := BuildTableInUseSQL(RelName);
            Result := ExecExists(Sql);
          end;
        end;
      end;
  end;
end;

function FbIsObjectInUseByType(ExecExists: TExecExistsFunc; const ObjectName: string; const ObjTypeStr: string): Boolean;
var
  T: TDbObjectType;
  S: string;
begin
  S := LowerCase(ObjTypeStr);
  if S = 'procedure' then T := otProcedure
  else if S = 'trigger' then T := otTrigger
  else T := otTable;
  Result := FbIsObjectInUse(ExecExists, ObjectName, T);
end;

end.
